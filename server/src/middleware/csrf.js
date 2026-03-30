/**
 * CSRF protection using the double-submit cookie pattern.
 *
 * Flow:
 *   1. GET /api/csrf-token   → issues a random token as a non-HttpOnly cookie
 *                              AND returns it in the JSON body.
 *   2. All state-changing requests must include the token in the
 *      X-CSRF-Token header. The middleware compares it to the csrf cookie.
 *   3. Requests that authenticate via Authorization: Bearer <jwt> (API / mobile)
 *      bypass the CSRF check entirely as they are not cookie-based sessions.
 *
 * Safe HTTP methods (GET, HEAD, OPTIONS) are always exempt.
 */
const crypto = require('crypto');

const CSRF_COOKIE = 'csrf_token';
const CSRF_HEADER = 'x-csrf-token';

/** Middleware: validates CSRF token on state-changing requests. */
const csrfProtection = (req, res, next) => {
  const safeMethods = ['GET', 'HEAD', 'OPTIONS'];
  if (safeMethods.includes(req.method)) return next();

  // Bearer token callers (mobile / API-key clients) skip CSRF
  if (req.headers.authorization?.startsWith('Bearer ')) return next();

  const cookieToken = req.cookies[CSRF_COOKIE];
  const headerToken = req.headers[CSRF_HEADER];

  if (cookieToken && headerToken && cookieToken === headerToken) {
    return next();
  }

  return res.status(403).json({ success: false, message: 'CSRF validation failed' });
};

/** Route handler: issues a fresh CSRF token. */
const issueCsrfToken = (req, res) => {
  const token = crypto.randomBytes(32).toString('hex');
  res.cookie(CSRF_COOKIE, token, {
    httpOnly: false, // must be readable by JS so the SPA can send it as a header
    sameSite: 'lax',
    secure: process.env.NODE_ENV === 'production',
    maxAge: 24 * 60 * 60 * 1000, // 24 h
  });
  return res.json({ success: true, data: { csrfToken: token } });
};

module.exports = { csrfProtection, issueCsrfToken };
