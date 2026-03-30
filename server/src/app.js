require('dotenv').config();
const express = require('express');
const cookieParser = require('cookie-parser');
const cors = require('cors');
const path = require('path');
const { apiLimiter, authLimiter } = require('./middleware/rateLimit');
const { csrfProtection, issueCsrfToken } = require('./middleware/csrf');

const app = express();

app.use(cors({
  origin: process.env.CLIENT_ORIGIN || 'http://localhost:5173',
  credentials: true,
}));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());

// CSRF token endpoint (exempt from CSRF check itself – it's a GET)
app.get('/api/csrf-token', issueCsrfToken);

// CSRF protection for all state-changing API requests
app.use('/api', csrfProtection);

// Rate limiting
app.use('/api', apiLimiter);
app.use('/api/auth', authLimiter);

// Serve uploaded files
app.use('/uploads', express.static(path.join(__dirname, '..', process.env.UPLOAD_DIR || 'uploads')));

// API routes
app.use('/api', require('./routes/index'));

// 404 handler
app.use((req, res) => {
  res.status(404).json({ success: false, message: 'Route not found' });
});

// Global error handler
app.use((err, req, res, next) => {
  console.error(err);
  res.status(err.status || 500).json({ success: false, message: err.message || 'Internal Server Error' });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`TableTrack server running on port ${PORT}`);
});

module.exports = app;
