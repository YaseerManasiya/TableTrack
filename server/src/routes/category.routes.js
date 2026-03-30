const router = require('express').Router();
const prisma = require('../lib/prisma');
const { authenticate } = require('../middleware/auth');
const { success, paginated, error } = require('../lib/response');

router.get('/', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const page = Number(req.query.page) || 1;
    const perPage = Number(req.query.per_page) || 50;
    const [data, total] = await Promise.all([
      prisma.itemCategory.findMany({
        where: { branchId },
        skip: (page - 1) * perPage,
        take: perPage,
        orderBy: { order: 'asc' },
      }),
      prisma.itemCategory.count({ where: { branchId } }),
    ]);
    return paginated(res, data, total, page, perPage);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.post('/', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const { name, description, image, isActive, order } = req.body;
    const cat = await prisma.itemCategory.create({
      data: { branchId, name, description, image, isActive: isActive ?? true, order: order || 0 },
    });
    return success(res, cat, 'Category created', 201);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.get('/:id', authenticate, async (req, res) => {
  try {
    const cat = await prisma.itemCategory.findUnique({ where: { id: Number(req.params.id) } });
    if (!cat) return error(res, 'Not found', 404);
    return success(res, cat);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.put('/:id', authenticate, async (req, res) => {
  try {
    const { name, description, image, isActive, order } = req.body;
    const cat = await prisma.itemCategory.update({
      where: { id: Number(req.params.id) },
      data: {
        ...(name !== undefined && { name }),
        ...(description !== undefined && { description }),
        ...(image !== undefined && { image }),
        ...(isActive !== undefined && { isActive }),
        ...(order !== undefined && { order }),
      },
    });
    return success(res, cat);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.delete('/:id', authenticate, async (req, res) => {
  try {
    await prisma.itemCategory.delete({ where: { id: Number(req.params.id) } });
    return success(res, null, 'Deleted');
  } catch (e) {
    return error(res, e.message, 500);
  }
});

module.exports = router;
