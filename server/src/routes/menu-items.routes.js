const router = require('express').Router();
const prisma = require('../lib/prisma');
const { authenticate } = require('../middleware/auth');
const { success, paginated, error } = require('../lib/response');

router.get('/', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const page = Number(req.query.page) || 1;
    const perPage = Number(req.query.per_page) || 20;
    const q = req.query.q;
    const where = { branchId, ...(q && { name: { contains: q } }) };
    const [data, total] = await Promise.all([
      prisma.menuItem.findMany({
        where,
        skip: (page - 1) * perPage,
        take: perPage,
        include: { itemCategory: true, menu: true, variations: true },
        orderBy: { createdAt: 'desc' },
      }),
      prisma.menuItem.count({ where }),
    ]);
    return paginated(res, data, total, page, perPage);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.get('/:id', authenticate, async (req, res) => {
  try {
    const item = await prisma.menuItem.findUnique({
      where: { id: Number(req.params.id) },
      include: { itemCategory: true, menu: true, variations: true },
    });
    if (!item) return error(res, 'Not found', 404);
    return success(res, item);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.put('/:id', authenticate, async (req, res) => {
  try {
    const { itemCategoryId, name, description, price, image, isActive, preparationTime, isFeatured } = req.body;
    const item = await prisma.menuItem.update({
      where: { id: Number(req.params.id) },
      data: {
        itemCategoryId: itemCategoryId !== undefined ? (itemCategoryId ? Number(itemCategoryId) : null) : undefined,
        name,
        description,
        price: price !== undefined ? Number(price) : undefined,
        image,
        isActive,
        preparationTime: preparationTime !== undefined ? Number(preparationTime) : undefined,
        isFeatured,
      },
      include: { itemCategory: true, variations: true },
    });
    return success(res, item);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.delete('/:id', authenticate, async (req, res) => {
  try {
    await prisma.menuItem.delete({ where: { id: Number(req.params.id) } });
    return success(res, null, 'Deleted');
  } catch (e) {
    return error(res, e.message, 500);
  }
});

// ── Menu Item Variations ─────────────────────────────────────────────────────

router.get('/:itemId/variations', authenticate, async (req, res) => {
  try {
    const variations = await prisma.menuItemVariation.findMany({
      where: { menuItemId: Number(req.params.itemId) },
      orderBy: { createdAt: 'asc' },
    });
    return success(res, variations);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.post('/:itemId/variations', authenticate, async (req, res) => {
  try {
    const { name, price, isActive } = req.body;
    if (!name || price === undefined) return error(res, 'Name and price are required', 422);
    const variation = await prisma.menuItemVariation.create({
      data: {
        menuItemId: Number(req.params.itemId),
        name,
        price: Number(price),
        isActive: isActive ?? true,
      },
    });
    return success(res, variation, 'Variation created', 201);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.put('/:itemId/variations/:variationId', authenticate, async (req, res) => {
  try {
    const { name, price, isActive } = req.body;
    const variation = await prisma.menuItemVariation.update({
      where: { id: Number(req.params.variationId) },
      data: {
        ...(name !== undefined && { name }),
        ...(price !== undefined && { price: Number(price) }),
        ...(isActive !== undefined && { isActive }),
      },
    });
    return success(res, variation);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.delete('/:itemId/variations/:variationId', authenticate, async (req, res) => {
  try {
    await prisma.menuItemVariation.delete({ where: { id: Number(req.params.variationId) } });
    return success(res, null, 'Deleted');
  } catch (e) {
    return error(res, e.message, 500);
  }
});

module.exports = router;

