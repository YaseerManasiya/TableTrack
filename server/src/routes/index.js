const router = require('express').Router();

router.use('/auth', require('./auth.routes'));
router.use('/dashboard', require('./dashboard.routes'));
router.use('/menus', require('./menu.routes'));
router.use('/menu-items', require('./menu-items.routes'));
router.use('/tables', require('./table.routes'));
router.use('/orders', require('./order.routes'));
router.use('/kots', require('./kot.routes'));
router.use('/staff', require('./staff.routes'));
router.use('/customers', require('./customer.routes'));
router.use('/reports', require('./report.routes'));
router.use('/reservations', require('./reservation.routes'));
router.use('/settings', require('./settings.routes'));
router.use('/pos', require('./pos.routes'));
router.use('/areas', require('./area.routes'));
router.use('/item-categories', require('./category.routes'));
router.use('/expenses', require('./expenses.routes'));
router.use('/delivery-executives', require('./delivery.routes'));
router.use('/payments', require('./payments.routes'));
router.use('/waiter-requests', require('./waiter-requests.routes'));
router.use('/modifier-groups', require('./modifier-groups.routes'));

module.exports = router;
