# FR-005: Administrative Features

## Document Information
**Feature ID**: FR-005  
**Feature Name**: Administrative Features  
**Document Version**: 1.0  
**Last Updated**: 2025-11-20  
**Status**: Implemented  
**Priority**: High

---

## Overview

Administrative Features provide comprehensive management interfaces for system administrators and staff to manage users, products, orders, access logs, suppliers, and system analytics. This feature set enables efficient platform administration and monitoring.

---

## Functional Requirements

### FR-005.1: Admin Dashboard

#### FR-005.1.1: Dashboard Overview
- **REQ-005.1.1.1**: System SHALL provide admin dashboard (`admin-dashboard.jsp`)
- **REQ-005.1.1.2**: Dashboard SHALL display key statistics:
  - Total users count (with trend indicator)
  - Total products count (with trend indicator)
  - Total orders count (with trend indicator)
  - Total suppliers count (with trend indicator)
- **REQ-005.1.1.3**: Dashboard SHALL display recent activity:
  - Recent orders
  - New user registrations
  - Product updates
  - System events
- **REQ-005.1.1.4**: Dashboard SHALL provide quick action buttons:
  - Manage Users
  - Manage Products
  - View Orders
  - Access Logs
  - Supplier Management
  - Data Export
- **REQ-005.1.1.5**: Dashboard SHALL be accessible only to Staff and Admin roles

### FR-005.2: User Management

#### FR-005.2.1: User Listing
- **REQ-005.2.1.1**: System SHALL provide user management interface (`manage-users.jsp`)
- **REQ-005.2.1.2**: User list SHALL display:
  - Avatar/Initials
  - Name
  - Email
  - Role
  - Status (Active/Inactive badge)
  - Registration Date
  - Actions (View, Edit, Delete)
- **REQ-005.2.1.3**: System SHALL provide search functionality (by name, email)
- **REQ-005.2.1.4**: System SHALL provide filtering options:
  - Role (Customer, Staff, Admin)
  - Status (Active, Inactive)
  - Registration date range
- **REQ-005.2.1.5**: System SHALL support pagination for large user lists

#### FR-005.2.2: User Operations
- **REQ-005.2.2.1**: System SHALL allow viewing user details
- **REQ-005.2.2.2**: System SHALL allow editing user information (`manage-user-form.jsp`)
- **REQ-005.2.2.3**: System SHALL allow changing user role (Admin only)
- **REQ-005.2.2.4**: System SHALL allow activating/deactivating users
- **REQ-005.2.2.5**: System SHALL allow deleting users (soft delete)
- **REQ-005.2.2.6**: System SHALL allow viewing user orders
- **REQ-005.2.2.7**: System SHALL allow viewing user access logs
- **REQ-005.2.2.8**: System SHALL require confirmation for destructive actions

### FR-005.3: Product Management

#### FR-005.3.1: Product Listing
- **REQ-005.3.1.1**: System SHALL provide product management interface (`manage-products.jsp`)
- **REQ-005.3.1.2**: Product list SHALL display:
  - Product image (thumbnail)
  - Product name
  - Category
  - SKU
  - Price
  - Stock quantity
  - Status (Active/Inactive)
  - Actions (View, Edit, Delete)
- **REQ-005.3.1.3**: System SHALL provide search functionality (by name, SKU, description)
- **REQ-005.3.1.4**: System SHALL provide filtering options:
  - Category
  - Stock status (In Stock, Out of Stock, Low Stock)
  - Active status
- **REQ-005.3.1.5**: System SHALL support pagination

#### FR-005.3.2: Product Operations
- **REQ-005.3.2.1**: System SHALL allow creating new products (`manage-product-form.jsp`)
- **REQ-005.3.2.2**: System SHALL allow editing existing products
- **REQ-005.3.2.3**: System SHALL allow deleting products (soft delete)
- **REQ-005.3.2.4**: System SHALL allow updating stock quantities
- **REQ-005.3.2.5**: System SHALL allow managing product categories
- **REQ-005.3.2.6**: System SHALL allow uploading product images
- **REQ-005.3.2.7**: System SHALL allow managing product specifications
- **REQ-005.3.2.8**: System SHALL support bulk operations

### FR-005.4: Order Management

#### FR-005.4.1: Order Listing
- **REQ-005.4.1.1**: System SHALL provide order management interface (`manage-orders.jsp`)
- **REQ-005.4.1.2**: Order list SHALL display:
  - Order number
  - Customer name
  - Order date
  - Status badge
  - Total amount
  - Items count
  - Actions (View, Process, Cancel)
- **REQ-005.4.1.3**: System SHALL provide search functionality (order number, customer name)
- **REQ-005.4.1.4**: System SHALL provide filtering options:
  - Status (Pending, Processing, Shipped, Delivered, Cancelled)
  - Date range
  - Customer
- **REQ-005.4.1.5**: System SHALL support pagination

#### FR-005.4.2: Order Operations
- **REQ-005.4.2.1**: System SHALL allow viewing order details
- **REQ-005.4.2.2**: System SHALL allow updating order status
- **REQ-005.4.2.3**: System SHALL allow processing orders
- **REQ-005.4.2.4**: System SHALL allow cancelling orders
- **REQ-005.4.2.5**: System SHALL allow refunding orders
- **REQ-005.4.2.6**: System SHALL allow generating shipping labels (if implemented)
- **REQ-005.4.2.7**: System SHALL allow updating tracking information
- **REQ-005.4.2.8**: System SHALL support bulk order processing

### FR-005.5: Access Logging

#### FR-005.5.1: Log Viewing
- **REQ-005.5.1.1**: System SHALL provide access log management interface (`manage-access-logs.jsp`)
- **REQ-005.5.1.2**: Log list SHALL display:
  - Timestamp
  - User (name or "Guest")
  - Action
  - Resource (URL/endpoint)
  - Method (GET, POST, etc.)
  - IP Address
  - User Agent (truncated)
  - Response Status
  - Actions (View Details)
- **REQ-005.5.1.3**: System SHALL provide search functionality
- **REQ-005.5.1.4**: System SHALL provide filtering options:
  - User
  - Action type
  - Date range
  - IP address
  - Response status
- **REQ-005.5.1.5**: System SHALL support pagination
- **REQ-005.5.1.6**: System SHALL allow exporting logs to CSV

#### FR-005.5.2: Log Information
- **REQ-005.5.2.1**: System SHALL log all system access attempts
- **REQ-005.5.2.2**: Logs SHALL include:
  - User ID and name
  - Action performed
  - Timestamp
  - IP address
  - User agent
  - Request details
  - Response status
- **REQ-005.5.2.3**: System SHALL allow viewing detailed log information

### FR-005.6: Reports & Analytics

#### FR-005.6.1: Reports Dashboard
- **REQ-005.6.1.1**: System SHALL provide reports dashboard (`reports-dashboard.jsp`)
- **REQ-005.6.1.2**: Dashboard SHALL provide report categories:
  - Sales Reports
  - User Reports
  - Inventory Reports
- **REQ-005.6.1.3**: System SHALL allow generating reports with date range selection

#### FR-005.6.2: Sales Reports
- **REQ-005.6.2.1**: System SHALL provide revenue reports by period
- **REQ-005.6.2.2**: System SHALL provide sales by category reports
- **REQ-005.6.2.3**: System SHALL provide sales by product reports
- **REQ-005.6.2.4**: System SHALL provide top-selling products reports
- **REQ-005.6.2.5**: System SHALL provide revenue trends

#### FR-005.6.3: User Reports
- **REQ-005.6.3.1**: System SHALL provide user registration trends
- **REQ-005.6.3.2**: System SHALL provide active users reports
- **REQ-005.6.3.3**: System SHALL provide user activity reports
- **REQ-005.6.3.4**: System SHALL provide user engagement metrics

#### FR-005.6.4: Inventory Reports
- **REQ-005.6.4.1**: System SHALL provide stock levels reports
- **REQ-005.6.4.2**: System SHALL provide low stock alerts
- **REQ-005.6.4.3**: System SHALL provide product performance reports
- **REQ-005.6.4.4**: System SHALL provide stock movement history

### FR-005.7: Supplier Management

#### FR-005.7.1: Supplier Listing
- **REQ-005.7.1.1**: System SHALL provide supplier management interface (`admin/supplier-list.jsp`)
- **REQ-005.7.1.2**: Supplier list SHALL display:
  - Company name
  - Contact name
  - Email
  - Phone
  - City, Country
  - Status (Active/Inactive)
  - Product count
  - Actions (View, Edit, Delete)
- **REQ-005.7.1.3**: System SHALL provide search functionality
- **REQ-005.7.1.4**: System SHALL provide filtering options:
  - Status (Active, Inactive)
  - Country

#### FR-005.7.2: Supplier Operations
- **REQ-005.7.2.1**: System SHALL allow creating suppliers (`admin/supplier-form.jsp`)
- **REQ-005.7.2.2**: System SHALL allow viewing supplier details (`admin/supplier-view.jsp`)
- **REQ-005.7.2.3**: System SHALL allow editing suppliers
- **REQ-005.7.2.4**: System SHALL allow deleting suppliers
- **REQ-005.7.2.5**: System SHALL allow associating products with suppliers
- **REQ-005.7.2.6**: System SHALL check for associated products before deletion

---

## Acceptance Criteria

### AC-005.1: Admin Dashboard
- Dashboard displays accurate statistics
- Quick action buttons navigate correctly
- Recent activity is displayed
- Dashboard is accessible only to authorized users

### AC-005.2: User Management
- Users can be searched and filtered
- User operations (view, edit, delete) work correctly
- Role changes are applied correctly
- User status can be toggled

### AC-005.3: Product Management
- Products can be created, updated, and deleted
- Stock quantities can be updated
- Product search and filtering work correctly
- Bulk operations function properly

### AC-005.4: Order Management
- Orders can be viewed and processed
- Order status can be updated
- Order search and filtering work correctly
- Tracking information can be updated

### AC-005.5: Access Logging
- All system access is logged
- Logs can be searched and filtered
- Logs can be exported to CSV
- Detailed log information is accessible

---

## Dependencies

- **Database**: User, Products, Orders, Access_Logs, Suppliers tables
- **FR-001**: User Management (for role-based access)
- **FR-002**: Product Catalog (for product management)
- **FR-003**: E-commerce (for order management)

---

## Related Features

- **FR-001**: User Management (user management interface)
- **FR-002**: Product Catalog (product management interface)
- **FR-003**: E-commerce (order management interface)
- **FR-006**: Data Management & Export (data export functionality)

---

## API Endpoints

- `GET /admin-dashboard` - View admin dashboard
- `GET /manage/users` - View user management
- `GET /manage/products` - View product management
- `GET /manage/orders` - View order management
- `GET /manage/access-logs` - View access logs
- `GET /admin/supplier/` - View supplier management
- `GET /reports-dashboard` - View reports dashboard
- `GET /api/accessLog` - Get access logs (JSON)
- `GET /api/accessLog/user/{userId}` - Get user access logs

---

## Implementation Files

- `src/main/webapp/admin-dashboard.jsp`
- `src/main/webapp/manage-users.jsp`
- `src/main/webapp/manage-user-form.jsp`
- `src/main/webapp/manage-products.jsp`
- `src/main/webapp/manage-product-form.jsp`
- `src/main/webapp/manage-orders.jsp`
- `src/main/webapp/manage-access-logs.jsp`
- `src/main/webapp/admin/supplier-list.jsp`
- `src/main/webapp/admin/supplier-view.jsp`
- `src/main/webapp/admin/supplier-form.jsp`
- `src/main/webapp/reports-dashboard.jsp`
- `src/main/java/controller/AdminDashboardController.java`
- `src/main/java/controller/ManageUserController.java`
- `src/main/java/controller/ManageProductController.java`
- `src/main/java/controller/ManageOrderController.java`
- `src/main/java/controller/ManageAccessLogController.java`
- `src/main/java/controller/SupplierController.java`

---

**End of FR-005: Administrative Features**

