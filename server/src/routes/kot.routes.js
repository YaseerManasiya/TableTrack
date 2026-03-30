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
      prisma.kOT.findMany({
        where,
        skip: (page - 1) * perPage,
        take: perPage,
        include: { kotItems: true, order: { include: { table: true } } },
        orderBy: { createdAt: 'asc' },
      }),
      prisma.kOT.count({ where }),
    ]);
    return paginated(res, data, total, page, perPage);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.get('/:id', authenticate, async (req, res) => {
  try {
    const kot = await prisma.kOT.findUnique({
      where: { id: Number(req.params.id) },
      include: { kotItems: true, order: { include: { table: true } } },
    });
    if (!kot) return error(res, 'Not found', 404);
    return success(res, kot);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.put('/:id/status', authenticate, async (req, res) => {
  try {
    const { status } = req.body;
    const kot = await prisma.kOT.update({
      where: { id: Number(req.params.id) },
      data: { status },
    });
    return success(res, kot);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

module.exports = router;
