# Database Design

This document describes the relational database schema, table structures, relationships, and design decisions for IoT Bay.

**Course**: 41025 Information Systems Development (ISD)  
**Assignment**: Assignment 2 - Autumn 2025  
**Institution**: University of Technology Sydney (UTS)

---

## 📊 Database Overview

IoTBay uses a **normalized relational database** for data persistence, supporting:

- **Development**: SQLite 3.x (file-based, zero setup)
- **Production**: PostgreSQL 13+ or MySQL 8.0+
- **Data Access**: Custom DAO (Data Access Object) pattern
- **Connection Pooling**: Managed via custom pool

---

## 🏗️ Database Architecture

### Schema Organization

```
iotbay_db/
├── User Management
│   ├── users
│   ├── address_details
│   ├── reset_questions
│   └── access_logs
├── Product Management
│   ├── categories
│   ├── products
│   └── reviews
├── Order Management
│   ├── cart_items
│   ├── orders
│   ├── order_products
│   ├── payments
│   ├── payment_details
│   └── shipments
└── Wishlist
    ├── wishlists
    └── wishlist_products
```

---

## 📋 Core Tables

### 1. Users Table

```sql
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    salt VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    postal_code VARCHAR(10),
    address_line1 VARCHAR(255),
    address_line2 VARCHAR(255),
    payment_method VARCHAR(50),
    date_of_birth DATE,
    role VARCHAR(20) DEFAULT 'customer' CHECK (role IN ('customer', 'admin', 'staff')),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP
);

CREATE INDEX idx_email ON users(email);
CREATE INDEX idx_role ON users(role);
```

**Key Fields**:
- `id`: Auto-incrementing primary key
- `email`: Unique login identifier
- `password_hash`: SHA-256 hashed password
- `salt`: Password hashing salt
- `role`: User type (customer/admin/staff)
- `is_active`: Account status

---

### 2. Categories Table

```sql
CREATE TABLE categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    parent_category_id INTEGER,
    slug VARCHAR(100) UNIQUE,
    image_url VARCHAR(255),
    sort_order INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (parent_category_id) REFERENCES categories(id)
);
```

**Category Hierarchy**:
1. Industrial IoT
   - Sensors, Controllers, Connectivity
2. Smart Home
   - Security, Lighting, Climate Control
3. Agriculture
   - Environmental Monitoring, Irrigation
4. Warehouse
   - Tracking, Automation, Inventory

---

### 3. Products Table

```sql
CREATE TABLE products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    category_id INTEGER NOT NULL,
    sku VARCHAR(50) UNIQUE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    cost_price DECIMAL(10,2),
    stock_quantity INTEGER DEFAULT 0,
    low_stock_threshold INTEGER DEFAULT 10,
    weight DECIMAL(8,2),
    dimensions VARCHAR(100),
    image_url VARCHAR(255),
    gallery_images TEXT,
    specifications TEXT,
    is_active BOOLEAN DEFAULT true,
    is_featured BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE INDEX idx_category ON products(category_id);
CREATE INDEX idx_sku ON products(sku);
```

**Key Fields**:
- `sku`: Stock Keeping Unit (unique identifier)
- `specifications`: JSON object for technical specs
- `gallery_images`: JSON array of image URLs

---

### 4. Cart Items Table

```sql
CREATE TABLE cart_items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);
```

---

### 5. Orders Table

```sql
CREATE TABLE orders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    order_number VARCHAR(50) UNIQUE,
    status VARCHAR(50) DEFAULT 'pending' 
        CHECK (status IN ('pending', 'confirmed', 'shipped', 'delivered', 'cancelled')),
    total_amount DECIMAL(10,2) NOT NULL,
    shipping_address TEXT NOT NULL,
    billing_address TEXT NOT NULL,
    shipping_method VARCHAR(50),
    tracking_number VARCHAR(100),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE INDEX idx_user_id ON orders(user_id);
CREATE INDEX idx_status ON orders(status);
CREATE INDEX idx_order_number ON orders(order_number);
```

---

### 6. Reviews Table

```sql
CREATE TABLE reviews (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    title VARCHAR(255),
    comment TEXT,
    is_verified_purchase BOOLEAN DEFAULT false,
    helpful_count INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE INDEX idx_product_id ON reviews(product_id);
CREATE INDEX idx_rating ON reviews(rating);
```

---

### 7. Access Logs Table

```sql
CREATE TABLE access_logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    event_type VARCHAR(50),
    resource_path VARCHAR(255),
    ip_address VARCHAR(45),
    user_agent TEXT,
    status_code INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE INDEX idx_user_id ON access_logs(user_id);
CREATE INDEX idx_created_at ON access_logs(created_at);
```

---

## 🔗 Entity Relationships

```
Users
  ├─ 1 to Many ─ Orders
  ├─ 1 to Many ─ Cart Items
  ├─ 1 to Many ─ Reviews
  ├─ 1 to Many ─ Access Logs
  └─ 1 to Many ─ Wishlists

Products
  ├─ Many to 1 ─ Categories
  ├─ 1 to Many ─ Reviews
  ├─ 1 to Many ─ Cart Items
  └─ 1 to Many ─ Order Products

Orders
  ├─ Many to 1 ─ Users
  ├─ 1 to Many ─ Order Products
  ├─ 1 to Many ─ Payments
  └─ 1 to Many ─ Shipments
```

---

## 🎯 Design Decisions

### Normalization
- **3rd Normal Form**: Minimal redundancy, referential integrity
- **No ENUM columns**: Use VARCHAR with CHECK constraints for portability
- **JSON fields**: For flexible specifications and addresses

### Indexing Strategy
- Primary keys on all tables
- Foreign keys indexed for join performance
- Search columns indexed (email, sku, name)
- Status columns indexed for filtering

### Data Integrity
- NOT NULL constraints on required fields
- CHECK constraints for valid values
- FOREIGN KEYs for referential integrity
- UNIQUE constraints for identifiers

---

## 📊 Data Volume Estimates

| Table | Est. Rows | Notes |
|---|---|---|
| users | 10K | Growing with registrations |
| products | 5K | Core inventory |
| orders | 100K | Historical orders |
| reviews | 50K | Product feedback |
| cart_items | 10K | Current carts |
| categories | 50 | Fairly static |
| access_logs | 1M+ | Regularly archived |

---

## 🔐 Security Considerations

- **Passwords**: SHA-256 with salt (minimum 16-byte salt)
- **PII**: Consider encryption at rest for PII columns
- **Audit Trail**: Access logs track all significant actions
- **Row-Level Security**: Implement via application logic

---

## 📈 Scaling Considerations

### Partitioning
- **access_logs**: Partition by date (monthly)
- **orders**: Partition by date (yearly)

### Replication
- Read replicas for reporting
- Write-primary for transactional data

### Caching
- Cache frequently accessed products
- Cache category hierarchy
- Cache user preferences

---

## 🔗 Related Documentation

- [Backend Guide](../4_development/BACKEND_GUIDE.md)
- [Database Setup](../4_development/DATABASE_SETUP.md)
- [API Design](./API_DESIGN.md)

---

**Last Updated**: December 3, 2025  
**Version**: 1.0.0  
**Status**: Frozen (v1.0.0)
