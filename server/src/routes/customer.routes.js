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
    const where = {
      branchId,
      ...(q && {
        OR: [
          { name: { contains: q } },
          { email: { contains: q } },
          { phoneNumber: { contains: q } },
        ],
      }),
    };
    const [data, total] = await Promise.all([
      prisma.customer.findMany({ where, skip: (page - 1) * perPage, take: perPage, orderBy: { createdAt: 'desc' } }),
      prisma.customer.count({ where }),
    ]);
    return paginated(res, data, total, page, perPage);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.post('/', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const { name, email, phoneNumber, address } = req.body;
    const cust = await prisma.customer.create({ data: { branchId, name, email, phoneNumber, address } });
    return success(res, cust, 'Customer created', 201);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.get('/:id', authenticate, async (req, res) => {
  try {
    const cust = await prisma.customer.findUnique({ where: { id: Number(req.params.id) } });
    if (!cust) return error(res, 'Not found', 404);
    return success(res, cust);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

// Customer's order history
router.get('/:id/orders', authenticate, async (req, res) => {
  try {
    const page = Number(req.query.page) || 1;
    const perPage = Number(req.query.per_page) || 20;
    const customerId = Number(req.params.id);
    const [data, total] = await Promise.all([
      prisma.order.findMany({
        where: { customerId },
        skip: (page - 1) * perPage,
        take: perPage,
        include: { table: true, orderItems: true, payments: true },
        orderBy: { createdAt: 'desc' },
      }),
      prisma.order.count({ where: { customerId } }),
    ]);
    return paginated(res, data, total, page, perPage);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.put('/:id', authenticate, async (req, res) => {
  try {
    const { name, email, phoneNumber, address } = req.body;
    const cust = await prisma.customer.update({
      where: { id: Number(req.params.id) },
      data: {
        ...(name !== undefined && { name }),
        ...(email !== undefined && { email }),
        ...(phoneNumber !== undefined && { phoneNumber }),
        ...(address !== undefined && { address }),
      },
    });
    return success(res, cust);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.delete('/:id', authenticate, async (req, res) => {
  try {
    await prisma.customer.delete({ where: { id: Number(req.params.id) } });
    return success(res, null, 'Deleted');
  } catch (e) {
    return error(res, e.message, 500);
  }
});

module.exports = router;
