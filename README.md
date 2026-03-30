# TableTrack — Restaurant Management SaaS

A full-stack restaurant management system built with React 19 + Vite + Express + Prisma + MySQL 8.

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | React 19, Vite 5, React Router v6, TanStack Query v5, Tailwind CSS |
| Backend | Express 4, Prisma 5, MySQL 8 |
| Auth | JWT (httpOnly cookies), bcryptjs |
| Other | concurrently, react-hot-toast, axios |

## Project Structure

```
TableTrack/
├── client/                  # React 19 + Vite SPA
│   ├── src/
│   │   ├── api/axios.js     # Axios instance with CSRF + JWT interceptors
│   │   ├── contexts/        # AuthContext
│   │   ├── components/      # Layout, Sidebar, Navbar, Modal, Pagination
│   │   └── pages/           # All feature pages
│   ├── vite.config.js       # Proxies /api to :3000
│   └── tailwind.config.js
├── server/                  # Express + Prisma API
│   ├── src/
│   │   ├── app.js           # Express entry point
│   │   ├── middleware/      # auth, permission, CSRF, rate-limit
│   │   ├── routes/          # All API route handlers
│   │   └── lib/             # Prisma client, response helpers
│   └── prisma/schema.prisma
└── package.json             # Root — concurrently scripts
```

## Quick Start

### 1. Prerequisites
- Node.js 20+
- MySQL 8

### 2. Install dependencies
```bash
npm run install:all
```

### 3. Configure environment
```bash
cp server/.env.example server/.env
# Edit server/.env with your MySQL credentials and JWT secret
```

### 4. Migrate database
```bash
npm run db:migrate
```

### 5. Seed database (optional)
```bash
npm run db:seed
```

### 6. Start development servers
```bash
npm run dev
```

- Client: http://localhost:5173
- API: http://localhost:3000

## Features

| Feature | Route |
|---------|-------|
| Dashboard | `/dashboard` |
| POS Interface | `/pos` |
| Order Management | `/orders` |
| KOT Board | `/kots` |
| Menu Management | `/menus` |
| Table Management | `/tables` |
| Reservations | `/reservations` |
| Customer Management | `/customers` |
| Staff Management | `/staff` |
| Reports | `/reports` |
| Settings | `/settings` |

## API Documentation

See [BACKEND_API_DOCUMENTATION.md](./BACKEND_API_DOCUMENTATION.md) for full API reference.

## Roles

| Role | Access |
|------|--------|
| Super Admin | Global — all restaurants |
| Admin | Restaurant-level management |
| Branch Head | Branch-level management |
| Waiter | Orders, tables, POS |
| Chef | KOT board |
