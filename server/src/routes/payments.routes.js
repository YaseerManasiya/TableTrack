const router = require('express').Router();
const prisma = require('../lib/prisma');
const { authenticate } = require('../middleware/auth');
const { success, paginated, error } = require('../lib/response');

// List all payments with order info
router.get('/', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const page = Number(req.query.page) || 1;
    const perPage = Number(req.query.per_page) || 20;
    const method = req.query.method;
    const status = req.query.status;

    const where = {
      branchId,
      ...(method && { method }),
      ...(status && { status }),
    };

    const [data, total] = await Promise.all([
      prisma.payment.findMany({
        where,
        skip: (page - 1) * perPage,
        take: perPage,
        include: {
          order: {
            include: { table: true, customer: true },
          },
        },
        orderBy: { createdAt: 'desc' },
      }),
      prisma.payment.count({ where }),
    ]);
    return paginated(res, data, total, page, perPage);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

// Record a payment for an order
router.post('/', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const { orderId, amount, method, status } = req.body;

    if (!orderId || !amount || !method) {
      return error(res, 'orderId, amount and method are required', 422);
    }

    const order = await prisma.order.findFirst({
      where: { id: Number(orderId), branchId },
    });
    if (!order) return error(res, 'Order not found', 404);

    const payment = await prisma.payment.create({
      data: {
        orderId: Number(orderId),
        branchId,
        amount: Number(amount),
        method,
        status: status || 'completed',
      },
      include: { order: { include: { table: true, customer: true } } },
    });

    // Mark order as completed if payment covers full amount
    const totalPaid = await prisma.payment.aggregate({
      where: { orderId: Number(orderId), status: 'completed' },
      _sum: { amount: true },
    });
    const paidSoFar = Number(totalPaid._sum.amount || 0);
    if (paidSoFar >= Number(order.total)) {
      await prisma.order.update({
        where: { id: Number(orderId) },
        data: { status: 'completed' },
      });
      // Free the table
      if (order.tableId) {
        await prisma.table.update({
          where: { id: order.tableId },
          data: { tableStatus: 'available' },
        });
      }
    }

    return success(res, payment, 'Payment recorded', 201);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

// Get a single payment
router.get('/:id', authenticate, async (req, res) => {
  try {
    const payment = await prisma.payment.findUnique({
      where: { id: Number(req.params.id) },
      include: { order: { include: { table: true, customer: true } } },
    });
    if (!payment) return error(res, 'Not found', 404);
    return success(res, payment);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

// Delete a payment
router.delete('/:id', authenticate, async (req, res) => {
  try {
    await prisma.payment.delete({ where: { id: Number(req.params.id) } });
    return success(res, null, 'Deleted');
  } catch (e) {
    return error(res, e.message, 500);
  }
});

// Due payments — orders that have no completed payment yet
router.get('/due/list', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const page = Number(req.query.page) || 1;
    const perPage = Number(req.query.per_page) || 20;

    // Find order IDs that already have a completed payment covering full amount
    const paidOrders = await prisma.payment.groupBy({
      by: ['orderId'],
      where: { branchId, status: 'completed' },
      _sum: { amount: true },
    });

    // Build set of fully-paid order IDs
    // We'll check against the actual orders below — for a quick approach,
    // just find orders that are NOT in 'completed' status and don't have payments
    const where = {
      branchId,
      status: { notIn: ['completed', 'cancelled'] },
    };

    const [data, total] = await Promise.all([
      prisma.order.findMany({
        where,
        skip: (page - 1) * perPage,
        take: perPage,
        include: {
          table: true,
          customer: true,
          payments: true,
        },
        orderBy: { createdAt: 'desc' },
      }),
      prisma.order.count({ where }),
    ]);

    // Annotate with paid/due amounts
    const annotated = data.map((order) => {
      const paid = order.payments
        .filter((p) => p.status === 'completed')
        .reduce((s, p) => s + Number(p.amount), 0);
      return { ...order, paidAmount: paid, dueAmount: Math.max(0, Number(order.total) - paid) };
    });

    return paginated(res, annotated, total, page, perPage);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

module.exports = router;
