const prisma = require('../lib/prisma');

const requireRole = (...roles) => (req, res, next) => {
  if (!req.user) return res.status(401).json({ success: false, message: 'Unauthorized' });
  if (roles.includes(req.user.role) || req.user.role === 'Super Admin') return next();
  return res.status(403).json({ success: false, message: 'Forbidden' });
};

const requirePermission = (permission) => async (req, res, next) => {
  if (!req.user) return res.status(401).json({ success: false, message: 'Unauthorized' });
  if (req.user.role === 'Super Admin') return next();
  const roleIds = req.user.modelHasRoles.map((mr) => mr.roleId);
  const rolePerms = await prisma.roleHasPermission.findMany({
    where: { roleId: { in: roleIds } },
    include: { permission: true },
  });
  const hasPermission = rolePerms.some((rp) => rp.permission.name === permission);
  if (hasPermission) return next();
  return res.status(403).json({ success: false, message: `Forbidden: missing permission: ${permission}` });
};

module.exports = { requireRole, requirePermission };
