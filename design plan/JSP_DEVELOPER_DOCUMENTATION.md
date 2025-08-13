# IoTBay E-commerce Platform - Developer Documentation (JSP Edition)

## 📋 Table of Contents
1. [Project Overview](#project-overview)
2. [Business Requirements](#business-requirements)
3. [System Architecture](#system-architecture)
4. [Database Design](#database-design)
5. [JSP Frontend Architecture](#jsp-frontend-architecture)
6. [Backend Servlet Design](#backend-servlet-design)
7. [Component Architecture](#component-architecture)
8. [Design System & Theming](#design-system--theming)
9. [Security Implementation](#security-implementation)
10. [Deployment Guidelines](#deployment-guidelines)

## 📋 Project Overview

IoTBay is a comprehensive JSP-based e-commerce platform specialized in Internet of Things (IoT) devices and components. The platform has been modernized with a cutting-edge design system that provides a futuristic, clean, and accessible user experience while maintaining the robust JSP/Servlet architecture.

### 🎨 **NEW** Modern Design Features
- **Contemporary Visual Design**: Clean, minimalist interface with subtle gradients and modern typography
- **CSS Custom Properties**: Global theming system for consistent styling
- **Component-Based Architecture**: Reusable UI components with systematic class naming
- **Responsive Design**: Mobile-first approach with fluid layouts
- **Dark Mode Support**: Automatic theme switching capabilities
- **Accessibility Focus**: WCAG 2.1 AA compliance with ARIA support
- **Performance Optimized**: Modern CSS techniques for fast rendering

### Technology Stack
- **Frontend**: JSP (JavaServer Pages) + Modern CSS3 + Vanilla JavaScript
- **Design System**: CSS Custom Properties + Component Classes
- **Backend**: Java Servlets with MVC architecture
- **Database**: SQLite with JDBC
- **Build Tool**: Maven
- **Server**: Jetty (development) / Tomcat (production)
- **Styling**: Component-based CSS with global theming system

### Key Features
- User Registration and Authentication
- Product Catalog with Search and Filtering
- Shopping Cart and Checkout System
- Order Management and History
- User Profile Management
- Administrative Interface
- Access Logging and Security Monitoring

## 🎯 Business Requirements

### User Management
- **Registration**: Users can create accounts with personal information
- **Authentication**: Secure login with hashed password storage
- **Profile Management**: Users can update personal information, addresses
- **Role-based Access**: Customer, Staff, and Admin user types

### Product Management
- **Catalog Browsing**: Browse products by categories (Industrial, Warehouse, Agriculture, Smart Home)
- **Search Functionality**: Keyword-based product search with autocomplete
- **Product Details**: Detailed product information and images
- **Inventory Management**: Stock level tracking and management

### Shopping Experience
- **Shopping Cart**: Add/remove products, quantity management
- **Checkout Process**: Secure order placement workflow
- **Order History**: Track past purchases and order status
- **User Dashboard**: Comprehensive user account management

### Administrative Features
- **User Management**: Admin can manage user accounts and roles
- **Product Management**: CRUD operations for products
- **Order Monitoring**: View and manage customer orders
- **Access Logging**: Security audit trails and system logs

## 🏗️ System Architecture

### MVC Architecture Pattern
```
┌─────────────────────────────────────────────────────────────┐
│                     CLIENT BROWSER                         │
└─────────────────────┬───────────────────────────────────────┘
                      │ HTTP Request/Response
                      ▼
┌─────────────────────────────────────────────────────────────┐
│                  WEB CONTAINER (Jetty/Tomcat)              │
│                                                             │
│  ┌───────────────┐  ┌─────────────────┐  ┌──────────────┐  │
│  │     VIEW      │  │   CONTROLLER    │  │    MODEL     │  │
│  │  (JSP Pages)  │  │   (Servlets)    │  │ (Java Beans) │  │
│  │               │  │                 │  │              │  │
│  │ • index.jsp   │◄─│ • LoginServlet  │◄─│ • User.java  │  │
│  │ • login.jsp   │  │ • CartServlet   │  │ • Product.java│ │
│  │ • browse.jsp  │  │ • BrowseServlet │  │ • Order.java │  │
│  │ • cart.jsp    │  │ • CheckoutServ. │  │ • Cart.java  │  │
│  │ • profile.jsp │  │ • AdminServlet  │  │ • etc...     │  │
│  └───────────────┘  └─────────────────┘  └──────────────┘  │
│                                │                            │
│                                ▼                            │
│                   ┌─────────────────────┐                   │
│                   │   SERVICE LAYER     │                   │
│                   │                     │                   │
│                   │ • UserService       │                   │
│                   │ • ProductService    │                   │
│                   │ • CartService       │                   │
│                   │ • OrderService      │                   │
│                   └─────────────────────┘                   │
│                                │                            │
│                                ▼                            │
│                   ┌─────────────────────┐                   │
│                   │   DATA ACCESS       │                   │
│                   │   (DAO LAYER)       │                   │
│                   │                     │                   │
│                   │ • UserDAO           │                   │
│                   │ • ProductDAO        │                   │
│                   │ • OrderDAO          │                   │
│                   │ • CartDAO           │                   │
│                   └─────────────────────┘                   │
└─────────────────────┬───────────────────────────────────────┘
                      │ JDBC Connection
                      ▼
┌─────────────────────────────────────────────────────────────┐
│                    DATABASE (SQLite)                       │
│                                                             │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌────────┐│
│  │   users     │ │  products   │ │   orders    │ │  logs  ││
│  │   table     │ │   table     │ │   table     │ │ table  ││
│  └─────────────┘ └─────────────┘ └─────────────┘ └────────┘│
└─────────────────────────────────────────────────────────────┘
```

### Directory Structure
```
IoTBay/
├── src/main/
│   ├── java/
│   │   ├── controller/              # Servlet Controllers
│   │   │   ├── LoginController.java
│   │   │   ├── RegisterController.java
│   │   │   ├── BrowseProductController.java
│   │   │   ├── CartController.java
│   │   │   ├── CheckoutController.java
│   │   │   ├── UserProfileController.java
│   │   │   └── admin/
│   │   │       ├── ManageUserController.java
│   │   │       ├── ManageProductController.java
│   │   │       └── ManageAccessLogController.java
│   │   ├── model/                   # Domain Models
│   │   │   ├── User.java
│   │   │   ├── Product.java
│   │   │   ├── Order.java
│   │   │   ├── CartItem.java
│   │   │   └── AccessLog.java
│   │   ├── dao/                     # Data Access Objects
│   │   │   ├── UserDAO.java
│   │   │   ├── ProductDAO.java
│   │   │   ├── OrderDAO.java
│   │   │   └── AccessLogDAO.java
│   │   ├── service/                 # Business Logic
│   │   │   ├── UserService.java
│   │   │   ├── ProductService.java
│   │   │   ├── CartService.java
│   │   │   └── OrderService.java
│   │   ├── util/                    # Utility Classes
│   │   │   ├── PasswordUtil.java
│   │   │   ├── TokenUtil.java
│   │   │   ├── DBConnection.java
│   │   │   └── ValidationUtil.java
│   │   └── config/                  # Configuration
│   │       └── AppConfig.java
│   ├── webapp/
│   │   ├── WEB-INF/
│   │   │   ├── web.xml             # Servlet Configuration
│   │   │   └── views/              # Admin JSP Views
│   │   │       ├── manage-users.jsp
│   │   │       ├── manage-products.jsp
│   │   │       └── manage-access-logs.jsp
│   │   ├── components/             # Reusable JSP Components
│   │   │   ├── header.jsp
│   │   │   ├── footer.jsp
│   │   │   ├── navigation.jsp
│   │   │   └── product-card.jsp
│   │   ├── css/                    # Stylesheets
│   │   │   ├── styles.css          # Main stylesheet
│   │   │   ├── themes/             # Theme system
│   │   │   │   ├── variables.css   # CSS custom properties
│   │   │   │   ├── components.css  # Component styles
│   │   │   │   └── utilities.css   # Utility classes
│   │   │   └── pages/              # Page-specific styles
│   │   │       ├── login.css
│   │   │       ├── browse.css
│   │   │       └── cart.css
│   │   ├── js/                     # JavaScript Files
│   │   │   ├── main.js
│   │   │   ├── search.js
│   │   │   └── cart.js
│   │   ├── images/                 # Static Images
│   │   │   ├── logo.png
│   │   │   ├── hero.png
│   │   │   └── products/
│   │   └── *.jsp                   # Main JSP Pages
│   │       ├── index.jsp           # Homepage
│   │       ├── login.jsp           # Login page
│   │       ├── register.jsp        # Registration page
│   │       ├── browse.jsp          # Product browsing
│   │       ├── productDetails.jsp  # Product details
│   │       ├── cart.jsp           # Shopping cart
│   │       ├── checkout.jsp       # Checkout process
│   │       ├── orderList.jsp      # Order history
│   │       ├── Profiles.jsp       # User profile
│   │       └── error.jsp          # Error handling
│   └── resources/
│       ├── sql/                    # Database Scripts
│       │   ├── schema.sql
│       │   ├── create_user.sql
│       │   └── sample_data.sql
│       └── application.properties  # App Configuration
└── pom.xml                        # Maven Configuration
```

## 🗄️ Database Design

### Entity Relationship Diagram
```
┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐
│      USERS      │       │    PRODUCTS     │       │     ORDERS      │
├─────────────────┤       ├─────────────────┤       ├─────────────────┤
│ id (PK)         │   ┌───│ id (PK)         │   ┌───│ id (PK)         │
│ email           │   │   │ category_id     │   │   │ user_id (FK)    │
│ password_hash   │   │   │ name            │   │   │ order_date      │
│ first_name      │   │   │ description     │   │   │ status          │
│ last_name       │   │   │ price           │   │   │ total_amount    │
│ phone           │   │   │ stock_quantity  │   │   └─────────────────┘
│ postal_code     │   │   │ image_url       │   │            │
│ address_line1   │   │   │ created_at      │   │            │
│ address_line2   │   │   └─────────────────┘   │            │
│ date_of_birth   │   │            │            │            │
│ role            │   │            │            │            │
│ is_active       │   │            │            │            │
│ created_at      │   │            │            │            │
└─────────────────┘   │            │            │            │
         │             │            │            │            │
         │             │            │            │            │
         │             │            │            │            │
┌─────────────────┐   │   ┌─────────────────┐   │   ┌─────────────────┐
│   CART_ITEMS    │   │   │  ORDER_ITEMS    │   │   │   ACCESS_LOGS   │
├─────────────────┤   │   ├─────────────────┤   │   ├─────────────────┤
│ id (PK)         │   │   │ id (PK)         │   │   │ id (PK)         │
│ user_id (FK)    │───┘   │ order_id (FK)   │───┘   │ user_id (FK)    │
│ product_id (FK) │───────│ product_id (FK) │───────│ action          │
│ quantity        │       │ quantity        │       │ timestamp       │
│ created_at      │       │ price_at_time   │       │ ip_address      │
└─────────────────┘       └─────────────────┘       │ user_agent      │
                                                    │ session_id      │
                                                    └─────────────────┘
```

### Core Tables

#### Users Table
```sql
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    postal_code VARCHAR(10),
    address_line1 VARCHAR(255),
    address_line2 VARCHAR(255),
    date_of_birth DATE,
    role VARCHAR(20) DEFAULT 'customer',
    is_active BOOLEAN DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### Products Table
```sql
CREATE TABLE products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    category_id INTEGER,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INTEGER DEFAULT 0,
    image_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### Orders Table
```sql
CREATE TABLE orders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'pending',
    total_amount DECIMAL(10,2),
    FOREIGN KEY (user_id) REFERENCES users(id)
);
```

## 🎨 JSP Frontend Architecture

### Page Structure
All JSP pages follow a consistent structure:

```jsp
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.*" %>

<%
    // Page-specific Java logic and data preparation
    Object pageData = request.getAttribute("data");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/styles.css">
    <title>IoT Bay - Page Title</title>
</head>
<body>
    <!-- Include common header -->
    <jsp:include page="components/header.jsp" />
    
    <!-- Page-specific content -->
    <main class="main-content">
        <!-- Content goes here -->
    </main>
    
    <!-- Include common footer -->
    <jsp:include page="components/footer.jsp" />
    
    <!-- Page-specific scripts -->
    <script src="<%=request.getContextPath()%>/js/page-script.js"></script>
</body>
</html>
```

### Component Architecture

#### Header Component (`components/header.jsp`)
```jsp
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="model.User" %>

<% 
    User user = (User) session.getAttribute("user");
    boolean isLoggedIn = user != null;
    boolean isAdmin = isLoggedIn && "admin".equalsIgnoreCase(user.getRole());
%>

<header class="header">
    <div class="header__container">
        <!-- Logo -->
        <div class="header__logo">
            <a href="<%=request.getContextPath()%>/index.jsp">
                <img src="<%=request.getContextPath()%>/images/logo.png" alt="IoT Bay" />
            </a>
        </div>
        
        <!-- Search -->
        <div class="header__search">
            <form action="<%=request.getContextPath()%>/browse" method="get">
                <input type="text" name="keyword" placeholder="Search products..." />
                <button type="submit">Search</button>
            </form>
        </div>
        
        <!-- Navigation -->
        <nav class="header__nav">
            <% if (!isLoggedIn) { %>
                <a href="<%=request.getContextPath()%>/login.jsp" class="btn btn--primary">Login</a>
                <a href="<%=request.getContextPath()%>/register.jsp" class="btn btn--secondary">Register</a>
            <% } else { %>
                <a href="<%=request.getContextPath()%>/cart" class="btn btn--cart">Cart</a>
                <a href="<%=request.getContextPath()%>/Profiles.jsp" class="btn btn--profile">
                    <%= user.getFirstName() %>
                </a>
                <% if (isAdmin) { %>
                    <a href="<%=request.getContextPath()%>/admin" class="btn btn--admin">Admin</a>
                <% } %>
                <a href="<%=request.getContextPath()%>/logout" class="btn btn--logout">Logout</a>
            <% } %>
        </nav>
    </div>
</header>
```

#### Product Card Component (`components/product-card.jsp`)
```jsp
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="model.Product" %>

<%
    Product product = (Product) request.getAttribute("product");
%>

<div class="product-card">
    <div class="product-card__image">
        <img src="<%= product.getImageUrl() %>" 
             alt="<%= product.getName() %>" 
             onerror="this.src='<%=request.getContextPath()%>/images/placeholder.jpg'" />
    </div>
    <div class="product-card__content">
        <h3 class="product-card__title"><%= product.getName() %></h3>
        <p class="product-card__description"><%= product.getDescription() %></p>
        <div class="product-card__footer">
            <span class="product-card__price">$<%= product.getPrice() %></span>
            <div class="product-card__actions">
                <a href="<%=request.getContextPath()%>/product?id=<%= product.getId() %>" 
                   class="btn btn--primary btn--sm">View Details</a>
                <form action="<%=request.getContextPath()%>/cart" method="post" class="product-card__cart-form">
                    <input type="hidden" name="action" value="add" />
                    <input type="hidden" name="productId" value="<%= product.getId() %>" />
                    <input type="hidden" name="quantity" value="1" />
                    <button type="submit" class="btn btn--secondary btn--sm">Add to Cart</button>
                </form>
            </div>
        </div>
    </div>
</div>
```

### Key JSP Pages

#### Browse Products (`browse.jsp`)
```jsp
<%@ page import="java.util.List, model.Product" %>
<%
    List<Product> products = (List<Product>) request.getAttribute("results");
    String keyword = (String) request.getAttribute("keyword");
%>

<main class="browse-page">
    <div class="container">
        <h1 class="page-title">
            <% if (keyword != null && !keyword.trim().isEmpty()) { %>
                Search results for "<%= keyword %>"
            <% } else { %>
                All Products
            <% } %>
        </h1>
        
        <div class="products-grid">
            <%
                if (products != null && !products.isEmpty()) {
                    for (Product product : products) {
                        request.setAttribute("product", product);
            %>
                        <jsp:include page="components/product-card.jsp" />
            <%
                    }
                } else {
            %>
                    <div class="no-results">
                        <p>No products found.</p>
                        <a href="<%=request.getContextPath()%>/browse" class="btn btn--primary">View All Products</a>
                    </div>
            <%
                }
            %>
        </div>
    </div>
</main>
```

#### Shopping Cart (`cart.jsp`)
```jsp
<%@ page import="java.util.*, model.*" %>
<%
    List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
    double totalAmount = 0.0;
    if (cartItems != null) {
        for (CartItem item : cartItems) {
            totalAmount += item.getProduct().getPrice() * item.getQuantity();
        }
    }
%>

<main class="cart-page">
    <div class="container">
        <h1 class="page-title">Shopping Cart</h1>
        
        <% if (cartItems == null || cartItems.isEmpty()) { %>
            <div class="empty-cart">
                <p>Your cart is empty</p>
                <a href="<%=request.getContextPath()%>/browse" class="btn btn--primary">Continue Shopping</a>
            </div>
        <% } else { %>
            <div class="cart-content">
                <div class="cart-items">
                    <% for (CartItem item : cartItems) { %>
                        <div class="cart-item">
                            <div class="cart-item__image">
                                <img src="<%= item.getProduct().getImageUrl() %>" 
                                     alt="<%= item.getProduct().getName() %>" />
                            </div>
                            <div class="cart-item__details">
                                <h3><%= item.getProduct().getName() %></h3>
                                <p class="price">$<%= item.getProduct().getPrice() %></p>
                            </div>
                            <div class="cart-item__quantity">
                                <form action="<%=request.getContextPath()%>/cart" method="post" class="quantity-form">
                                    <input type="hidden" name="action" value="update" />
                                    <input type="hidden" name="itemId" value="<%= item.getId() %>" />
                                    <input type="number" name="quantity" value="<%= item.getQuantity() %>" 
                                           min="1" onchange="this.form.submit()" />
                                </form>
                            </div>
                            <div class="cart-item__total">
                                $<%= String.format("%.2f", item.getProduct().getPrice() * item.getQuantity()) %>
                            </div>
                            <div class="cart-item__actions">
                                <form action="<%=request.getContextPath()%>/cart" method="post">
                                    <input type="hidden" name="action" value="remove" />
                                    <input type="hidden" name="itemId" value="<%= item.getId() %>" />
                                    <button type="submit" class="btn btn--danger btn--sm">Remove</button>
                                </form>
                            </div>
                        </div>
                    <% } %>
                </div>
                
                <div class="cart-summary">
                    <div class="summary-row">
                        <span>Total: $<%= String.format("%.2f", totalAmount) %></span>
                    </div>
                    <div class="cart-actions">
                        <a href="<%=request.getContextPath()%>/browse" class="btn btn--secondary">Continue Shopping</a>
                        <a href="<%=request.getContextPath()%>/checkout" class="btn btn--primary">Proceed to Checkout</a>
                    </div>
                </div>
            </div>
        <% } %>
    </div>
</main>
```

## 🎨 Design System & Theming

### **UPDATED** Modern CSS Architecture
The design system is built on CSS Custom Properties and component-based architecture for maximum maintainability and theming flexibility:

```
css/
├── modern-theme.css        # Complete modern design system
├── styles.css             # Legacy styles (being phased out)
└── js/
    └── main.js            # Interactive components and theming
```

### **NEW** Design Tokens System
```css
:root {
  /* Modern Color Palette */
  --color-primary: #3b82f6;           /* Modern blue */
  --color-primary-dark: #1d4ed8;
  --color-primary-light: #93c5fd;
  --color-primary-50: #eff6ff;
  
  --color-secondary: #6b7280;         /* Neutral gray */
  --color-accent: #10b981;            /* Modern green */
  --color-warning: #f59e0b;           /* Amber */
  --color-error: #ef4444;             /* Modern red */
  --color-success: #10b981;           /* Emerald */
  
  /* Surface Colors */
  --color-bg-primary: #ffffff;
  --color-bg-secondary: #f9fafb;
  --color-bg-tertiary: #f3f4f6;
  --color-surface: #ffffff;
  --color-surface-hover: #f9fafb;
  
  /* Text Colors */
  --color-text-primary: #111827;
  --color-text-secondary: #6b7280;
  --color-text-tertiary: #9ca3af;
  --color-text-inverse: #ffffff;
  
  /* Border Colors */
  --color-border: #e5e7eb;
  --color-border-focus: #3b82f6;
  --color-border-error: #ef4444;
}

/* Dark Theme Support */
[data-theme="dark"] {
  --color-bg-primary: #1f2937;
  --color-bg-secondary: #111827;
  --color-bg-tertiary: #0f172a;
  --color-text-primary: #f9fafb;
  --color-text-secondary: #d1d5db;
  --color-border: #374151;
}
```

### **NEW** Component System
Modern, reusable components with systematic naming:

#### Button Components
```css
.btn {
  /* Base button styles */
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: var(--spacing-3) var(--spacing-6);
  border-radius: var(--radius-md);
  font-weight: 500;
  transition: all 0.2s ease;
}

.btn--primary { /* Primary blue button */ }
.btn--secondary { /* Secondary gray button */ }
.btn--outline { /* Outlined button */ }
.btn--ghost { /* Ghost button */ }
.btn--sm { /* Small size */ }
.btn--lg { /* Large size */ }
```

#### Form Components
```css
.form__group {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-2);
}

.form__input {
  padding: var(--spacing-3);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
  font-size: var(--font-size-base);
  transition: all 0.2s ease;
}

.form__input:focus {
  outline: none;
  border-color: var(--color-border-focus);
  box-shadow: 0 0 0 3px var(--color-primary-50);
}
```

#### Card Components
```css
.card {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-lg);
  padding: var(--spacing-6);
  box-shadow: var(--shadow-sm);
}

.product-card {
  /* Enhanced product card with hover effects */
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.product-card:hover {
  transform: translateY(-2px);
  box-shadow: var(--shadow-md);
}
```

### **NEW** Typography System
```css
:root {
  /* Font Families */
  --font-family-primary: 'Inter', system-ui, -apple-system, sans-serif;
  --font-family-mono: 'JetBrains Mono', 'Fira Code', monospace;
  
  /* Font Sizes (Type Scale) */
  --font-size-xs: 0.75rem;    /* 12px */
  --font-size-sm: 0.875rem;   /* 14px */
  --font-size-base: 1rem;     /* 16px */
  --font-size-lg: 1.125rem;   /* 18px */
  --font-size-xl: 1.25rem;    /* 20px */
  --font-size-2xl: 1.5rem;    /* 24px */
  --font-size-3xl: 1.875rem;  /* 30px */
  --font-size-4xl: 2.25rem;   /* 36px */
  
  /* Font Weights */
  --font-weight-normal: 400;
  --font-weight-medium: 500;
  --font-weight-semibold: 600;
  --font-weight-bold: 700;
  
  /* Line Heights */
  --line-height-tight: 1.25;
  --line-height-normal: 1.5;
  --line-height-relaxed: 1.75;
}
```

### **NEW** Spacing System
```css
:root {
  /* Consistent 4px spacing scale */
  --spacing-0: 0;
  --spacing-1: 0.25rem;  /* 4px */
  --spacing-2: 0.5rem;   /* 8px */
  --spacing-3: 0.75rem;  /* 12px */
  --spacing-4: 1rem;     /* 16px */
  --spacing-5: 1.25rem;  /* 20px */
  --spacing-6: 1.5rem;   /* 24px */
  --spacing-8: 2rem;     /* 32px */
  --spacing-10: 2.5rem;  /* 40px */
  --spacing-12: 3rem;    /* 48px */
  --spacing-16: 4rem;    /* 64px */
  --spacing-20: 5rem;    /* 80px */
}
```

### **NEW** Responsive Grid System
```css
.container {
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 var(--spacing-4);
}

.grid {
  display: grid;
  gap: var(--spacing-6);
}

.grid--2 { grid-template-columns: repeat(2, 1fr); }
.grid--3 { grid-template-columns: repeat(3, 1fr); }
.grid--4 { grid-template-columns: repeat(4, 1fr); }

/* Responsive breakpoints */
@media (max-width: 768px) {
  .grid--2,
  .grid--3,
  .grid--4 {
    grid-template-columns: 1fr;
  }
}
```

### **NEW** Component Usage in JSP
```jsp
<!-- Modern button usage -->
<button class="btn btn--primary btn--lg">
  Add to Cart
</button>

<!-- Modern form -->
<div class="form__group">
  <label for="email" class="form__label">Email Address</label>
  <input type="email" id="email" class="form__input" 
         placeholder="Enter your email" />
</div>

<!-- Modern card -->
<div class="product-card">
  <img class="product-card__image" src="..." alt="..." />
  <div class="product-card__body">
    <h3 class="product-card__title">Product Name</h3>
    <p class="product-card__description">Description...</p>
    <div class="product-card__price">$99.00</div>
  </div>
</div>
```

### **NEW** Dark Mode Implementation
JavaScript-powered theme switching:
```javascript
// Theme toggle functionality
function toggleTheme() {
  const currentTheme = document.documentElement.getAttribute('data-theme');
  const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
  
  document.documentElement.setAttribute('data-theme', newTheme);
  localStorage.setItem('theme', newTheme);
}

// Auto-detect user preference
const prefersDark = window.matchMedia('(prefers-color-scheme: dark)');
const savedTheme = localStorage.getItem('theme');
const theme = savedTheme || (prefersDark.matches ? 'dark' : 'light');
document.documentElement.setAttribute('data-theme', theme);
```
  --color-gray-200: #dee2e6;
  --color-gray-300: #ced4da;
  --color-gray-400: #adb5bd;
  --color-gray-500: #6c757d;
  --color-gray-600: #495057;
  --color-gray-700: #343a40;
  --color-gray-800: #212529;
  --color-gray-900: #1a1a1a;
  --color-black: #000000;
  
  /* Typography */
  --font-family-primary: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  --font-family-mono: 'Monaco', 'Menlo', 'Ubuntu Mono', monospace;
  
  --font-size-xs: 0.75rem;    /* 12px */
  --font-size-sm: 0.875rem;   /* 14px */
  --font-size-base: 1rem;     /* 16px */
  --font-size-lg: 1.125rem;   /* 18px */
  --font-size-xl: 1.25rem;    /* 20px */
  --font-size-2xl: 1.5rem;    /* 24px */
  --font-size-3xl: 1.875rem;  /* 30px */
  --font-size-4xl: 2.25rem;   /* 36px */
  
  --font-weight-light: 300;
  --font-weight-normal: 400;
  --font-weight-medium: 500;
  --font-weight-semibold: 600;
  --font-weight-bold: 700;
  
  --line-height-tight: 1.25;
  --line-height-normal: 1.5;
  --line-height-relaxed: 1.75;
  
  /* Spacing */
  --spacing-1: 0.25rem;   /* 4px */
  --spacing-2: 0.5rem;    /* 8px */
  --spacing-3: 0.75rem;   /* 12px */
  --spacing-4: 1rem;      /* 16px */
  --spacing-5: 1.25rem;   /* 20px */
  --spacing-6: 1.5rem;    /* 24px */
  --spacing-8: 2rem;      /* 32px */
  --spacing-10: 2.5rem;   /* 40px */
  --spacing-12: 3rem;     /* 48px */
  --spacing-16: 4rem;     /* 64px */
  --spacing-20: 5rem;     /* 80px */
  
  /* Border Radius */
  --radius-sm: 0.25rem;   /* 4px */
  --radius-base: 0.375rem; /* 6px */
  --radius-md: 0.5rem;    /* 8px */
  --radius-lg: 0.75rem;   /* 12px */
  --radius-xl: 1rem;      /* 16px */
  --radius-full: 9999px;
  
  /* Shadows */
  --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
  --shadow-base: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
  --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
  --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
  --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
  
  /* Transitions */
  --transition-fast: 0.15s ease-in-out;
  --transition-normal: 0.3s ease-in-out;
  --transition-slow: 0.5s ease-in-out;
  
  /* Breakpoints */
  --breakpoint-sm: 640px;
  --breakpoint-md: 768px;
  --breakpoint-lg: 1024px;
  --breakpoint-xl: 1280px;
  --breakpoint-2xl: 1536px;
  
  /* Layout */
  --container-max-width: 1240px;
  --container-padding: var(--spacing-5);
  
  /* Z-index */
  --z-dropdown: 1000;
  --z-sticky: 1020;
  --z-fixed: 1030;
  --z-modal-backdrop: 1040;
  --z-modal: 1050;
  --z-popover: 1060;
  --z-tooltip: 1070;
}
```

### Base Styles (`themes/base.css`)
```css
/* Modern CSS Reset */
*,
*::before,
*::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

html {
  font-size: 16px;
  scroll-behavior: smooth;
}

body {
  font-family: var(--font-family-primary);
  font-size: var(--font-size-base);
  line-height: var(--line-height-normal);
  color: var(--color-gray-800);
  background-color: var(--color-white);
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

/* Typography */
h1, h2, h3, h4, h5, h6 {
  font-weight: var(--font-weight-semibold);
  line-height: var(--line-height-tight);
  margin-bottom: var(--spacing-4);
}

h1 { font-size: var(--font-size-4xl); }
h2 { font-size: var(--font-size-3xl); }
h3 { font-size: var(--font-size-2xl); }
h4 { font-size: var(--font-size-xl); }
h5 { font-size: var(--font-size-lg); }
h6 { font-size: var(--font-size-base); }

p {
  margin-bottom: var(--spacing-4);
}

a {
  color: var(--color-primary);
  text-decoration: none;
  transition: color var(--transition-fast);
}

a:hover {
  color: var(--color-primary-dark);
}

/* Lists */
ul, ol {
  list-style: none;
}

/* Images */
img {
  max-width: 100%;
  height: auto;
  display: block;
}

/* Form Elements */
input,
textarea,
select,
button {
  font-family: inherit;
  font-size: inherit;
}

button {
  cursor: pointer;
  border: none;
  background: none;
}

/* Layout */
.container {
  max-width: var(--container-max-width);
  margin: 0 auto;
  padding: 0 var(--container-padding);
}

.visually-hidden {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border: 0;
}
```

### Component Styles (`themes/components.css`)
```css
/* Button Component */
.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: var(--spacing-3) var(--spacing-6);
  font-size: var(--font-size-base);
  font-weight: var(--font-weight-medium);
  line-height: 1;
  border: 2px solid transparent;
  border-radius: var(--radius-md);
  text-decoration: none;
  transition: all var(--transition-fast);
  cursor: pointer;
  min-height: 44px; /* Touch target size */
}

.btn:focus {
  outline: 2px solid var(--color-primary);
  outline-offset: 2px;
}

.btn--primary {
  background-color: var(--color-primary);
  color: var(--color-white);
  border-color: var(--color-primary);
}

.btn--primary:hover {
  background-color: var(--color-primary-dark);
  border-color: var(--color-primary-dark);
  color: var(--color-white);
}

.btn--secondary {
  background-color: transparent;
  color: var(--color-primary);
  border-color: var(--color-primary);
}

.btn--secondary:hover {
  background-color: var(--color-primary);
  color: var(--color-white);
}

.btn--danger {
  background-color: var(--color-error);
  color: var(--color-white);
  border-color: var(--color-error);
}

.btn--danger:hover {
  background-color: #c82333;
  border-color: #bd2130;
  color: var(--color-white);
}

.btn--sm {
  padding: var(--spacing-2) var(--spacing-4);
  font-size: var(--font-size-sm);
  min-height: 36px;
}

.btn--lg {
  padding: var(--spacing-4) var(--spacing-8);
  font-size: var(--font-size-lg);
  min-height: 52px;
}

/* Form Component */
.form-group {
  margin-bottom: var(--spacing-5);
}

.form-label {
  display: block;
  font-weight: var(--font-weight-medium);
  margin-bottom: var(--spacing-2);
  color: var(--color-gray-700);
}

.form-input {
  width: 100%;
  padding: var(--spacing-3) var(--spacing-4);
  font-size: var(--font-size-base);
  border: 2px solid var(--color-gray-300);
  border-radius: var(--radius-md);
  transition: border-color var(--transition-fast);
}

.form-input:focus {
  outline: none;
  border-color: var(--color-primary);
  box-shadow: 0 0 0 3px rgba(0, 119, 182, 0.1);
}

.form-input--error {
  border-color: var(--color-error);
}

.form-error {
  color: var(--color-error);
  font-size: var(--font-size-sm);
  margin-top: var(--spacing-1);
}

/* Card Component */
.card {
  background: var(--color-white);
  border: 1px solid var(--color-gray-200);
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow-sm);
  overflow: hidden;
  transition: box-shadow var(--transition-fast);
}

.card:hover {
  box-shadow: var(--shadow-md);
}

.card__header {
  padding: var(--spacing-6);
  border-bottom: 1px solid var(--color-gray-200);
}

.card__body {
  padding: var(--spacing-6);
}

.card__footer {
  padding: var(--spacing-6);
  border-top: 1px solid var(--color-gray-200);
  background-color: var(--color-gray-50);
}

/* Product Card Component */
.product-card {
  background: var(--color-white);
  border: 1px solid var(--color-gray-200);
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow-sm);
  overflow: hidden;
  transition: all var(--transition-fast);
  height: 100%;
  display: flex;
  flex-direction: column;
}

.product-card:hover {
  box-shadow: var(--shadow-lg);
  transform: translateY(-2px);
}

.product-card__image {
  position: relative;
  padding-bottom: 60%; /* 16:9 aspect ratio */
  overflow: hidden;
}

.product-card__image img {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform var(--transition-normal);
}

.product-card:hover .product-card__image img {
  transform: scale(1.05);
}

.product-card__content {
  padding: var(--spacing-5);
  flex-grow: 1;
  display: flex;
  flex-direction: column;
}

.product-card__title {
  font-size: var(--font-size-lg);
  font-weight: var(--font-weight-semibold);
  margin-bottom: var(--spacing-2);
  color: var(--color-gray-800);
}

.product-card__description {
  color: var(--color-gray-600);
  font-size: var(--font-size-sm);
  line-height: var(--line-height-relaxed);
  margin-bottom: var(--spacing-4);
  flex-grow: 1;
}

.product-card__footer {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-top: auto;
}

.product-card__price {
  font-size: var(--font-size-xl);
  font-weight: var(--font-weight-bold);
  color: var(--color-primary);
}

.product-card__actions {
  display: flex;
  gap: var(--spacing-2);
}

/* Header Component */
.header {
  background: var(--color-white);
  border-bottom: 1px solid var(--color-gray-200);
  box-shadow: var(--shadow-sm);
  position: sticky;
  top: 0;
  z-index: var(--z-sticky);
}

.header__container {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: var(--spacing-4) 0;
  gap: var(--spacing-8);
}

.header__logo img {
  height: 40px;
  width: auto;
}

.header__search {
  flex: 1;
  max-width: 500px;
}

.header__search form {
  display: flex;
  position: relative;
}

.header__search input {
  flex: 1;
  padding: var(--spacing-3) var(--spacing-4);
  border: 2px solid var(--color-gray-300);
  border-radius: var(--radius-md) 0 0 var(--radius-md);
  font-size: var(--font-size-base);
}

.header__search button {
  padding: var(--spacing-3) var(--spacing-6);
  background: var(--color-primary);
  color: var(--color-white);
  border: 2px solid var(--color-primary);
  border-radius: 0 var(--radius-md) var(--radius-md) 0;
  font-weight: var(--font-weight-medium);
  transition: background-color var(--transition-fast);
}

.header__search button:hover {
  background: var(--color-primary-dark);
}

.header__nav {
  display: flex;
  align-items: center;
  gap: var(--spacing-4);
}

/* Navigation Component */
.nav__container {
  background: var(--color-gray-50);
  border-bottom: 1px solid var(--color-gray-200);
}

.nav__list {
  display: flex;
  align-items: center;
  gap: var(--spacing-8);
  padding: var(--spacing-4) 0;
}

.nav__item {
  position: relative;
}

.nav__link {
  font-size: var(--font-size-lg);
  font-weight: var(--font-weight-medium);
  color: var(--color-gray-700);
  padding: var(--spacing-2) 0;
  border-bottom: 2px solid transparent;
  transition: all var(--transition-fast);
}

.nav__link:hover,
.nav__link--active {
  color: var(--color-primary);
  border-bottom-color: var(--color-primary);
}

/* Footer Component */
.footer {
  background: var(--color-gray-800);
  color: var(--color-gray-300);
  padding: var(--spacing-12) 0 var(--spacing-8);
  margin-top: auto;
}

.footer__content {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: var(--spacing-8);
  margin-bottom: var(--spacing-8);
}

.footer__section h3 {
  color: var(--color-white);
  margin-bottom: var(--spacing-4);
}

.footer__section ul {
  list-style: none;
}

.footer__section li {
  margin-bottom: var(--spacing-2);
}

.footer__section a {
  color: var(--color-gray-300);
  transition: color var(--transition-fast);
}

.footer__section a:hover {
  color: var(--color-white);
}

.footer__bottom {
  border-top: 1px solid var(--color-gray-700);
  padding-top: var(--spacing-6);
  text-align: center;
  color: var(--color-gray-400);
}
```

### Utility Classes (`themes/utilities.css`)
```css
/* Display */
.block { display: block; }
.inline-block { display: inline-block; }
.inline { display: inline; }
.flex { display: flex; }
.inline-flex { display: inline-flex; }
.grid { display: grid; }
.hidden { display: none; }

/* Flexbox */
.flex-row { flex-direction: row; }
.flex-col { flex-direction: column; }
.flex-wrap { flex-wrap: wrap; }
.flex-nowrap { flex-wrap: nowrap; }

.items-start { align-items: flex-start; }
.items-end { align-items: flex-end; }
.items-center { align-items: center; }
.items-stretch { align-items: stretch; }

.justify-start { justify-content: flex-start; }
.justify-end { justify-content: flex-end; }
.justify-center { justify-content: center; }
.justify-between { justify-content: space-between; }
.justify-around { justify-content: space-around; }

.flex-1 { flex: 1; }
.flex-auto { flex: auto; }
.flex-none { flex: none; }

/* Grid */
.grid-cols-1 { grid-template-columns: repeat(1, 1fr); }
.grid-cols-2 { grid-template-columns: repeat(2, 1fr); }
.grid-cols-3 { grid-template-columns: repeat(3, 1fr); }
.grid-cols-4 { grid-template-columns: repeat(4, 1fr); }
.grid-cols-6 { grid-template-columns: repeat(6, 1fr); }
.grid-cols-12 { grid-template-columns: repeat(12, 1fr); }

.gap-1 { gap: var(--spacing-1); }
.gap-2 { gap: var(--spacing-2); }
.gap-3 { gap: var(--spacing-3); }
.gap-4 { gap: var(--spacing-4); }
.gap-5 { gap: var(--spacing-5); }
.gap-6 { gap: var(--spacing-6); }
.gap-8 { gap: var(--spacing-8); }

/* Spacing */
.p-0 { padding: 0; }
.p-1 { padding: var(--spacing-1); }
.p-2 { padding: var(--spacing-2); }
.p-3 { padding: var(--spacing-3); }
.p-4 { padding: var(--spacing-4); }
.p-5 { padding: var(--spacing-5); }
.p-6 { padding: var(--spacing-6); }
.p-8 { padding: var(--spacing-8); }

.m-0 { margin: 0; }
.m-1 { margin: var(--spacing-1); }
.m-2 { margin: var(--spacing-2); }
.m-3 { margin: var(--spacing-3); }
.m-4 { margin: var(--spacing-4); }
.m-5 { margin: var(--spacing-5); }
.m-6 { margin: var(--spacing-6); }
.m-8 { margin: var(--spacing-8); }

.mx-auto { margin-left: auto; margin-right: auto; }
.my-auto { margin-top: auto; margin-bottom: auto; }

/* Text */
.text-left { text-align: left; }
.text-center { text-align: center; }
.text-right { text-align: right; }

.text-xs { font-size: var(--font-size-xs); }
.text-sm { font-size: var(--font-size-sm); }
.text-base { font-size: var(--font-size-base); }
.text-lg { font-size: var(--font-size-lg); }
.text-xl { font-size: var(--font-size-xl); }
.text-2xl { font-size: var(--font-size-2xl); }
.text-3xl { font-size: var(--font-size-3xl); }
.text-4xl { font-size: var(--font-size-4xl); }

.font-light { font-weight: var(--font-weight-light); }
.font-normal { font-weight: var(--font-weight-normal); }
.font-medium { font-weight: var(--font-weight-medium); }
.font-semibold { font-weight: var(--font-weight-semibold); }
.font-bold { font-weight: var(--font-weight-bold); }

.text-primary { color: var(--color-primary); }
.text-secondary { color: var(--color-gray-600); }
.text-success { color: var(--color-success); }
.text-warning { color: var(--color-warning); }
.text-error { color: var(--color-error); }
.text-white { color: var(--color-white); }

/* Background */
.bg-primary { background-color: var(--color-primary); }
.bg-secondary { background-color: var(--color-gray-100); }
.bg-success { background-color: var(--color-success); }
.bg-warning { background-color: var(--color-warning); }
.bg-error { background-color: var(--color-error); }
.bg-white { background-color: var(--color-white); }
.bg-gray-50 { background-color: var(--color-gray-50); }
.bg-gray-100 { background-color: var(--color-gray-100); }

/* Border */
.border { border: 1px solid var(--color-gray-200); }
.border-t { border-top: 1px solid var(--color-gray-200); }
.border-b { border-bottom: 1px solid var(--color-gray-200); }
.border-l { border-left: 1px solid var(--color-gray-200); }
.border-r { border-right: 1px solid var(--color-gray-200); }

.rounded { border-radius: var(--radius-base); }
.rounded-sm { border-radius: var(--radius-sm); }
.rounded-md { border-radius: var(--radius-md); }
.rounded-lg { border-radius: var(--radius-lg); }
.rounded-xl { border-radius: var(--radius-xl); }
.rounded-full { border-radius: var(--radius-full); }

/* Shadow */
.shadow-sm { box-shadow: var(--shadow-sm); }
.shadow { box-shadow: var(--shadow-base); }
.shadow-md { box-shadow: var(--shadow-md); }
.shadow-lg { box-shadow: var(--shadow-lg); }
.shadow-xl { box-shadow: var(--shadow-xl); }

/* Width & Height */
.w-full { width: 100%; }
.w-auto { width: auto; }
.h-full { height: 100%; }
.h-auto { height: auto; }

/* Position */
.relative { position: relative; }
.absolute { position: absolute; }
.fixed { position: fixed; }
.sticky { position: sticky; }

/* Overflow */
.overflow-hidden { overflow: hidden; }
.overflow-auto { overflow: auto; }
.overflow-scroll { overflow: scroll; }

/* Transitions */
.transition { transition: all var(--transition-normal); }
.transition-fast { transition: all var(--transition-fast); }
.transition-slow { transition: all var(--transition-slow); }
```

### Responsive Design (`themes/responsive.css`)
```css
/* Mobile First Responsive Design */

/* Small devices (landscape phones, 576px and up) */
@media (min-width: 640px) {
  .sm\:block { display: block; }
  .sm\:hidden { display: none; }
  .sm\:flex { display: flex; }
  .sm\:grid { display: grid; }
  
  .sm\:grid-cols-1 { grid-template-columns: repeat(1, 1fr); }
  .sm\:grid-cols-2 { grid-template-columns: repeat(2, 1fr); }
  .sm\:grid-cols-3 { grid-template-columns: repeat(3, 1fr); }
  
  .sm\:text-sm { font-size: var(--font-size-sm); }
  .sm\:text-base { font-size: var(--font-size-base); }
  .sm\:text-lg { font-size: var(--font-size-lg); }
  
  .sm\:p-4 { padding: var(--spacing-4); }
  .sm\:p-6 { padding: var(--spacing-6); }
  .sm\:p-8 { padding: var(--spacing-8); }
}

/* Medium devices (tablets, 768px and up) */
@media (min-width: 768px) {
  .md\:block { display: block; }
  .md\:hidden { display: none; }
  .md\:flex { display: flex; }
  .md\:grid { display: grid; }
  
  .md\:grid-cols-1 { grid-template-columns: repeat(1, 1fr); }
  .md\:grid-cols-2 { grid-template-columns: repeat(2, 1fr); }
  .md\:grid-cols-3 { grid-template-columns: repeat(3, 1fr); }
  .md\:grid-cols-4 { grid-template-columns: repeat(4, 1fr); }
  
  .md\:text-base { font-size: var(--font-size-base); }
  .md\:text-lg { font-size: var(--font-size-lg); }
  .md\:text-xl { font-size: var(--font-size-xl); }
  .md\:text-2xl { font-size: var(--font-size-2xl); }
  
  .md\:p-6 { padding: var(--spacing-6); }
  .md\:p-8 { padding: var(--spacing-8); }
  .md\:p-12 { padding: var(--spacing-12); }
}

/* Large devices (desktops, 1024px and up) */
@media (min-width: 1024px) {
  .lg\:block { display: block; }
  .lg\:hidden { display: none; }
  .lg\:flex { display: flex; }
  .lg\:grid { display: grid; }
  
  .lg\:grid-cols-2 { grid-template-columns: repeat(2, 1fr); }
  .lg\:grid-cols-3 { grid-template-columns: repeat(3, 1fr); }
  .lg\:grid-cols-4 { grid-template-columns: repeat(4, 1fr); }
  .lg\:grid-cols-6 { grid-template-columns: repeat(6, 1fr); }
  
  .lg\:text-lg { font-size: var(--font-size-lg); }
  .lg\:text-xl { font-size: var(--font-size-xl); }
  .lg\:text-2xl { font-size: var(--font-size-2xl); }
  .lg\:text-3xl { font-size: var(--font-size-3xl); }
  
  .lg\:p-8 { padding: var(--spacing-8); }
  .lg\:p-12 { padding: var(--spacing-12); }
  .lg\:p-16 { padding: var(--spacing-16); }
}

/* Extra large devices (large desktops, 1280px and up) */
@media (min-width: 1280px) {
  .xl\:grid-cols-4 { grid-template-columns: repeat(4, 1fr); }
  .xl\:grid-cols-5 { grid-template-columns: repeat(5, 1fr); }
  .xl\:grid-cols-6 { grid-template-columns: repeat(6, 1fr); }
  
  .xl\:text-xl { font-size: var(--font-size-xl); }
  .xl\:text-2xl { font-size: var(--font-size-2xl); }
  .xl\:text-3xl { font-size: var(--font-size-3xl); }
  .xl\:text-4xl { font-size: var(--font-size-4xl); }
}

/* Product Grid Responsive */
.products-grid {
  display: grid;
  gap: var(--spacing-6);
  grid-template-columns: 1fr;
}

@media (min-width: 640px) {
  .products-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (min-width: 1024px) {
  .products-grid {
    grid-template-columns: repeat(3, 1fr);
  }
}

@media (min-width: 1280px) {
  .products-grid {
    grid-template-columns: repeat(4, 1fr);
  }
}

/* Header Responsive */
@media (max-width: 767px) {
  .header__container {
    flex-direction: column;
    gap: var(--spacing-4);
  }
  
  .header__search {
    order: 2;
    max-width: 100%;
  }
  
  .header__nav {
    order: 3;
    flex-wrap: wrap;
    justify-content: center;
  }
}

/* Navigation Responsive */
@media (max-width: 767px) {
  .nav__list {
    flex-wrap: wrap;
    justify-content: center;
    gap: var(--spacing-4);
  }
}

/* Cart Responsive */
@media (max-width: 767px) {
  .cart-item {
    flex-direction: column;
    text-align: center;
  }
  
  .cart-item__actions {
    margin-top: var(--spacing-4);
  }
}
```

## 🔒 Security Implementation

### Password Security
- **Hashing**: SHA-256 with salt using `PasswordUtil.java`
- **Salt Generation**: Random salt per user
- **Password Policy**: Minimum length and complexity requirements

### Session Management
- **Session Timeout**: Configurable session expiration
- **Session Validation**: Server-side session verification
- **Secure Cookies**: HttpOnly and Secure flags

### Access Control
- **Role-based Access**: Customer, Staff, Admin roles
- **Page Protection**: Servlet filters for authentication
- **CSRF Protection**: Token-based protection for forms

### Input Validation
- **Server-side Validation**: All inputs validated on server
- **SQL Injection Prevention**: Prepared statements
- **XSS Prevention**: Output encoding in JSP pages

## 🚀 Deployment Guidelines

### Development Environment
```bash
# Clone repository
git clone https://github.com/salieri009/IoTBay.git
cd IoTBay

# Build with Maven
mvn clean compile

# Run development server
mvn jetty:run
```

### Production Deployment
1. **Build WAR file**: `mvn clean package`
2. **Deploy to Tomcat**: Copy WAR to `webapps` directory
3. **Configure Database**: Update `application.properties`
4. **SSL Configuration**: Enable HTTPS in production
5. **Logging**: Configure application logging

### Environment Configuration
```properties
# Database Configuration
db.url=jdbc:sqlite:iotbay.db
db.driver=org.sqlite.JDBC

# Security Configuration
session.timeout=1800
password.salt.length=16

# Application Configuration
app.name=IoTBay
app.version=1.0.0
```

This comprehensive documentation provides a complete overview of the JSP-based IoTBay platform with modern design principles and maintainable architecture.
