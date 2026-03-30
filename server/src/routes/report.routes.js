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

// Category-wise sales report
router.get('/category', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const { from, to } = req.query;
    const orderWhere = {
      branchId,
      status: { not: 'cancelled' },
      ...(from && to && { createdAt: { gte: new Date(from), lte: new Date(to) } }),
    };
    const orderIds = (await prisma.order.findMany({ where: orderWhere, select: { id: true } })).map((o) => o.id);

    // Get order items with their menu item category info
    const orderItems = await prisma.orderItem.findMany({
      where: { orderId: { in: orderIds } },
      include: {
        menuItem: { include: { itemCategory: true } },
      },
    });

    // Group by category
    const categoryMap = {};
    for (const item of orderItems) {
      const categoryName = item.menuItem?.itemCategory?.name ?? 'Uncategorized';
      const categoryId = item.menuItem?.itemCategoryId ?? 0;
      if (!categoryMap[categoryName]) {
        categoryMap[categoryName] = { categoryId, categoryName, totalQty: 0, totalRevenue: 0, items: 0 };
      }
      categoryMap[categoryName].totalQty += item.quantity;
      categoryMap[categoryName].totalRevenue += Number(item.price) * item.quantity;
      categoryMap[categoryName].items += 1;
    }

    const rows = Object.values(categoryMap).sort((a, b) => b.totalRevenue - a.totalRevenue);
    return success(res, rows);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

// Expense report
router.get('/expense', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const { from, to } = req.query;
    const where = {
      branchId,
      ...(from && to
        ? { date: { gte: new Date(from), lte: new Date(to) } }
        : {}),
    };

    const [expenses, summary] = await Promise.all([
      prisma.expense.findMany({
        where,
        include: { expenseCategory: true },
        orderBy: { date: 'desc' },
      }),
      prisma.expense.aggregate({
        where,
        _sum: { amount: true },
        _count: { id: true },
      }),
    ]);

    return success(res, {
      expenses,
      summary: {
        total: summary._sum.amount || 0,
        count: summary._count.id,
      },
    });
  } catch (e) {
    return error(res, e.message, 500);
  }
});

// Outstanding (unpaid) orders report
router.get('/outstanding', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const { from, to } = req.query;

    const where = {
      branchId,
      status: { notIn: ['completed', 'cancelled'] },
      ...(from && to && { createdAt: { gte: new Date(from), lte: new Date(to) } }),
    };

    const orders = await prisma.order.findMany({
      where,
      include: { table: true, customer: true, payments: true },
      orderBy: { createdAt: 'desc' },
    });

    const annotated = orders.map((order) => {
      const paid = order.payments
        .filter((p) => p.status === 'completed')
        .reduce((s, p) => s + Number(p.amount), 0);
      return {
        ...order,
        paidAmount: paid,
        dueAmount: Math.max(0, Number(order.total) - paid),
      };
    });

    const totalDue = annotated.reduce((s, o) => s + o.dueAmount, 0);

    return success(res, { orders: annotated, totalDue });
  } catch (e) {
    return error(res, e.message, 500);
  }
});

module.exports = router;

