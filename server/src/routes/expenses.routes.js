const router = require('express').Router();
const prisma = require('../lib/prisma');
const { authenticate } = require('../middleware/auth');
const { success, paginated, error } = require('../lib/response');

// ── Expense Categories ───────────────────────────────────────────────────────

router.get('/categories', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const categories = await prisma.expenseCategory.findMany({
      where: { branchId },
      orderBy: { name: 'asc' },
    });
    return success(res, categories);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.post('/categories', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const { name } = req.body;
    if (!name) return error(res, 'Name is required', 422);
    const category = await prisma.expenseCategory.create({ data: { branchId, name } });
    return success(res, category, 'Category created', 201);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.put('/categories/:id', authenticate, async (req, res) => {
  try {
    const { name } = req.body;
    const category = await prisma.expenseCategory.update({
      where: { id: Number(req.params.id) },
      data: { ...(name !== undefined && { name }) },
    });
    return success(res, category);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.delete('/categories/:id', authenticate, async (req, res) => {
  try {
    await prisma.expenseCategory.delete({ where: { id: Number(req.params.id) } });
    return success(res, null, 'Deleted');
  } catch (e) {
    return error(res, e.message, 500);
  }
});

// ── Expenses ─────────────────────────────────────────────────────────────────

router.get('/', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const page = Number(req.query.page) || 1;
    const perPage = Number(req.query.per_page) || 20;
    const categoryId = req.query.category_id ? Number(req.query.category_id) : undefined;
    const dateFrom = req.query.date_from;
    const dateTo = req.query.date_to;

    const where = {
      branchId,
      ...(categoryId && { expenseCategoryId: categoryId }),
      ...(dateFrom || dateTo
        ? {
            date: {
              ...(dateFrom && { gte: new Date(dateFrom) }),
              ...(dateTo && { lte: new Date(dateTo) }),
            },
          }
        : {}),
    };

    const [data, total] = await Promise.all([
      prisma.expense.findMany({
        where,
        skip: (page - 1) * perPage,
        take: perPage,
        include: { expenseCategory: true },
        orderBy: { date: 'desc' },
      }),
      prisma.expense.count({ where }),
    ]);
    return paginated(res, data, total, page, perPage);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.post('/', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const { expenseCategoryId, amount, notes, date } = req.body;
    if (!amount || !date) return error(res, 'Amount and date are required', 422);
    const expense = await prisma.expense.create({
      data: {
        branchId,
        expenseCategoryId: expenseCategoryId ? Number(expenseCategoryId) : null,
        amount: Number(amount),
        notes: notes || null,
        date: new Date(date),
      },
      include: { expenseCategory: true },
    });
    return success(res, expense, 'Expense created', 201);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.get('/:id', authenticate, async (req, res) => {
  try {
    const expense = await prisma.expense.findUnique({
      where: { id: Number(req.params.id) },
      include: { expenseCategory: true },
    });
    if (!expense) return error(res, 'Not found', 404);
    return success(res, expense);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.put('/:id', authenticate, async (req, res) => {
  try {
    const { expenseCategoryId, amount, notes, date } = req.body;
    const expense = await prisma.expense.update({
      where: { id: Number(req.params.id) },
      data: {
        ...(expenseCategoryId !== undefined && {
          expenseCategoryId: expenseCategoryId ? Number(expenseCategoryId) : null,
        }),
        ...(amount !== undefined && { amount: Number(amount) }),
        ...(notes !== undefined && { notes }),
        ...(date !== undefined && { date: new Date(date) }),
      },
      include: { expenseCategory: true },
    });
    return success(res, expense);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.delete('/:id', authenticate, async (req, res) => {
  try {
    await prisma.expense.delete({ where: { id: Number(req.params.id) } });
    return success(res, null, 'Deleted');
  } catch (e) {
    return error(res, e.message, 500);
  }
});

module.exports = router;
