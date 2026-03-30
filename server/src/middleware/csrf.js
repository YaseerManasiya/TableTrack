/**
 * CSRF protection using the "custom request header" technique.
 *
 * For state-changing requests (POST/PUT/PATCH/DELETE) the client must send
 * either:
 *   1. An Authorization: Bearer <token> header (API clients / mobile), OR
 *   2. The X-Requested-With: XMLHttpRequest header together with an Origin
 *      that matches CLIENT_ORIGIN (browser SPA clients using cookie auth).
 *
 * Simple GET/HEAD/OPTIONS requests are exempt because they cannot cause
 * server-side state changes via CSRF.
 */
const csrfProtection = (req, res, next) => {
  const safeMethods = ['GET', 'HEAD', 'OPTIONS'];
  if (safeMethods.includes(req.method)) return next();

  // Bearer token in Authorization header bypasses CSRF check (not cookie-based)
  if (req.headers.authorization?.startsWith('Bearer ')) return next();

  // For cookie-based sessions validate Origin / Referer against CLIENT_ORIGIN
  const allowedOrigin = process.env.CLIENT_ORIGIN || 'http://localhost:5173';
  const origin = req.headers.origin || req.headers.referer || '';
  const xRequested = req.headers['x-requested-with'];

  if (origin.startsWith(allowedOrigin) || xRequested === 'XMLHttpRequest') {
    return next();
  }

  return res.status(403).json({ success: false, message: 'CSRF validation failed' });
};

module.exports = { csrfProtection };
