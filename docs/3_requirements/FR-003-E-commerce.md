# FR-003: E-commerce Features

## Document Information
**Feature ID**: FR-003  
**Feature Name**: E-commerce  
**Document Version**: 1.0  
**Last Updated**: 2025-11-20  
**Status**: Implemented  
**Priority**: High

---

## Overview

E-commerce features provide complete shopping cart functionality, checkout process, order management, and payment processing capabilities. This feature set enables customers to purchase IoT devices and components through a secure and user-friendly shopping experience.

---

## Functional Requirements

### FR-003.1: Shopping Cart

#### FR-003.1.1: Add to Cart
- **REQ-003.1.1.1**: System SHALL allow adding products to cart from:
  - Product detail page
  - Product listing pages
- **REQ-003.1.1.2**: System SHALL support quantity selection when adding to cart
- **REQ-003.1.1.3**: System SHALL provide optimistic UI updates (immediate feedback)
- **REQ-003.1.1.4**: System SHALL display toast notifications when items are added
- **REQ-003.1.1.5**: System SHALL update cart count badge in header immediately
- **REQ-003.1.1.6**: System SHALL validate stock availability before adding to cart
- **REQ-003.1.1.7**: System SHALL prevent adding out-of-stock items

#### FR-003.1.2: Cart Management
- **REQ-003.1.2.1**: System SHALL provide cart page (`cart.jsp`)
- **REQ-003.1.2.2**: Cart page SHALL display:
  - List of cart items with product information
  - Quantity selector for each item
  - Price per item and subtotal
  - Remove item button
  - Cart summary (subtotal, tax, shipping, total)
- **REQ-003.1.2.3**: System SHALL allow updating item quantities:
  - Increment/decrement buttons
  - Direct quantity input
  - Real-time price updates
- **REQ-003.1.2.4**: System SHALL allow removing items from cart
- **REQ-003.1.2.5**: System SHALL allow clearing entire cart
- **REQ-003.1.2.6**: System SHALL persist cart for:
  - Guest users (session-based)
  - Logged-in users (database-based)
- **REQ-003.1.2.7**: System SHALL merge guest cart with user cart upon login

#### FR-003.1.3: Compatibility Checking
- **REQ-003.1.3.1**: System SHALL automatically check product compatibility in cart
- **REQ-003.1.3.2**: System SHALL display compatibility warnings for incompatible products
- **REQ-003.1.3.3**: System SHALL suggest compatible alternatives
- **REQ-003.1.3.4**: System SHALL allow users to proceed with incompatible items (with warning)
- **REQ-003.1.3.5**: System SHALL integrate with CompatibilityEngine service

#### FR-003.1.4: Cart Features
- **REQ-003.1.4.1**: System SHALL calculate cart totals in real-time
- **REQ-003.1.4.2**: System SHALL check stock availability for all cart items
- **REQ-003.1.4.3**: System SHALL handle out-of-stock items appropriately
- **REQ-003.1.4.4**: System SHALL display empty cart message when cart is empty
- **REQ-003.1.4.5**: System SHALL provide "Continue Shopping" link

### FR-003.2: Checkout Process

#### FR-003.2.1: Checkout Page
- **REQ-003.2.1.1**: System SHALL provide checkout page (`checkout.jsp`)
- **REQ-003.2.1.2**: System SHALL require user login before checkout (redirect if not logged in)
- **REQ-003.2.1.3**: System SHALL display checkout progress indicator:
  - Cart (completed)
  - Shipping (current)
  - Payment (upcoming)
  - Review (upcoming)
- **REQ-003.2.1.4**: System SHALL allow navigation between checkout steps

#### FR-003.2.2: Shipping Information
- **REQ-003.2.2.1**: System SHALL collect shipping information:
  - Full name (required)
  - Email address (required, validated)
  - Phone number (required, formatted)
  - Address line 1 (required)
  - Address line 2 (optional)
  - City (required)
  - State (required)
  - Postal code (required)
  - Country (required, default: KR)
- **REQ-003.2.2.2**: System SHALL allow using saved addresses for logged-in users
- **REQ-003.2.2.3**: System SHALL allow saving current address for future use
- **REQ-003.2.2.4**: System SHALL validate all shipping fields
- **REQ-003.2.2.5**: System SHALL perform address validation

#### FR-003.2.3: Shipping Method Selection
- **REQ-003.2.3.1**: System SHALL provide shipping method options:
  - Standard shipping (5-7 days)
  - Express shipping (2-3 days)
  - Overnight shipping (1 day)
- **REQ-003.2.3.2**: System SHALL display shipping cost for each method
- **REQ-003.2.3.3**: System SHALL display estimated delivery date
- **REQ-003.2.3.4**: System SHALL update total cost when shipping method changes

#### FR-003.2.4: Payment Information
- **REQ-003.2.4.1**: System SHALL provide payment method selection:
  - Credit/Debit Card
  - PayPal
  - Bank Transfer
- **REQ-003.2.4.2**: For Credit Card, System SHALL collect:
  - Card number (with formatting and type detection)
  - Expiry date (MM/YY format)
  - CVV (with help tooltip)
  - Cardholder name
  - Save card option (if logged in)
- **REQ-003.2.4.3**: System SHALL validate card information in real-time
- **REQ-003.2.4.4**: For PayPal, System SHALL redirect to PayPal (if implemented)
- **REQ-003.2.4.5**: For Bank Transfer, System SHALL display:
  - Bank account information
  - Payment instructions
  - Reference number

#### FR-003.2.5: Review & Confirm
- **REQ-003.2.5.1**: System SHALL display order summary:
  - Shipping address (editable)
  - Payment method (editable)
  - Order items list
  - Subtotal, shipping, tax, total
- **REQ-003.2.5.2**: System SHALL require Terms & Conditions acceptance
- **REQ-003.2.5.3**: System SHALL require Privacy Policy acceptance
- **REQ-003.2.5.4**: System SHALL allow editing any section before final submission

#### FR-003.2.6: Order Placement
- **REQ-003.2.6.1**: System SHALL process order upon "Place Order" click
- **REQ-003.2.6.2**: System SHALL display loading state during processing
- **REQ-003.2.6.3**: System SHALL create order in database
- **REQ-003.2.6.4**: System SHALL generate unique order number
- **REQ-003.2.6.5**: System SHALL process payment (if applicable)
- **REQ-003.2.6.6**: System SHALL update product stock quantities
- **REQ-003.2.6.7**: System SHALL redirect to order confirmation page
- **REQ-003.2.6.8**: System SHALL clear cart after successful order

### FR-003.3: Order Management

#### FR-003.3.1: Order History
- **REQ-003.3.1.1**: System SHALL provide order history page (`orderList.jsp`)
- **REQ-003.3.1.2**: Order history SHALL display:
  - List of all user orders (newest first)
  - Order number (clickable)
  - Order date
  - Order status badge
  - Total amount
  - Number of items
  - "View Details" button
- **REQ-003.3.1.3**: System SHALL provide filtering options:
  - Filter by status
  - Filter by date range
- **REQ-003.3.1.4**: System SHALL support pagination for large order lists

#### FR-003.3.2: Order Details
- **REQ-003.3.2.1**: System SHALL display order details including:
  - Order number and date
  - Order status and timeline
  - Shipping address
  - Billing address
  - Payment method
  - Order items (with images, quantities, prices)
  - Subtotal, shipping, tax, total
  - Tracking information (if shipped)
- **REQ-003.3.2.2**: System SHALL provide "Track Shipment" button (if available)

#### FR-003.3.3: Order Status
- **REQ-003.3.3.1**: System SHALL support order statuses:
  - Pending
  - Processing
  - Shipped
  - Delivered
  - Cancelled
  - Refunded
- **REQ-003.3.3.2**: System SHALL update order status automatically
- **REQ-003.3.3.3**: System SHALL display status timeline
- **REQ-003.3.3.4**: System SHALL notify users of status changes (if implemented)

#### FR-003.3.4: Order Tracking
- **REQ-003.3.4.1**: System SHALL provide shipment tracking functionality
- **REQ-003.3.4.2**: System SHALL display tracking number
- **REQ-003.3.4.3**: System SHALL display shipment status
- **REQ-003.3.4.4**: System SHALL display estimated delivery date
- **REQ-003.3.4.5**: System SHALL display tracking history timeline
- **REQ-003.3.4.6**: System SHALL support tracking by tracking number

### FR-003.4: Payment Processing

#### FR-003.4.1: Payment Methods
- **REQ-003.4.1.1**: System SHALL support Credit/Debit Card payment:
  - Card number processing
  - Card type detection (Visa, Mastercard, Amex, etc.)
  - Expiry date validation
  - CVV validation
  - Cardholder name
  - Secure payment processing
- **REQ-003.4.1.2**: System SHALL support PayPal integration:
  - PayPal redirect
  - PayPal callback handling
  - Payment confirmation
- **REQ-003.4.1.3**: System SHALL support Bank Transfer:
  - Bank account information display
  - Payment instructions
  - Reference number generation

#### FR-003.4.2: Payment Management
- **REQ-003.4.2.1**: System SHALL create payment record for each order
- **REQ-003.4.2.2**: System SHALL track payment status:
  - Pending
  - Completed
  - Failed
  - Cancelled
  - Refunded
- **REQ-003.4.2.3**: System SHALL store payment transaction details
- **REQ-003.4.2.4**: System SHALL provide payment history view

---

## Acceptance Criteria

### AC-003.1: Shopping Cart
- Users can add products to cart from product pages
- Cart persists for both guest and logged-in users
- Cart quantities can be updated
- Items can be removed from cart
- Compatibility warnings display correctly

### AC-003.2: Checkout
- Checkout process guides users through all steps
- Shipping information is validated
- Payment information is securely processed
- Order is created successfully
- User is redirected to confirmation page

### AC-003.3: Order Management
- Users can view order history
- Order details display all required information
- Order status updates correctly
- Tracking information is accessible

### AC-003.4: Payment
- Payment methods work correctly
- Payment information is validated
- Payment records are created
- Payment status is tracked

---

## Dependencies

- **Database**: Cart_Items, Orders, Order_Products, Payments, Shipments tables
- **FR-001**: User Management (for user authentication and addresses)
- **FR-002**: Product Catalog (for product information)
- **Service**: CompatibilityEngine for compatibility checking
- **Service**: CartService for cart operations

---

## Related Features

- **FR-001**: User Management (user authentication, saved addresses)
- **FR-002**: Product Catalog (product information, stock)
- **FR-004**: Reviews & Ratings (order-linked reviews)
- **FR-005**: Administrative Features (order processing)

---

## API Endpoints

- `GET /cart` - View cart page
- `GET /api/cart` - Get cart data (JSON)
- `POST /api/cart/add` - Add item to cart
- `PUT /api/cart/update` - Update cart item quantity
- `DELETE /api/cart/remove` - Remove item from cart
- `DELETE /api/cart/clear` - Clear entire cart
- `GET /checkout` - View checkout page
- `POST /checkout` - Process checkout
- `GET /orderList` - View order history
- `GET /api/payment/{id}` - Get payment details
- `GET /api/payment/user/{userId}` - Get user payments
- `GET /shipment/{id}` - Get shipment details
- `GET /shipment/tracking/{trackingNumber}` - Track by tracking number

---

## Implementation Files

- `src/main/webapp/cart.jsp`
- `src/main/webapp/checkout.jsp`
- `src/main/webapp/orderList.jsp`
- `src/main/java/controller/CartController.java`
- `src/main/java/controller/CheckoutController.java`
- `src/main/java/controller/OrderHistoryController.java`
- `src/main/java/controller/PaymentController.java`
- `src/main/java/controller/ShipmentController.java`
- `src/main/java/service/CartService.java`
- `src/main/java/service/CompatibilityEngine.java`

---

**End of FR-003: E-commerce Features**



---

**Audience**: Developers, Stakeholders
**Maintained By**: IoT Bay Documentation Team
