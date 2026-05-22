# IoTBay — Developer Guide

> UTS 41025 Internet Software Development — Assignment 2  
> Last updated: 2026-05-22

---

## Table of Contents
1. [System Architecture](#1-system-architecture)
2. [Technology Stack](#2-technology-stack)
3. [Project Structure](#3-project-structure)
4. [Feature Diagrams](#4-feature-diagrams)
   - [F05 — Shipment Management](#f05--shipment-management)
   - [F06 — User Management](#f06--user-management)
   - [F07 — Customer Management](#f07--customer-management)
   - [F08 — Staff Management](#f08--staff-management)
   - [F09 — Supplier Management](#f09--supplier-management)
   - [F10 — Data Management](#f10--data-management)
5. [Database Schema](#5-database-schema)
6. [Security Patterns](#6-security-patterns)
7. [Running Locally](#7-running-locally)

---

## 1. System Architecture

```mermaid
graph TB
    subgraph Browser
        A[User Browser]
    end

    subgraph "Servlet Layer (Java EE)"
        B[HttpServlet Controllers]
        C[JSP Views]
        D[Tag Library / Layout Tags]
    end

    subgraph "DAO Layer"
        E[DAO Interfaces]
        F[DAO Implementations]
    end

    subgraph "Utilities"
        G[SecurityUtil]
        H[PasswordUtil]
        I[CSVUtil]
        J[DatabaseInitializer]
        K[DIContainer]
    end

    subgraph "Persistence"
        L[(SQLite Database)]
    end

    A -->|HTTP Request| B
    B -->|forward| C
    C -->|tag lib| D
    B --> E
    E --> F
    F --> K
    K --> L
    B --> G
    B --> H
    B --> I
    J -->|init on startup| L
```

---

## 2. Technology Stack

| Layer | Technology |
|-------|-----------|
| Web Server | Eclipse Jetty 9 (via `jetty:run`) |
| Servlet API | Jakarta EE / `javax.servlet` |
| View | JSP + JSTL + Custom Tag Library (`<t:base>`) |
| CSS | Tailwind CSS (utility-first) |
| Database | SQLite (file-based, `iotbay.db`) |
| Build | Maven 3 |
| Java | Java 11+ |

---

## 3. Project Structure

```
src/main/
├── java/
│   ├── controller/          # Servlet controllers (one per feature)
│   ├── dao/
│   │   ├── interfaces/      # DAO contracts (UserDAO, ProductDAO, …)
│   │   └── *DAOImpl.java    # SQLite implementations
│   ├── model/               # POJOs (User, Product, Order, Shipment, …)
│   ├── config/
│   │   └── DIContainer.java # Simple DI + DB connection pool
│   └── utils/
│       ├── DatabaseInitializer.java
│       ├── SecurityUtil.java   # CSRF, sanitize, session checks
│       ├── PasswordUtil.java   # BCrypt hashing
│       ├── CSVUtil.java        # CSV parse / generate
│       └── ErrorAction.java    # Centralised error forwarding
└── webapp/
    ├── admin/               # Admin JSPs (customer, staff, supplier)
    ├── WEB-INF/
    │   ├── views/           # Main feature JSPs
    │   └── tags/layout/     # <t:base> layout tag
    └── assets/              # CSS / JS
```

---

## 4. Feature Diagrams

### F05 — Shipment Management

**URL pattern:** `/shipment/*`  
**Controller:** `ShipmentController`

```mermaid
sequenceDiagram
    actor Customer
    participant OrderList as orderList.jsp
    participant ShipCtrl as ShipmentController
    participant ShipDAO as ShipmentDAOImpl
    participant DB as SQLite

    Customer->>OrderList: View my orders
    OrderList->>Customer: [PENDING order] "Add Shipment" button
    Customer->>ShipCtrl: GET /shipment/form?orderId=X
    ShipCtrl->>Customer: shipment-form.jsp (create mode)
    Customer->>ShipCtrl: POST /shipment/create (carrier, date, address…)
    ShipCtrl->>ShipDAO: createShipment(shipment)
    ShipDAO->>DB: INSERT INTO shipment …
    ShipCtrl->>Customer: Redirect → /shipment/list

    Customer->>ShipCtrl: GET /shipment/list
    ShipCtrl->>ShipDAO: findByUserId(userId)
    ShipDAO->>DB: SELECT * FROM shipment WHERE order_id IN (…)
    ShipCtrl->>Customer: shipment-list.jsp

    Customer->>ShipCtrl: GET /shipment/view/42
    ShipCtrl->>ShipDAO: findById(42)
    ShipCtrl->>Customer: shipment-view.jsp
    Customer->>ShipCtrl: POST /shipment/delete (PENDING only)
    ShipCtrl->>ShipDAO: deleteShipment(42)
```

**Status lifecycle:**

```mermaid
stateDiagram-v2
    [*] --> PENDING : created
    PENDING --> PREPARING : staff updates
    PREPARING --> SHIPPED : staff updates
    SHIPPED --> DELIVERED : staff updates
    PENDING --> [*] : deleted by customer
    PREPARING --> [*] : deleted by customer
```

---

### F06 — User Management

**URL pattern:** `/api/manage/users/*`  
**Controllers:** `ManageUserController`, `UpdateUserController`, `DeleteUserController`

```mermaid
flowchart TD
    A[Staff/Admin Login] --> B[GET /api/manage/users/]
    B --> C{Search params?}
    C -- yes --> D[searchUsers name+phone]
    C -- no  --> E[getAllUsers]
    D --> F[manage-users.jsp]
    E --> F

    F --> G[Edit user]
    G --> H[GET /manage/users/update?id=X]
    H --> I[getUserById]
    I --> J[manage-user-form.jsp Edit mode]
    J --> K[POST /manage/users/update]
    K --> L[updateUser in DB]
    L --> M[Redirect manage-users]

    F --> N[Delete user]
    N --> O[POST /manage/users/delete]
    O --> P[deleteUser in DB]
    P --> M
```

---

### F07 — Customer Management

**URL pattern:** `/admin/customer/*`  
**Controller:** `CustomerController`

```mermaid
flowchart TD
    A[Admin/Staff] --> B[GET /admin/customer/]
    B --> C{Search name or type?}
    C -- yes --> D[searchCustomers role=customer]
    C -- no  --> E[getCustomers role=customer]
    D --> F[customer-list.jsp]
    E --> F

    F --> G[Create new]
    G --> H[customer-form.jsp create mode]
    H --> I[POST /admin/customer/create]
    I --> J[createUser role=customer customerType=…]

    F --> K[Edit]
    K --> L[customer-form.jsp edit mode]
    L --> M[POST /admin/customer/update]
    M --> N[updateUser in DB]

    F --> O[View]
    O --> P[customer-view.jsp]
    P --> Q[DELETE /admin/customer/delete]
    Q --> R[deleteUser in DB]
```

**Customer Type field** is stored in `User.customerType` (`individual` / `company`).

---

### F08 — Staff Management

**URL pattern:** `/admin/staff/*`  
**Controller:** `StaffController`

```mermaid
flowchart TD
    A[Admin/Staff] --> B[GET /admin/staff/]
    B --> C{Search name or position?}
    C -- yes --> D[searchStaff role=staff]
    C -- no  --> E[getStaff role=staff]
    D --> F[staff-list.jsp]
    E --> F

    F --> G[Create staff]
    G --> H[staff-form.jsp create]
    H --> I[POST /admin/staff/create]
    I --> J[createUser role=staff position=…]

    F --> K[Edit staff]
    K --> L[staff-form.jsp edit]
    L --> M[POST /admin/staff/update]
    M --> N[updateUser in DB]

    F --> O[View / Delete]
    O --> P[staff-view.jsp]
    P --> Q[POST /admin/staff/delete]
```

**Position values:** `salesperson` | `manager` | `support` | `technician`  
Stored in `User.position` column.

---

### F09 — Supplier Management

**URL pattern:** `/admin/supplier/*`  *(fully implemented, no changes)*

```mermaid
flowchart LR
    A[Admin] --> B[/admin/supplier/]
    B --> C[supplier-list.jsp]
    C --> D[/admin/supplier/form] --> E[Create]
    C --> F[/admin/supplier/edit/id] --> G[Update]
    C --> H[/admin/supplier/delete] --> I[Delete]
```

---

### F10 — Data Management

**URL pattern:** `/api/dataManagement/*`  
**Controller:** `DataManagementController`

```mermaid
flowchart TD
    A[Admin/Staff] --> B[data-management.jsp]

    B --> C[Export]
    C --> D[GET /exportUsers] --> DA[users_export.csv]
    C --> E[GET /exportProducts] --> EA[products_export.csv]
    C --> F[GET /exportOrders] --> FA[orders_export.csv]
    C --> G[GET /exportAccessLogs] --> GA[access_logs_export.csv]

    B --> H[Import]
    H --> I[POST /import multipart CSV]
    I --> J{Valid headers?}
    J -- no  --> K[Error → data-management.jsp]
    J -- yes --> L[import-preview.jsp]
    L --> M[POST /confirmImport]
    M --> N[Bulk INSERT via UserDAO / ProductDAO]
    N --> O[Success message → dashboard]

    B --> P[Bulk Delete]
    P --> Q[POST /bulkDelete ids[]+deleteType]
    Q --> R[deleteUser / deleteProduct per ID]
    R --> O
```

**Supported import entity types:**

| entityType | Expected CSV Headers |
|------------|---------------------|
| `users` | Email, First Name, Last Name, Phone, Is Active |
| `products` | Name, Category, Price, Stock Quantity, Description |

---

## 5. Database Schema

```mermaid
erDiagram
    User {
        INTEGER user_id PK
        TEXT email
        TEXT password
        TEXT firstName
        TEXT lastName
        TEXT phone
        TEXT postalCode
        TEXT addressLine1
        TEXT addressLine2
        TEXT dateOfBirth
        TEXT role
        TEXT customerType
        TEXT position
        INTEGER isActive
        TEXT createdAt
        TEXT updatedAt
    }

    Order {
        INTEGER order_id PK
        INTEGER user_id FK
        REAL total_amount
        TEXT status
        TEXT shipping_address
        TEXT payment_method
        TEXT order_date
    }

    Shipment {
        INTEGER shipment_id PK
        INTEGER order_id FK
        TEXT carrier
        TEXT shipping_status
        TEXT shipping_date
        TEXT delivery_date
        TEXT tracking_number
        TEXT notes
    }

    Product {
        INTEGER id PK
        INTEGER category_id
        TEXT name
        TEXT description
        REAL price
        INTEGER stock_quantity
        TEXT image_url
    }

    Supplier {
        INTEGER supplier_id PK
        TEXT name
        TEXT contactEmail
        TEXT contactPhone
        TEXT address
    }

    User ||--o{ Order : places
    Order ||--o{ Shipment : has
```

---

## 6. Security Patterns

| Concern | Implementation |
|---------|---------------|
| CSRF | `SecurityUtil.generateCSRFToken(request)` on every form; `validateCSRFToken(request)` in every POST handler |
| XSS | `SecurityUtil.sanitizeInput()` on all user text input; JSP `<c:out>` for output |
| Auth check | `session.getAttribute("user")` instanceof `User` in every controller |
| Role check | `"admin".equalsIgnoreCase(role) \|\| "staff".equalsIgnoreCase(role)` |
| Password | BCrypt via `PasswordUtil.hashPassword()` and `PasswordUtil.verifyPassword()` |
| SQL injection | Parameterised `PreparedStatement` throughout all DAOs |

---

## 7. Running Locally

```bash
# Clone
git clone https://github.com/salieri009/IoTBay.git
cd IoTBay

# Build & run (Jetty embedded)
mvn jetty:run

# Access
open http://localhost:8080
```

Default test accounts (seeded by `DatabaseInitializer`):

| Role | Email | Password |
|------|-------|----------|
| Admin | admin@iotbay.com | admin123 |
| Staff | staff@iotbay.com | staff123 |
| Customer | customer@iotbay.com | customer123 |

---

*Generated for the IoTBay project — UTS 41025 ISD Assignment 2.*
