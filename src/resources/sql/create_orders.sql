-- Orders Table
-- Stores customer orders with shipping and billing information

CREATE TABLE IF NOT EXISTS orders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_number TEXT UNIQUE NOT NULL,
    user_id INTEGER NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'confirmed', 'processing', 'shipped', 'delivered', 'cancelled', 'refunded')),
    subtotal REAL NOT NULL CHECK (subtotal >= 0),
    tax_amount REAL NOT NULL DEFAULT 0 CHECK (tax_amount >= 0),
    shipping_cost REAL NOT NULL DEFAULT 0 CHECK (shipping_cost >= 0),
    discount_amount REAL NOT NULL DEFAULT 0 CHECK (discount_amount >= 0),
    total_amount REAL NOT NULL CHECK (total_amount >= 0),
    currency TEXT DEFAULT 'USD',
    
    -- Shipping information
    shipping_first_name TEXT,
    shipping_last_name TEXT,
    shipping_company TEXT,
    shipping_address_line1 TEXT,
    shipping_address_line2 TEXT,
    shipping_city TEXT,
    shipping_postal_code TEXT,
    shipping_country TEXT DEFAULT 'US',
    shipping_phone TEXT,
    
    -- Billing information
    billing_first_name TEXT,
    billing_last_name TEXT,
    billing_address_line1 TEXT,
    billing_address_line2 TEXT,
    billing_city TEXT,
    billing_postal_code TEXT,
    billing_country TEXT DEFAULT 'US',
    
    notes TEXT,
    order_date TEXT NOT NULL DEFAULT (datetime('now')),
    confirmed_at TEXT,
    shipped_at TEXT,
    delivered_at TEXT,
    
    FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE RESTRICT
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_orders_user ON orders(user_id);
CREATE INDEX IF NOT EXISTS idx_orders_status ON orders(status);
CREATE INDEX IF NOT EXISTS idx_orders_order_date ON orders(order_date);
CREATE INDEX IF NOT EXISTS idx_orders_order_number ON orders(order_number);
CREATE INDEX IF NOT EXISTS idx_orders_user_status ON orders(user_id, status, order_date);

