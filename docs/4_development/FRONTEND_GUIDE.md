# Frontend Development Guide

Comprehensive guide for frontend developers working on the IoT Bay platform.

---

## Architecture Overview

### Atomic Design System

IoT Bay uses **Atomic Design** methodology to structure UI components:

```
┌─────────────────────────────────┐
│     Templates (Page Layouts)     │  Complete pages
├─────────────────────────────────┤
│    Organisms (Component Groups)  │  Featured sections
├─────────────────────────────────┤
│    Molecules (Component Combos)  │  Simple combinations
├─────────────────────────────────┤
│      Atoms (Basic Elements)      │  Buttons, inputs, labels
└─────────────────────────────────┘
```

### Component Hierarchy

```
Product Detail Page (Template)
├── Navigation Organism
│   ├── Logo (Atom)
│   ├── Search Bar (Molecule)
│   └── User Menu (Molecule)
├── Product Display Organism
│   ├── Product Image (Atom)
│   ├── Product Info (Molecule)
│   └── Add to Cart Button (Atom)
└── Footer Organism
    └── Links (Atoms)
```

---

## Project Structure

```
src/main/webapp/
├── WEB-INF/
│   ├── views/
│   │   ├── atoms/              # Basic components
│   │   │   ├── button.jsp
│   │   │   ├── input.jsp
│   │   │   └── ...
│   │   ├── molecules/          # Component combinations
│   │   │   ├── search-bar.jsp
│   │   │   ├── card.jsp
│   │   │   └── ...
│   │   ├── organisms/          # Featured sections
│   │   │   ├── header.jsp
│   │   │   ├── navigation.jsp
│   │   │   └── ...
│   │   └── templates/          # Page layouts
│   │       ├── base-layout.jsp
│   │       ├── product-detail.jsp
│   │       └── ...
│   └── web.xml
├── assets/
│   ├── css/
│   │   ├── style.css           # Main stylesheet
│   │   ├── atoms.css           # Atom styles
│   │   ├── molecules.css       # Molecule styles
│   │   ├── organisms.css       # Organism styles
│   │   └── responsive.css      # Media queries
│   ├── js/
│   │   ├── main.js             # Main JavaScript
│   │   ├── components.js       # Component logic
│   │   ├── api-client.js       # API calls
│   │   └── utils.js            # Helper functions
│   └── img/                    # Images
└── index.jsp                   # Home page
```

---

## JSP Component Patterns

### Atom Component (Button)

Create `src/main/webapp/WEB-INF/views/atoms/button.jsp`:

```jsp
<%-- Button Atom Component --%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    // Default attributes
    String buttonText = (String) request.getAttribute("buttonText");
    String buttonClass = (String) request.getAttribute("buttonClass");
    String buttonId = (String) request.getAttribute("buttonId");
    String onClick = (String) request.getAttribute("onClick");
    String buttonType = (String) request.getAttribute("buttonType");
    
    if (buttonClass == null) buttonClass = "btn-primary";
    if (buttonType == null) buttonType = "button";
%>

<button 
    type="<%= buttonType %>" 
    id="<%= buttonId %>" 
    class="btn <%= buttonClass %>"
    <% if (onClick != null) { %>onclick="<%= onClick %>"<% } %>>
    <%= buttonText %>
</button>
```

Usage in Molecule:

```jsp
<%
    request.setAttribute("buttonText", "Add to Cart");
    request.setAttribute("buttonClass", "btn-primary");
    request.setAttribute("buttonId", "add-cart-btn");
    request.setAttribute("onClick", "addToCart(" + productId + ")");
%>
<jsp:include page="/WEB-INF/views/atoms/button.jsp" />
```

### Molecule Component (Product Card)

Create `src/main/webapp/WEB-INF/views/molecules/product-card.jsp`:

```jsp
<%-- Product Card Molecule Component --%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="iotbay.model.Product" %>

<%
    Product product = (Product) request.getAttribute("product");
    if (product == null) return;
%>

<div class="product-card">
    <div class="product-image">
        <img src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>">
    </div>
    
    <div class="product-info">
        <h3 class="product-name"><%= product.getName() %></h3>
        <p class="product-description"><%= product.getDescription() %></p>
        
        <div class="product-price">
            <span class="price">$<%= String.format("%.2f", product.getPrice()) %></span>
        </div>
        
        <div class="product-rating">
            <div class="stars">
                <% for (int i = 0; i < product.getRating(); i++) { %>
                    <span class="star">★</span>
                <% } %>
            </div>
            <span class="review-count">(<%= product.getReviewCount() %> reviews)</span>
        </div>
    </div>
    
    <div class="product-actions">
        <button class="btn btn-primary" onclick="addToCart(<%= product.getId() %>)">
            Add to Cart
        </button>
        <a href="product?id=<%= product.getId() %>" class="btn btn-secondary">
            View Details
        </a>
    </div>
</div>
```

### Organism Component (Navigation)

Create `src/main/webapp/WEB-INF/views/organisms/navigation.jsp`:

```jsp
<%-- Navigation Organism Component --%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="iotbay.model.User" %>

<%
    User user = (User) session.getAttribute("user");
%>

<nav class="navbar">
    <div class="navbar-container">
        <div class="navbar-brand">
            <a href="index.jsp" class="logo">IoT Bay</a>
        </div>
        
        <div class="navbar-menu">
            <ul class="nav-links">
                <li><a href="browse">Browse</a></li>
                <li><a href="categories">Categories</a></li>
                <li><a href="deals">Deals</a></li>
            </ul>
        </div>
        
        <div class="navbar-search">
            <form method="GET" action="search" class="search-form">
                <input type="text" name="q" placeholder="Search products..." required>
                <button type="submit" class="btn-search">Search</button>
            </form>
        </div>
        
        <div class="navbar-user">
            <% if (user != null) { %>
                <span class="user-name"><%= user.getUsername() %></span>
                <a href="profile" class="nav-link">Profile</a>
                <a href="cart" class="nav-link">Cart</a>
                <a href="logout" class="nav-link">Logout</a>
            <% } else { %>
                <a href="login" class="btn btn-primary">Login</a>
                <a href="register" class="btn btn-secondary">Register</a>
            <% } %>
        </div>
    </div>
</nav>
```

### Template Component (Page Layout)

Create `src/main/webapp/WEB-INF/views/templates/base-layout.jsp`:

```jsp
<%-- Base Layout Template --%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= request.getAttribute("pageTitle") != null ? request.getAttribute("pageTitle") : "IoT Bay" %></title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/atoms.css">
    <link rel="stylesheet" href="assets/css/molecules.css">
    <link rel="stylesheet" href="assets/css/organisms.css">
    <link rel="stylesheet" href="assets/css/responsive.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="/WEB-INF/views/organisms/navigation.jsp" />
    
    <!-- Main Content -->
    <main class="main-content">
        <% if (request.getAttribute("content") != null) { %>
            <jsp:include page="<%= (String) request.getAttribute("content") %>" />
        <% } %>
    </main>
    
    <!-- Footer -->
    <jsp:include page="/WEB-INF/views/organisms/footer.jsp" />
    
    <!-- Scripts -->
    <script src="assets/js/utils.js"></script>
    <script src="assets/js/components.js"></script>
    <script src="assets/js/api-client.js"></script>
    <script src="assets/js/main.js"></script>
</body>
</html>
```

---

## CSS & Styling

### Atomic CSS Structure

Create `src/main/webapp/assets/css/atoms.css`:

```css
/* ========== ATOMS ========== */

/* Buttons */
.btn {
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    transition: all 0.3s ease;
}

.btn-primary {
    background-color: #007bff;
    color: white;
}

.btn-primary:hover {
    background-color: #0056b3;
}

.btn-secondary {
    background-color: #6c757d;
    color: white;
}

.btn-secondary:hover {
    background-color: #545b62;
}

/* Text Inputs */
input[type="text"],
input[type="email"],
input[type="password"],
textarea {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
    font-family: inherit;
}

input[type="text"]:focus,
input[type="email"]:focus,
input[type="password"]:focus,
textarea:focus {
    outline: none;
    border-color: #007bff;
    box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
}

/* Labels */
label {
    display: block;
    margin-bottom: 5px;
    font-weight: 600;
    color: #333;
}

/* Headings */
h1, h2, h3, h4, h5, h6 {
    margin: 20px 0 10px 0;
    color: #333;
    line-height: 1.3;
}

h1 { font-size: 32px; }
h2 { font-size: 28px; }
h3 { font-size: 24px; }
h4 { font-size: 20px; }
h5 { font-size: 16px; }
h6 { font-size: 14px; }

/* Links */
a {
    color: #007bff;
    text-decoration: none;
}

a:hover {
    text-decoration: underline;
}
```

### Responsive Design

Create `src/main/webapp/assets/css/responsive.css`:

```css
/* ========== RESPONSIVE DESIGN ========== */

/* Tablets (768px and up) */
@media (min-width: 768px) {
    .container {
        width: 750px;
    }
    
    .navbar-menu {
        display: flex;
    }
    
    .product-grid {
        grid-template-columns: repeat(2, 1fr);
    }
}

/* Desktop (992px and up) */
@media (min-width: 992px) {
    .container {
        width: 960px;
    }
    
    .product-grid {
        grid-template-columns: repeat(3, 1fr);
    }
    
    .sidebar {
        display: block;
    }
}

/* Large Desktop (1200px and up) */
@media (min-width: 1200px) {
    .container {
        width: 1140px;
    }
    
    .product-grid {
        grid-template-columns: repeat(4, 1fr);
    }
}

/* Mobile (below 768px) */
@media (max-width: 767px) {
    .container {
        width: 100%;
        padding: 0 15px;
    }
    
    .navbar-menu {
        display: none;
    }
    
    .product-grid {
        grid-template-columns: repeat(1, 1fr);
    }
    
    .sidebar {
        display: none;
    }
}
```

---

## JavaScript & Interactivity

### API Client

Create `src/main/webapp/assets/js/api-client.js`:

```javascript
// API Client for Backend Communication

class APIClient {
    constructor(baseURL = '') {
        this.baseURL = baseURL;
    }
    
    async request(endpoint, options = {}) {
        const url = `${this.baseURL}${endpoint}`;
        
        try {
            const response = await fetch(url, {
                headers: {
                    'Content-Type': 'application/json',
                    ...options.headers,
                },
                ...options,
            });
            
            if (!response.ok) {
                throw new Error(`API Error: ${response.status}`);
            }
            
            return await response.json();
        } catch (error) {
            console.error('API Request Error:', error);
            throw error;
        }
    }
    
    // GET request
    async get(endpoint) {
        return this.request(endpoint, { method: 'GET' });
    }
    
    // POST request
    async post(endpoint, data) {
        return this.request(endpoint, {
            method: 'POST',
            body: JSON.stringify(data),
        });
    }
    
    // PUT request
    async put(endpoint, data) {
        return this.request(endpoint, {
            method: 'PUT',
            body: JSON.stringify(data),
        });
    }
    
    // DELETE request
    async delete(endpoint) {
        return this.request(endpoint, { method: 'DELETE' });
    }
}

// Create global API instance
const api = new APIClient();

// Product API methods
async function getProducts(page = 1) {
    return api.get(`/products?page=${page}`);
}

async function getProductById(id) {
    return api.get(`/product?id=${id}`);
}

async function searchProducts(query) {
    return api.get(`/search?q=${encodeURIComponent(query)}`);
}
```

### Component Logic

Create `src/main/webapp/assets/js/components.js`:

```javascript
// Component Interaction Logic

// Add to cart functionality
async function addToCart(productId) {
    try {
        const response = await api.post('/cart', {
            productId: productId,
            quantity: 1,
        });
        
        if (response.success) {
            showNotification('Product added to cart!', 'success');
            updateCartCount();
        } else {
            showNotification('Error adding to cart', 'error');
        }
    } catch (error) {
        console.error('Error adding to cart:', error);
        showNotification('Error adding to cart', 'error');
    }
}

// Update cart item quantity
async function updateCartQuantity(cartItemId, quantity) {
    try {
        const response = await api.put(`/cart/${cartItemId}`, {
            quantity: quantity,
        });
        
        if (response.success) {
            location.reload(); // Refresh page
        }
    } catch (error) {
        console.error('Error updating cart:', error);
    }
}

// Remove from cart
async function removeFromCart(cartItemId) {
    try {
        const response = await api.delete(`/cart/${cartItemId}`);
        
        if (response.success) {
            location.reload(); // Refresh page
        }
    } catch (error) {
        console.error('Error removing from cart:', error);
    }
}

// Show notification message
function showNotification(message, type = 'info') {
    const notification = document.createElement('div');
    notification.className = `notification notification-${type}`;
    notification.textContent = message;
    
    document.body.appendChild(notification);
    
    setTimeout(() => {
        notification.classList.add('show');
    }, 10);
    
    setTimeout(() => {
        notification.classList.remove('show');
        setTimeout(() => notification.remove(), 300);
    }, 3000);
}

// Update cart count in navbar
async function updateCartCount() {
    try {
        const response = await api.get('/cart/count');
        const cartCountElement = document.querySelector('.cart-count');
        if (cartCountElement) {
            cartCountElement.textContent = response.count;
        }
    } catch (error) {
        console.error('Error updating cart count:', error);
    }
}
```

---

## Form Validation

### Client-Side Validation

```javascript
// Validate email
function validateEmail(email) {
    const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return regex.test(email);
}

// Validate password strength
function validatePassword(password) {
    const minLength = 8;
    const hasUppercase = /[A-Z]/.test(password);
    const hasLowercase = /[a-z]/.test(password);
    const hasNumbers = /\d/.test(password);
    const hasSpecial = /[@$!%*?&]/.test(password);
    
    return password.length >= minLength && 
           hasUppercase && 
           hasLowercase && 
           hasNumbers && 
           hasSpecial;
}

// Validate form
function validateForm(formId) {
    const form = document.getElementById(formId);
    const inputs = form.querySelectorAll('input, textarea');
    let isValid = true;
    
    inputs.forEach(input => {
        const error = validateInput(input);
        if (error) {
            isValid = false;
            showError(input, error);
        } else {
            clearError(input);
        }
    });
    
    return isValid;
}

function validateInput(input) {
    const value = input.value.trim();
    
    if (input.required && !value) {
        return 'This field is required';
    }
    
    if (input.type === 'email' && !validateEmail(value)) {
        return 'Invalid email address';
    }
    
    if (input.name === 'password' && !validatePassword(value)) {
        return 'Password must be 8+ chars with uppercase, lowercase, numbers, and special chars';
    }
    
    return null;
}

function showError(input, message) {
    const errorElement = input.nextElementSibling;
    if (errorElement && errorElement.classList.contains('error-message')) {
        errorElement.textContent = message;
        errorElement.style.display = 'block';
    }
    input.classList.add('error');
}

function clearError(input) {
    const errorElement = input.nextElementSibling;
    if (errorElement && errorElement.classList.contains('error-message')) {
        errorElement.style.display = 'none';
    }
    input.classList.remove('error');
}
```

---

## Testing Frontend Code

### Unit Testing with Jest (if applicable)

```javascript
// __tests__/api-client.test.js
describe('API Client', () => {
    test('should send GET request', async () => {
        const client = new APIClient();
        const mockResponse = { success: true };
        
        // Mock fetch
        global.fetch = jest.fn(() =>
            Promise.resolve({
                ok: true,
                json: () => Promise.resolve(mockResponse),
            })
        );
        
        const result = await client.get('/products');
        expect(result).toEqual(mockResponse);
    });
    
    test('should handle API errors', async () => {
        const client = new APIClient();
        
        global.fetch = jest.fn(() =>
            Promise.resolve({
                ok: false,
                status: 404,
            })
        );
        
        await expect(client.get('/products')).rejects.toThrow();
    });
});
```

---

## Performance Tips

### CSS & Layout

```css
/* ✅ Use CSS Grid for layouts */
.product-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    gap: 20px;
}

/* ❌ Avoid nested floats */
/* ❌ Avoid excessive positioning */
```

### JavaScript

```javascript
// ✅ Debounce expensive operations
function debounce(fn, delay) {
    let timeoutId;
    return function(...args) {
        clearTimeout(timeoutId);
        timeoutId = setTimeout(() => fn(...args), delay);
    };
}

const debouncedSearch = debounce(async (query) => {
    const results = await searchProducts(query);
    displayResults(results);
}, 300);

// ✅ Lazy load images
<img src="placeholder.jpg" data-src="real-image.jpg" loading="lazy">
```

---

## Common Patterns

### Modal Component

```jsp
<%-- Modal Molecule --%>
<div id="modal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <div id="modal-body"></div>
    </div>
</div>

<style>
.modal {
    display: none;
    position: fixed;
    z-index: 1000;
    top: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.4);
}

.modal-content {
    background-color: white;
    margin: 15% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 80%;
    max-width: 500px;
    border-radius: 4px;
}
</style>

<script>
function openModal(content) {
    document.getElementById('modal-body').innerHTML = content;
    document.getElementById('modal').style.display = 'block';
}

function closeModal() {
    document.getElementById('modal').style.display = 'none';
}
</script>
```

---

## Resources

- See [COMPONENT_ARCHITECTURE.md](../2_architecture/COMPONENT_ARCHITECTURE.md) for detailed component patterns
- See [CODE_STYLE.md](./CODE_STYLE.md) for CSS and JS conventions
- See [BACKEND_GUIDE.md](./BACKEND_GUIDE.md) for API integration
- See [ERROR_PREVENTION.md](../5_testing/ERROR_PREVENTION.md) for common frontend errors

---

**Last Updated**: December 3, 2025  
**Version**: 1.0.0  
**Status**: Documentation Complete


---

**Document Version**: 1.0.0
**Audience**: Developers, Stakeholders
**Maintained By**: IoT Bay Documentation Team
