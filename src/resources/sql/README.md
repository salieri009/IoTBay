# SQL Schema Files

This directory contains SQL schema files for the IoTBay database.

## Table Creation Order

Tables should be created in the following order due to foreign key dependencies:

1. **User** (`create_user.sql`) - Base user table
2. **Categories** (`create_categories.sql`) - Product categories (self-referencing)
3. **Products** (`create_product.sql`) - Product catalog
4. **Cart Items** (`create_cart_items.sql`) - Shopping cart
5. **Orders** (`create_orders.sql`) - Order information
6. **Order Products** (`create_order_products.sql`) - Order line items
7. **Payments** (`create_payments.sql`) - Payment transactions
8. **Shipments** (`create_shipments.sql`) - Shipping information
9. **Reviews** (`create_reviews.sql`) - Product reviews
10. **Wishlists** (`create_wishlists.sql`) - User wishlists
11. **Wishlist Products** (`create_wishlists.sql`) - Wishlist items
12. **Address Details** (`create_address_details.sql`) - User addresses
13. **Reset Questions** (`create_reset_questions.sql`) - Password recovery
14. **Access Logs** (`create_access_log.sql`) - Access logging

## Usage

To create all tables:

```sql
.read create_user.sql
.read create_categories.sql
.read create_product.sql
.read create_cart_items.sql
.read create_orders.sql
.read create_order_products.sql
.read create_payments.sql
.read create_shipments.sql
.read create_reviews.sql
.read create_wishlists.sql
.read create_address_details.sql
.read create_reset_questions.sql
.read create_access_log.sql
```

## Notes

- All tables use SQLite syntax
- `IF NOT EXISTS` is used to prevent errors on re-creation
- Foreign keys use appropriate `ON DELETE` actions:
  - `CASCADE`: Delete related records (cart items, wishlist items)
  - `RESTRICT`: Prevent deletion if referenced (orders, products)
  - `SET NULL`: Set to NULL on deletion (access logs)
- Indexes are created for performance on frequently queried columns
- CHECK constraints ensure data integrity

