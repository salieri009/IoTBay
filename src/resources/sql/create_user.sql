-- User Table
-- Stores user account information

CREATE TABLE IF NOT EXISTS User (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    firstName TEXT NOT NULL,
    lastName TEXT NOT NULL,
    phoneNumber TEXT,
    postalCode TEXT,
    addressLine1 TEXT,
    addressLine2 TEXT,
    city TEXT,
    state TEXT,
    country TEXT DEFAULT 'US',
    dateOfBirth TEXT,        -- yyyy-MM-dd format recommended
    paymentMethod TEXT,
    createdAt TEXT NOT NULL DEFAULT (datetime('now')),
    updatedAt TEXT NOT NULL DEFAULT (datetime('now')),
    role TEXT NOT NULL CHECK(role IN ('customer', 'staff', 'admin')) DEFAULT 'customer',
    isActive BOOLEAN NOT NULL DEFAULT 1,
    last_login TEXT
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_user_email ON User(email);
CREATE INDEX IF NOT EXISTS idx_user_role ON User(role);
CREATE INDEX IF NOT EXISTS idx_user_created ON User(createdAt);
CREATE INDEX IF NOT EXISTS idx_user_active ON User(isActive);
