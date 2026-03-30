const router = require('express').Router();
const prisma = require('../lib/prisma');
const { authenticate } = require('../middleware/auth');
const { success, paginated, error } = require('../lib/response');

// --- Menus ---

router.get('/', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const page = Number(req.query.page) || 1;
    const perPage = Number(req.query.per_page) || 20;
    const q = req.query.q;
    const where = { branchId, ...(q && { name: { contains: q } }) };
    const [data, total] = await Promise.all([
      prisma.menu.findMany({ where, skip: (page - 1) * perPage, take: perPage, orderBy: { createdAt: 'desc' } }),
      prisma.menu.count({ where }),
    ]);
    return paginated(res, data, total, page, perPage);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.post('/', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const { name, description, image, isActive } = req.body;
    const menu = await prisma.menu.create({
      data: { branchId, name, description, image, isActive: isActive ?? true },
    });
    return success(res, menu, 'Menu created', 201);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.get('/:id', authenticate, async (req, res) => {
  try {
    const menu = await prisma.menu.findUnique({
      where: { id: Number(req.params.id) },
      include: { menuItems: { include: { itemCategory: true } } },
    });
    if (!menu) return error(res, 'Not found', 404);
    return success(res, menu);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.put('/:id', authenticate, async (req, res) => {
  try {
    const { name, description, image, isActive } = req.body;
    const menu = await prisma.menu.update({
      where: { id: Number(req.params.id) },
      data: {
        ...(name !== undefined && { name }),
        ...(description !== undefined && { description }),
        ...(image !== undefined && { image }),
        ...(isActive !== undefined && { isActive }),
      },
    });
    return success(res, menu);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.delete('/:id', authenticate, async (req, res) => {
  try {
    await prisma.menu.delete({ where: { id: Number(req.params.id) } });
    return success(res, null, 'Deleted');
  } catch (e) {
    return error(res, e.message, 500);
  }
});

// --- Menu Items scoped under a menu ---

router.get('/:menuId/items', authenticate, async (req, res) => {
  try {
    const menuId = Number(req.params.menuId);
    const items = await prisma.menuItem.findMany({
      where: { menuId },
      include: { itemCategory: true },
    });
    return success(res, items);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.post('/:menuId/items', authenticate, async (req, res) => {
  try {
    const menuId = Number(req.params.menuId);
    const branchId = req.user.branchId;
    const { itemCategoryId, name, description, price, image, isActive, preparationTime, isFeatured } = req.body;
    const item = await prisma.menuItem.create({
      data: {
        branchId,
        menuId,
        itemCategoryId: itemCategoryId ? Number(itemCategoryId) : null,
        name,
        description,
        price: Number(price),
        image,
        isActive: isActive ?? true,
        preparationTime: preparationTime ? Number(preparationTime) : null,
        isFeatured: isFeatured ?? false,
      },
    });
    return success(res, item, 'Item created', 201);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

module.exports = router;
