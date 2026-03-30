const router = require('express').Router();
const prisma = require('../lib/prisma');
const { authenticate } = require('../middleware/auth');
const { success, paginated, error } = require('../lib/response');

// List waiter requests
router.get('/', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const page = Number(req.query.page) || 1;
    const perPage = Number(req.query.per_page) || 20;
    const status = req.query.status;

    const where = {
      branchId,
      ...(status && { status }),
    };

    const [data, total] = await Promise.all([
      prisma.waiterRequest.findMany({
        where,
        skip: (page - 1) * perPage,
        take: perPage,
        include: { table: true },
        orderBy: { createdAt: 'desc' },
      }),
      prisma.waiterRequest.count({ where }),
    ]);
    return paginated(res, data, total, page, perPage);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

// Create a waiter request
router.post('/', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const { tableId, message } = req.body;
    if (!tableId) return error(res, 'tableId is required', 422);

    const request = await prisma.waiterRequest.create({
      data: {
        branchId,
        tableId: Number(tableId),
        message: message || null,
        status: 'pending',
      },
      include: { table: true },
    });
    return success(res, request, 'Request created', 201);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

// Update waiter request status
router.put('/:id', authenticate, async (req, res) => {
  try {
    const { status, message } = req.body;
    const request = await prisma.waiterRequest.update({
      where: { id: Number(req.params.id) },
      data: {
        ...(status !== undefined && { status }),
        ...(message !== undefined && { message }),
      },
      include: { table: true },
    });
    return success(res, request);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

// Delete / resolve a waiter request
router.delete('/:id', authenticate, async (req, res) => {
  try {
    await prisma.waiterRequest.delete({ where: { id: Number(req.params.id) } });
    return success(res, null, 'Deleted');
  } catch (e) {
    return error(res, e.message, 500);
  }
});

module.exports = router;
