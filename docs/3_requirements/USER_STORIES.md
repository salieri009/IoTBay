# User Stories

Complete user stories for IoT Bay platform covering all major features and user journeys.

---

## User Story Format

```
As a [user role]
I want to [action]
So that [benefit/outcome]

Acceptance Criteria:
- [ ] Given [context], when [action], then [result]
- [ ] Given [context], when [action], then [result]

Priority: [High/Medium/Low]
Status: [Not Started/In Progress/Complete]
Estimated Points: [1-13]
```

---

## User Management Stories

### US-001: User Registration

```
As a new visitor
I want to create an account with email and password
So that I can access personalized features and order history

Acceptance Criteria:
- [ ] Given I'm on the registration page, when I fill all required fields and click "Create Account", then my account is created and I'm redirected to login
- [ ] Given I enter an invalid email format, when I try to register, then I see an error message
- [ ] Given I enter passwords that don't match, when I try to register, then I see an error message
- [ ] Given I enter a password less than 8 characters, when I try to register, then I see a strength warning
- [ ] Given an account with my email already exists, when I try to register, then I see an error message

Priority: High
Status: Complete
Estimated Points: 5
```

### US-002: User Login

```
As a registered user
I want to login with my email and password
So that I can access my account

Acceptance Criteria:
- [ ] Given I'm on the login page, when I enter valid credentials and click "Login", then I'm redirected to my dashboard
- [ ] Given I enter invalid credentials, when I click "Login", then I see an error message
- [ ] Given my login is successful, when I navigate to protected pages, then I remain logged in
- [ ] Given I stay inactive for 30 minutes, when I try to access my account, then I'm logged out

Priority: High
Status: Complete
Estimated Points: 3
```

### US-003: User Profile Management

```
As a logged-in user
I want to view and edit my profile information
So that I can keep my personal details up to date

Acceptance Criteria:
- [ ] Given I'm logged in, when I navigate to /profile, then I see my current information
- [ ] Given I click "Edit Profile", when I update my name and phone, then changes are saved
- [ ] Given I click "Change Password", when I enter my current and new password, then my password is updated
- [ ] Given I change my password, when I logout and login with the new password, then I can access my account

Priority: Medium
Status: Complete
Estimated Points: 5
```

---

## Product Browsing Stories

### US-010: Browse Products

```
As a customer
I want to browse all available products
So that I can find items I'm interested in

Acceptance Criteria:
- [ ] Given I'm on the browse page, when products load, then I see a paginated list of 10 products per page
- [ ] Given I'm viewing products, when I click on a product, then I see detailed product information
- [ ] Given I'm on the browse page, when I click the next page button, then I see the next set of products
- [ ] Given there are 100 products, when I navigate through pages, then I can access all products

Priority: High
Status: Complete
Estimated Points: 5
```

### US-011: Search Products

```
As a customer
I want to search for products by name or keyword
So that I can quickly find what I'm looking for

Acceptance Criteria:
- [ ] Given I'm on any page, when I enter "sensor" in the search box and press Enter, then I see products matching "sensor"
- [ ] Given I search for a term, when results load, then they're relevant to my search
- [ ] Given no products match my search, when I submit, then I see a "No results found" message
- [ ] Given I search for "iot", when results display, then they're sorted by relevance

Priority: High
Status: Complete
Estimated Points: 5
```

### US-012: Filter Products by Category

```
As a customer
I want to filter products by category
So that I can focus on specific product types

Acceptance Criteria:
- [ ] Given I'm browsing products, when I click a category filter, then only products in that category display
- [ ] Given I select "Sensors" category, when products load, then all shown products belong to Sensors
- [ ] Given I've applied a filter, when I click "Clear Filters", then all products display again
- [ ] Given multiple categories exist, when I view the filter panel, then all categories are listed

Priority: Medium
Status: Complete
Estimated Points: 3
```

### US-013: View Product Details

```
As a customer
I want to view detailed information about a product
So that I can make an informed purchase decision

Acceptance Criteria:
- [ ] Given I click on a product, when the detail page loads, then I see name, description, price, and image
- [ ] Given I'm viewing a product, when I scroll down, then I see specifications and reviews
- [ ] Given a product has reviews, when I view the detail page, then I see average rating and review count
- [ ] Given a product has 0 stock, when I view it, then the "Add to Cart" button is disabled
- [ ] Given a product has reviews, when I click on a review, then I see the full review text

Priority: High
Status: Complete
Estimated Points: 4
```

### US-014: Sort Products

```
As a customer
I want to sort products by price, rating, or newest
So that I can organize results to my preference

Acceptance Criteria:
- [ ] Given I'm browsing products, when I select "Price: Low to High", then products are sorted by price ascending
- [ ] Given I select "Rating: High to Low", then products are sorted by average rating
- [ ] Given I select "Newest", then products are sorted by creation date (newest first)
- [ ] Given I've applied sorting, when I navigate to the next page, then sorting persists

Priority: Medium
Status: Complete
Estimated Points: 3
```

---

## Shopping Cart Stories

### US-020: Add Item to Cart

```
As a customer viewing a product
I want to add it to my shopping cart
So that I can purchase it later

Acceptance Criteria:
- [ ] Given I'm viewing a product, when I click "Add to Cart", then the item is added
- [ ] Given I add an item, when I see a confirmation message, then cart count increases
- [ ] Given I add multiple items, when I view the cart, then all items are there
- [ ] Given I add the same product twice, when I check the cart, then quantity is 2 (not 2 separate items)

Priority: High
Status: Complete
Estimated Points: 3
```

### US-021: View Shopping Cart

```
As a customer
I want to view all items in my shopping cart
So that I can review what I'm about to purchase

Acceptance Criteria:
- [ ] Given I have items in my cart, when I navigate to /cart, then I see all items with quantities
- [ ] Given I'm viewing the cart, when I see an item, then I see product name, price, quantity, and subtotal
- [ ] Given items are in my cart, when I view the page, then I see the total price including tax
- [ ] Given my cart is empty, when I view /cart, then I see an empty cart message with a link to browse products

Priority: High
Status: Complete
Estimated Points: 3
```

### US-022: Update Cart Quantity

```
As a customer with items in my cart
I want to update the quantity of items
So that I can adjust amounts before checkout

Acceptance Criteria:
- [ ] Given I have an item in my cart, when I change its quantity to 5, then the subtotal updates
- [ ] Given I set quantity to 0, when I confirm, then the item is removed from cart
- [ ] Given an item has max quantity of 10, when I try to set quantity to 15, then I see an error
- [ ] Given I update a quantity, when I check the total, then it's recalculated correctly

Priority: Medium
Status: Complete
Estimated Points: 3
```

### US-023: Remove Item from Cart

```
As a customer with items in my cart
I want to remove specific items
So that I can refine my purchase

Acceptance Criteria:
- [ ] Given I have an item in my cart, when I click the "Remove" button, then the item is deleted
- [ ] Given I remove an item, when I view the cart, then the item is gone and total is updated
- [ ] Given my cart has multiple items, when I remove one, then other items remain
- [ ] Given I remove the last item, when the cart loads, then I see the empty cart message

Priority: Medium
Status: Complete
Estimated Points: 2
```

---

## Checkout & Orders Stories

### US-030: Checkout Process

```
As a customer with items in my cart
I want to proceed to checkout
So that I can purchase my items

Acceptance Criteria:
- [ ] Given I'm viewing my cart with items, when I click "Checkout", then I'm shown the checkout form
- [ ] Given I'm on the checkout page, when I fill shipping and payment information, then I can submit
- [ ] Given I submit checkout, when payment is processed, then I see an order confirmation
- [ ] Given checkout fails, when payment is declined, then I see an error and can retry

Priority: High
Status: Complete
Estimated Points: 8
```

### US-031: View Order History

```
As a logged-in customer
I want to view all my past orders
So that I can track my purchase history

Acceptance Criteria:
- [ ] Given I'm logged in, when I navigate to /orders, then I see a list of all my orders
- [ ] Given I'm viewing orders, when I see an order, then it shows order number, date, status, and total
- [ ] Given I have multiple orders, when I navigate pages, then I can view all of them
- [ ] Given an order exists, when I click on it, then I see detailed order information

Priority: Medium
Status: Complete
Estimated Points: 3
```

### US-032: Track Order Status

```
As a customer with an active order
I want to see my order status and tracking information
So that I know where my package is

Acceptance Criteria:
- [ ] Given I have an order, when I view it, then I see current status (processing, shipped, delivered)
- [ ] Given my order is shipped, when I view it, then I see a tracking number
- [ ] Given I have a tracking number, when I click it, then I'm directed to carrier tracking page
- [ ] Given my order status changes, when I log in, then I see the updated status

Priority: Medium
Status: Complete
Estimated Points: 4
```

---

## Review Stories

### US-040: View Product Reviews

```
As a customer viewing a product
I want to see reviews from other customers
So that I can make a more informed purchase

Acceptance Criteria:
- [ ] Given a product has reviews, when I view the detail page, then I see reviews with rating and comment
- [ ] Given reviews exist, when I scroll through them, then I see reviewer name, date, and verified badge
- [ ] Given a review is helpful, when I click the helpful button, then the count increases
- [ ] Given there are many reviews, when I scroll down, then I see pagination controls

Priority: Medium
Status: Complete
Estimated Points: 3
```

### US-041: Submit Product Review

```
As a customer who purchased a product
I want to submit a review with rating and comment
So that I can share my experience with others

Acceptance Criteria:
- [ ] Given I've purchased a product, when I navigate to its page, then I see a "Write Review" button
- [ ] Given I click the review button, when a form appears, then I can select a 1-5 rating
- [ ] Given I submit a review, when the form is filled out, then my review is posted
- [ ] Given I submit a review, when it's posted, then I see a success message

Priority: Low
Status: Complete
Estimated Points: 4
```

---

## Admin Stories

### US-050: Admin Product Management

```
As an admin
I want to create, read, update, and delete products
So that I can manage the product catalog

Acceptance Criteria:
- [ ] Given I'm an admin, when I navigate to /admin/products, then I see all products
- [ ] Given I click "Add Product", when I fill out the product form, then the product is created
- [ ] Given a product exists, when I click "Edit", then I can update its information
- [ ] Given I click "Delete" on a product, when I confirm, then the product is removed
- [ ] Given I make changes to a product, when I save, then changes are immediately visible

Priority: High
Status: Complete
Estimated Points: 8
```

### US-051: View Orders (Admin)

```
As an admin
I want to view all customer orders
So that I can monitor sales and manage fulfillment

Acceptance Criteria:
- [ ] Given I'm an admin, when I navigate to /admin/orders, then I see all orders
- [ ] Given orders exist, when I view the list, then I see order number, customer, date, status, and total
- [ ] Given I click an order, when the detail page loads, then I see all items and customer information
- [ ] Given an order status is pending, when I update it to shipped, then the change is saved

Priority: High
Status: Complete
Estimated Points: 5
```

### US-052: Manage Categories

```
As an admin
I want to create, edit, and delete product categories
So that I can organize the product catalog

Acceptance Criteria:
- [ ] Given I'm an admin, when I navigate to /admin/categories, then I see all categories
- [ ] Given I click "Add Category", when I enter a name and description, then the category is created
- [ ] Given a category exists, when I click "Edit", then I can update its information
- [ ] Given I delete a category, when products exist in it, then I see a warning

Priority: Medium
Status: Complete
Estimated Points: 4
```

---

## Feature Coverage Matrix

| Feature | US-# | Priority | Status | Points |
|---|---|---|---|---|
| User Registration | US-001 | High | Complete | 5 |
| User Login | US-002 | High | Complete | 3 |
| Profile Management | US-003 | Medium | Complete | 5 |
| Browse Products | US-010 | High | Complete | 5 |
| Search Products | US-011 | High | Complete | 5 |
| Filter by Category | US-012 | Medium | Complete | 3 |
| View Product Details | US-013 | High | Complete | 4 |
| Sort Products | US-014 | Medium | Complete | 3 |
| Add to Cart | US-020 | High | Complete | 3 |
| View Cart | US-021 | High | Complete | 3 |
| Update Quantity | US-022 | Medium | Complete | 3 |
| Remove Item | US-023 | Medium | Complete | 2 |
| Checkout | US-030 | High | Complete | 8 |
| View Orders | US-031 | Medium | Complete | 3 |
| Track Order | US-032 | Medium | Complete | 4 |
| View Reviews | US-040 | Medium | Complete | 3 |
| Submit Review | US-041 | Low | Complete | 4 |
| Admin Products | US-050 | High | Complete | 8 |
| Admin Orders | US-051 | High | Complete | 5 |
| Manage Categories | US-052 | Medium | Complete | 4 |

**Total Points: 94 (All Complete)**

---

## Resources

- [Features Documentation](./FEATURES.md)
- [Acceptance Criteria Details](./acceptance-criteria/)
- [User Roles & Permissions](../4_development/BACKEND_GUIDE.md#authentication--authorization)

---

**Last Updated**: December 3, 2025  
**Version**: 1.0.0  
**Status**: Documentation Complete
