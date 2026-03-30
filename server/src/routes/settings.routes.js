const router = require('express').Router();
const prisma = require('../lib/prisma');
const { authenticate } = require('../middleware/auth');
const { success, error } = require('../lib/response');

router.get('/restaurant', authenticate, async (req, res) => {
  try {
    const restaurantId = req.user.restaurantId;
    const restaurant = await prisma.restaurant.findUnique({
      where: { id: restaurantId },
      include: { branches: true },
    });
    return success(res, restaurant);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.put('/restaurant', authenticate, async (req, res) => {
  try {
    const restaurantId = req.user.restaurantId;
    const { name, ownerName, email, phoneNumber } = req.body;
    const restaurant = await prisma.restaurant.update({
      where: { id: restaurantId },
      data: {
        ...(name !== undefined && { name }),
        ...(ownerName !== undefined && { ownerName }),
        ...(email !== undefined && { email }),
        ...(phoneNumber !== undefined && { phoneNumber }),
      },
    });
    return success(res, restaurant);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.get('/global', authenticate, async (req, res) => {
  try {
    const setting = await prisma.globalSetting.findFirst();
    return success(res, setting);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.get('/taxes', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const taxes = await prisma.restaurantTax.findMany({ where: { branchId } });
    return success(res, taxes);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.post('/taxes', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const { name, rate, type, isActive } = req.body;
    const tax = await prisma.restaurantTax.create({
      data: { branchId, name, rate: Number(rate), type: type || 'percentage', isActive: isActive ?? true },
    });
    return success(res, tax, 'Tax created', 201);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.put('/taxes/:id', authenticate, async (req, res) => {
  try {
    const { name, rate, type, isActive } = req.body;
    const tax = await prisma.restaurantTax.update({
      where: { id: Number(req.params.id) },
      data: {
        ...(name !== undefined && { name }),
        ...(rate !== undefined && { rate: Number(rate) }),
        ...(type !== undefined && { type }),
        ...(isActive !== undefined && { isActive }),
      },
    });
    return success(res, tax);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.delete('/taxes/:id', authenticate, async (req, res) => {
  try {
    await prisma.restaurantTax.delete({ where: { id: Number(req.params.id) } });
    return success(res, null, 'Deleted');
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.get('/roles', authenticate, async (req, res) => {
  try {
    const restaurantId = req.user.restaurantId;
    const roles = await prisma.role.findMany({
      where: { OR: [{ restaurantId }, { restaurantId: null }] },
    });
    return success(res, roles);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

// ── Restaurant Charges ───────────────────────────────────────────────────────

router.get('/charges', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const charges = await prisma.restaurantCharge.findMany({ where: { branchId } });
    return success(res, charges);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.post('/charges', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const { name, amount, type, orderType, isActive } = req.body;
    if (!name || amount === undefined) return error(res, 'Name and amount are required', 422);
    const charge = await prisma.restaurantCharge.create({
      data: {
        branchId,
        name,
        amount: Number(amount),
        type: type || 'fixed',
        orderType: orderType || null,
        isActive: isActive ?? true,
      },
    });
    return success(res, charge, 'Charge created', 201);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.put('/charges/:id', authenticate, async (req, res) => {
  try {
    const { name, amount, type, orderType, isActive } = req.body;
    const charge = await prisma.restaurantCharge.update({
      where: { id: Number(req.params.id) },
      data: {
        ...(name !== undefined && { name }),
        ...(amount !== undefined && { amount: Number(amount) }),
        ...(type !== undefined && { type }),
        ...(orderType !== undefined && { orderType }),
        ...(isActive !== undefined && { isActive }),
      },
    });
    return success(res, charge);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.delete('/charges/:id', authenticate, async (req, res) => {
  try {
    await prisma.restaurantCharge.delete({ where: { id: Number(req.params.id) } });
    return success(res, null, 'Deleted');
  } catch (e) {
    return error(res, e.message, 500);
  }
});

module.exports = router;
