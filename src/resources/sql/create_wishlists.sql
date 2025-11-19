-- Wishlists Table
-- Stores user wishlists

CREATE TABLE IF NOT EXISTS wishlists (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    name TEXT NOT NULL DEFAULT 'My Wishlist',
    is_default BOOLEAN NOT NULL DEFAULT 1,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    
    FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE
);

-- Wishlist Products Table
-- Stores products in wishlists

CREATE TABLE IF NOT EXISTS wishlist_products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    wishlist_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    added_at TEXT NOT NULL DEFAULT (datetime('now')),
    
    FOREIGN KEY (wishlist_id) REFERENCES wishlists(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    UNIQUE(wishlist_id, product_id)
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_wishlists_user ON wishlists(user_id);
CREATE INDEX IF NOT EXISTS idx_wishlist_products_wishlist ON wishlist_products(wishlist_id);
CREATE INDEX IF NOT EXISTS idx_wishlist_products_product ON wishlist_products(product_id);

