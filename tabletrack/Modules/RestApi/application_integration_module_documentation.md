# ApplicationIntegration Module Documentation

## Overview

**ApplicationIntegration** is a unified API layer that exposes POS and customer-facing functionality for external or companion applications (Flutter, mobile, web).

It wraps existing Laravel domain logic into stable, token-based endpoints and provides essential supporting utilities, including:

- Branch scoping and enforcement
- Menus and items
- Orders and payments
- Reservations and table management
- Customers and staff
- Device tokens
- In-app and broadcast notifications

The module integrates seamlessly without requiring changes to the core application.

---

## Module Objectives

- Provide a stable, well-documented API surface for POS and customer applications.
- Enforce restaurant and branch context for all data access.
- Expose the complete ordering lifecycle:
  
  **menus → items / variations / modifiers → carts → orders → payments**

- Support operational workflows:
  - Table management
  - Reservations
  - Order status updates
  - Delivery platforms
  - Staff (waiters / delivery)
  - Taxes and extra charges
  - Order types
  - Customer management

- Enable real-time and in-app notifications using:
  - Pusher / Laravel Broadcast
  - Stored notifications
  - Device token registration

- Keep the integration fully self-contained with no modifications required in the main application.

---

## Value Proposition

- A single API contract for all POS and customer-facing applications.
- Secure multi-branch enforcement ensuring users only access their assigned branch data.
- Faster application development with ready-made endpoints for menus, items, orders, payments, staff, customers, taxes, charges, and reservations.
- Real-time user experience via broadcast notifications, in-app APIs, and push notification support.
- Full compatibility with existing Laravel models and business logic.

---

## Quick Start Guide

### 1. Authentication

**Login Endpoint**
```
POST /api/application-integration/auth/login
```

Returns a **Bearer Token**.

**Required Headers (for all requests):**
```
Authorization: Bearer <token>
Accept: application/json
Content-Type: application/json
```

---

### 2. Branch Context

- Tokens are scoped to the user’s restaurant and branch.
- To switch branches:
```
POST /platform/switch-branch
```
(Include the desired branch in the request body.)

---

### 3. Catalog (POS)

**Menus & Categories**
- `GET /pos/menus`
- `GET /pos/categories`

**Items & Modifiers**
- `GET /pos/items`
- `GET /pos/items/category/{id}`
- `GET /pos/items/menu/{id}`
- `GET /pos/items/{id}/variations`
- `GET /pos/items/{id}/modifier-groups`

**Order Configuration**
- `GET /pos/order-types`
- `GET /pos/extra-charges/{orderType}`
- `GET /pos/delivery-platforms`
- `GET /pos/actions`
- `GET /pos/get-order-number`

---

### 4. Tables & Reservations

- List tables:
```
GET /pos/tables
```

- Force unlock a table:
```
POST /pos/tables/{tableId}/unlock
```

- Reservations:
```
GET /pos/reservations/today
GET /pos/reservations
POST /pos/reservations
POST /pos/reservations/{id}/status
```

---

### 5. Orders (POS)

**Create / Submit Order**
```
POST /pos/orders
```
(Include items, order_type, table_id, pax, charges, etc.)

**Retrieve Orders**
```
GET /pos/orders
GET /pos/orders/{id}
```

**Update Status**
```
POST /pos/orders/{id}/status
```

**Payment**
```
POST /pos/orders/{id}/pay
```

Request Body:
```json
{
  "amount": 20,
  "method": "cash|card|wallet|other"
}
```

Notes:
- Does not modify the `order_status` enum.
- Marks the order as paid and frees the table if dine-in.
- Returns `404` if the order does not belong to the active branch.

---

### 6. Customers

- List / Search:
```
GET /pos/customers
```

- Create / Update:
```
POST /pos/customers
```

- Phone country codes:
```
GET /pos/phone-codes
```

Global customer endpoints are also available under `/customer`.

---

### 7. Staff, Waiters & Roles

- List by role:
```
GET /pos/waiters?role=delivery
```

Optional:
```
include_permissions=true
```

- Platform endpoints:
```
GET /platform/roles
GET /platform/staff
GET /platform/permissions
```

---

### 8. Taxes, Charges, Restaurants & Branches

- Taxes:
```
GET /pos/taxes
```

- Extra charges:
```
GET /pos/extra-charges/{orderType}
```

- Restaurants:
```
GET /pos/restaurants
```

- Branches:
```
GET /pos/branches
```

---

## Typical POS Payment Flow

1. Create order via `POST /pos/orders`.
2. Collect payment externally (cash, card, or gateway).
3. Confirm payment using `POST /pos/orders/{id}/pay`.
4. Refresh orders and tables after success.

---

## Notifications & Push

### Register Device Token
```
POST /pos/notifications/register-token
```

```json
{
  "token": "<fcm_or_apns>",
  "platform": "ios|android|web",
  "device_id": "optional"
}
```

### In-App Notifications

- List:
```
GET /pos/notifications
```

- Mark as read:
```
POST /pos/notifications/{id}/read
```

- Send test (debug):
```
POST /pos/notifications/test
```

### Broadcast (Pusher / Laravel Echo)

- Channel:
```
private-App.Models.User.{userId}
```

- Event:
```
BroadcastNotificationCreated
```

Payload includes `title`, `body`, and `data`.

---

## Device Token Storage

- Table name: `ai_device_tokens`
- Fields:
  - `user_id`
  - `restaurant_id`
  - `branch_id`
  - `platform`
  - `device_id`
  - `token`

---

## Error Handling

- Always include:
```
Accept: application/json
```

- `401` – Missing or invalid token
- `403 / 404` – Branch scoping violation or resource not found
- `500` – Unexpected server error

Payments must always be handled via the `/pay` endpoint.

---

## Testing Examples

### Login
```bash
curl -X POST "https://yourdomain.com/api/application-integration/auth/login" \
-H "Content-Type: application/json" \
-d '{"email":"<user>","password":"<password>"}'
```

### Pay Order
```bash
curl -X POST "https://yourdomain.com/api/application-integration/pos/orders/62/pay" \
-H "Authorization: Bearer <token>" \
-H "Accept: application/json" \
-H "Content-Type: application/json" \
-d '{"amount":20,"method":"cash"}'
```

### Register Device Token
```bash
curl -X POST "https://yourdomain.com/api/application-integration/pos/notifications/register-token" \
-H "Authorization: Bearer <token>" \
-H "Accept: application/json" \
-H "Content-Type: application/json" \
-d '{"token":"<fcm>","platform":"android","device_id":"device-123"}'
```

---

## Deployment Notes

- Run module migrations to create the `ai_device_tokens` table.
- No core application changes are required.
- Clear caches if needed:
```
php artisan optimize:clear
```

---

**This document is the official reference for integrating the ApplicationIntegration module into any POS or customer-facing application.**

