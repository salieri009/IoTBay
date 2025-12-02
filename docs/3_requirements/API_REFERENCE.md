# API Reference

Complete API documentation for IoT Bay platform.

---

## API Overview

| Base URL | Environment |
|---|---|
| `http://localhost:8080` | Development |
| `https://api.iotbay.com` | Production |

### Authentication

All API endpoints (except `/login` and `/register`) require authentication via session cookie or JWT token.

```
Cookie: JSESSIONID=<session_id>
```

---

## Authentication Endpoints

### POST /login

Authenticate user with credentials.

**Request:**
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

**Response (Success):**
```json
{
  "success": true,
  "userId": 1,
  "username": "john_doe",
  "role": "customer"
}
```

**Response (Error):**
```json
{
  "success": false,
  "error": "Invalid email or password"
}
```

**Status Codes:**
- `200` - Login successful
- `401` - Invalid credentials
- `400` - Missing required fields

---

### POST /register

Register new user account.

**Request:**
```json
{
  "email": "newuser@example.com",
  "password": "SecurePass123!",
  "confirmPassword": "SecurePass123!",
  "firstName": "John",
  "lastName": "Doe"
}
```

**Response (Success):**
```json
{
  "success": true,
  "userId": 2,
  "message": "Account created successfully"
}
```

**Status Codes:**
- `201` - User created
- `400` - Validation error
- `409` - Email already exists

---

### POST /logout

Logout current user.

**Response:**
```json
{
  "success": true,
  "message": "Logged out successfully"
}
```

---

## Product Endpoints

### GET /products

Retrieve list of products with pagination.

**Query Parameters:**
| Parameter | Type | Description |
|---|---|---|
| `page` | integer | Page number (default: 1) |
| `limit` | integer | Items per page (default: 10, max: 100) |
| `category` | string | Filter by category ID |
| `sort` | string | Sort field: `name`, `price`, `rating`, `newest` |
| `order` | string | Sort order: `asc`, `desc` (default: `asc`) |

**Example Request:**
```
GET /products?page=1&limit=20&sort=price&order=asc
```

**Response:**
```json
{
  "products": [
    {
      "id": 1,
      "name": "IoT Sensor Kit",
      "description": "Complete sensor kit",
      "price": 99.99,
      "category": 2,
      "stock": 45,
      "rating": 4.5,
      "reviews": 128,
      "imageUrl": "/images/sensor-kit.jpg"
    },
    {
      "id": 2,
      "name": "MQTT Broker",
      "price": 299.99,
      "category": 3,
      "stock": 12,
      "rating": 4.8,
      "reviews": 87,
      "imageUrl": "/images/mqtt-broker.jpg"
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 156,
    "pages": 8
  }
}
```

**Status Codes:**
- `200` - Success
- `400` - Invalid parameters
- `500` - Server error

---

### GET /products/{id}

Retrieve specific product details.

**Path Parameters:**
- `id` - Product ID (integer)

**Response:**
```json
{
  "id": 1,
  "name": "IoT Sensor Kit",
  "description": "Complete 10-piece sensor kit for IoT projects",
  "price": 99.99,
  "category": 2,
  "categoryName": "Sensors",
  "stock": 45,
  "rating": 4.5,
  "reviews": 128,
  "imageUrl": "/images/sensor-kit.jpg",
  "specifications": {
    "quantity": 10,
    "types": ["temperature", "humidity", "pressure"],
    "warranty": "2 years"
  },
  "reviews": [
    {
      "id": 1,
      "userId": 5,
      "username": "jane_smith",
      "rating": 5,
      "title": "Excellent quality",
      "comment": "Great product, exactly as described",
      "date": "2025-01-15"
    }
  ]
}
```

**Status Codes:**
- `200` - Success
- `404` - Product not found
- `500` - Server error

---

### POST /products (Admin Only)

Create new product.

**Request:**
```json
{
  "name": "New IoT Device",
  "description": "Description here",
  "price": 149.99,
  "category": 2,
  "stock": 100,
  "imageUrl": "/images/new-device.jpg"
}
```

**Response:**
```json
{
  "success": true,
  "productId": 103,
  "message": "Product created successfully"
}
```

**Status Codes:**
- `201` - Product created
- `400` - Validation error
- `401` - Unauthorized
- `403` - Forbidden (not admin)

---

### PUT /products/{id} (Admin Only)

Update existing product.

**Request:**
```json
{
  "name": "Updated Product Name",
  "price": 129.99,
  "stock": 80
}
```

**Response:**
```json
{
  "success": true,
  "message": "Product updated successfully"
}
```

---

### DELETE /products/{id} (Admin Only)

Delete product.

**Response:**
```json
{
  "success": true,
  "message": "Product deleted successfully"
}
```

---

## Cart Endpoints

### GET /cart

Retrieve current user's shopping cart.

**Response:**
```json
{
  "cartId": 5,
  "items": [
    {
      "cartItemId": 10,
      "productId": 1,
      "productName": "IoT Sensor Kit",
      "price": 99.99,
      "quantity": 2,
      "subtotal": 199.98
    },
    {
      "cartItemId": 11,
      "productId": 3,
      "productName": "MQTT Broker",
      "price": 299.99,
      "quantity": 1,
      "subtotal": 299.99
    }
  ],
  "subtotal": 499.97,
  "tax": 45.00,
  "total": 544.97
}
```

---

### POST /cart

Add item to cart.

**Request:**
```json
{
  "productId": 1,
  "quantity": 2
}
```

**Response:**
```json
{
  "success": true,
  "cartItemId": 10,
  "cartTotal": 544.97,
  "message": "Item added to cart"
}
```

---

### PUT /cart/{cartItemId}

Update cart item quantity.

**Request:**
```json
{
  "quantity": 5
}
```

**Response:**
```json
{
  "success": true,
  "cartTotal": 599.97,
  "message": "Cart updated"
}
```

---

### DELETE /cart/{cartItemId}

Remove item from cart.

**Response:**
```json
{
  "success": true,
  "cartTotal": 299.99,
  "message": "Item removed from cart"
}
```

---

### DELETE /cart

Clear entire cart.

**Response:**
```json
{
  "success": true,
  "message": "Cart cleared"
}
```

---

## Order Endpoints

### POST /checkout

Create and process order.

**Request:**
```json
{
  "shippingAddress": {
    "street": "123 Main St",
    "city": "Sydney",
    "state": "NSW",
    "zipCode": "2000"
  },
  "paymentMethod": "credit_card",
  "cardNumber": "4111111111111111"
}
```

**Response:**
```json
{
  "success": true,
  "orderId": 45,
  "orderNumber": "ORD-2025-0045",
  "total": 544.97,
  "message": "Order placed successfully"
}
```

---

### GET /orders

Retrieve user's order history.

**Query Parameters:**
- `page` - Page number (default: 1)
- `limit` - Items per page (default: 10)

**Response:**
```json
{
  "orders": [
    {
      "orderId": 45,
      "orderNumber": "ORD-2025-0045",
      "orderDate": "2025-01-20",
      "status": "delivered",
      "total": 544.97,
      "itemCount": 3
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 10,
    "total": 5
  }
}
```

---

### GET /orders/{orderId}

Retrieve specific order details.

**Response:**
```json
{
  "orderId": 45,
  "orderNumber": "ORD-2025-0045",
  "orderDate": "2025-01-20",
  "status": "delivered",
  "items": [
    {
      "productId": 1,
      "productName": "IoT Sensor Kit",
      "quantity": 2,
      "price": 99.99,
      "subtotal": 199.98
    }
  ],
  "shippingAddress": {
    "street": "123 Main St",
    "city": "Sydney",
    "state": "NSW",
    "zipCode": "2000"
  },
  "subtotal": 499.97,
  "shipping": 10.00,
  "tax": 45.00,
  "total": 544.97,
  "trackingNumber": "TRK-123456789"
}
```

---

## Review Endpoints

### GET /products/{productId}/reviews

Retrieve product reviews.

**Query Parameters:**
- `page` - Page number (default: 1)
- `sort` - Sort by: `recent`, `helpful`, `rating-high`, `rating-low`

**Response:**
```json
{
  "reviews": [
    {
      "reviewId": 1,
      "userId": 5,
      "username": "jane_smith",
      "rating": 5,
      "title": "Excellent quality",
      "comment": "Great product, exceeded expectations",
      "helpful": 12,
      "unhelpful": 1,
      "date": "2025-01-15",
      "verified": true
    }
  ],
  "pagination": {
    "page": 1,
    "total": 128
  }
}
```

---

### POST /reviews

Submit product review.

**Request:**
```json
{
  "productId": 1,
  "rating": 5,
  "title": "Great product",
  "comment": "Really impressed with quality and speed of delivery"
}
```

**Response:**
```json
{
  "success": true,
  "reviewId": 129,
  "message": "Review submitted successfully"
}
```

---

## Category Endpoints

### GET /categories

Retrieve all product categories.

**Response:**
```json
{
  "categories": [
    {
      "id": 1,
      "name": "Microcontrollers",
      "description": "Arduino, ESP8266, etc.",
      "productCount": 24
    },
    {
      "id": 2,
      "name": "Sensors",
      "description": "Temperature, humidity, pressure, etc.",
      "productCount": 45
    }
  ]
}
```

---

## User Endpoints

### GET /profile

Retrieve current user profile.

**Response:**
```json
{
  "userId": 1,
  "username": "john_doe",
  "email": "john@example.com",
  "firstName": "John",
  "lastName": "Doe",
  "phone": "+61 2 1234 5678",
  "role": "customer",
  "memberSince": "2024-06-15",
  "totalOrders": 5,
  "totalSpent": 2450.50
}
```

---

### PUT /profile

Update user profile.

**Request:**
```json
{
  "firstName": "John",
  "lastName": "Smith",
  "phone": "+61 2 9876 5432"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Profile updated successfully"
}
```

---

### PUT /profile/password

Change password.

**Request:**
```json
{
  "currentPassword": "OldPassword123!",
  "newPassword": "NewPassword456!",
  "confirmPassword": "NewPassword456!"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Password changed successfully"
}
```

---

## Search Endpoints

### GET /search

Search products.

**Query Parameters:**
- `q` - Search query (required)
- `page` - Page number (default: 1)
- `category` - Filter by category
- `minPrice` - Minimum price
- `maxPrice` - Maximum price

**Response:**
```json
{
  "results": [
    {
      "id": 1,
      "name": "IoT Sensor Kit",
      "price": 99.99,
      "rating": 4.5,
      "imageUrl": "/images/sensor-kit.jpg"
    }
  ],
  "total": 24,
  "query": "sensor",
  "executionTime": "45ms"
}
```

---

## Error Responses

### Standard Error Format

```json
{
  "success": false,
  "error": "Error message here",
  "errorCode": "PRODUCT_NOT_FOUND",
  "statusCode": 404
}
```

### Common Error Codes

| Code | Status | Description |
|---|---|---|
| `INVALID_CREDENTIALS` | 401 | Email or password incorrect |
| `UNAUTHORIZED` | 401 | User not authenticated |
| `FORBIDDEN` | 403 | User lacks permission |
| `NOT_FOUND` | 404 | Resource not found |
| `VALIDATION_ERROR` | 400 | Invalid request data |
| `CONFLICT` | 409 | Resource already exists |
| `INTERNAL_ERROR` | 500 | Server error |

---

## Rate Limiting

API requests are rate limited to prevent abuse:

- **Authenticated Users**: 1000 requests per hour
- **Anonymous Users**: 100 requests per hour

Rate limit information is provided in response headers:

```
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 987
X-RateLimit-Reset: 2025-01-20T15:30:00Z
```

---

## Pagination

List endpoints support pagination:

**Query Parameters:**
- `page` - Page number (default: 1)
- `limit` - Items per page (default: 10, max: 100)

**Response Format:**
```json
{
  "items": [...],
  "pagination": {
    "page": 1,
    "limit": 10,
    "total": 156,
    "pages": 16
  }
}
```

---

## Resources

- [Backend Guide](./BACKEND_GUIDE.md) - Implementation details
- [Database Schema](../2_architecture/DATABASE_DESIGN.md) - Data structures
- [Error Prevention](../5_testing/ERROR_PREVENTION.md) - Common errors

---

**Last Updated**: December 3, 2025  
**Version**: 1.0.0  
**Status**: Documentation Complete
