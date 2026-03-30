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
    const { tableId, customerId, orderType, items, discount, applyTaxes, applyCharges, taxIds, chargeIds } = req.body;
    if (!items || !items.length) return error(res, 'Items required', 422);

    const subtotal = items.reduce((s, i) => s + Number(i.price) * Number(i.quantity), 0);

    // Fetch active taxes for this branch
    const taxesToApply = applyTaxes !== false
      ? await prisma.restaurantTax.findMany({
          where: {
            branchId,
            isActive: true,
            ...(taxIds && Array.isArray(taxIds) && taxIds.length > 0
              ? { id: { in: taxIds.map(Number) } }
              : {}),
          },
        })
      : [];

    // Fetch active charges for this branch / order type
    const effectiveOrderType = orderType || 'dine_in';
    const chargesToApply = applyCharges !== false
      ? await prisma.restaurantCharge.findMany({
          where: {
            branchId,
            isActive: true,
            OR: [{ orderType: null }, { orderType: effectiveOrderType }],
            ...(chargeIds && Array.isArray(chargeIds) && chargeIds.length > 0
              ? { id: { in: chargeIds.map(Number) } }
              : {}),
          },
        })
      : [];

    // Compute tax amounts
    const computedTaxes = taxesToApply.map((t) => ({
      taxId: t.id,
      name: t.name,
      rate: Number(t.rate),
      amount:
        t.type === 'percentage'
          ? parseFloat(((subtotal * Number(t.rate)) / 100).toFixed(2))
          : Number(t.rate),
    }));

    // Compute charge amounts
    const computedCharges = chargesToApply.map((c) => ({
      name: c.name,
      amount: c.type === 'percentage'
        ? parseFloat(((subtotal * Number(c.amount)) / 100).toFixed(2))
        : Number(c.amount),
      type: c.type,
    }));

    const totalTax = computedTaxes.reduce((s, t) => s + t.amount, 0);
    const totalCharges = computedCharges.reduce((s, c) => s + c.amount, 0);
    const totalDiscount = Number(discount || 0);
    const total = parseFloat((subtotal + totalTax + totalCharges - totalDiscount).toFixed(2));

    // Generate order number
    const count = await prisma.order.count({ where: { branchId } });
    const orderNumber = `ORD-${String(count + 1).padStart(4, '0')}`;

    const order = await prisma.order.create({
      data: {
        branchId,
        restaurantId,
        tableId: tableId ? Number(tableId) : null,
        customerId: customerId ? Number(customerId) : null,
        orderType: effectiveOrderType,
        orderNumber,
        subtotal,
        total,
        taxAmount: totalTax,
        discount: totalDiscount,
        status: 'pending',
        orderItems: {
          create: items.map((i) => ({
            menuItemId: i.menuItemId ? Number(i.menuItemId) : null,
            name: i.name,
            price: Number(i.price),
            quantity: Number(i.quantity),
            notes: i.notes || null,
          })),
        },
        ...(computedTaxes.length > 0
          ? {
              orderTaxes: {
                create: computedTaxes.map((t) => ({
                  taxId: t.taxId,
                  name: t.name,
                  rate: t.rate,
                  amount: t.amount,
                })),
              },
            }
          : {}),
        ...(computedCharges.length > 0
          ? {
              orderCharges: {
                create: computedCharges.map((c) => ({
                  name: c.name,
                  amount: c.amount,
                  type: c.type,
                })),
              },
            }
          : {}),
      },
      include: { orderItems: true, orderTaxes: true, orderCharges: true },
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
            quantity: Number(i.quantity),
            status: 'pending',
            notes: i.notes || null,
          })),
        },
      },
    });

    // Set table to running for dine-in
    if (tableId && (effectiveOrderType === 'dine_in')) {
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
        orderTaxes: true,
        orderCharges: true,
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
    // Free the table when order is completed or cancelled
    if ((status === 'completed' || status === 'cancelled') && order.tableId) {
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
        ...(discount !== undefined && { discount: Number(discount) }),
        ...(taxAmount !== undefined && { taxAmount: Number(taxAmount) }),
      },
    });
    return success(res, order);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

module.exports = router;

