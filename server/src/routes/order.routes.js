const router = require('express').Router();
const prisma = require('../lib/prisma');
const { authenticate } = require('../middleware/auth');
const { success, paginated, error } = require('../lib/response');

router.get('/', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const page = Number(req.query.page) || 1;
    const perPage = Number(req.query.per_page) || 20;
    const status = req.query.status;
    const where = { branchId, ...(status && { status }) };
    const [data, total] = await Promise.all([
      prisma.order.findMany({
        where,
        skip: (page - 1) * perPage,
        take: perPage,
        include: { table: true, customer: true, orderItems: true },
        orderBy: { createdAt: 'desc' },
      }),
      prisma.order.count({ where }),
    ]);
    return paginated(res, data, total, page, perPage);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.post('/', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const restaurantId = req.user.restaurantId;
    const { tableId, customerId, orderType, items, discount, taxAmount } = req.body;
    if (!items || !items.length) return error(res, 'Items required');

    const subtotal = items.reduce((s, i) => s + i.price * i.quantity, 0);
    const total = subtotal + (taxAmount || 0) - (discount || 0);

    const count = await prisma.order.count({ where: { branchId } });
    const orderNumber = `ORD-${String(count + 1).padStart(4, '0')}`;

    const order = await prisma.order.create({
      data: {
        branchId,
        restaurantId,
        tableId: tableId ? Number(tableId) : null,
        customerId: customerId ? Number(customerId) : null,
        orderType: orderType || 'dine_in',
        orderNumber,
        subtotal,
        total,
        taxAmount: taxAmount || 0,
        discount: discount || 0,
        status: 'pending',
        orderItems: {
          create: items.map((i) => ({
            menuItemId: i.menuItemId ? Number(i.menuItemId) : null,
            name: i.name,
            price: i.price,
            quantity: i.quantity,
            notes: i.notes || null,
          })),
        },
      },
      include: { orderItems: true },
    });

    // Create KOT
    const kotCount = await prisma.kOT.count({ where: { branchId } });
    await prisma.kOT.create({
      data: {
        orderId: order.id,
        branchId,
        tokenNumber: kotCount + 1,
        status: 'pending',
        kotItems: {
          create: items.map((i) => ({
            menuItemId: i.menuItemId ? Number(i.menuItemId) : null,
            name: i.name,
            quantity: i.quantity,
            status: 'pending',
            notes: i.notes || null,
          })),
        },
      },
    });

    // Set table to running for dine-in
    if (tableId && (orderType === 'dine_in' || !orderType)) {
      await prisma.table.update({
        where: { id: Number(tableId) },
        data: { tableStatus: 'running' },
      });
    }

    return success(res, order, 'Order created', 201);
  } catch (e) {
    console.error(e);
    return error(res, e.message, 500);
  }
});

router.get('/:id', authenticate, async (req, res) => {
  try {
    const order = await prisma.order.findUnique({
      where: { id: Number(req.params.id) },
      include: {
        table: true,
        customer: true,
        orderItems: { include: { menuItem: true } },
        kots: { include: { kotItems: true } },
        payments: true,
      },
    });
    if (!order) return error(res, 'Not found', 404);
    return success(res, order);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.put('/:id/status', authenticate, async (req, res) => {
  try {
    const { status } = req.body;
    const order = await prisma.order.update({
      where: { id: Number(req.params.id) },
      data: { status },
    });
    // Free the table when order is completed
    if (status === 'completed' && order.tableId) {
      await prisma.table.update({
        where: { id: order.tableId },
        data: { tableStatus: 'available' },
      });
    }
    return success(res, order);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.put('/:id', authenticate, async (req, res) => {
  try {
    const { status, discount, taxAmount } = req.body;
    const order = await prisma.order.update({
      where: { id: Number(req.params.id) },
      data: {
        ...(status !== undefined && { status }),
        ...(discount !== undefined && { discount }),
        ...(taxAmount !== undefined && { taxAmount }),
      },
    });
    return success(res, order);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

module.exports = router;
