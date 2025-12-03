# Architecture Overview

**Version**: 1.0.0  
**Last Updated**: December 3, 2025  
**Status**: Published  
**Audience**: Architects, Developers, Technical Leads

---

This section contains high-level system design documentation, including component organization, database schema, API design, and security architecture.

---

## 📚 Architecture Documents

| Document | Purpose | Audience |
|---|---|---|
| [COMPONENT_ARCHITECTURE.md](./COMPONENT_ARCHITECTURE.md) | UI component organization and design patterns | Frontend devs, architects |
| [COMPONENT_ARCHITECTURE.en_docs.md](./COMPONENT_ARCHITECTURE.en_docs.md) | Detailed multilingual component guide (1,162 lines) | Frontend devs, architects |
| [DATABASE_DESIGN.md](./DATABASE_DESIGN.md) | Database schema, tables, relationships | Backend devs, DBAs |
| [DATABASE_DESIGN.en_docs.md](./DATABASE_DESIGN.en_docs.md) | Extended database documentation | Backend devs, DBAs |
| [DESIGN_SYSTEM.en_docs.md](./DESIGN_SYSTEM.en_docs.md) | Comprehensive design philosophy (1,069 lines) | Designers, frontend devs |
| [MODERN_DESIGN_SYSTEM.en_docs.md](./MODERN_DESIGN_SYSTEM.en_docs.md) | CSS implementation guide (377 lines) | Frontend devs |

> **Note**: `.en_docs.md` files contain multilingual content and specialized implementation details complementing the standard English-only versions.

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
