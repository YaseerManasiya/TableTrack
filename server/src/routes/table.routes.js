const router = require('express').Router();
const crypto = require('crypto');
const prisma = require('../lib/prisma');
const { authenticate } = require('../middleware/auth');
const { success, paginated, error } = require('../lib/response');

router.get('/', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const page = Number(req.query.page) || 1;
    const perPage = Number(req.query.per_page) || 50;
    const areaId = req.query.areaId ? Number(req.query.areaId) : undefined;
    const where = { branchId, ...(areaId && { areaId }) };
    const [data, total] = await Promise.all([
      prisma.table.findMany({
        where,
        skip: (page - 1) * perPage,
        take: perPage,
        include: { area: true },
        orderBy: { createdAt: 'asc' },
      }),
      prisma.table.count({ where }),
    ]);
    return paginated(res, data, total, page, perPage);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.post('/', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const { areaId, tableName, seatingCapacity, isActive } = req.body;
    const uniqueHash = crypto.randomBytes(8).toString('hex');
    const table = await prisma.table.create({
      data: {
        branchId,
        areaId: areaId ? Number(areaId) : null,
        tableName,
        uniqueHash,
        seatingCapacity: Number(seatingCapacity),
        tableStatus: 'available',
        isActive: isActive ?? true,
      },
    });
    return success(res, table, 'Table created', 201);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.get('/:id', authenticate, async (req, res) => {
  try {
    const table = await prisma.table.findUnique({
      where: { id: Number(req.params.id) },
      include: { area: true },
    });
    if (!table) return error(res, 'Not found', 404);
    return success(res, table);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.put('/:id', authenticate, async (req, res) => {
  try {
    const { areaId, tableName, seatingCapacity, tableStatus, isActive } = req.body;
    const table = await prisma.table.update({
      where: { id: Number(req.params.id) },
      data: {
        ...(areaId !== undefined && { areaId: areaId ? Number(areaId) : null }),
        ...(tableName !== undefined && { tableName }),
        ...(seatingCapacity !== undefined && { seatingCapacity: Number(seatingCapacity) }),
        ...(tableStatus !== undefined && { tableStatus }),
        ...(isActive !== undefined && { isActive }),
      },
    });
    return success(res, table);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.delete('/:id', authenticate, async (req, res) => {
  try {
    await prisma.table.delete({ where: { id: Number(req.params.id) } });
    return success(res, null, 'Deleted');
  } catch (e) {
    return error(res, e.message, 500);
  }
});

module.exports = router;
