const router = require('express').Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const prisma = require('../lib/prisma');
const { authenticate } = require('../middleware/auth');
const { success, error } = require('../lib/response');

router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    if (!email || !password) return error(res, 'Email and password required');
    const user = await prisma.user.findFirst({
      where: { email },
      include: { modelHasRoles: { include: { role: true } } },
    });
    if (!user) return error(res, 'Invalid credentials', 401);
    const valid = await bcrypt.compare(password, user.password);
    if (!valid) return error(res, 'Invalid credentials', 401);
    const role = user.modelHasRoles[0]?.role;
    const token = jwt.sign(
      { userId: user.id, restaurantId: user.restaurantId, branchId: user.branchId, role: role?.name },
      process.env.JWT_SECRET,
      { expiresIn: process.env.JWT_EXPIRES_IN || '7d' }
    );
    res.cookie('token', token, {
      httpOnly: true,
      sameSite: 'lax',
      secure: process.env.NODE_ENV === 'production',
      maxAge: 7 * 24 * 60 * 60 * 1000,
    });
    const { password: _, ...userWithoutPassword } = user;
    return success(res, { user: userWithoutPassword, token, role: role?.name });
  } catch (e) {
    console.error(e);
    return error(res, 'Server error', 500);
  }
});

router.post('/logout', (req, res) => {
  res.clearCookie('token');
  return success(res, null, 'Logged out');
});

router.get('/me', authenticate, async (req, res) => {
  const { password: _, ...userWithoutPassword } = req.user;
  return success(res, userWithoutPassword);
});

module.exports = router;
