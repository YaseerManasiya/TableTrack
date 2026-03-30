const router = require('express').Router();
const prisma = require('../lib/prisma');
const { authenticate } = require('../middleware/auth');
const { success, paginated, error } = require('../lib/response');

// ── Modifier Groups ───────────────────────────────────────────────────────────

router.get('/', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const page = Number(req.query.page) || 1;
    const perPage = Number(req.query.per_page) || 50;
    const [data, total] = await Promise.all([
      prisma.modifierGroup.findMany({
        where: { branchId },
        skip: (page - 1) * perPage,
        take: perPage,
        include: { modifierOptions: true },
        orderBy: { createdAt: 'desc' },
      }),
      prisma.modifierGroup.count({ where: { branchId } }),
    ]);
    return paginated(res, data, total, page, perPage);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.post('/', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const { name, options } = req.body;
    if (!name) return error(res, 'Name is required', 422);
    const group = await prisma.modifierGroup.create({
      data: {
        branchId,
        name,
        ...(options && Array.isArray(options) && options.length > 0
          ? {
              modifierOptions: {
                create: options.map((o) => ({ name: o.name, price: Number(o.price || 0) })),
              },
            }
          : {}),
      },
      include: { modifierOptions: true },
    });
    return success(res, group, 'Modifier group created', 201);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.get('/:id', authenticate, async (req, res) => {
  try {
    const group = await prisma.modifierGroup.findUnique({
      where: { id: Number(req.params.id) },
      include: { modifierOptions: true },
    });
    if (!group) return error(res, 'Not found', 404);
    return success(res, group);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.put('/:id', authenticate, async (req, res) => {
  try {
    const { name } = req.body;
    const group = await prisma.modifierGroup.update({
      where: { id: Number(req.params.id) },
      data: { ...(name !== undefined && { name }) },
      include: { modifierOptions: true },
    });
    return success(res, group);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.delete('/:id', authenticate, async (req, res) => {
  try {
    // Cascade delete options via onDelete in schema (or do it manually)
    await prisma.modifierOption.deleteMany({ where: { modifierGroupId: Number(req.params.id) } });
    await prisma.modifierGroup.delete({ where: { id: Number(req.params.id) } });
    return success(res, null, 'Deleted');
  } catch (e) {
    return error(res, e.message, 500);
  }
});

// ── Modifier Options (nested under a group) ───────────────────────────────────

router.get('/:groupId/options', authenticate, async (req, res) => {
  try {
    const options = await prisma.modifierOption.findMany({
      where: { modifierGroupId: Number(req.params.groupId) },
      orderBy: { createdAt: 'asc' },
    });
    return success(res, options);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.post('/:groupId/options', authenticate, async (req, res) => {
  try {
    const { name, price } = req.body;
    if (!name) return error(res, 'Name is required', 422);
    const option = await prisma.modifierOption.create({
      data: {
        modifierGroupId: Number(req.params.groupId),
        name,
        price: Number(price || 0),
      },
    });
    return success(res, option, 'Option created', 201);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.put('/:groupId/options/:optionId', authenticate, async (req, res) => {
  try {
    const { name, price } = req.body;
    const option = await prisma.modifierOption.update({
      where: { id: Number(req.params.optionId) },
      data: {
        ...(name !== undefined && { name }),
        ...(price !== undefined && { price: Number(price) }),
      },
    });
    return success(res, option);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.delete('/:groupId/options/:optionId', authenticate, async (req, res) => {
  try {
    await prisma.modifierOption.delete({ where: { id: Number(req.params.optionId) } });
    return success(res, null, 'Deleted');
  } catch (e) {
    return error(res, e.message, 500);
  }
});

module.exports = router;
