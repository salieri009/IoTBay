# Component Architecture

This document describes the component organization, design patterns, and JSP/Servlet architecture used in IoT Bay.

**Course**: 41025 Information Systems Development (ISD)  
**Assignment**: Assignment 2 - Autumn 2025  
**Institution**: University of Technology Sydney (UTS)

---

## 📋 Overview

IoTBay uses a **modular component-based architecture** for the presentation layer. The system implements reusable UI components with consistent design patterns, supporting atomic design principles (Atoms, Molecules, Organisms).

### Design Principles
- **Single Responsibility**: Each component has one clear purpose
- **Reusability**: Maximize use of common components
- **Composition**: Combine small components into complex UI
- **Consistency**: Design system ensures unified user experience
- **Accessibility**: WCAG 2.1 AA compliance
- **Performance**: Efficient rendering and DOM manipulation

---

## 🏗️ Project Structure

### Frontend Component Organization

```
src/main/webapp/
├── components/              # Reusable JSP components
│   ├── header.jsp          # Header component
│   ├── footer.jsp          # Footer component
│   ├── masthead.jsp        # Hero section
│   ├── product-card.jsp    # Product card component
│   ├── modal.jsp           # Modal component
│   ├── toast.jsp           # Toast notifications
│   └── layout/
│       └── base.tag        # Base layout tag
├── css/
│   ├── modern-theme.css    # Main design system
│   └── themes/             # Theme files
├── js/
│   ├── main.js            # Main JavaScript
│   └── components/        # Component-specific JS
└── *.jsp                  # Page files
```

### Backend Service Organization

```
src/main/java/
├── controller/            # Request handlers (Servlet)
├── service/              # Business logic layer
├── dao/                  # Data Access Object pattern
│   ├── interfaces/       # DAO interfaces
│   ├── impl/             # DAO implementations
│   └── stub/             # Mock/test DAOs
└── model/                # Entity/data models
```

---

## 🎨 Atomic Design System

### Atoms (Basic Elements)
- Buttons
- Form inputs
- Labels
- Badges
- Icons
- Typography

### Molecules (Small Groups)
- Form field (Label + Input + Error)
- Search box (Input + Button)
- Product badge (Image + Price)
- Review card (Author + Rating + Text)

### Organisms (Complex Components)
- Header (Logo + Nav + Search)
- Product card (Image + Details + Actions)
- Product list (Grid of product cards)
- Checkout form (Multiple form fields + buttons)

### Templates (Page Layouts)
- Base layout (Header + Content + Footer)
- Product detail page
- Checkout page
- Admin dashboard

---

## 📝 JSP Component Example

```jsp
<!-- components/product-card.jsp -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Atoms: Image + Title + Price -->
<div class="product-card">
    <img src="${product.imageUrl}" alt="${product.name}" class="product-image">
    <h3 class="product-name">${product.name}</h3>
    <p class="product-price">
        <fmt:formatNumber value="${product.price}" type="currency"/>
    </p>
    
    <!-- Molecule: Rating -->
    <div class="rating">
        <span class="stars">${product.averageRating}/5</span>
        <span class="reviews">(${product.reviewCount})</span>
    </div>
    
    <!-- Atoms: Button -->
    <button class="btn btn-primary">Add to Cart</button>
</div>
```

---

## 🔄 Component Lifecycle

### 1. Request Phase
```
User Action
    ↓
Controller receives request
    ↓
Controller calls Service
    ↓
Service processes business logic
```

### 2. Data Retrieval Phase
```
Service calls DAO
    ↓
DAO queries database
    ↓
Data returned to Service
    ↓
Service returns data to Controller
```

### 3. View Rendering Phase
```
Controller forwards to JSP
    ↓
JSP renders HTML using data
    ↓
Components use data to render UI
    ↓
HTML sent to browser
```

---

## 🎯 Component Usage Guidelines

### When to Create a New Component
- Used in multiple pages
- Can be described in one sentence
- Has clear boundaries
- Receives specific data structure

### When Not to Create a Component
- Only used once
- Complex business logic
- Unclear purpose
- Too many dependencies

---

## 🔗 Component Communication

### Parent to Child
```jsp
<jsp:include page="components/product-card.jsp">
    <jsp:param name="product" value="${product}"/>
</jsp:include>
```

### Child to Parent (Events)
Components communicate via form submissions or AJAX calls:
```jsp
<form method="POST" action="${pageContext.request.contextPath}/cart/add">
    <input type="hidden" name="productId" value="${product.id}"/>
    <input type="hidden" name="quantity" value="1"/>
    <button type="submit">Add to Cart</button>
</form>
```

---

## 📱 Responsive Design

All components support responsive breakpoints:
- **Mobile**: < 576px
- **Tablet**: 576px - 992px  
- **Desktop**: > 992px

---

## ✅ Component Checklist

Before committing a new component:
- [ ] Documented purpose and usage
- [ ] Tested in all breakpoints
- [ ] Accessibility tested (WCAG 2.1 AA)
- [ ] Performance optimized
- [ ] No hardcoded values (use parameters)
- [ ] Follows code style guide
- [ ] Unit/integration tests added

---

## 🔗 Related Documentation

- [Design System](./DESIGN_SYSTEM.md)
- [Frontend Guide](../4_development/FRONTEND_GUIDE.md)
- [Code Style](../4_development/CODE_STYLE.md)

---

**Last Updated**: December 3, 2025  
**Version**: 1.0.0


---

**Document Version**: 1.0.0
**Status**: Published
**Audience**: Developers, Stakeholders
**Maintained By**: IoT Bay Documentation Team
