# Architecture Overview

This section contains high-level system design documentation, including component organization, database schema, API design, and security architecture.

---

## 📚 Architecture Documents

| Document | Purpose | Audience |
|---|---|---|
| [Component Architecture](./COMPONENT_ARCHITECTURE.md) | How UI components are organized and designed | Frontend devs, architects |
| [Database Design](./DATABASE_DESIGN.md) | Database schema, tables, relationships | Backend devs, DBAs |
| [Design System](./DESIGN_SYSTEM.md) | Visual design, colors, typography, components | Designers, frontend devs |
| [API Design](./API_DESIGN.md) | API endpoints, request/response formats | Backend devs, frontend devs |
| [Security Architecture](./SECURITY_ARCHITECTURE.md) | Authentication, authorization, security measures | Security team, backend devs |

---

## 🏗️ System Design Principles

1. **Modularity**: System is organized into independent, reusable modules
2. **Scalability**: Design supports growth without major rewrites
3. **Maintainability**: Clear separation of concerns, consistent patterns
4. **Security**: Multi-layered security with defense in depth
5. **Performance**: Optimized for speed and resource efficiency

---

## 🔄 System Layers

```
┌─────────────────────────────┐
│   Presentation Layer (JSP)  │
├─────────────────────────────┤
│   Controller Layer (Servlets)│
├─────────────────────────────┤
│   Service/Business Logic    │
├─────────────────────────────┤
│   Data Access Layer (DAO)   │
├─────────────────────────────┤
│   Database (SQLite/PostgreSQL)│
└─────────────────────────────┘
```

---

## 📊 Data Architecture

- **Database**: SQLite (development), PostgreSQL (production)
- **ORM Pattern**: Custom DAO (Data Access Object)
- **Schema**: Normalized relational design
- See [Database Design](./DATABASE_DESIGN.md) for full schema

---

## 🎨 Component Architecture

- **Framework**: JSP/Servlet with component pattern
- **Design System**: Atomic Design (Atoms, Molecules, Organisms)
- **Styling**: CSS with theming support
- **Interactivity**: TypeScript/JavaScript
- See [Component Architecture](./COMPONENT_ARCHITECTURE.md) for details

---

## 🔐 Security Layers

- **Authentication**: Session-based with password hashing (SHA-256)
- **Authorization**: Role-Based Access Control (RBAC)
- **Input Validation**: Server-side validation, SQL injection prevention
- **CSRF Protection**: Token-based CSRF protection
- See [Security Architecture](./SECURITY_ARCHITECTURE.md) for full details

---

## 📡 API Architecture

- **Style**: RESTful endpoints
- **Format**: JSON request/response
- **Authentication**: Session cookies + API tokens
- **Versioning**: URL-based versioning (`/api/v1/...`)
- See [API Design](./API_DESIGN.md) for endpoints

---

## 🔗 Key Relationships

```
Users
  ├── Orders
  ├── Reviews
  ├── Cart Items
  └── Wishlist Items

Products
  ├── Reviews
  ├── Categories
  └── Suppliers

Orders
  ├── Order Items
  ├── Payments
  └── Shipments
```

---

## 🚀 Quick Navigation

- **Building UI components?** → [Component Architecture](./COMPONENT_ARCHITECTURE.md)
- **Working with data?** → [Database Design](./DATABASE_DESIGN.md)
- **Building APIs?** → [API Design](./API_DESIGN.md)
- **Implementing features?** → [Security Architecture](./SECURITY_ARCHITECTURE.md)

---

**Last Updated**: December 3, 2025  
**Version**: 1.0.0
