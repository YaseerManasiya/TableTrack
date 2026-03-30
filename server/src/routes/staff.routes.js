const router = require('express').Router();
const bcrypt = require('bcryptjs');
const prisma = require('../lib/prisma');
const { authenticate } = require('../middleware/auth');
const { success, paginated, error } = require('../lib/response');

router.get('/', authenticate, async (req, res) => {
  try {
    const restaurantId = req.user.restaurantId;
    const page = Number(req.query.page) || 1;
    const perPage = Number(req.query.per_page) || 20;
    const where = { restaurantId };
    const [data, total] = await Promise.all([
      prisma.user.findMany({
        where,
        skip: (page - 1) * perPage,
        take: perPage,
        select: {
          id: true,
          name: true,
          email: true,
          phoneNumber: true,
          branchId: true,
          restaurantId: true,
          createdAt: true,
          modelHasRoles: { include: { role: true } },
        },
        orderBy: { createdAt: 'desc' },
      }),
      prisma.user.count({ where }),
    ]);
    return paginated(res, data, total, page, perPage);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.post('/', authenticate, async (req, res) => {
  try {
    const restaurantId = req.user.restaurantId;
    const { name, email, password, phoneNumber, branchId, roleId } = req.body;
    const exists = await prisma.user.findFirst({ where: { email } });
    if (exists) return error(res, 'Email already in use');
    const hashed = await bcrypt.hash(password, 10);
    const user = await prisma.user.create({
      data: {
        restaurantId,
        branchId: branchId ? Number(branchId) : null,
        name,
        email,
        password: hashed,
        phoneNumber,
      },
    });
    if (roleId) {
      await prisma.modelHasRole.create({
        data: { roleId: Number(roleId), modelType: 'App\\Models\\User', modelId: user.id },
      });
    }
    const { password: _, ...u } = user;
    return success(res, u, 'Staff created', 201);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.get('/:id', authenticate, async (req, res) => {
  try {
    const user = await prisma.user.findUnique({
      where: { id: Number(req.params.id) },
      select: {
        id: true,
        name: true,
        email: true,
        phoneNumber: true,
        branchId: true,
        restaurantId: true,
        createdAt: true,
        modelHasRoles: { include: { role: true } },
      },
    });
    if (!user) return error(res, 'Not found', 404);
    return success(res, user);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.put('/:id', authenticate, async (req, res) => {
  try {
    const { name, email, phoneNumber, branchId, roleId } = req.body;
    const user = await prisma.user.update({
      where: { id: Number(req.params.id) },
      data: {
        ...(name !== undefined && { name }),
        ...(email !== undefined && { email }),
        ...(phoneNumber !== undefined && { phoneNumber }),
        ...(branchId !== undefined && { branchId: branchId ? Number(branchId) : null }),
      },
    });
    if (roleId) {
      await prisma.modelHasRole.deleteMany({
        where: { modelId: user.id, modelType: 'App\\Models\\User' },
      });
      await prisma.modelHasRole.create({
        data: { roleId: Number(roleId), modelType: 'App\\Models\\User', modelId: user.id },
      });
    }
    const { password: _, ...u } = user;
    return success(res, u);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.delete('/:id', authenticate, async (req, res) => {
  try {
    await prisma.user.delete({ where: { id: Number(req.params.id) } });
    return success(res, null, 'Deleted');
  } catch (e) {
    return error(res, e.message, 500);
  }
});

module.exports = router;
