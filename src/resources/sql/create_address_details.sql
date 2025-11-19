-- Address Details Table
-- Stores multiple addresses for users (shipping and billing)

CREATE TABLE IF NOT EXISTS address_details (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    address_type TEXT NOT NULL CHECK (address_type IN ('shipping', 'billing', 'both')),
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    company TEXT,
    address_line1 TEXT NOT NULL,
    address_line2 TEXT,
    city TEXT NOT NULL,
    state TEXT,
    postal_code TEXT NOT NULL,
    country TEXT NOT NULL DEFAULT 'US',
    phone TEXT,
    is_default BOOLEAN NOT NULL DEFAULT 0,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now')),
    
    FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_address_details_user ON address_details(user_id);
CREATE INDEX IF NOT EXISTS idx_address_details_type ON address_details(address_type);
CREATE INDEX IF NOT EXISTS idx_address_details_default ON address_details(user_id, is_default);

