# UX Scenarios: E-commerce Features

## Document Information
**Feature Category**: E-commerce  
**Last Updated**: 2025-01-20  
**Related Features**: Shopping Cart, Checkout, Order Management, Payment Processing

---

## 1. Shopping Cart Scenarios

### 1.1 Scenario: Adding Product to Cart

**User Persona**: Customer browsing products  
**Goal**: Add product to shopping cart for later purchase  
**Context**: User on product listing or product details page

#### Step-by-Step Flow

1. **Product Selection**
   - User views product (on browse page or product details)
   - User decides to add product to cart
   - User may select quantity (if on product details page)

2. **Add to Cart Action**
   - User clicks "Add to Cart" button
   - Button shows loading state ("Adding...")
   - Optimistic UI update:
     - Cart count badge in header updates immediately
     - Button shows checkmark briefly
   - Toast notification appears: "Added to cart successfully"

3. **Cart Persistence**
   - Item saved to cart (database or session)
   - Cart persists across sessions (if logged in)
   - Guest cart saved in session

4. **Visual Feedback**
   - Cart icon in header pulses briefly
   - Cart count badge updates (e.g., "3")
   - Optional: Mini cart preview (if implemented)

#### UX Considerations
- **Immediate Feedback**: Optimistic UI for instant response
- **Error Handling**: Rollback if server error
- **Stock Validation**: Check stock before adding
- **Quantity Limits**: Respect maximum quantity

---

### 1.2 Scenario: Viewing Shopping Cart

**User Persona**: Customer with items in cart  
**Goal**: Review cart items before checkout  
**Context**: User clicks cart icon in header

#### Step-by-Step Flow

1. **Cart Access**
   - User clicks cart icon in header
   - Redirected to `/cart.jsp`
   - Cart page loads with all items

2. **Cart Display**
   - Page shows:
     - List of cart items
     - Each item shows:
       - Product image (thumbnail)
       - Product name (link to details)
       - Price (per unit)
       - Quantity selector
       - Subtotal (price × quantity)
       - Remove button
     - Cart summary sidebar:
       - Subtotal
       - Shipping cost (calculated or estimated)
       - Tax
       - Total amount
       - "Proceed to Checkout" button

3. **Item Management**
   - User can update quantity:
     - Click "+" or "-" buttons
     - Or type quantity directly
     - Subtotal updates in real-time
     - Cart total recalculates
   - User can remove item:
     - Click "Remove" or trash icon
     - Confirmation (optional): "Remove this item?"
     - Item removed from cart
     - Cart updates immediately

4. **Compatibility Warnings**
   - If incompatible products in cart:
     - Warning banner appears
     - Lists incompatible products
     - Suggests compatible alternatives
     - User can remove incompatible items

5. **Empty Cart State**
   - If cart is empty:
     - Message: "Your cart is empty"
     - "Continue Shopping" button
     - Links to popular categories

6. **Proceed to Checkout**
   - User reviews cart
   - User clicks "Proceed to Checkout" button
   - Redirected to `/checkout.jsp`

#### UX Considerations
- **Real-time Updates**: Instant calculation of totals
- **Optimistic UI**: Immediate feedback on actions
- **Error Recovery**: Undo option for removed items (if implemented)
- **Mobile**: Touch-friendly quantity controls

---

### 1.3 Scenario: Updating Cart Quantities

**User Persona**: Customer adjusting order quantities  
**Goal**: Change quantity of items in cart  
**Context**: User on cart page

#### Step-by-Step Flow

1. **Quantity Change**
   - User clicks "+" button to increase quantity
   - Quantity updates immediately
   - Subtotal recalculates
   - Cart total updates

2. **Stock Validation**
   - If quantity exceeds stock:
     - Warning message: "Only 5 items available"
     - Quantity resets to maximum available
     - User notified

3. **Server Sync**
   - Change sent to server
   - If successful: Confirmation (subtle)
   - If error: Revert to previous quantity
   - Error message displayed

4. **Bulk Update**
   - User can update multiple quantities
   - Changes saved together
   - Single confirmation message

#### UX Considerations
- **Validation**: Check stock before allowing increase
- **Feedback**: Clear indication of changes
- **Persistence**: Changes saved immediately
- **Mobile**: Large touch targets for buttons

---

## 2. Checkout Process Scenarios

### 2.1 Scenario: Complete Checkout Flow

**User Persona**: Customer ready to purchase  
**Goal**: Complete order and payment  
**Context**: User proceeds from cart to checkout

#### Step-by-Step Flow

1. **Checkout Entry**
   - User on cart page
   - User clicks "Proceed to Checkout"
   - Redirected to `/checkout.jsp`
   - If not logged in: Redirect to login, then back to checkout

2. **Checkout Progress Indicator**
   - Progress bar shows 4 steps:
     - Cart (completed)
     - Shipping (current)
     - Payment (upcoming)
     - Review (upcoming)
   - Current step highlighted
   - Completed steps show checkmarks

3. **Shipping Information Step**
   - Form displays:
     - Full Name
     - Email Address
     - Phone Number
     - Address Line 1
     - Address Line 2 (optional)
     - City, State, Postal Code
     - Country
   - If logged in: "Use saved address" option
   - "Save this address" checkbox
   - Form validation in real-time
   - User fills in information
   - User clicks "Continue to Payment"

4. **Shipping Method Selection**
   - User selects shipping method:
     - Standard Shipping (5-7 days) - $5.00
     - Express Shipping (2-3 days) - $15.00
     - Overnight Shipping (1 day) - $25.00
   - Shipping cost updates
   - Estimated delivery date shown
   - User clicks "Continue to Payment"

5. **Payment Information Step**
   - User selects payment method:
     - Credit/Debit Card
     - PayPal
     - Bank Transfer
   - If Credit Card:
     - Card number input (auto-formats)
     - Expiry date (MM/YY)
     - CVV
     - Cardholder name
     - "Save card" option (if logged in)
   - If PayPal:
     - "Pay with PayPal" button
     - Redirects to PayPal (if implemented)
   - If Bank Transfer:
     - Bank details displayed
     - Reference number shown
   - User fills payment information
   - User clicks "Continue to Review"

6. **Review & Confirm Step**
   - Order summary displayed:
     - Shipping address (editable)
     - Payment method (editable)
     - Order items list
     - Subtotal, shipping, tax, total
   - Terms & Conditions checkbox (required)
   - Privacy Policy checkbox (required)
   - User reviews all information
   - User can edit any section
   - User clicks "Place Order"

7. **Order Processing**
   - Button shows loading: "Processing order..."
   - Order created in database
   - Payment processed (if applicable)
   - Confirmation email sent (if implemented)
   - Order number generated

8. **Order Confirmation**
   - Redirect to order confirmation page
   - Order number displayed prominently
   - Order summary shown
   - "Track Order" button
   - "Continue Shopping" button
   - Email confirmation sent (if implemented)

#### UX Considerations
- **Progress Indicator**: Clear indication of steps
- **Form Validation**: Real-time validation
- **Error Handling**: Clear error messages
- **Save Draft**: Auto-save form data (if implemented)
- **Mobile**: Single column layout, sticky buttons

---

### 2.2 Scenario: Guest Checkout

**User Persona**: Guest user, not registered  
**Goal**: Complete purchase without account  
**Context**: Guest user with items in cart

#### Flow Differences
- No login required
- Must enter all shipping information
- Cannot save address
- Option to create account after checkout
- Email required for order confirmation

---

### 2.3 Scenario: Returning Customer Checkout

**User Persona**: Logged-in customer  
**Goal**: Quick checkout with saved information  
**Context**: Customer with saved addresses and payment methods

#### Flow Differences
- Pre-filled shipping information
- "Use saved address" dropdown
- Saved payment methods available
- Faster checkout process
- Can save new address/payment method

---

## 3. Order Management Scenarios

### 3.1 Scenario: Viewing Order History

**User Persona**: Customer wanting to track orders  
**Goal**: View past and current orders  
**Context**: User clicks "Orders" in header menu

#### Step-by-Step Flow

1. **Order History Access**
   - User clicks "Orders" in header menu
   - Redirected to `/orderList.jsp`
   - Order history page loads

2. **Order List Display**
   - Page shows:
     - List of orders (newest first)
     - Each order shows:
       - Order number (link to details)
       - Order date
       - Status badge (Pending, Processing, Shipped, Delivered)
       - Total amount
       - Number of items
       - "View Details" button
   - Filter options:
     - Filter by status
     - Filter by date range
   - Pagination (if many orders)

3. **Order Details**
   - User clicks order number or "View Details"
   - Order details page shows:
     - Order number and date
     - Order status and timeline
     - Shipping address
     - Billing address
     - Payment method
     - Order items (with images, quantities, prices)
     - Subtotal, shipping, tax, total
     - Tracking information (if shipped)
     - "Track Shipment" button (if available)

4. **Order Status Updates**
   - Status updates automatically
   - User sees status changes:
     - Pending → Processing
     - Processing → Shipped
     - Shipped → Delivered
   - Email notifications (if implemented)

#### UX Considerations
- **Status Clarity**: Clear status indicators with colors
- **Timeline**: Visual timeline of order progress
- **Filtering**: Easy filtering by status or date
- **Mobile**: Responsive table or card layout

---

### 3.2 Scenario: Order Tracking

**User Persona**: Customer tracking shipment  
**Goal**: Track order delivery status  
**Context**: User has shipped order

#### Step-by-Step Flow

1. **Tracking Access**
   - User on order details page
   - User clicks "Track Shipment" button
   - Or user navigates to tracking page with tracking number

2. **Tracking Information Display**
   - Page shows:
     - Tracking number
     - Carrier name
     - Current status
     - Estimated delivery date
     - Tracking history timeline:
       - Order placed
       - Order confirmed
       - Shipped
       - In transit
       - Out for delivery
       - Delivered
   - Each step shows date and time
   - Current step highlighted

3. **Delivery Confirmation**
   - When delivered:
     - Status updates to "Delivered"
     - Delivery date shown
     - "Leave Review" button appears (if implemented)
     - "Reorder" button (if implemented)

#### UX Considerations
- **Real-time Updates**: Status updates automatically
- **Visual Timeline**: Clear progress visualization
- **Carrier Integration**: Link to carrier tracking (if available)
- **Notifications**: Email/SMS updates (if implemented)

---

## 4. Payment Processing Scenarios

### 4.1 Scenario: Credit Card Payment

**User Persona**: Customer paying with card  
**Goal**: Complete payment securely  
**Context**: User in checkout, payment step

#### Step-by-Step Flow

1. **Payment Method Selection**
   - User selects "Credit/Debit Card"
   - Card form appears

2. **Card Information Entry**
   - User enters card number
     - Auto-formats as user types (e.g., "1234 5678 9012 3456")
     - Card type detected (Visa, Mastercard, etc.)
     - Card icon updates
   - User enters expiry date (MM/YY)
     - Auto-advances to next field
   - User enters CVV
     - Help tooltip: "3 digits on back of card"
   - User enters cardholder name

3. **Card Validation**
   - Real-time validation:
     - Card number format
     - Expiry date (not expired)
     - CVV format
   - Errors shown immediately
   - Form highlights invalid fields

4. **Payment Processing**
   - User clicks "Place Order"
   - Payment processed:
     - Card validated
     - Payment authorized
     - Transaction created
   - Loading state: "Processing payment..."

5. **Payment Result**
   - If successful:
     - Order confirmed
     - Transaction ID shown
     - Redirect to confirmation page
   - If failed:
     - Error message: "Payment failed. Please try again."
     - User can retry or change payment method
     - Form retains information (except CVV)

#### UX Considerations
- **Security**: PCI compliance, secure processing
- **Validation**: Real-time card validation
- **Error Messages**: Clear, actionable errors
- **Retry**: Easy retry option

---

### 4.2 Scenario: PayPal Payment

**User Persona**: Customer preferring PayPal  
**Goal**: Pay using PayPal account  
**Context**: User in checkout, selects PayPal

#### Step-by-Step Flow

1. **PayPal Selection**
   - User selects "PayPal" payment method
   - "Pay with PayPal" button appears

2. **PayPal Redirect**
   - User clicks "Pay with PayPal"
   - Redirected to PayPal (if implemented)
   - Or PayPal popup/modal

3. **PayPal Authentication**
   - User logs in to PayPal
   - User confirms payment
   - User authorizes payment

4. **Return to Site**
   - Redirected back to site
   - Payment confirmed
   - Order created
   - Confirmation page shown

#### UX Considerations
- **Seamless Integration**: Smooth redirect flow
- **Error Handling**: Handle PayPal errors
- **Return URL**: Proper return URL handling

---

## 5. Compatibility Checking Scenarios

### 5.1 Scenario: Incompatible Products Warning

**User Persona**: Customer adding multiple products  
**Goal**: Avoid incompatible product combinations  
**Context**: User adds products to cart

#### Step-by-Step Flow

1. **Compatibility Check**
   - User adds product to cart
   - System checks compatibility with existing cart items
   - `CompatibilityEngine` analyzes products

2. **Warning Display**
   - If incompatible:
     - Warning banner appears in cart
     - Message: "Some products in your cart may not be compatible"
     - Lists incompatible products
     - Explains incompatibility reason

3. **User Actions**
   - User can:
     - Remove incompatible items
     - View compatibility details
     - See suggested compatible alternatives
     - Proceed anyway (with warning)

4. **Compatibility Suggestions**
   - System suggests compatible alternatives
   - User can replace incompatible items
   - One-click replacement option

#### UX Considerations
- **Proactive**: Check before checkout
- **Clear Warnings**: Easy to understand
- **Solutions**: Provide alternatives
- **User Choice**: Allow override if needed

---

## 6. Error Scenarios

### 6.1 Scenario: Out of Stock During Checkout

**Flow**:
1. User proceeds to checkout
2. System checks stock for all items
3. If item out of stock:
   - Warning message: "Some items are no longer available"
   - Lists unavailable items
   - User can:
     - Remove unavailable items
     - Update quantities
     - Return to cart
4. Cart updates automatically
5. User can proceed with available items

### 6.2 Scenario: Payment Failure

**Flow**:
1. User submits payment
2. Payment processing fails
3. Error message: "Payment could not be processed"
4. Possible reasons:
   - Insufficient funds
   - Card declined
   - Network error
5. User can:
   - Retry payment
   - Change payment method
   - Contact support
6. Order not created (payment required)

### 6.3 Scenario: Session Expired During Checkout

**Flow**:
1. User in checkout process
2. Session expires
3. User attempts to place order
4. Redirect to login with message: "Your session expired"
5. After login, redirect back to checkout
6. Cart items preserved
7. Form data may be lost (or saved in draft)

---

## 7. Mobile UX Considerations

### 7.1 Mobile Cart
- Bottom sheet for cart preview
- Swipe to remove items
- Large quantity controls
- Sticky checkout button

### 7.2 Mobile Checkout
- Single column layout
- Sticky progress indicator
- Auto-fill for addresses
- Simplified payment forms
- Large touch targets

### 7.3 Mobile Order Tracking
- Card-based layout
- Swipeable timeline
- Push notifications (if implemented)

---

## 8. Performance Considerations

### 8.1 Cart Updates
- Optimistic UI updates
- Background server sync
- Error rollback if needed

### 8.2 Checkout
- Auto-save form data
- Progress persistence
- Fast payment processing

### 8.3 Order History
- Lazy loading of orders
- Pagination for large lists
- Cached order data

---

**End of E-commerce UX Scenarios**


## Document Information
**Feature Category**: E-commerce  
**Last Updated**: 2025-01-20  
**Related Features**: Shopping Cart, Checkout, Order Management, Payment Processing

---

## 1. Shopping Cart Scenarios

### 1.1 Scenario: Adding Product to Cart

**User Persona**: Customer browsing products  
**Goal**: Add product to shopping cart for later purchase  
**Context**: User on product listing or product details page

#### Step-by-Step Flow

1. **Product Selection**
   - User views product (on browse page or product details)
   - User decides to add product to cart
   - User may select quantity (if on product details page)

2. **Add to Cart Action**
   - User clicks "Add to Cart" button
   - Button shows loading state ("Adding...")
   - Optimistic UI update:
     - Cart count badge in header updates immediately
     - Button shows checkmark briefly
   - Toast notification appears: "Added to cart successfully"

3. **Cart Persistence**
   - Item saved to cart (database or session)
   - Cart persists across sessions (if logged in)
   - Guest cart saved in session

4. **Visual Feedback**
   - Cart icon in header pulses briefly
   - Cart count badge updates (e.g., "3")
   - Optional: Mini cart preview (if implemented)

#### UX Considerations
- **Immediate Feedback**: Optimistic UI for instant response
- **Error Handling**: Rollback if server error
- **Stock Validation**: Check stock before adding
- **Quantity Limits**: Respect maximum quantity

---

### 1.2 Scenario: Viewing Shopping Cart

**User Persona**: Customer with items in cart  
**Goal**: Review cart items before checkout  
**Context**: User clicks cart icon in header

#### Step-by-Step Flow

1. **Cart Access**
   - User clicks cart icon in header
   - Redirected to `/cart.jsp`
   - Cart page loads with all items

2. **Cart Display**
   - Page shows:
     - List of cart items
     - Each item shows:
       - Product image (thumbnail)
       - Product name (link to details)
       - Price (per unit)
       - Quantity selector
       - Subtotal (price × quantity)
       - Remove button
     - Cart summary sidebar:
       - Subtotal
       - Shipping cost (calculated or estimated)
       - Tax
       - Total amount
       - "Proceed to Checkout" button

3. **Item Management**
   - User can update quantity:
     - Click "+" or "-" buttons
     - Or type quantity directly
     - Subtotal updates in real-time
     - Cart total recalculates
   - User can remove item:
     - Click "Remove" or trash icon
     - Confirmation (optional): "Remove this item?"
     - Item removed from cart
     - Cart updates immediately

4. **Compatibility Warnings**
   - If incompatible products in cart:
     - Warning banner appears
     - Lists incompatible products
     - Suggests compatible alternatives
     - User can remove incompatible items

5. **Empty Cart State**
   - If cart is empty:
     - Message: "Your cart is empty"
     - "Continue Shopping" button
     - Links to popular categories

6. **Proceed to Checkout**
   - User reviews cart
   - User clicks "Proceed to Checkout" button
   - Redirected to `/checkout.jsp`

#### UX Considerations
- **Real-time Updates**: Instant calculation of totals
- **Optimistic UI**: Immediate feedback on actions
- **Error Recovery**: Undo option for removed items (if implemented)
- **Mobile**: Touch-friendly quantity controls

---

### 1.3 Scenario: Updating Cart Quantities

**User Persona**: Customer adjusting order quantities  
**Goal**: Change quantity of items in cart  
**Context**: User on cart page

#### Step-by-Step Flow

1. **Quantity Change**
   - User clicks "+" button to increase quantity
   - Quantity updates immediately
   - Subtotal recalculates
   - Cart total updates

2. **Stock Validation**
   - If quantity exceeds stock:
     - Warning message: "Only 5 items available"
     - Quantity resets to maximum available
     - User notified

3. **Server Sync**
   - Change sent to server
   - If successful: Confirmation (subtle)
   - If error: Revert to previous quantity
   - Error message displayed

4. **Bulk Update**
   - User can update multiple quantities
   - Changes saved together
   - Single confirmation message

#### UX Considerations
- **Validation**: Check stock before allowing increase
- **Feedback**: Clear indication of changes
- **Persistence**: Changes saved immediately
- **Mobile**: Large touch targets for buttons

---

## 2. Checkout Process Scenarios

### 2.1 Scenario: Complete Checkout Flow

**User Persona**: Customer ready to purchase  
**Goal**: Complete order and payment  
**Context**: User proceeds from cart to checkout

#### Step-by-Step Flow

1. **Checkout Entry**
   - User on cart page
   - User clicks "Proceed to Checkout"
   - Redirected to `/checkout.jsp`
   - If not logged in: Redirect to login, then back to checkout

2. **Checkout Progress Indicator**
   - Progress bar shows 4 steps:
     - Cart (completed)
     - Shipping (current)
     - Payment (upcoming)
     - Review (upcoming)
   - Current step highlighted
   - Completed steps show checkmarks

3. **Shipping Information Step**
   - Form displays:
     - Full Name
     - Email Address
     - Phone Number
     - Address Line 1
     - Address Line 2 (optional)
     - City, State, Postal Code
     - Country
   - If logged in: "Use saved address" option
   - "Save this address" checkbox
   - Form validation in real-time
   - User fills in information
   - User clicks "Continue to Payment"

4. **Shipping Method Selection**
   - User selects shipping method:
     - Standard Shipping (5-7 days) - $5.00
     - Express Shipping (2-3 days) - $15.00
     - Overnight Shipping (1 day) - $25.00
   - Shipping cost updates
   - Estimated delivery date shown
   - User clicks "Continue to Payment"

5. **Payment Information Step**
   - User selects payment method:
     - Credit/Debit Card
     - PayPal
     - Bank Transfer
   - If Credit Card:
     - Card number input (auto-formats)
     - Expiry date (MM/YY)
     - CVV
     - Cardholder name
     - "Save card" option (if logged in)
   - If PayPal:
     - "Pay with PayPal" button
     - Redirects to PayPal (if implemented)
   - If Bank Transfer:
     - Bank details displayed
     - Reference number shown
   - User fills payment information
   - User clicks "Continue to Review"

6. **Review & Confirm Step**
   - Order summary displayed:
     - Shipping address (editable)
     - Payment method (editable)
     - Order items list
     - Subtotal, shipping, tax, total
   - Terms & Conditions checkbox (required)
   - Privacy Policy checkbox (required)
   - User reviews all information
   - User can edit any section
   - User clicks "Place Order"

7. **Order Processing**
   - Button shows loading: "Processing order..."
   - Order created in database
   - Payment processed (if applicable)
   - Confirmation email sent (if implemented)
   - Order number generated

8. **Order Confirmation**
   - Redirect to order confirmation page
   - Order number displayed prominently
   - Order summary shown
   - "Track Order" button
   - "Continue Shopping" button
   - Email confirmation sent (if implemented)

#### UX Considerations
- **Progress Indicator**: Clear indication of steps
- **Form Validation**: Real-time validation
- **Error Handling**: Clear error messages
- **Save Draft**: Auto-save form data (if implemented)
- **Mobile**: Single column layout, sticky buttons

---

### 2.2 Scenario: Guest Checkout

**User Persona**: Guest user, not registered  
**Goal**: Complete purchase without account  
**Context**: Guest user with items in cart

#### Flow Differences
- No login required
- Must enter all shipping information
- Cannot save address
- Option to create account after checkout
- Email required for order confirmation

---

### 2.3 Scenario: Returning Customer Checkout

**User Persona**: Logged-in customer  
**Goal**: Quick checkout with saved information  
**Context**: Customer with saved addresses and payment methods

#### Flow Differences
- Pre-filled shipping information
- "Use saved address" dropdown
- Saved payment methods available
- Faster checkout process
- Can save new address/payment method

---

## 3. Order Management Scenarios

### 3.1 Scenario: Viewing Order History

**User Persona**: Customer wanting to track orders  
**Goal**: View past and current orders  
**Context**: User clicks "Orders" in header menu

#### Step-by-Step Flow

1. **Order History Access**
   - User clicks "Orders" in header menu
   - Redirected to `/orderList.jsp`
   - Order history page loads

2. **Order List Display**
   - Page shows:
     - List of orders (newest first)
     - Each order shows:
       - Order number (link to details)
       - Order date
       - Status badge (Pending, Processing, Shipped, Delivered)
       - Total amount
       - Number of items
       - "View Details" button
   - Filter options:
     - Filter by status
     - Filter by date range
   - Pagination (if many orders)

3. **Order Details**
   - User clicks order number or "View Details"
   - Order details page shows:
     - Order number and date
     - Order status and timeline
     - Shipping address
     - Billing address
     - Payment method
     - Order items (with images, quantities, prices)
     - Subtotal, shipping, tax, total
     - Tracking information (if shipped)
     - "Track Shipment" button (if available)

4. **Order Status Updates**
   - Status updates automatically
   - User sees status changes:
     - Pending → Processing
     - Processing → Shipped
     - Shipped → Delivered
   - Email notifications (if implemented)

#### UX Considerations
- **Status Clarity**: Clear status indicators with colors
- **Timeline**: Visual timeline of order progress
- **Filtering**: Easy filtering by status or date
- **Mobile**: Responsive table or card layout

---

### 3.2 Scenario: Order Tracking

**User Persona**: Customer tracking shipment  
**Goal**: Track order delivery status  
**Context**: User has shipped order

#### Step-by-Step Flow

1. **Tracking Access**
   - User on order details page
   - User clicks "Track Shipment" button
   - Or user navigates to tracking page with tracking number

2. **Tracking Information Display**
   - Page shows:
     - Tracking number
     - Carrier name
     - Current status
     - Estimated delivery date
     - Tracking history timeline:
       - Order placed
       - Order confirmed
       - Shipped
       - In transit
       - Out for delivery
       - Delivered
   - Each step shows date and time
   - Current step highlighted

3. **Delivery Confirmation**
   - When delivered:
     - Status updates to "Delivered"
     - Delivery date shown
     - "Leave Review" button appears (if implemented)
     - "Reorder" button (if implemented)

#### UX Considerations
- **Real-time Updates**: Status updates automatically
- **Visual Timeline**: Clear progress visualization
- **Carrier Integration**: Link to carrier tracking (if available)
- **Notifications**: Email/SMS updates (if implemented)

---

## 4. Payment Processing Scenarios

### 4.1 Scenario: Credit Card Payment

**User Persona**: Customer paying with card  
**Goal**: Complete payment securely  
**Context**: User in checkout, payment step

#### Step-by-Step Flow

1. **Payment Method Selection**
   - User selects "Credit/Debit Card"
   - Card form appears

2. **Card Information Entry**
   - User enters card number
     - Auto-formats as user types (e.g., "1234 5678 9012 3456")
     - Card type detected (Visa, Mastercard, etc.)
     - Card icon updates
   - User enters expiry date (MM/YY)
     - Auto-advances to next field
   - User enters CVV
     - Help tooltip: "3 digits on back of card"
   - User enters cardholder name

3. **Card Validation**
   - Real-time validation:
     - Card number format
     - Expiry date (not expired)
     - CVV format
   - Errors shown immediately
   - Form highlights invalid fields

4. **Payment Processing**
   - User clicks "Place Order"
   - Payment processed:
     - Card validated
     - Payment authorized
     - Transaction created
   - Loading state: "Processing payment..."

5. **Payment Result**
   - If successful:
     - Order confirmed
     - Transaction ID shown
     - Redirect to confirmation page
   - If failed:
     - Error message: "Payment failed. Please try again."
     - User can retry or change payment method
     - Form retains information (except CVV)

#### UX Considerations
- **Security**: PCI compliance, secure processing
- **Validation**: Real-time card validation
- **Error Messages**: Clear, actionable errors
- **Retry**: Easy retry option

---

### 4.2 Scenario: PayPal Payment

**User Persona**: Customer preferring PayPal  
**Goal**: Pay using PayPal account  
**Context**: User in checkout, selects PayPal

#### Step-by-Step Flow

1. **PayPal Selection**
   - User selects "PayPal" payment method
   - "Pay with PayPal" button appears

2. **PayPal Redirect**
   - User clicks "Pay with PayPal"
   - Redirected to PayPal (if implemented)
   - Or PayPal popup/modal

3. **PayPal Authentication**
   - User logs in to PayPal
   - User confirms payment
   - User authorizes payment

4. **Return to Site**
   - Redirected back to site
   - Payment confirmed
   - Order created
   - Confirmation page shown

#### UX Considerations
- **Seamless Integration**: Smooth redirect flow
- **Error Handling**: Handle PayPal errors
- **Return URL**: Proper return URL handling

---

## 5. Compatibility Checking Scenarios

### 5.1 Scenario: Incompatible Products Warning

**User Persona**: Customer adding multiple products  
**Goal**: Avoid incompatible product combinations  
**Context**: User adds products to cart

#### Step-by-Step Flow

1. **Compatibility Check**
   - User adds product to cart
   - System checks compatibility with existing cart items
   - `CompatibilityEngine` analyzes products

2. **Warning Display**
   - If incompatible:
     - Warning banner appears in cart
     - Message: "Some products in your cart may not be compatible"
     - Lists incompatible products
     - Explains incompatibility reason

3. **User Actions**
   - User can:
     - Remove incompatible items
     - View compatibility details
     - See suggested compatible alternatives
     - Proceed anyway (with warning)

4. **Compatibility Suggestions**
   - System suggests compatible alternatives
   - User can replace incompatible items
   - One-click replacement option

#### UX Considerations
- **Proactive**: Check before checkout
- **Clear Warnings**: Easy to understand
- **Solutions**: Provide alternatives
- **User Choice**: Allow override if needed

---

## 6. Error Scenarios

### 6.1 Scenario: Out of Stock During Checkout

**Flow**:
1. User proceeds to checkout
2. System checks stock for all items
3. If item out of stock:
   - Warning message: "Some items are no longer available"
   - Lists unavailable items
   - User can:
     - Remove unavailable items
     - Update quantities
     - Return to cart
4. Cart updates automatically
5. User can proceed with available items

### 6.2 Scenario: Payment Failure

**Flow**:
1. User submits payment
2. Payment processing fails
3. Error message: "Payment could not be processed"
4. Possible reasons:
   - Insufficient funds
   - Card declined
   - Network error
5. User can:
   - Retry payment
   - Change payment method
   - Contact support
6. Order not created (payment required)

### 6.3 Scenario: Session Expired During Checkout

**Flow**:
1. User in checkout process
2. Session expires
3. User attempts to place order
4. Redirect to login with message: "Your session expired"
5. After login, redirect back to checkout
6. Cart items preserved
7. Form data may be lost (or saved in draft)

---

## 7. Mobile UX Considerations

### 7.1 Mobile Cart
- Bottom sheet for cart preview
- Swipe to remove items
- Large quantity controls
- Sticky checkout button

### 7.2 Mobile Checkout
- Single column layout
- Sticky progress indicator
- Auto-fill for addresses
- Simplified payment forms
- Large touch targets

### 7.3 Mobile Order Tracking
- Card-based layout
- Swipeable timeline
- Push notifications (if implemented)

---

## 8. Performance Considerations

### 8.1 Cart Updates
- Optimistic UI updates
- Background server sync
- Error rollback if needed

### 8.2 Checkout
- Auto-save form data
- Progress persistence
- Fast payment processing

### 8.3 Order History
- Lazy loading of orders
- Pagination for large lists
- Cached order data

---

**End of E-commerce UX Scenarios**



---

**Document Version**: 1.0.0
**Status**: Published
**Audience**: Developers, Stakeholders
**Maintained By**: IoT Bay Documentation Team
