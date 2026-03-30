const router = require('express').Router();
const prisma = require('../lib/prisma');
const { authenticate } = require('../middleware/auth');
const { success, paginated, error } = require('../lib/response');

router.get('/', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const page = Number(req.query.page) || 1;
    const perPage = Number(req.query.per_page) || 20;
    const where = {
      branchId,
      ...(req.query.active === 'true' && { isActive: true }),
    };
    const [data, total] = await Promise.all([
      prisma.deliveryExecutive.findMany({
        where,
        skip: (page - 1) * perPage,
        take: perPage,
        orderBy: { name: 'asc' },
      }),
      prisma.deliveryExecutive.count({ where }),
    ]);
    return paginated(res, data, total, page, perPage);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.post('/', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const { name, phoneNumber, isActive } = req.body;
    if (!name) return error(res, 'Name is required', 422);
    const executive = await prisma.deliveryExecutive.create({
      data: { branchId, name, phoneNumber: phoneNumber || null, isActive: isActive ?? true },
    });
    return success(res, executive, 'Delivery executive created', 201);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.get('/:id', authenticate, async (req, res) => {
  try {
    const executive = await prisma.deliveryExecutive.findUnique({
      where: { id: Number(req.params.id) },
    });
    if (!executive) return error(res, 'Not found', 404);
    return success(res, executive);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.put('/:id', authenticate, async (req, res) => {
  try {
    const { name, phoneNumber, isActive } = req.body;
    const executive = await prisma.deliveryExecutive.update({
      where: { id: Number(req.params.id) },
      data: {
        ...(name !== undefined && { name }),
        ...(phoneNumber !== undefined && { phoneNumber }),
        ...(isActive !== undefined && { isActive }),
      },
    });
    return success(res, executive);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.delete('/:id', authenticate, async (req, res) => {
  try {
    await prisma.deliveryExecutive.delete({ where: { id: Number(req.params.id) } });
    return success(res, null, 'Deleted');
  } catch (e) {
    return error(res, e.message, 500);
  }
});

module.exports = router;
