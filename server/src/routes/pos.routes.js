const router = require('express').Router();
const prisma = require('../lib/prisma');
const { authenticate } = require('../middleware/auth');
const { success, error } = require('../lib/response');

// Get all data needed to bootstrap the POS interface
router.get('/init', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const [menus, categories, tables, taxes, customers] = await Promise.all([
      prisma.menu.findMany({
        where: { branchId, isActive: true },
        include: { menuItems: { where: { isActive: true }, include: { itemCategory: true } } },
      }),
      prisma.itemCategory.findMany({ where: { branchId, isActive: true }, orderBy: { order: 'asc' } }),
      prisma.table.findMany({ where: { branchId, isActive: true }, include: { area: true } }),
      prisma.restaurantTax.findMany({ where: { branchId, isActive: true } }),
      prisma.customer.findMany({ where: { branchId } }),
    ]);
    return success(res, { menus, categories, tables, taxes, customers });
  } catch (e) {
    return error(res, e.message, 500);
  }
});

module.exports = router;
