const router = require('express').Router();
const prisma = require('../lib/prisma');
const { authenticate } = require('../middleware/auth');
const { success, error } = require('../lib/response');

router.get('/sales', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const { from, to } = req.query;
    const where = {
      branchId,
      status: { not: 'cancelled' },
      ...(from && to && { createdAt: { gte: new Date(from), lte: new Date(to) } }),
    };
    const [orders, summary] = await Promise.all([
      prisma.order.findMany({
        where,
        include: { table: true, customer: true },
        orderBy: { createdAt: 'desc' },
      }),
      prisma.order.aggregate({
        where,
        _sum: { total: true, subtotal: true, taxAmount: true, discount: true },
        _count: { id: true },
      }),
    ]);
    return success(res, {
      orders,
      summary: {
        total: summary._sum.total || 0,
        subtotal: summary._sum.subtotal || 0,
        taxAmount: summary._sum.taxAmount || 0,
        discount: summary._sum.discount || 0,
        count: summary._count.id,
      },
    });
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.get('/items', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const { from, to } = req.query;
    const orderWhere = {
      branchId,
      status: { not: 'cancelled' },
      ...(from && to && { createdAt: { gte: new Date(from), lte: new Date(to) } }),
    };
    const orderIds = (await prisma.order.findMany({ where: orderWhere, select: { id: true } })).map((o) => o.id);
    const items = await prisma.orderItem.groupBy({
      by: ['name', 'menuItemId'],
      where: { orderId: { in: orderIds } },
      _sum: { quantity: true, price: true },
      _count: { id: true },
    });
    return success(res, items);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

module.exports = router;
