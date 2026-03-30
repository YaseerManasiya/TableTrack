const router = require('express').Router();
const prisma = require('../lib/prisma');
const { authenticate } = require('../middleware/auth');
const { success, error } = require('../lib/response');

router.get('/stats', authenticate, async (req, res) => {
  try {
    const branchId = req.query.branchId ? Number(req.query.branchId) : req.user.branchId;
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);

    const [ordersToday, revenueResult, pendingKots, tables] = await Promise.all([
      prisma.order.count({ where: { branchId, createdAt: { gte: today, lt: tomorrow } } }),
      prisma.order.aggregate({
        where: { branchId, createdAt: { gte: today, lt: tomorrow }, status: { not: 'cancelled' } },
        _sum: { total: true },
      }),
      prisma.kOT.count({ where: { branchId, status: 'pending' } }),
      prisma.table.groupBy({
        by: ['tableStatus'],
        where: { branchId, isActive: true },
        _count: { tableStatus: true },
      }),
    ]);

    const tableStats = { available: 0, reserved: 0, running: 0 };
    tables.forEach((t) => {
      tableStats[t.tableStatus] = t._count.tableStatus;
    });

    return success(res, {
      ordersToday,
      revenueToday: revenueResult._sum.total || 0,
      pendingKots,
      tableStats,
    });
  } catch (e) {
    console.error(e);
    return error(res, 'Server error', 500);
  }
});

module.exports = router;
