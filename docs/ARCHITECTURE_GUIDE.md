# Architecture Guide for System Designers

**Version**: 1.0.0  
**Last Updated**: December 3, 2025  
**Status**: Published  
**Audience**: Architects, Tech Leads, Senior Developers  
**Prerequisite**: [Project Overview](./1_getting-started/PROJECT_OVERVIEW.md)

---

## 🏗️ Architecture at a Glance

IoT Bay follows a **3-tier Model-View-Controller (MVC) architecture** with clear separation of concerns:

```
┌─────────────────────────────────────────┐
│         Presentation Layer              │
│  JSP Pages + HTML/CSS/JavaScript        │
│         (Atomic Design)                 │
└────────────────┬────────────────────────┘
                 │
┌─────────────────┴────────────────────────┐
│       Controller Layer (Servlets)        │
│  @WebServlet annotations                 │
│  HTTP request/response handling          │
└────────────────┬────────────────────────┘
                 │
┌─────────────────┴────────────────────────┐
│       Service Layer (Business Logic)     │
│  UserService, ProductService, etc.       │
│  Validation + business rules             │
└────────────────┬────────────────────────┘
                 │
┌─────────────────┴────────────────────────┐
│    Data Access Layer (DAO Pattern)       │
│  Interface-based design (interfaces/)    │
│  JDBC + PreparedStatements               │
└────────────────┬────────────────────────┘
                 │
┌─────────────────┴────────────────────────┐
│       Database Layer (SQLite/PostgreSQL) │
│  Relational schema with normalization    │
└─────────────────────────────────────────┘
```

---

## 🗂️ Component Overview

### 1. Presentation Layer
**Files**: `src/main/webapp/*.jsp`, `src/main/webapp/components/`, `src/main/webapp/css/`

**Responsibilities**:
- Render HTML for user interaction
- Component-based using Atomic Design (Atoms → Molecules → Organisms)
- Responsive CSS with modern design system
- Form handling + client-side validation

**Key Concepts**:
- JSP: Server-side templating
- Components: Reusable modules (`product-card.jsp`, `modal.jsp`, etc.)
- Design System: Centralized CSS (`modern-theme.css`)

[Read: Component Architecture](./2_architecture/COMPONENT_ARCHITECTURE.md)

### 2. Controller Layer (Servlets)
**Files**: `src/main/java/controller/*Controller.java`

**Responsibilities**:
- HTTP request entry points (`@WebServlet` annotations)
- Route requests to appropriate methods (`doGet`, `doPost`)
- Initialize DAOs/Services in `init()` method
- Handle errors (IllegalArgumentException, SQLException)

**Pattern**:
```java
@WebServlet("/resource/*")
public class ResourceController extends HttpServlet {
    private ResourceDAO resourceDAO;
    private ResourceService resourceService;
    
    @Override
    public void init() throws ServletException {
        // 1. Get connection
        Connection connection = DIContainer.getConnection();
        // 2. Initialize DAOs
        resourceDAO = new ResourceDAO(connection);
        // 3. Throw ServletException if fails
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) {
        // 1. Get data from request
        // 2. Call service/DAO
        // 3. Forward to JSP
    }
}
```

**Key Files**: [Backend Developer Guide](./4_development/BACKEND_GUIDE.md)

### 3. Service Layer (Business Logic)
**Files**: `src/main/java/service/*Service.java`

**Responsibilities**:
- Validation (email format, password strength, etc.)
- Business rules (e.g., "email must be unique")
- Orchestration (call multiple DAOs for complex operations)
- Error handling (throw `IllegalArgumentException` for validation, `SQLException` for DB)

**Pattern**:
```java
public class UserService {
    private final UserDAO userDAO;
    
    public User registerUser(UserRegistrationRequest request) throws SQLException {
        // 1. Validate
        if (!isValidEmail(request.getEmail())) {
            throw new IllegalArgumentException("Invalid email");
        }
        
        // 2. Check business rules
        if (userDAO.getUserByEmail(request.getEmail()) != null) {
            throw new IllegalArgumentException("Email already exists");
        }
        
        // 3. Create and return
        User user = new User(request);
        userDAO.createUser(user);
        return user;
    }
}
```

**Key Files**: [Backend Developer Guide](./4_development/BACKEND_GUIDE.md#service-layer)

### 4. Data Access Layer (DAOs)
**Files**: 
- `src/main/java/dao/interfaces/*DAO.java` (contracts)
- `src/main/java/dao/*DAOImpl.java` (implementations)

**Responsibilities**:
- Database operations (CRUD)
- SQL execution via JDBC
- Result set mapping to objects
- Resource cleanup (try-with-resources)

**Pattern**:
```java
// Interface (contract)
public interface UserDAO {
    void createUser(User user) throws SQLException;
    User getUserById(int id) throws SQLException;
    User getUserByEmail(String email) throws SQLException;
}

// Implementation (JDBC)
public class UserDAOImpl implements UserDAO {
    private final Connection connection;
    
    @Override
    public void createUser(User user) throws SQLException {
        String sql = "INSERT INTO users (email, name, password) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getName());
            stmt.setString(3, user.getPassword());
            stmt.executeUpdate();
        }
    }
}
```

**Best Practices**:
- Always use `PreparedStatement` (prevent SQL injection)
- Use try-with-resources for resource cleanup
- Throw `SQLException`, don't catch
- All methods throw `SQLException`

[Read: Backend Developer Guide](./4_development/BACKEND_GUIDE.md#dao-layer)

### 5. Database Layer
**Files**: `src/main/resources/iotbay.db` (SQLite, dev) or PostgreSQL (prod)

**Schema**: Normalized relational design with 12+ tables

**Key Entities**:
- Users, Addresses, Reset Questions
- Categories, Products, Reviews
- Carts, Orders, Payments
- Access Logs, Wishlist Items

[Read: Database Design](./2_architecture/DATABASE_DESIGN.md)

---

## 🔌 Integration Points

### Database Connection Management

**Pattern 1: Direct Factory** (Legacy, used in HomeController)
```java
Connection connection = DBConnection.getConnection();  // Static factory
productDAO = new ProductDAOImpl(connection);
```

**Pattern 2: Dependency Injection** (Recommended for new code)
```java
Connection connection = DIContainer.getConnection();  // DI container
cartItemDAO = new CartItemDAO(connection);
```

- `DBConnection.getConnection()` → Uses `AppConfig` (db.url, db.driver)
- `DIContainer.getConnection()` → Managed connection lifecycle
- **Prefer DIContainer** for testability and potential connection pooling

### Request-Response Flow

```
1. User Request (Browser)
   ↓
2. Servlet Router (@WebServlet path)
   ↓
3. Controller.init() ← Initialize DAOs (once per servlet lifecycle)
   ↓
4. Controller.doGet/doPost() ← Handle request
   ├─→ Extract parameters (request.getParameter)
   ├─→ Call Service (validation + business logic)
   ├─→ Call DAO (database operation)
   ├─→ Handle errors (catch IllegalArgumentException or SQLException)
   ├─→ Prepare response (request.setAttribute, response.sendRedirect)
   └─→ Forward to JSP (request.getRequestDispatcher)
   ↓
5. JSP Rendering (server-side template)
   ↓
6. HTML Response (Browser)
```

### Error Handling Flow

```
Controller (Entry point)
├─ Catch IllegalArgumentException
│  └─→ Validation error → Show form with error message
│
├─ Catch SQLException
│  └─→ Database error → Log error, show generic message
│
└─ Throw ServletException (if DAO initialization fails in init())
   └─→ Container error → 500 Internal Server Error
```

[Read: Backend Developer Guide - Error Handling](./4_development/BACKEND_GUIDE.md#error-handling)

---

## 🔒 Security Architecture

### Authentication & Authorization
- Session-based authentication (`HttpSession`)
- Password hashing (SHA-256 with salt)
- Role-based access control (admin vs. user)

### Input Validation
- Server-side validation (critical)
- `ValidationUtil` class for email, passwords, etc.
- `PasswordUtil` for hashing

### SQL Injection Prevention
- `PreparedStatement` (parameterized queries)
- Never concatenate SQL strings

### CSRF Protection
- Token-based CSRF checks
- Same-origin validation

[Read: Security Architecture](./2_architecture/SECURITY_ARCHITECTURE.md)

---

## 📊 API Architecture

### Endpoint Structure
- RESTful conventions (GET, POST, PUT, DELETE)
- URL versioning (`/api/v1/...`)
- JSON responses (via GSON)

### API Layer
- Service layer provides business logic
- Controllers translate requests to service calls
- Response formatting via GSON

### Example
```
GET /products?categoryId=1
    ↓ ProductController.doGet()
    ├→ Extract categoryId
    ├→ ProductService.getProductsByCategory(categoryId)
    ├→ ProductDAO.getProductsByCategory(1)
    ├→ Return list of Products
    ├→ Format as JSON (GSON)
    └→ Response 200 OK
```

[Read: API Design & API Reference](./2_architecture/API_DESIGN.md)

---

## 🗄️ Data Model & Relationships

### Key Entities & Relationships

```
User (1) ──── (M) Address
User (1) ──── (M) Order
User (1) ──── (M) Review
User (1) ──── (M) Wishlist

Category (1) ──── (M) Product
Product (1) ──── (M) Review
Product (1) ──── (M) CartItem
Product (1) ──── (M) OrderProduct

Order (1) ──── (1) Payment
Order (1) ──── (M) OrderProduct
OrderProduct (M) ──── (1) Product

CartItem (M) ──── (1) Product
```

### Sample Query Patterns
```sql
-- Get user's orders with product details
SELECT o.*, op.*, p.* 
FROM orders o
JOIN order_products op ON o.id = op.order_id
JOIN products p ON op.product_id = p.id
WHERE o.user_id = ?

-- Get products in category with average rating
SELECT p.*, AVG(r.rating) as avg_rating
FROM products p
LEFT JOIN reviews r ON p.id = r.product_id
WHERE p.category_id = ?
GROUP BY p.id
```

[Read: Database Design](./2_architecture/DATABASE_DESIGN.md)

---

## 🎨 Design System & Frontend

### Atomic Design Principles
- **Atoms**: Basic elements (buttons, inputs, labels)
- **Molecules**: Simple components (search bar, card)
- **Organisms**: Complex components (header, product grid)

### Component Organization
```
src/main/webapp/components/
├── atoms/           # Reusable basic elements
├── molecules/       # Simple combined components
├── organisms/       # Complex components
└── templates/       # Page layouts
```

### Design System
- Centralized CSS (`modern-theme.css`)
- Color palette, typography, spacing
- Responsive grid system
- WCAG 2.1 AA accessibility compliance

[Read: Component Architecture & Design System](./2_architecture/COMPONENT_ARCHITECTURE.md)

---

## 📈 Scalability Considerations

### Current Limitations
- SQLite single-file database (dev only)
- No caching layer (direct DB queries)
- Single-threaded servlet handling

### Production Readiness
- Switch to PostgreSQL for multi-user concurrency
- Implement connection pooling (HikariCP)
- Add caching layer (Redis)
- Async processing for heavy operations

### Future Enhancements (v1.1+)
- Real-time notifications (WebSockets)
- Recommendation engine (Machine Learning)
- Internationalization (i18n)

[Read: Project Roadmap](./6_planning/PROJECT_ROADMAP.md)

---

## 🧪 Testing Strategy

### Layers
- **Unit Tests**: Service layer business logic
- **Integration Tests**: DAO + Database
- **E2E Tests**: Full request-response flow

### Testing Pyramid
```
         / \
        /E2E\           Few end-to-end tests
       /-----\
      / Tests \
     /---------\
    / Integration\    Some integration tests
   /------------- \
  /   Unit Tests   \  Many unit tests
 /_________________ \
```

[Read: Test Strategy](./5_testing/TEST_STRATEGY.md)

---

## 📚 Related Documents

### Deep Dives
- [Component Architecture](./2_architecture/COMPONENT_ARCHITECTURE.md) - Frontend structure
- [Database Design](./2_architecture/DATABASE_DESIGN.md) - Schema details
- [API Design](./2_architecture/API_DESIGN.md) - API patterns
- [Security Architecture](./2_architecture/SECURITY_ARCHITECTURE.md) - Security details

### Implementation Guides
- [Backend Developer Guide](./4_development/BACKEND_GUIDE.md) - Coding patterns
- [Frontend Developer Guide](./4_development/FRONTEND_GUIDE.md) - JSP/CSS patterns
- [Code Style Guide](./4_development/CODE_STYLE.md) - Conventions

### Testing & Quality
- [Test Strategy](./5_testing/TEST_STRATEGY.md) - Testing approach
- [Error Prevention](./5_testing/ERROR_PREVENTION.md) - Prevent common errors

---

## 🎯 Key Architectural Decisions

| Decision | Rationale | Trade-off |
|----------|-----------|-----------|
| **MVC 3-tier** | Clear separation of concerns | Extra boilerplate vs. monolith |
| **DAO Pattern** | Interface-based, testable | Abstraction layer overhead |
| **Servlet-based** | University requirement, proven | Not async/reactive |
| **SQLite (dev)** | Zero setup, file-based | Single-user, not production-ready |
| **PreparedStatement** | SQL injection prevention | Slight performance cost |
| **Atomic Design** | Reusable, maintainable components | Learning curve |

---

## 🚀 Design Principles

1. **Separation of Concerns**: Each layer has one job
2. **DRY (Don't Repeat Yourself)**: Reuse components and utilities
3. **SOLID Principles**: Single responsibility, open/closed, Liskov substitution
4. **Fail Fast**: Validate early, throw exceptions
5. **Security First**: Prevent injection, validate input, handle errors
6. **Accessibility First**: WCAG 2.1 AA compliance from the start

---

## 📞 Architecture Review

Have questions? Need to discuss architectural changes?

1. **Check [Architecture Index](#-component-overview)** above
2. **Read [Component Architecture](./2_architecture/COMPONENT_ARCHITECTURE.md)** for details
3. **Review [Database Design](./2_architecture/DATABASE_DESIGN.md)** for schema
4. **Consult [Backend Guide](./4_development/BACKEND_GUIDE.md)** for implementation patterns
5. **Reach out to tech lead** for design discussions

---

**Version**: 1.0.0  
**Status**: Published  
**Maintained By**: IoT Bay Architecture Team  
**Last Updated**: December 3, 2025


---

**Document Version**: 1.0.0
