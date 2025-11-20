# IoTBay Features Documentation
## Comprehensive Feature List - Assignment Brief Complete Reference

**Course**: 41025 Information Systems Development (ISD)  
**Assignment**: Assignment 2 - Autumn 2025  
**Institution**: University of Technology Sydney (UTS)  
**Project Type**: E-commerce Web Application for IoT Devices  
**Document Version**: 2.1  
**Last Updated**: 2025-01-20

---

## Table of Contents

1. [User Management Features](#1-user-management-features)
2. [Product Catalog Features](#2-product-catalog-features)
3. [E-commerce Features](#3-e-commerce-features)
4. [Product Reviews & Ratings](#4-product-reviews--ratings)
5. [Administrative Features](#5-administrative-features)
6. [Data Management & Export](#6-data-management--export)
7. [Security Features](#7-security-features)
8. [UI/UX Features](#8-uiux-features)
9. [Accessibility Features](#9-accessibility-features)
10. [Performance Features](#10-performance-features)
11. [API Endpoints](#11-api-endpoints)
12. [Static Pages & Navigation](#12-static-pages--navigation)
13. [Technical Features](#13-technical-features)

---

## 1. User Management Features

### 1.1 User Registration & Authentication

#### Registration (`register.jsp`, `RegisterController`)
- **User Registration Form**
  - Full name input (first name, last name) with validation
  - Email address input with real-time validation
  - Password input with strength indicator (weak, medium, strong)
  - Password confirmation matching
  - Phone number input (optional, with formatting)
  - Business email validation for B2B users
  - Terms and conditions acceptance checkbox (required)
  - Privacy policy acceptance checkbox (required)
  - Client-side form validation (real-time feedback)
  - Server-side validation and sanitization
  - Error message display with clear feedback
  - Success message on successful registration
  - Redirect to welcome page after registration

#### Authentication (`login.jsp`, `LoginController`)
- **Login System**
  - Email-based login
  - Password authentication
  - "Remember me" functionality (session persistence)
  - Client-side form validation
  - Loading states during authentication
  - Error handling for invalid credentials
  - Account lockout prevention
  - Session management
  - Secure logout functionality (`logout.jsp`, `LogoutController`)
  - Redirect to welcome page after login
  - Redirect to goodbye page after logout

#### Password Management
- **Password Security**
  - SHA-256 hashing with salt
  - Password strength requirements
  - Password strength indicator (weak, medium, strong)
  - Password reset functionality (via reset questions)
  - Secure password storage
  - Password change functionality in profile

### 1.2 User Profile Management

#### Profile Viewing & Editing (`Profiles.jsp`, `UserProfileController`, `updateProfile.jsp`, `UpdateUserController`)
- **Profile Page**
  - Display user information
  - Edit profile functionality
  - Personal information management
    - Name, email, phone number
    - Address management (multiple addresses)
    - Payment method management
  - Profile picture upload (if implemented)
  - Account settings
  - Password change functionality
  - Order history link
  - Review history link

#### Account Management
- **Account Deletion** (`deleteaccount.jsp`)
  - Account deletion request
  - Confirmation dialog with clear warnings
  - Soft delete functionality
  - Data retention policy information
  - Loading states during deletion
  - Success/error feedback
  - Redirect to goodbye page after deletion

#### User Information API (`MeController`)
- **Current User Information**
  - GET `/api/me` - Retrieve current user information
  - JSON response format
  - Session-based authentication

### 1.3 Role-Based Access Control

#### User Roles
- **Customer Role**
  - Browse products
  - Add to cart
  - Place orders
  - View order history
  - Manage profile
  - View product details
  - Submit product reviews
  - View own reviews

- **Staff Role**
  - All customer permissions
  - View all orders
  - Process orders
  - View shipment information
  - Access customer information
  - View access logs
  - Moderate product reviews
  - Export data (CSV)

- **Admin Role**
  - All staff permissions
  - User management (CRUD operations)
  - Product management (CRUD operations)
  - System configuration
  - Access log management
  - Analytics and reporting
  - Supplier management
  - Data export and import

#### Session Management
- **Session Handling**
  - Secure session creation
  - Session timeout
  - Session invalidation on logout
  - Guest session support (for cart persistence)
  - Session security (CSRF protection)
  - Session-based user tracking

---

## 2. Product Catalog Features

### 2.1 Product Browsing

#### Homepage (`index.jsp`)
- **Hero Section**
  - Full-width banner with gradient background
  - Hero image showcasing IoT devices
  - Headline and subheadline
  - Call-to-action buttons (Browse Products, Learn More)
  - Trust badges

- **Category Quick Links**
  - Industrial IoT Devices
  - Warehouse Solutions
  - Agriculture Technology
  - Smart Home
  - Visual category cards with icons
  - Category descriptions
  - Direct navigation to category pages

- **Featured Products**
  - Curated product selection
  - Product grid display (4 columns desktop, 2 tablet, 1 mobile)
  - Product cards with key information
  - "View All Products" button

- **Trust Indicators**
  - Certification badges (CE, FCC, RoHS)
  - Support availability (24/7, Business Hours)
  - Warranty information
  - Shipping information

- **Newsletter Signup**
  - Email capture form
  - GDPR compliant
  - Subscription management

#### Product Listing Pages
- **Browse Page** (`browse.jsp`, `BrowseProductController`)
  - All products display
  - Search functionality
  - Filter sidebar
  - Product grid/list view toggle
  - Sorting options
  - Pagination
  - Results count display

- **Category Pages**
  - `categories.jsp` - Main category listing
  - `category-industrial.jsp` - Industrial IoT products
  - `category-warehouse.jsp` - Warehouse solutions
  - `category-agriculture.jsp` - Agriculture technology
  - `category-smarthome.jsp` - Smart home devices
  - Category-specific filtering
  - Breadcrumb navigation
  - Category descriptions
  - Skeleton loading states

### 2.2 Product Search & Filtering

#### Search Functionality (`BrowseProductController`)
- **Global Search** (Header search bar)
  - Keyword-based search
  - Autocomplete suggestions
  - Search results page
  - Search history (if implemented)
  - Search filters
  - URL-based search state (`/search?q=keyword`)

#### Multi-Dimensional Filtering
- **Category Filter**
  - Industrial
  - Warehouse
  - Agriculture
  - Smart Home
  - Multiple selection support

- **Protocol Filter**
  - LoRaWAN
  - WiFi
  - Zigbee
  - Bluetooth
  - Other protocols

- **Voltage Filter**
  - 12V DC
  - 24V DC
  - 5V DC
  - AC options
  - Custom voltage ranges

- **Price Range Filter**
  - Min/Max price sliders
  - Price range input fields
  - Real-time filtering

- **Stock Status Filter**
  - In stock only
  - Include out of stock
  - Low stock indicator

- **Compatibility Filter**
  - Home Assistant compatible
  - AWS IoT compatible
  - Other platform compatibility

- **Additional Filters**
  - Use case filtering
  - Brand filtering
  - Rating filtering
  - Certification filtering

#### Sorting Options
- Relevance (default)
- Price: Low to High
- Price: High to Low
- Name: A to Z
- Name: Z to A
- Newest First
- Most Popular
- Highest Rated

### 2.3 Product Details

#### Product Detail Page (`productDetails.jsp`, `ProductDetailsController`)
- **Product Information**
  - Product name and category
  - Product images (gallery with zoom)
  - Product description
  - Key specifications (displayed prominently)
  - Full technical specifications (accordion)
  - Price and stock status
  - Stock quantity indicator

- **Technical Specifications**
  - Communication protocol
  - Power requirements
  - Operating range
  - Dimensions and weight
  - Operating temperature
  - Certifications
  - Compatibility matrix
  - Integration guides (if available)

- **Trust Badges**
  - Certification badges (CE, FCC, RoHS)
  - Compatibility badges
  - Stock reliability indicator
  - Technical support level
  - Warranty information

- **Product Actions**
  - Add to Cart button
  - Quantity selector
  - Wishlist functionality (if implemented)
  - Share product
  - Print product details

- **Related Products**
  - Compatible products
  - Similar products
  - Frequently bought together
  - Recently viewed products

- **Product Reviews Section**
  - Average rating display
  - Total review count
  - Review list with pagination
  - Review submission link
  - Rating distribution chart

### 2.4 Product Management (Admin/Staff)

#### Product CRUD Operations
- **Create Product** (`manage-product-form.jsp`, `manage-products.jsp`, `ManageProductController`)
  - Product name, description
  - Category assignment
  - Price and stock quantity
  - Product images upload
  - Technical specifications
  - Compatibility information
  - Trust badges assignment

- **Update Product** (`UpdateProductController`)
  - Edit all product fields
  - Update stock quantities
  - Modify pricing
  - Update images
  - Edit specifications

- **Delete Product** (`DeleteProductController`)
  - Soft delete functionality
  - Archive products
  - Restore deleted products
  - Confirmation dialog

- **Product Listing Management**
  - Bulk operations
  - Product status management
  - Featured product selection
  - Category management

#### Product API (`ProductApiController`)
- **RESTful Product API**
  - GET `/api/v1/products` - List all products
  - GET `/api/v1/products/{id}` - Get product details
  - POST `/api/v1/products` - Create product (admin/staff)
  - PUT `/api/v1/products/{id}` - Update product (admin/staff)
  - DELETE `/api/v1/products/{id}` - Delete product (admin/staff)
  - JSON response format
  - Pagination support
  - Filtering support

---

## 3. E-commerce Features

### 3.1 Shopping Cart

#### Cart Functionality (`cart.jsp`, `CartController`)
- **Add to Cart**
  - Add products from product detail page
  - Add products from product listing pages
  - Quantity selection
  - Optimistic UI updates
  - Toast notifications
  - Cart count badge update in header

- **Cart Management**
  - View cart items
  - Update item quantities (`/api/cart/update`)
  - Remove items from cart (`/api/cart/remove`)
  - Clear entire cart
  - Cart persistence (guest and logged-in users)
  - Cart total calculation
  - Subtotal, tax, shipping calculation

- **Compatibility Checking**
  - Automatic compatibility warnings
  - Incompatible product alerts
  - Compatibility suggestions
  - Integration with CompatibilityEngine
  - Visual compatibility indicators

- **Cart Features**
  - Real-time price updates
  - Stock availability checking
  - Out-of-stock item handling
  - Save for later functionality (if implemented)
  - Cart item notes

#### Cart API Endpoints
- GET `/cart` - View cart page
- GET `/api/cart` - Get cart data (JSON)
- POST `/api/cart/add` - Add item to cart
- PUT `/api/cart/update` - Update cart item quantity
- DELETE `/api/cart/remove` - Remove item from cart
- DELETE `/api/cart/clear` - Clear entire cart

### 3.2 Checkout Process

#### Checkout Page (`checkout.jsp`, `CheckoutController`)
- **Checkout Progress Indicator**
  - 4-step progress: Cart → Shipping → Payment → Review
  - Visual progress bar
  - Step completion indicators
  - Navigation between steps

- **Shipping Information**
  - Full name input
  - Email address (with validation)
  - Phone number (with formatting)
  - Address line 1 and 2
  - City, state, postal code
  - Country selection
  - Use saved addresses option
  - Save current address option
  - Address validation

- **Shipping Method Selection**
  - Standard shipping
  - Express shipping
  - Overnight shipping
  - Shipping cost display
  - Estimated delivery dates
  - Real-time cost updates

- **Payment Information**
  - Payment method selection
    - Credit/Debit Card
    - PayPal
    - Bank Transfer
  - Credit card form
    - Card number (with formatting and type detection)
    - Expiry date (MM/YY format)
    - CVV (with help tooltip)
    - Cardholder name
    - Save card option
  - PayPal integration (redirect)
  - Bank transfer information display

- **Order Notes**
  - Optional order notes field
  - Special instructions
  - Delivery preferences

- **Review & Confirm**
  - Shipping address review
  - Payment method review
  - Order summary
  - Edit buttons for each section
  - Terms & conditions checkbox
  - Privacy policy checkbox

- **Order Placement**
  - Place Order button
  - Loading state during processing
  - Confirmation dialog
  - Order success page
  - Order number display

#### Order Summary Sidebar
- **Sticky Order Summary**
  - Cart items list
  - Item quantities and prices
  - Subtotal calculation
  - Shipping cost
  - Tax calculation
  - Total amount
  - Security badges
  - Estimated delivery date
  - Promo code input (if implemented)

### 3.3 Order Management

#### Order History (`orderList.jsp`, `OrderHistoryController`)
- **Order Listing**
  - List of all user orders
  - Order number display
  - Order date
  - Order status
  - Total amount
  - Order items summary
  - View order details
  - Reorder functionality (if implemented)
  - Filter by status
  - Filter by date range

#### Order Details
- **Order Information**
  - Order number and date
  - Order status and timeline
  - Shipping address
  - Billing address
  - Payment method
  - Order items with details
  - Subtotal, shipping, tax, total
  - Tracking information
  - Shipment details

#### Order Tracking
- **Shipment Tracking** (`ShipmentController`)
  - Tracking number
  - Shipment status
  - Delivery date estimate
  - Tracking history
  - Delivery confirmation
  - GET `/shipment/{id}` - View shipment details
  - GET `/shipment/tracking/{trackingNumber}` - Track by tracking number
  - GET `/shipment/search` - Search shipments

#### Order Status
- **Status Types**
  - Pending
  - Processing
  - Shipped
  - Delivered
  - Cancelled
  - Refunded

### 3.4 Payment Processing

#### Payment Methods (`PaymentController`)
- **Credit/Debit Card**
  - Card number processing
  - Card type detection (Visa, Mastercard, Amex, etc.)
  - Expiry date validation
  - CVV validation
  - Cardholder name
  - Secure payment processing

- **PayPal Integration**
  - PayPal redirect
  - PayPal callback handling
  - Payment confirmation

- **Bank Transfer**
  - Bank account information display
  - Payment instructions
  - Reference number generation

#### Payment Management
- **Payment History**
  - View payment history
  - Payment details
  - Payment status
  - Receipt download (if implemented)
  - GET `/api/payment/{id}` - Get payment details
  - GET `/api/payment/user/{userId}` - Get user payments
  - GET `/api/payment/search` - Search payments

---

## 4. Product Reviews & Ratings

### 4.1 Review System (`ReviewController`)

#### Review Submission
- **Create Review** (`/review/create`)
  - Product selection
  - Rating (1-5 stars)
  - Review title
  - Review text
  - Form validation
  - Duplicate review prevention
  - Moderation queue (reviews need staff verification)

#### Review Management
- **View Reviews**
  - List all reviews (`/review`)
  - View product reviews (`/review/product/{productId}`)
  - View user reviews (`/review/user/{userId}`)
  - View single review (`/review/view/{reviewId}`)
  - Average rating calculation
  - Review count display

#### Review Operations
- **Update Review** (`/review/update`)
  - Edit own reviews
  - Staff can edit any review
  - Re-verification after customer update

- **Delete Review** (`/review/delete`)
  - Delete own reviews
  - Staff can delete any review
  - Confirmation dialog

#### Review Display
- **Product Review Section**
  - Average rating display
  - Rating distribution
  - Review list with pagination
  - Review sorting (newest, highest rated, lowest rated)
  - Verified review badge
  - Review helpfulness voting (if implemented)

#### Review Moderation (Staff/Admin)
- **Review Verification**
  - Review moderation queue
  - Approve/reject reviews
  - Mark reviews as verified
  - Review management interface

---

## 5. Administrative Features

### 5.1 Admin Dashboard (`admin-dashboard.jsp`)

#### Dashboard Overview
- **Statistics Display**
  - Total users count
  - Total products count
  - Total orders count
  - Revenue statistics
  - Recent activity
  - System health indicators
  - Quick access to management pages

#### Navigation
- **Admin Menu**
  - User management
  - Product management
  - Order management
  - Access logs
  - Reports and analytics
  - System settings
  - Supplier management
  - Data management

### 5.2 User Management

#### User Management Interface (`manage-users.jsp`, `manage-user-form.jsp`, `ManageUserController`)
- **User Listing**
  - List all users
  - User search and filtering
  - User role display
  - User status (active/inactive)
  - Registration date
  - Pagination

- **User Operations**
  - View user details
  - Edit user information (`UpdateUserController`)
  - Change user role
  - Activate/deactivate users
  - Delete users (`DeleteUserController`, soft delete)
  - View user orders
  - View user access logs

### 5.3 Product Management

#### Product Management Interface (`manage-products.jsp`, `ManageProductController`)
- **Product Listing**
  - List all products
  - Product search and filtering
  - Category filtering
  - Stock status filtering
  - Bulk operations
  - Pagination

- **Product Operations**
  - Create new products
  - Edit existing products (`UpdateProductController`)
  - Delete products (`DeleteProductController`)
  - Update stock quantities
  - Manage product categories
  - Upload product images
  - Manage product specifications

### 5.4 Order Management

#### Order Processing
- **Order Listing**
  - List all orders
  - Order search and filtering
  - Order status filtering
  - Date range filtering
  - Customer filtering
  - Pagination

- **Order Operations**
  - View order details
  - Update order status
  - Process orders
  - Cancel orders
  - Refund orders
  - Generate shipping labels
  - Update tracking information

### 5.5 Access Logging

#### Access Log Management (`accessLog.jsp`, `manage-access-logs.jsp`, `AccesslogController`, `ManageAccessLogController`)
- **Log Viewing**
  - View all access logs
  - Filter by user
  - Filter by action type
  - Filter by date range
  - Filter by IP address
  - Export logs (CSV)
  - Pagination

- **Log Information**
  - User ID and name
  - Action performed
  - Timestamp
  - IP address
  - User agent
  - Request details
  - Response status

#### Access Log API
- GET `/api/accessLog` - Get access logs (JSON)
- GET `/api/accessLog/user/{userId}` - Get user access logs
- GET `/api/accessLog/search` - Search access logs

### 5.6 Reports & Analytics

#### Reports Dashboard (`reports-dashboard.jsp`, `admin-statistics.jsp`)
- **Sales Reports**
  - Revenue reports
  - Sales by category
  - Sales by product
  - Sales by date range
  - Top-selling products
  - Revenue trends

- **User Reports**
  - User registration trends
  - Active users
  - User activity reports
  - User engagement metrics

- **Inventory Reports**
  - Stock levels
  - Low stock alerts
  - Product performance
  - Stock movement history

### 5.7 Supplier Management

#### Supplier Management (`admin/supplier-list.jsp`, `admin/supplier-view.jsp`, `admin/supplier-form.jsp`, `SupplierController`)
- **Supplier Listing**
  - List all suppliers
  - Supplier information
  - Contact details
  - Supplier products association

- **Supplier Operations**
  - Add suppliers (`/admin/supplier/create`)
  - Edit suppliers (`/admin/supplier/update`)
  - Delete suppliers (`/admin/supplier/delete`)
  - Supplier product association
  - Supplier contact management

---

## 6. Data Management & Export

### 6.1 Data Export (`data-management.jsp`, `DataManagementController`)

#### CSV Export Functionality
- **Export Users** (`/api/dataManagement/exportUsers`)
  - Export all users to CSV
  - User information (name, email, role, registration date)
  - Downloadable CSV file

- **Export Access Logs** (`/api/dataManagement/exportAccessLogs`)
  - Export access logs to CSV
  - Date range filtering
  - Log details (user, action, timestamp, IP, user agent)
  - Downloadable CSV file

- **Export Orders** (`/api/dataManagement/exportOrders`)
  - Export all orders to CSV
  - Order information (order number, date, status, total)
  - Downloadable CSV file

- **Export Products** (`/api/dataManagement/exportProducts`)
  - Export all products to CSV
  - Product information (name, category, price, stock)
  - Downloadable CSV file

#### Data Management Dashboard
- **Dashboard Overview** (`/api/dataManagement/dashboard`)
  - Total users count
  - Total orders count
  - Total products count
  - Quick export links
  - Data management tools

#### Data Import (Future)
- **Import Functionality**
  - CSV import for products
  - CSV import for users
  - Data validation
  - Import error handling

---

## 7. Security Features

### 7.1 Authentication & Authorization

#### Secure Authentication
- **Password Security**
  - SHA-256 hashing with salt
  - Password strength requirements
  - Secure password storage
  - Password reset functionality

#### Authorization
- **Role-Based Access Control (RBAC)**
  - Customer role permissions
  - Staff role permissions
  - Admin role permissions
  - Route protection
  - Page-level access control
  - API endpoint protection

#### Session Security
- **Session Management**
  - Secure session creation
  - Session timeout
  - Session invalidation
  - CSRF protection
  - Session hijacking prevention

### 7.2 Input Validation & Sanitization

#### Client-Side Validation
- **Form Validation**
  - Real-time validation
  - Email format validation
  - Password strength validation
  - Phone number validation
  - Credit card validation
  - Address validation

#### Server-Side Validation
- **Input Sanitization**
  - SQL injection prevention
  - XSS (Cross-Site Scripting) prevention
  - Input type validation
  - Length validation
  - Format validation
  - `InputValidator` utility class

### 7.3 Data Security

#### Data Protection
- **Sensitive Data Handling**
  - Secure password storage
  - Payment information security
  - Personal data protection
  - GDPR compliance considerations

#### Access Control
- **Data Access Control**
  - User data isolation
  - Admin-only data access
  - Audit logging
  - Access log tracking

---

## 8. UI/UX Features

### 8.1 Design System

#### Modern Design System
- **CSS Custom Properties**
  - Theme variables
  - Color palette
  - Typography scale
  - Spacing system
  - Component styles

#### Color Palette
- **Primary Colors**
  - Primary Blue (`#0a95ff`): Trust, technology, professionalism
  - Secondary Green (`#22c55e`): Success, energy, innovation
  - Accent Orange (`#f97316`): Attention, warnings, CTAs

#### Typography
- **Font System**
  - Display fonts (headings)
  - Body fonts (content)
  - Monospace fonts (code)
  - Font size scale
  - Line height system

### 8.2 Responsive Design

#### Mobile-First Approach
- **Breakpoints**
  - Mobile: < 768px
  - Tablet: 768px - 1024px
  - Desktop: > 1024px
  - Large Desktop: > 1440px

#### Responsive Components
- **Navigation**
  - Desktop: Full navigation bar
  - Mobile: Hamburger menu
  - Tablet: Collapsible menu

- **Product Grid**
  - Desktop: 4 columns
  - Tablet: 2 columns
  - Mobile: 1 column

- **Forms**
  - Responsive form layouts
  - Mobile-optimized inputs
  - Touch-friendly buttons

### 8.3 Dark Mode

#### Theme Switching
- **Dark Mode Support**
  - Toggle button in header
  - System preference detection
  - Theme persistence (localStorage)
  - Smooth theme transitions
  - Complete dark theme implementation

### 8.4 User Feedback

#### Loading States
- **Skeleton Loading**
  - Product card skeletons
  - Content placeholders
  - Smooth loading animations

- **Loading Indicators**
  - Button loading states
  - Page loading overlays
  - Progress indicators
  - Spinner animations

#### Toast Notifications (`components/toast.jsp`)
- **Toast System**
  - Success messages
  - Error messages
  - Warning messages
  - Info messages
  - Auto-dismiss functionality
  - Manual dismiss option

#### Confirmation Dialogs (`components/modal.jsp`)
- **Dialog System**
  - Delete confirmations
  - Order placement confirmation
  - Account deletion confirmation
  - Action confirmations

### 8.5 Interactive Elements

#### Optimistic UI
- **Optimistic Updates**
  - Add to cart (immediate feedback)
  - Update quantities (instant update)
  - Remove items (instant removal)
  - Error rollback on failure

#### Micro-interactions
- **Hover Effects**
  - Product card elevation
  - Button hover states
  - Link hover effects
  - Image zoom on hover

#### Animations
- **Smooth Animations**
  - Page transitions
  - Modal animations
  - Toast animations
  - Loading animations
  - Scroll animations

### 8.6 Trust & Credibility

#### Trust Badges
- **Product Trust Indicators**
  - Certification badges (CE, FCC, RoHS)
  - Compatibility badges
  - Stock reliability indicator
  - Technical support level
  - Warranty information

#### Social Proof
- **Credibility Signals**
  - Customer testimonials
  - Trust indicators
  - Security badges
  - Guarantee information

---

## 9. Accessibility Features

### 9.1 WCAG 2.1 AA Compliance

#### Keyboard Navigation
- **Keyboard Support**
  - Full keyboard navigation
  - Tab order management
  - Focus indicators
  - Skip links
  - Keyboard shortcuts

#### Screen Reader Support
- **ARIA Attributes**
  - ARIA labels
  - ARIA roles
  - ARIA live regions
  - ARIA expanded states
  - ARIA controls

#### Semantic HTML
- **Semantic Markup**
  - Proper heading hierarchy
  - Landmark regions
  - Form labels
  - Alt text for images
  - Link descriptions

### 9.2 Accessibility Enhancements

#### Skip Links
- **Navigation Shortcuts**
  - Skip to main content
  - Skip to navigation
  - Skip to search

#### Focus Management
- **Focus Indicators**
  - Visible focus outlines
  - Focus trap in modals
  - Focus restoration
  - Focus order

#### Color Contrast
- **Contrast Ratios**
  - WCAG AA compliant contrast
  - Text readability
  - Button contrast
  - Link contrast

---

## 10. Performance Features

### 10.1 Optimization

#### Image Optimization
- **Image Handling**
  - Lazy loading
  - Responsive images
  - Image compression
  - WebP format support (if implemented)
  - Fallback images

#### Code Optimization
- **JavaScript Optimization**
  - Minified JavaScript
  - Code splitting
  - Deferred loading
  - Event delegation

#### CSS Optimization
- **Stylesheet Optimization**
  - Minified CSS
  - CSS custom properties
  - Efficient selectors
  - Reduced specificity

### 10.2 Caching

#### Browser Caching
- **Cache Strategy**
  - Static asset caching
  - Cache headers
  - ETag support
  - Cache invalidation

### 10.3 Resource Loading

#### Resource Hints
- **Performance Hints**
  - Preconnect
  - Preload
  - DNS prefetch
  - Resource prioritization

---

## 11. API Endpoints

### 11.1 Authentication API
- POST `/api/auth/register` - User registration
- POST `/api/login` - User login
- GET `/api/me` - Get current user information

### 11.2 Product API
- GET `/api/v1/products` - List all products
- GET `/api/v1/products/{id}` - Get product details
- POST `/api/v1/products` - Create product (admin/staff)
- PUT `/api/v1/products/{id}` - Update product (admin/staff)
- DELETE `/api/v1/products/{id}` - Delete product (admin/staff)

### 11.3 Cart API
- GET `/api/cart` - Get cart data
- POST `/api/cart/add` - Add item to cart
- PUT `/api/cart/update` - Update cart item quantity
- DELETE `/api/cart/remove` - Remove item from cart
- DELETE `/api/cart/clear` - Clear entire cart

### 11.4 Payment API
- GET `/api/payment/{id}` - Get payment details
- GET `/api/payment/user/{userId}` - Get user payments
- GET `/api/payment/search` - Search payments

### 11.5 Shipment API
- GET `/shipment/{id}` - Get shipment details
- GET `/shipment/tracking/{trackingNumber}` - Track by tracking number
- GET `/shipment/search` - Search shipments

### 11.6 Review API
- GET `/review` - List all reviews
- GET `/review/product/{productId}` - Get product reviews
- GET `/review/user/{userId}` - Get user reviews
- GET `/review/view/{reviewId}` - Get review details
- POST `/review/create` - Create review
- POST `/review/update` - Update review
- POST `/review/delete` - Delete review

### 11.7 Access Log API
- GET `/api/accessLog` - Get access logs
- GET `/api/accessLog/user/{userId}` - Get user access logs
- GET `/api/accessLog/search` - Search access logs

### 11.8 Data Management API
- GET `/api/dataManagement/exportUsers` - Export users to CSV
- GET `/api/dataManagement/exportAccessLogs` - Export access logs to CSV
- GET `/api/dataManagement/exportOrders` - Export orders to CSV
- GET `/api/dataManagement/exportProducts` - Export products to CSV
- GET `/api/dataManagement/dashboard` - Get data management dashboard

---

## 12. Static Pages & Navigation

### 12.1 Static Pages

#### About Page (`about.jsp`)
- **Company Information**
  - Company story
  - Mission and vision
  - Team information
  - Company values
  - Contact information

#### Contact Page (`contact.jsp`)
- **Contact Form**
  - Name, email, subject, message fields
  - Form validation
  - Contact information display
  - Office location
  - Business hours

#### Welcome Page (`welcome.jsp`)
- **Welcome Message**
  - Personalized greeting after registration/login
  - Success animation
  - Quick navigation links
  - Feature highlights

#### Goodbye Page (`goodbye.jsp`)
- **Logout Confirmation**
  - Thank you message
  - Logout confirmation
  - Return to homepage link
  - Feature reminders

#### Error Page (`error.jsp`)
- **Error Handling**
  - Error message display
  - Error details (development mode)
  - Return to homepage link
  - Contact support link
  - User-friendly error messages

### 12.2 Navigation Components

#### Header (`components/header.jsp`)
- **Global Navigation**
  - Logo and branding
  - Main navigation menu
  - Search bar
  - User menu (login/profile)
  - Shopping cart icon with count badge
  - Theme toggle button
  - Mobile hamburger menu

#### Footer (`components/footer.jsp`)
- **Site Footer**
  - Company information
  - Quick links
  - Product categories
  - Support links
  - Legal links (Privacy, Terms)
  - Social media links
  - Back to top button
  - Copyright information

#### Layout Base (`WEB-INF/tags/layout/base.tag`)
- **Base Layout Template**
  - HTML structure
  - Meta tags
  - CSS includes
  - JavaScript includes
  - Skip links for accessibility
  - ARIA landmarks

### 12.3 Reusable Components

#### Product Card (`components/product-card.jsp`)
- **Product Display Component**
  - Product image
  - Product name
  - Price
  - Stock status
  - Key specifications
  - Add to cart button
  - View details link

#### Pagination (`components/pagination.jsp`)
- **Pagination Component**
  - Page numbers
  - Previous/Next buttons
  - Current page indicator
  - Total pages display

#### Search Filter (`components/search-filter.jsp`)
- **Filter Component**
  - Category filters
  - Price range
  - Stock status
  - Other filters

#### Masthead (`components/masthead.jsp`)
- **Page Header Component**
  - Page title
  - Breadcrumb navigation
  - Action buttons

---

## 13. Technical Features

### 13.1 Architecture

#### MVC Pattern
- **Model-View-Controller**
  - Clean separation of concerns
  - Controller layer (Servlets)
  - Model layer (JavaBeans)
  - View layer (JSP)

#### DAO Pattern
- **Data Access Object**
  - Database abstraction
  - Interface-based design
  - Implementation flexibility
  - Testability

#### Service Layer
- **Business Logic**
  - Service classes
  - Business rule enforcement
  - Validation logic
  - Compatibility checking
  - `CartService`
  - `ProductService`
  - `CompatibilityEngine`

### 13.2 Database

#### Database Design
- **SQLite Database**
  - Relational database
  - Normalized schema
  - Foreign key constraints
  - Index optimization

#### Database Tables
- **User** - User accounts and profiles (with password_hash, salt, role, isActive)
- **Products** - Product catalog (with sku, short_description, cost_price, low_stock_threshold, weight, dimensions, gallery_images, specifications, is_active, is_featured, meta_title, meta_description)
- **Categories** - Product categories (hierarchical with parent_category_id, slug, image_url, sort_order, is_active)
- **Orders** - Customer orders (with order_number, status, subtotal, tax_amount, shipping_cost, discount_amount, total_amount, currency, shipping/billing addresses, order_date, confirmed_at, shipped_at, delivered_at)
- **Order_Products** - Order line items (with product_name, product_sku, quantity, unit_price, total_price, product_snapshot)
- **Cart_Items** - Shopping cart items (with user_id, product_id, quantity, added_at, updated_at)
- **Payments** - Payment transactions (with order_id, payment_method, payment_status, amount, currency, transaction_id, gateway_response, paid_at)
- **Shipments** - Shipping information (with order_id, tracking_number, carrier, shipping_date, delivery_date, status)
- **Access_Logs** - System access logs (with user_id, action, resource, method, ip_address, user_agent, request_data, response_status, created_at)
- **Address_Details** - User addresses (with user_id, recipient_name, street_address, city, state, postal_code, country, phone_number, is_default)
- **Reviews** - Product reviews and ratings (with product_id, user_id, order_id, rating, title, comment, images, is_verified, is_approved, helpful_count)
- **Wishlists** - User wishlists (with user_id, name, is_default)
- **Wishlist_Products** - Wishlist items (with wishlist_id, product_id, added_at)
- **Reset_Questions** - Password recovery questions (with user_id, question, answer_hash, salt)
- **Suppliers** - Supplier information (if implemented, with company_name, contact_name, email, phone, address, city, state, postal_code, country, is_active)

### 13.3 Utilities

#### Utility Classes
- **Helper Classes**
  - `ValidationUtil` - Input validation
  - `ResponseUtil` - JSON responses
  - `InputValidator` - Form validation
  - `CSVUtil` - CSV processing
  - `PasswordUtil` - Password hashing
  - `DBConnection` - Database connection management

#### Compatibility Engine
- **Product Compatibility**
  - Compatibility checking
  - Compatibility warnings
  - Compatibility suggestions
  - Integration with cart
  - `CompatibilityEngine` service class

### 13.4 Build & Deployment

#### Build System
- **Maven Configuration**
  - Project structure
  - Dependency management
  - Build lifecycle
  - Plugin configuration

#### Server Configuration
- **Jetty Server** (Development)
  - Embedded server
  - Port configuration
  - Context path
  - Hot reload support

---

## Feature Summary Tables

### Table 1: Core User Management Features

| Feature | Status | Priority | Assignment Requirement | Implementation Details |
|---------|--------|----------|----------------------|----------------------|
| User Registration | ✅ Implemented | High | ✅ Required | `register.jsp`, `RegisterController`, password strength indicator, validation |
| User Login | ✅ Implemented | High | ✅ Required | `login.jsp`, `LoginController`, session management, CSRF protection |
| User Logout | ✅ Implemented | High | ✅ Required | `logout.jsp`, `LogoutController`, session invalidation |
| Profile Management | ✅ Implemented | High | ✅ Required | `profile.jsp`, `UserProfileController`, edit profile, address management |
| Password Reset | 🚧 Partially | Medium | ✅ Required | Reset questions table exists, UI may need enhancement |
| Role-Based Access Control | ✅ Implemented | High | ✅ Required | Customer, Staff, Admin roles with different permissions |
| Account Deletion | ✅ Implemented | Medium | ✅ Required | `deleteaccount.jsp`, soft delete functionality |

### Table 2: Product Catalog Features

| Feature | Status | Priority | Assignment Requirement | Implementation Details |
|---------|--------|----------|----------------------|----------------------|
| Product Browsing | ✅ Implemented | High | ✅ Required | `browse.jsp`, `BrowseProductController`, category pages |
| Product Search | ✅ Implemented | High | ✅ Required | Keyword search, autocomplete, search results page |
| Product Filtering | ✅ Implemented | High | ✅ Required | Multi-dimensional filtering (category, protocol, voltage, price, stock) |
| Product Details | ✅ Implemented | High | ✅ Required | `productDetails.jsp`, technical specifications, images, reviews |
| Category Management | ✅ Implemented | High | ✅ Required | Hierarchical categories, `categories.jsp`, `CategoryController` |
| Product Management (Admin) | ✅ Implemented | High | ✅ Required | `manage-products.jsp`, `manage-product-form.jsp`, CRUD operations |
| Inventory Management | ✅ Implemented | High | ✅ Required | Stock tracking, low stock alerts, stock status indicators |

### Table 3: E-commerce Features

| Feature | Status | Priority | Assignment Requirement | Implementation Details |
|---------|--------|----------|----------------------|----------------------|
| Shopping Cart | ✅ Implemented | High | ✅ Required | `cart.jsp`, `CartController`, add/update/remove items, persistence |
| Checkout Process | ✅ Implemented | High | ✅ Required | `checkout.jsp`, multi-step process, shipping, payment, review |
| Order Management | ✅ Implemented | High | ✅ Required | `orderList.jsp`, order history, order details, status tracking |
| Order Tracking | ✅ Implemented | Medium | ✅ Required | Shipment tracking, tracking numbers, delivery status |
| Payment Processing | 🚧 Partially | High | ✅ Required | Payment methods (Card, PayPal, Bank Transfer), gateway integration needed |
| Compatibility Checking | ✅ Implemented | Medium | ✅ Required | `CompatibilityEngine`, cart compatibility warnings |
| Wishlist | 🚧 Partially | Low | Optional | Database structure exists, UI may need enhancement |

### Table 4: Reviews & Ratings Features

| Feature | Status | Priority | Assignment Requirement | Implementation Details |
|---------|--------|----------|----------------------|----------------------|
| Review Submission | ✅ Implemented | High | ✅ Required | `ReviewController`, rating (1-5 stars), title, comment |
| Review Display | ✅ Implemented | High | ✅ Required | Product reviews, average rating, rating distribution |
| Review Moderation | ✅ Implemented | Medium | ✅ Required | Staff approval, verification, moderation queue |
| Review Management | ✅ Implemented | Medium | ✅ Required | Edit/delete reviews, user review history |

### Table 5: Administrative Features

| Feature | Status | Priority | Assignment Requirement | Implementation Details |
|---------|--------|----------|----------------------|----------------------|
| Admin Dashboard | ✅ Implemented | High | ✅ Required | `admin-dashboard.jsp`, statistics, quick access links |
| User Management | ✅ Implemented | High | ✅ Required | `manage-users.jsp`, `manage-user-form.jsp`, CRUD operations |
| Product Management | ✅ Implemented | High | ✅ Required | `manage-products.jsp`, `manage-product-form.jsp`, CRUD operations |
| Order Management | ✅ Implemented | High | ✅ Required | Order processing, status updates, order search/filter |
| Access Logging | ✅ Implemented | High | ✅ Required | `manage-access-logs.jsp`, log viewing, filtering, export |
| Supplier Management | ✅ Implemented | Medium | ✅ Required | `admin/supplier-list.jsp`, `SupplierController`, CRUD operations |
| Reports & Analytics | ✅ Implemented | Medium | ✅ Required | `reports-dashboard.jsp`, sales reports, user reports, inventory reports |
| Data Export | ✅ Implemented | High | ✅ Required | CSV export for users, products, orders, access logs |

### Table 6: Security Features

| Feature | Status | Priority | Assignment Requirement | Implementation Details |
|---------|--------|----------|----------------------|----------------------|
| Password Hashing | ✅ Implemented | High | ✅ Required | SHA-256 with salt, `PasswordUtil` |
| CSRF Protection | ✅ Implemented | High | ✅ Required | Token-based CSRF protection, `SecurityUtil` |
| Input Validation | ✅ Implemented | High | ✅ Required | Client-side and server-side validation, `InputValidator`, `ValidationUtil` |
| SQL Injection Prevention | ✅ Implemented | High | ✅ Required | Prepared statements, parameterized queries |
| XSS Prevention | ✅ Implemented | High | ✅ Required | Input sanitization, output encoding |
| Session Security | ✅ Implemented | High | ✅ Required | Secure session management, timeout, invalidation |
| Rate Limiting | ✅ Implemented | Medium | ✅ Required | Request throttling for security |
| Access Control | ✅ Implemented | High | ✅ Required | Role-based access control, route protection |

### Table 7: UI/UX Features

| Feature | Status | Priority | Assignment Requirement | Implementation Details |
|---------|--------|----------|----------------------|----------------------|
| Responsive Design | ✅ Implemented | High | ✅ Required | Mobile-first approach, breakpoints, responsive components |
| Dark Mode | ✅ Implemented | Medium | Optional | Theme toggle, system preference detection, persistence |
| Design System | ✅ Implemented | High | ✅ Required | CSS custom properties, component-based architecture |
| Loading States | ✅ Implemented | Medium | ✅ Required | Skeleton loading, loading indicators, progress bars |
| Toast Notifications | ✅ Implemented | Medium | ✅ Required | Success/error/warning/info messages, auto-dismiss |
| Optimistic UI | ✅ Implemented | Medium | Optional | Immediate feedback, error rollback |
| Accessibility (WCAG 2.1 AA) | ✅ Implemented | High | ✅ Required | ARIA attributes, keyboard navigation, screen reader support |

### Table 8: Static Pages & Navigation

| Feature | Status | Priority | Assignment Requirement | Implementation Details |
|---------|--------|----------|----------------------|----------------------|
| Homepage | ✅ Implemented | High | ✅ Required | `index.jsp`, hero section, featured products, categories |
| About Page | ✅ Implemented | Medium | ✅ Required | `about.jsp`, company information, team |
| Contact Page | ✅ Implemented | Medium | ✅ Required | `contact.jsp`, contact form, business hours |
| Welcome Page | ✅ Implemented | Medium | ✅ Required | `welcome.jsp`, personalized greeting after login/registration |
| Goodbye Page | ✅ Implemented | Medium | ✅ Required | `goodbye.jsp`, logout confirmation |
| Error Page | ✅ Implemented | High | ✅ Required | `error.jsp`, error handling, user-friendly messages |
| Help Page | ✅ Implemented | Low | Optional | `help.jsp`, help center |
| Header Navigation | ✅ Implemented | High | ✅ Required | `components/organisms/header/header.jsp`, search, user menu, cart |
| Footer Navigation | ✅ Implemented | Medium | ✅ Required | `components/organisms/footer/footer.jsp`, links, company info |

### Table 9: API Endpoints

| Feature | Status | Priority | Assignment Requirement | Implementation Details |
|---------|--------|----------|----------------------|----------------------|
| Authentication API | ✅ Implemented | High | ✅ Required | `/api/auth/register`, `/api/login`, `/api/me` |
| Product API | ✅ Implemented | High | ✅ Required | `/api/v1/products`, CRUD operations, pagination |
| Cart API | ✅ Implemented | High | ✅ Required | `/api/cart`, add/update/remove/clear operations |
| Payment API | 🚧 Partially | High | ✅ Required | `/api/payment`, basic structure exists |
| Shipment API | ✅ Implemented | Medium | ✅ Required | `/shipment`, tracking, search |
| Review API | ✅ Implemented | Medium | ✅ Required | `/review`, CRUD operations |
| Access Log API | ✅ Implemented | Medium | ✅ Required | `/api/accessLog`, viewing, filtering |
| Data Management API | ✅ Implemented | High | ✅ Required | `/api/dataManagement`, CSV export endpoints |

### Table 10: Database Schema

| Table | Status | Priority | Assignment Requirement | Key Fields |
|-------|--------|----------|----------------------|------------|
| User | ✅ Implemented | High | ✅ Required | id, email, password_hash, salt, firstName, lastName, role, isActive |
| Products | ✅ Implemented | High | ✅ Required | id, category_id, sku, name, price, stock_quantity, is_active, is_featured |
| Categories | ✅ Implemented | High | ✅ Required | id, name, slug, parent_category_id, is_active |
| Orders | ✅ Implemented | High | ✅ Required | id, order_number, user_id, status, total_amount, order_date |
| Order_Products | ✅ Implemented | High | ✅ Required | id, order_id, product_id, quantity, unit_price, total_price |
| Cart_Items | ✅ Implemented | High | ✅ Required | id, user_id, product_id, quantity, added_at |
| Payments | ✅ Implemented | High | ✅ Required | id, order_id, payment_method, payment_status, amount |
| Shipments | ✅ Implemented | Medium | ✅ Required | id, order_id, tracking_number, status, delivery_date |
| Reviews | ✅ Implemented | High | ✅ Required | id, product_id, user_id, rating, title, comment, is_approved |
| Access_Logs | ✅ Implemented | High | ✅ Required | id, user_id, action, resource, method, ip_address, response_status |
| Address_Details | ✅ Implemented | Medium | ✅ Required | id, user_id, recipient_name, street_address, city, postal_code |
| Wishlists | ✅ Implemented | Low | Optional | id, user_id, name, is_default |
| Wishlist_Products | ✅ Implemented | Low | Optional | id, wishlist_id, product_id, added_at |
| Reset_Questions | ✅ Implemented | Medium | ✅ Required | id, user_id, question, answer_hash, salt |

### Table 11: Technical Architecture

| Component | Status | Priority | Assignment Requirement | Implementation Details |
|-----------|--------|----------|----------------------|----------------------|
| MVC Architecture | ✅ Implemented | High | ✅ Required | Clean separation: Controllers, Models, Views (JSP) |
| DAO Pattern | ✅ Implemented | High | ✅ Required | Interface-based DAOs, database abstraction |
| Service Layer | ✅ Implemented | High | ✅ Required | Business logic: `UserService`, `CartService`, `CompatibilityEngine` |
| Dependency Injection | ✅ Implemented | Medium | Optional | `DIContainer` for dependency management |
| Error Handling | ✅ Implemented | High | ✅ Required | Comprehensive validation, error recovery, user feedback |
| Logging | ✅ Implemented | Medium | ✅ Required | Structured logging, access logging |
| TypeScript Migration | ✅ Implemented | Medium | Optional | Frontend JS converted to TypeScript for stability |

---

## Feature Implementation Status

### ✅ Fully Implemented
- User registration and authentication
- User profile management
- Product catalog browsing
- Product search and filtering
- Shopping cart functionality
- Checkout process
- Order management
- Order tracking and shipment
- Product reviews and ratings
- Admin dashboard
- User management (CRUD)
- Product management (CRUD)
- Access logging
- Data export (CSV)
- Supplier management
- Reports and analytics
- Responsive design
- Dark mode
- Accessibility features (WCAG 2.1 AA)
- Security features
- Design system
- Static pages (About, Contact, Welcome, Goodbye, Error)
- API endpoints
- Reusable components

### 🚧 Partially Implemented
- Wishlist functionality (structure exists, may need enhancement)
- Email notifications (may need implementation)
- Payment gateway integration (structure exists, may need real payment processing)
- Advanced analytics (basic reports exist, may need enhancement)

### 📋 Planned/Enhancement
- Product comparison tool
- Advanced search with Elasticsearch
- Real-time inventory updates
- Multi-language support (UI)
- Mobile app (future consideration)
- Data import functionality
- Advanced reporting and analytics dashboards

---

## Feature Dependencies

### Core Dependencies
- Java JDK 8+
- Maven 3.6+
- Jetty Server
- SQLite Database
- JSP 2.3+
- JSTL 1.2
- Gson (JSON processing)

### Frontend Dependencies
- HTML5
- CSS3 (Custom Properties)
- JavaScript (ES6+)
- No external JavaScript frameworks (vanilla JS)

---

## Assignment Requirements Coverage

### Functional Requirements ✅
1. ✅ **User Management**: Registration, authentication, profile management, role-based access
2. ✅ **Product Management**: Catalog, search, filtering, details, inventory
3. ✅ **E-commerce Features**: Shopping cart, checkout, order management, payment processing
4. ✅ **Administrative Features**: User management, product management, order processing, access logging
5. ✅ **Product Reviews**: Review submission, moderation, display
6. ✅ **Data Management**: Export functionality, data management dashboard

### Technical Requirements ✅
1. ✅ **MVC Architecture**: Clean separation of concerns
2. ✅ **DAO Pattern**: Abstraction layer for data access
3. ✅ **Security**: Secure authentication and authorization
4. ✅ **Responsive Design**: Mobile-first approach
5. ✅ **Modern UI/UX**: Design system principles
6. ✅ **Error Handling**: Comprehensive validation and error recovery
7. ✅ **Access Logging**: Security auditing and analytics

### Design Requirements ✅
1. ✅ **Consistent Design System**: Unified components across all pages
2. ✅ **Responsive Layout**: Mobile, tablet, and desktop support
3. ✅ **Accessibility**: WCAG 2.1 AA compliance
4. ✅ **Dark Mode**: Complete theme support
5. ✅ **Modern Interface**: Clean, intuitive, and professional

---

## Notes

- This feature list is based on the **41025 ISD Assignment 2 Autumn 2025** requirements and current implementation
- All features documented here are either fully implemented or have clear implementation paths
- Feature implementation follows MVC architecture and DAO pattern
- All features are designed with accessibility and user experience in mind
- Security is a priority in all feature implementations
- The system supports three user roles: Customer, Staff, and Admin
- All API endpoints return JSON responses for programmatic access
- The system includes comprehensive error handling and user feedback mechanisms

---

**Document Maintained By**: Development Team  
**For Questions**: Refer to `README.md` and `designplan/UI_UXdoc.md`  
**Assignment Reference**: `design plan/41025 ISD Assignment 2 Autumn 2025.pdf`
