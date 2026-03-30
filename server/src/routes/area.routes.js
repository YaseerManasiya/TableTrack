const router = require('express').Router();
const prisma = require('../lib/prisma');
const { authenticate } = require('../middleware/auth');
const { success, error } = require('../lib/response');

router.get('/', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const areas = await prisma.area.findMany({ where: { branchId }, include: { tables: true } });
    return success(res, areas);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.post('/', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const { areaName } = req.body;
    const area = await prisma.area.create({ data: { branchId, areaName } });
    return success(res, area, 'Area created', 201);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.get('/:id', authenticate, async (req, res) => {
  try {
    const area = await prisma.area.findUnique({
      where: { id: Number(req.params.id) },
      include: { tables: true },
    });
    if (!area) return error(res, 'Not found', 404);
    return success(res, area);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.put('/:id', authenticate, async (req, res) => {
  try {
    const { areaName } = req.body;
    const area = await prisma.area.update({
      where: { id: Number(req.params.id) },
      data: { ...(areaName !== undefined && { areaName }) },
    });
    return success(res, area);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.delete('/:id', authenticate, async (req, res) => {
  try {
    await prisma.area.delete({ where: { id: Number(req.params.id) } });
    return success(res, null, 'Deleted');
  } catch (e) {
    return error(res, e.message, 500);
  }
});

module.exports = router;
