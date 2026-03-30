const router = require('express').Router();
const prisma = require('../lib/prisma');
const { authenticate } = require('../middleware/auth');
const { success, paginated, error } = require('../lib/response');

router.get('/', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const page = Number(req.query.page) || 1;
    const perPage = Number(req.query.per_page) || 20;
    const status = req.query.status;
    const where = { branchId, ...(status && { status }) };
    const [data, total] = await Promise.all([
      prisma.reservation.findMany({
        where,
        skip: (page - 1) * perPage,
        take: perPage,
        include: { table: true },
        orderBy: { reservedAt: 'asc' },
      }),
      prisma.reservation.count({ where }),
    ]);
    return paginated(res, data, total, page, perPage);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.post('/', authenticate, async (req, res) => {
  try {
    const branchId = req.user.branchId;
    const { tableId, customerName, customerPhone, partySize, reservedAt, notes } = req.body;
    const reservation = await prisma.reservation.create({
      data: {
        branchId,
        tableId: Number(tableId),
        customerName,
        customerPhone,
        partySize: Number(partySize),
        reservedAt: new Date(reservedAt),
        status: 'pending',
        notes,
      },
    });
    return success(res, reservation, 'Reservation created', 201);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.get('/:id', authenticate, async (req, res) => {
  try {
    const reservation = await prisma.reservation.findUnique({
      where: { id: Number(req.params.id) },
      include: { table: true },
    });
    if (!reservation) return error(res, 'Not found', 404);
    return success(res, reservation);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.put('/:id', authenticate, async (req, res) => {
  try {
    const { tableId, customerName, customerPhone, partySize, reservedAt, status, notes } = req.body;
    const reservation = await prisma.reservation.update({
      where: { id: Number(req.params.id) },
      data: {
        ...(tableId !== undefined && { tableId: Number(tableId) }),
        ...(customerName !== undefined && { customerName }),
        ...(customerPhone !== undefined && { customerPhone }),
        ...(partySize !== undefined && { partySize: Number(partySize) }),
        ...(reservedAt !== undefined && { reservedAt: new Date(reservedAt) }),
        ...(status !== undefined && { status }),
        ...(notes !== undefined && { notes }),
      },
    });
    return success(res, reservation);
  } catch (e) {
    return error(res, e.message, 500);
  }
});

router.delete('/:id', authenticate, async (req, res) => {
  try {
    await prisma.reservation.delete({ where: { id: Number(req.params.id) } });
    return success(res, null, 'Deleted');
  } catch (e) {
    return error(res, e.message, 500);
  }
});

module.exports = router;
