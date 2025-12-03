# API Design

**Document Version**: 1.0.0  
**Status**: Published  
**Last Updated**: December 3, 2025  
**Audience**: Architects, Developers  
**Maintained By**: IoT Bay Documentation Team

---

## Overview

IoT Bay uses a RESTful API design pattern for client-server communication, primarily serving the frontend JSP pages via AJAX and providing potential external integration points.

## Design Principles

1.  **Resource-Oriented**: URLs represent resources (e.g., `/api/products`, `/api/users`).
2.  **Stateless**: Each request contains all necessary information (via session cookies).
3.  **Standard Methods**: Uses HTTP methods explicitly (GET, POST, PUT, DELETE).
4.  **JSON Format**: Data exchange in JSON format.

## API Structure

### Base URL
- Development: `http://localhost:8080/IoTBay/api`
- Production: `https://iotbay.com/api`

### Standard Response Format

```json
{
  "success": true,
  "data": { ... },
  "message": "Operation successful",
  "timestamp": "2025-12-03T12:00:00Z"
}
```

### Error Format

```json
{
  "success": false,
  "error": "RESOURCE_NOT_FOUND",
  "message": "The requested product ID 123 does not exist",
  "statusCode": 404
}
```

## Core Resources

| Resource | Description | Endpoint |
|---|---|---|
| **Auth** | Login, register, logout | `/auth/*` |
| **Products** | Catalog management | `/products/*` |
| **Orders** | Order processing | `/orders/*` |
| **Users** | Profile management | `/users/*` |

## Detailed Documentation

For the complete list of endpoints, parameters, and examples, please refer to the **[API Reference](../3_requirements/API_REFERENCE.md)**.

## Related Documentation

- [API Reference](../3_requirements/API_REFERENCE.md)
- [Backend Guide](../4_development/BACKEND_GUIDE.md)
