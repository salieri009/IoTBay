# IoTBay Database Design Document

## 📋 Project Information

**Course**: 41025 Information Systems Development (ISD)  
**Assignment**: Assignment 2 - Autumn 2025  
**Institution**: University of Technology Sydney (UTS)  
**Project Type**: E-commerce Web Application for IoT Devices

---

## 📊 데이터베이스 개요

IoTBay는 IoT 전자상거래 플랫폼을 위한 관계형 데이터베이스 설계를 사용합니다. **UTS 41025 ISD Assignment 2 Autumn 2025**의 요구사항에 맞춰 확장성, 성능, 데이터 무결성을 고려한 정규화된 스키마를 제공합니다.

### 기술 스택
- **개발환경**: SQLite 3.x
- **운영환경**: PostgreSQL 13+ (권장) / MySQL 8.0+
- **ORM**: 사용자 정의 DAO 패턴
- **연결 풀링**: 사용자 정의 Connection Pool

---

## 🏗️ 데이터베이스 아키텍처

### 스키마 구조
```
iotbay_db
├── 사용자 관리 (User Management)
│   ├── users
│   ├── address_details
│   ├── reset_questions
│   └── access_logs
├── 상품 관리 (Product Management)
│   ├── categories
│   ├── products
│   └── reviews
├── 주문 관리 (Order Management)
│   ├── cart_items
│   ├── orders
│   ├── order_products
│   ├── payments
│   ├── payment_details
│   └── shipments
└── 위시리스트 (Wishlist)
    ├── wishlists
    └── wishlist_products
```

---

## 📋 테이블 설계

### 1. Users Table (사용자)
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
    last_login TIMESTAMP,
    
    -- 인덱스
    INDEX idx_email (email),
    INDEX idx_role (role),
    INDEX idx_created_at (created_at)
);
```

**필드 설명:**
- `id`: 기본키, 자동증가
- `email`: 유니크 이메일 주소 (로그인 ID)
- `password_hash`: SHA-256 해시된 비밀번호
- `salt`: 비밀번호 해싱용 솔트
- `role`: 사용자 역할 (customer/admin/staff)
- `is_active`: 계정 활성화 상태

### 2. Categories Table (카테고리)
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
    
    FOREIGN KEY (parent_category_id) REFERENCES categories(id),
    INDEX idx_parent (parent_category_id),
    INDEX idx_slug (slug)
);
```

**카테고리 계층 구조:**
```
1. Industrial IoT (산업용 IoT)
   ├── 1.1 Sensors (센서)
   ├── 1.2 Controllers (컨트롤러)
   └── 1.3 Connectivity (연결성)

2. Smart Home (스마트홈)
   ├── 2.1 Security (보안)
   ├── 2.2 Lighting (조명)
   └── 2.3 Climate (기후)

3. Agriculture (농업)
   ├── 3.1 Environmental Monitoring (환경 모니터링)
   ├── 3.2 Irrigation (관개)
   └── 3.3 Livestock (축산)

4. Warehouse (창고)
   ├── 4.1 Tracking (추적)
   ├── 4.2 Automation (자동화)
   └── 4.3 Inventory (재고)
```

### 3. Products Table (상품)
```sql
CREATE TABLE products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    category_id INTEGER NOT NULL,
    sku VARCHAR(50) UNIQUE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    short_description VARCHAR(500),
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    cost_price DECIMAL(10,2),
    stock_quantity INTEGER DEFAULT 0 CHECK (stock_quantity >= 0),
    low_stock_threshold INTEGER DEFAULT 10,
    weight DECIMAL(8,2),
    dimensions VARCHAR(100), -- "L x W x H cm"
    image_url VARCHAR(255),
    gallery_images TEXT, -- JSON array of image URLs
    specifications TEXT, -- JSON object for technical specs
    is_active BOOLEAN DEFAULT true,
    is_featured BOOLEAN DEFAULT false,
    meta_title VARCHAR(255),
    meta_description VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (category_id) REFERENCES categories(id),
    INDEX idx_category (category_id),
    INDEX idx_sku (sku),
    INDEX idx_name (name),
    INDEX idx_price (price),
    INDEX idx_stock (stock_quantity),
    INDEX idx_featured (is_featured),
    FULLTEXT INDEX idx_search (name, description, short_description)
);
```

**Specifications JSON 예시:**
```json
{
  "technical": {
    "voltage": "3.3V-5V",
    "interface": "I2C/SPI",
    "accuracy": "±0.5°C",
    "resolution": "0.1°C",
    "operating_temp": "-40°C to +85°C"
  },
  "physical": {
    "dimensions": "25 x 15 x 8 mm",
    "weight": "5g",
    "material": "PCB + Plastic"
  },
  "compatibility": [
    "Arduino",
    "Raspberry Pi",
    "ESP32"
  ]
}
```

### 4. Cart Items Table (장바구니)
```sql
CREATE TABLE cart_items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_product (user_id, product_id),
    INDEX idx_user (user_id),
    INDEX idx_product (product_id)
);
```

### 5. Orders Table (주문)
```sql
CREATE TABLE orders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_number VARCHAR(20) UNIQUE NOT NULL,
    user_id INTEGER NOT NULL,
    status VARCHAR(20) DEFAULT 'pending' CHECK (
        status IN ('pending', 'confirmed', 'processing', 'shipped', 'delivered', 'cancelled', 'refunded')
    ),
    subtotal DECIMAL(10,2) NOT NULL,
    tax_amount DECIMAL(10,2) DEFAULT 0,
    shipping_cost DECIMAL(10,2) DEFAULT 0,
    discount_amount DECIMAL(10,2) DEFAULT 0,
    total_amount DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'KRW',
    
    -- 배송 정보
    shipping_first_name VARCHAR(100),
    shipping_last_name VARCHAR(100),
    shipping_company VARCHAR(100),
    shipping_address_line1 VARCHAR(255),
    shipping_address_line2 VARCHAR(255),
    shipping_city VARCHAR(100),
    shipping_postal_code VARCHAR(10),
    shipping_country VARCHAR(2) DEFAULT 'KR',
    shipping_phone VARCHAR(20),
    
    -- 청구 정보
    billing_first_name VARCHAR(100),
    billing_last_name VARCHAR(100),
    billing_address_line1 VARCHAR(255),
    billing_address_line2 VARCHAR(255),
    billing_city VARCHAR(100),
    billing_postal_code VARCHAR(10),
    billing_country VARCHAR(2) DEFAULT 'KR',
    
    notes TEXT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    confirmed_at TIMESTAMP,
    shipped_at TIMESTAMP,
    delivered_at TIMESTAMP,
    
    FOREIGN KEY (user_id) REFERENCES users(id),
    INDEX idx_user (user_id),
    INDEX idx_status (status),
    INDEX idx_order_date (order_date),
    INDEX idx_order_number (order_number)
);
```

### 6. Order Products Table (주문 상품)
```sql
CREATE TABLE order_products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    product_name VARCHAR(255) NOT NULL, -- 주문 시점의 상품명 저장
    product_sku VARCHAR(50),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    product_snapshot TEXT, -- JSON으로 주문 시점의 상품 정보 저장
    
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id),
    INDEX idx_order (order_id),
    INDEX idx_product (product_id)
);
```

### 7. Payments Table (결제)
```sql
CREATE TABLE payments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER NOT NULL,
    payment_method VARCHAR(50) NOT NULL, -- 'card', 'bank_transfer', 'mobile', 'crypto'
    payment_status VARCHAR(20) DEFAULT 'pending' CHECK (
        payment_status IN ('pending', 'completed', 'failed', 'cancelled', 'refunded')
    ),
    amount DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'KRW',
    transaction_id VARCHAR(100),
    gateway_response TEXT, -- JSON 형태의 PG사 응답
    paid_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (order_id) REFERENCES orders(id),
    INDEX idx_order (order_id),
    INDEX idx_status (payment_status),
    INDEX idx_transaction (transaction_id)
);
```

### 8. Reviews Table (리뷰)
```sql
CREATE TABLE reviews (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    order_id INTEGER, -- 구매 확인용
    rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
    title VARCHAR(200),
    comment TEXT,
    images TEXT, -- JSON array of image URLs
    is_verified BOOLEAN DEFAULT false, -- 구매 확인된 리뷰
    is_approved BOOLEAN DEFAULT false, -- 관리자 승인
    helpful_count INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    UNIQUE KEY unique_user_product_order (user_id, product_id, order_id),
    INDEX idx_product (product_id),
    INDEX idx_user (user_id),
    INDEX idx_rating (rating),
    INDEX idx_approved (is_approved)
);
```

### 9. Access Logs Table (접근 로그)
```sql
CREATE TABLE access_logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    action VARCHAR(100) NOT NULL,
    resource VARCHAR(255),
    method VARCHAR(10),
    ip_address VARCHAR(45),
    user_agent TEXT,
    request_data TEXT, -- JSON 형태의 요청 데이터
    response_status INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_user (user_id),
    INDEX idx_action (action),
    INDEX idx_created_at (created_at),
    INDEX idx_ip (ip_address)
);
```

### 10. Wishlists Table (위시리스트)
```sql
CREATE TABLE wishlists (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    name VARCHAR(100) DEFAULT 'My Wishlist',
    is_default BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user (user_id)
);

CREATE TABLE wishlist_products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    wishlist_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (wishlist_id) REFERENCES wishlists(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    UNIQUE KEY unique_wishlist_product (wishlist_id, product_id),
    INDEX idx_wishlist (wishlist_id),
    INDEX idx_product (product_id)
);
```

---

## 🔧 인덱스 최적화

### 성능 최적화를 위한 복합 인덱스
```sql
-- 상품 검색 최적화
CREATE INDEX idx_products_search ON products(category_id, is_active, price);
CREATE INDEX idx_products_featured ON products(is_featured, is_active, created_at DESC);

-- 주문 관리 최적화
CREATE INDEX idx_orders_user_status ON orders(user_id, status, order_date DESC);
CREATE INDEX idx_order_products_order_product ON order_products(order_id, product_id);

-- 장바구니 최적화
CREATE INDEX idx_cart_user_updated ON cart_items(user_id, updated_at DESC);

-- 로그 분석 최적화
CREATE INDEX idx_access_logs_date_action ON access_logs(created_at DESC, action);
```

---

## 🔗 관계형 설계

### Entity Relationship Diagram
```
Users (1) ←→ (N) Orders
Users (1) ←→ (N) Cart_Items
Users (1) ←→ (N) Reviews
Users (1) ←→ (N) Wishlists

Categories (1) ←→ (N) Products
Categories (1) ←→ (N) Categories (Self-reference)

Products (1) ←→ (N) Cart_Items
Products (1) ←→ (N) Order_Products
Products (1) ←→ (N) Reviews
Products (1) ←→ (N) Wishlist_Products

Orders (1) ←→ (N) Order_Products
Orders (1) ←→ (N) Payments

Wishlists (1) ←→ (N) Wishlist_Products
```

### 참조 무결성 제약조건
- **CASCADE**: 사용자 삭제 시 관련 장바구니, 위시리스트도 삭제
- **SET NULL**: 사용자 삭제 시 접근 로그의 user_id는 NULL로 설정
- **RESTRICT**: 상품이 주문에 포함된 경우 삭제 제한

---

## 📊 데이터 볼륨 예상

### 초기 데이터 (1년차)
- **사용자**: 10,000명
- **상품**: 5,000개
- **카테고리**: 50개
- **주문**: 50,000건
- **리뷰**: 15,000개
- **접근 로그**: 10,000,000건

### 성장 예상 (3년차)
- **사용자**: 100,000명
- **상품**: 50,000개
- **주문**: 1,000,000건
- **리뷰**: 300,000개
- **접근 로그**: 300,000,000건

---

## 🔒 보안 고려사항

### 개인정보 보호
```sql
-- 민감한 정보 암호화 (애플리케이션 레벨)
- 비밀번호: SHA-256 + Salt
- 전화번호: AES-256 암호화
- 주소: 부분 마스킹

-- 접근 권한 제어
GRANT SELECT, INSERT, UPDATE ON iotbay.* TO 'app_user'@'localhost';
GRANT ALL PRIVILEGES ON iotbay.* TO 'admin_user'@'localhost';
```

### 데이터 백업 전략
```sql
-- 일일 백업
mysqldump --single-transaction --triggers --routines iotbay > backup_$(date +%Y%m%d).sql

-- 주간 전체 백업
mysqldump --all-databases > full_backup_$(date +%Y%m%d).sql
```

---

## 🚀 성능 최적화

### 파티셔닝 전략 (향후 적용)
```sql
-- 날짜별 파티셔닝 (접근 로그)
ALTER TABLE access_logs PARTITION BY RANGE (YEAR(created_at)) (
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p2026 VALUES LESS THAN (2027),
    PARTITION p2027 VALUES LESS THAN (2028)
);

-- 해시 파티셔닝 (대용량 주문 데이터)
ALTER TABLE orders PARTITION BY HASH(user_id) PARTITIONS 8;
```

### 캐싱 전략
- **상품 목록**: Redis 캐시 (5분)
- **카테고리 트리**: 메모리 캐시 (1시간)
- **사용자 세션**: Redis (30분)
- **검색 결과**: Elasticsearch (실시간)

---

## 📈 모니터링 및 분석

### 성능 모니터링 쿼리
```sql
-- 느린 쿼리 식별
SELECT query_time, lock_time, rows_sent, rows_examined, sql_text
FROM mysql.slow_log 
WHERE query_time > 1
ORDER BY query_time DESC;

-- 인덱스 사용률 확인
SELECT object_schema, object_name, index_name, count_star, count_read
FROM performance_schema.table_io_waits_summary_by_index_usage
WHERE object_schema = 'iotbay';
```

### 데이터 분석 뷰
```sql
-- 매출 분석 뷰
CREATE VIEW sales_summary AS
SELECT 
    DATE(order_date) as order_date,
    COUNT(*) as order_count,
    SUM(total_amount) as total_sales,
    AVG(total_amount) as avg_order_value
FROM orders 
WHERE status IN ('confirmed', 'shipped', 'delivered')
GROUP BY DATE(order_date);

-- 인기 상품 뷰
CREATE VIEW popular_products AS
SELECT 
    p.id, p.name, p.price,
    COUNT(op.product_id) as order_count,
    SUM(op.quantity) as total_sold,
    AVG(r.rating) as avg_rating
FROM products p
LEFT JOIN order_products op ON p.id = op.product_id
LEFT JOIN reviews r ON p.id = r.product_id
GROUP BY p.id, p.name, p.price
ORDER BY total_sold DESC;
```

---

## 🔄 마이그레이션 스크립트

### 개발 → 운영 환경 마이그레이션
```sql
-- SQLite → PostgreSQL 마이그레이션
-- 1. 스키마 변환
-- 2. 데이터 타입 조정
-- 3. 자동증가 시퀀스 생성
-- 4. 제약조건 재생성

-- PostgreSQL 전용 기능 활용
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm"; -- 유사 문자열 검색

-- 전문 검색 인덱스
CREATE INDEX idx_products_fts ON products USING gin(to_tsvector('english', name || ' ' || description));
```

이 데이터베이스 설계는 확장성, 성능, 보안을 고려하여 IoTBay 플랫폼의 모든 요구사항을 충족할 수 있도록 구성되었습니다.
