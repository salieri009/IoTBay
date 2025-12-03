# IoT Bay Copilot Instructions

Guide for AI coding agents working with the IoT Bay codebase.

## Architecture Overview

**Pattern**: MVC with 3-tier design (Servlet → Service → DAO → Database)

- **Controllers** (`src/main/java/controller/`): Servlet-based HTTP handlers using `@WebServlet` annotations
- **Services** (`src/main/java/service/`): Business logic layer (UserService, ProductService, CartService, OrderService)
- **DAOs** (`src/main/java/dao/`): Data access layer with interface-based design (interfaces/, impl/ subdirectories)
- **Models** (`src/main/java/model/`): JavaBeans representing database entities
- **Database**: SQLite via JDBC (`jdbc:sqlite:iotbay.db`)
- **Frontend**: JSP pages in `src/main/webapp/` + components in `src/main/webapp/components/`

**Build**: Maven with Java 8, Jetty 9.4.12 server, GSON 2.10.1 for JSON, JUnit 4.13.2 for testing.

**Key Project Info**:
- **Course**: 41025 Information Systems Development (ISD)
- **Assignment**: Assignment 2 - Autumn 2025
- **Institution**: University of Technology Sydney (UTS)

## 1. Big Picture

**What This Codebase Does**:
IoT Bay is an e-commerce web application built for UTS's 41025 Information Systems Development course (Assignment 2, Autumn 2025). It provides online shopping functionality including user authentication, product catalog browsing, shopping cart management, order processing, and administrative dashboards.

**How the Architecture Works**:
- **MVC 3-Tier Pattern**: Servlet Controllers → Services (business logic) → DAOs (data access) → SQLite Database
- **Frontend**: JSP pages with TypeScript-enhanced components in `src/main/webapp/`
- **Backend**: Java EE Servlets using `@WebServlet` annotations for HTTP handling
- **Dependency Injection**: `DIContainer` manages connections and DAO instances (preferred over legacy `DBConnection` factory)
- **Database**: Single SQLite file (`jdbc:sqlite:iotbay.db`) with JDBC connectivity

**Key Technologies**:
- Java 8, Maven build system, Jetty 9.4.12 servlet container
- SQLite JDBC 3.49.1.0, GSON 2.10.1 (JSON), JUnit 4.13.2 (testing)
- JSP for server-side rendering, TypeScript for client-side interactivity

## 2. Key Developer Workflows

### Building and Running
```bash
# Clean and compile
mvn clean install

# Run tests
mvn test

# Start development server (Jetty)
mvn jetty:run
# Access at http://localhost:8080
```

### Making Changes
1. **Adding a Feature**: Start with requirements in `docs/3_requirements/FR-XXX-*.md`
2. **Controller Changes**: Update servlet in `src/main/java/controller/`, ensure `init()` uses `DIContainer.getConnection()`
3. **Business Logic**: Add methods to `src/main/java/service/[Entity]Service.java`, validate with `ValidationUtil`
4. **Data Access**: Define method in `dao/interfaces/[Entity]DAO.java`, implement in `dao/[Entity]DAOImpl.java` using `PreparedStatement`
5. **Frontend**: Update JSP in `src/main/webapp/`, use components from `components/` directory
6. **Testing**: Write JUnit tests, run `mvn test` before committing

### Debugging Common Issues
- **500 Errors**: Check servlet `init()` methods throw `ServletException` on DB failures
- **403/404 Errors**: Verify `@WebServlet` path matches request URL, check authentication in `AuthUtil`
- **SQL Errors**: Use `PreparedStatement`, never string concatenation; check DAO try-with-resources blocks
- **Connection Issues**: Ensure `DIContainer.getConnection()` (not `DBConnection.getConnection()`) is used in all new code

## 3. Project Conventions

### Naming Conventions
- **Controllers**: `[Resource]Controller.java` (e.g., `UserController.java`, `CartController.java`)
- **Services**: `[Entity]Service.java` (e.g., `UserService.java`, `ProductService.java`)
- **DAO Interfaces**: `dao/interfaces/[Entity]DAO.java`
- **DAO Implementations**: `dao/[Entity]DAOImpl.java` or `dao/impl/[Entity]DAOImpl.java`
- **Models**: `model/[Entity].java` (JavaBean pattern with getters/setters)
- **Servlet Paths**: `/resource-path/*` (e.g., `/cart/*`, `/product/*`, `/user/*`)

### File Organization
```
src/main/java/
├── controller/        # Servlet HTTP handlers (one per resource)
├── service/           # Business logic layer
├── dao/
│   ├── interfaces/   # DAO contracts
│   ├── impl/         # JDBC implementations
│   └── stub/         # Testing stubs
├── model/            # Entity classes (JavaBeans)
├── config/           # DIContainer, AppConfig
├── db/               # DBConnection (legacy, prefer DIContainer)
└── utils/            # ValidationUtil, PasswordUtil, AuthUtil

src/main/webapp/
├── *.jsp             # Page templates
├── components/       # Reusable JSP fragments
├── static/           # CSS, JS, images
└── WEB-INF/          # web.xml, protected resources
```

### Code Style Rules
- **Java 8 target**: Use lambda expressions, streams where appropriate
- **Final fields**: DAO fields in controllers should be `final` if possible
- **Try-with-resources**: Always use for JDBC resources (automatic cleanup)
- **PreparedStatement**: Required for all SQL (prevents injection attacks)
- **Exception handling**: Controllers catch, services/DAOs throw
- **No printStackTrace()**: Use proper error forwarding via `ErrorAction` or `ServletException`

## 4. Integration Points and Critical Patterns

### Servlet Controller Pattern
**All controllers must follow this init() pattern**:
```java
@WebServlet("/cart/*")
public class CartController extends HttpServlet {
    private CartItemDAO cartItemDAO;
    
    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DIContainer.getConnection();
            cartItemDAO = new CartItemDAO(connection);
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize database", e);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        // Dispatch logic here
    }
}
```

**Critical Requirements**:
- Use `DIContainer.getConnection()` (not `DBConnection.getConnection()`) for new code
- Throw `ServletException` from `init()` on database errors (never catch and ignore)
- Initialize all DAOs in `init()` to prevent null pointer exceptions
- Only catch `SQLException` (DIContainer doesn't throw `ClassNotFoundException`)

### Service Layer Pattern
**Services validate, then delegate to DAOs**:
```java
public class UserService {
    private final UserDAO userDAO;
    
    public UserService() {
        this.userDAO = DIContainer.get(UserDAO.class);  // DI pattern
    }
    
    public User registerUser(UserRegistrationRequest request) throws SQLException {
        // Validation BEFORE database calls
        ValidationUtil.validateEmail(request.getEmail());
        ValidationUtil.validatePassword(request.getPassword());
        
        // Business rule: check uniqueness
        if (userDAO.getUserByEmail(request.getEmail()) != null) {
            throw new IllegalArgumentException("Email already exists");
        }
        
        // Hash password before storage
        String hashedPassword = PasswordUtil.hashPassword(request.getPassword());
        
        // Create via DAO
        User user = new User(request.getEmail(), hashedPassword, request.getName());
        userDAO.createUser(user);
        return user;
    }
}
```

**Critical Requirements**:
- Obtain DAOs via `DIContainer.get([DAO].class)` in constructor
- Validate inputs using `ValidationUtil` and `PasswordUtil` BEFORE DAO calls
- Throw `IllegalArgumentException` for validation failures (caught by controller)
- Throw `SQLException` for database errors (propagated to controller, never catch)

### DAO Interface-Based Design
**Define interface contract, implement with JDBC**:
```java
// dao/interfaces/UserDAO.java
public interface UserDAO {
    void createUser(User user) throws SQLException;
    User getUserById(int id) throws SQLException;
    User getUserByEmail(String email) throws SQLException;
    void updateUser(User user) throws SQLException;
    void deleteUser(int id) throws SQLException;
}

// dao/UserDAOImpl.java
public class UserDAOImpl implements dao.interfaces.UserDAO {
    private final Connection connection;
    
    public UserDAOImpl(Connection connection) {
        this.connection = connection;
    }
    
    @Override
    public void createUser(User user) throws SQLException {
        String query = "INSERT INTO user (email, password, name) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getName());
            stmt.executeUpdate();
        }
    }
}
```

**Critical Requirements**:
- Always use `PreparedStatement` (never string concatenation for SQL)
- Use try-with-resources (`try (PreparedStatement stmt = ...)`) for automatic cleanup
- All DAO methods throw `SQLException` (never catch, propagate to caller)
- DAO constructors accept `Connection` from servlet `init()` or service constructor

### Error Handling Flow
**Three-tier exception strategy**:
- **Controllers**: Catch `IllegalArgumentException` (validation) → display error to user; catch `SQLException` → log error, show generic message
- **Services**: Throw `IllegalArgumentException` for validation failures; throw `SQLException` if DAO call fails (never catch)
- **DAOs**: Throw `SQLException` from JDBC; use try-with-resources for cleanup (no explicit catch needed)

**Example Controller Error Handling**:
```java
try {
    User user = userService.registerUser(request);
    response.sendRedirect("/login.jsp?registered=true");
} catch (IllegalArgumentException e) {
    // Validation error - show form with error message
    request.setAttribute("error", e.getMessage());
    request.getRequestDispatcher("/register.jsp").forward(request, response);
} catch (SQLException e) {
    // Database error - log and show generic message
    throw new ServletException("Failed to register user", e);
}
```

### Database Connection Management
**Preferred Pattern (Dependency Injection)**:
```java
// In controller init() or service constructor
Connection connection = DIContainer.getConnection();
userDAO = new UserDAOImpl(connection);
```

**Legacy Pattern (Direct Factory - avoid for new code)**:
```java
Connection connection = DBConnection.getConnection();  // Old style
userDAO = new UserDAOImpl(connection);
```

**Key Differences**:
- `DIContainer.getConnection()`: Enables testing, connection pooling, only throws `SQLException`
- `DBConnection.getConnection()`: Static factory, throws `SQLException | ClassNotFoundException`
- **Always use DIContainer for new code** (enables dependency injection, simplifies testing)

## 5. Examples and Quick References

### Adding a New Controller
```bash
# 1. Create controller file
touch src/main/java/controller/OrderController.java

# 2. Implement servlet pattern
@WebServlet("/order/*")
public class OrderController extends HttpServlet {
    private OrderDAO orderDAO;
    
    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DIContainer.getConnection();
            orderDAO = new OrderDAOImpl(connection);
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize database", e);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Handle GET requests
    }
}
```

### Adding a New DAO Method
```bash
# 1. Add to interface
# dao/interfaces/ProductDAO.java
Product getProductById(int id) throws SQLException;

# 2. Implement with PreparedStatement
# dao/ProductDAOImpl.java
@Override
public Product getProductById(int id) throws SQLException {
    String query = "SELECT * FROM product WHERE id = ?";
    try (PreparedStatement stmt = connection.prepareStatement(query)) {
        stmt.setInt(1, id);
        try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return new Product(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getDouble("price")
                );
            }
            return null;
        }
    }
}
```

### Adding Business Logic
```bash
# service/ProductService.java
public Product createProduct(String name, double price) throws SQLException {
    // Validate
    if (name == null || name.trim().isEmpty()) {
        throw new IllegalArgumentException("Product name is required");
    }
    if (price <= 0) {
        throw new IllegalArgumentException("Price must be positive");
    }
    
    // Create via DAO
    Product product = new Product(name, price);
    ProductDAO productDAO = DIContainer.get(ProductDAO.class);
    productDAO.createProduct(product);
    return product;
}
```

## 6. Key Workflows and Testing

### Running Tests
```bash
# Run all tests
mvn test

# Run specific test
mvn test -Dtest=UserServiceTest

# Run with coverage
mvn clean test jacoco:report
```

### Testing Strategy
- **DAO Tests**: Use stub implementations in `dao/stub/` (no real database)
- **Service Tests**: Mock DAO dependencies, test validation logic
- **Controller Tests**: Use servlet testing frameworks (HttpServletRequest/Response mocks)
- **JUnit 4 Conventions**: Use `@Before`, `@Test`, `@After` annotations

### Git Workflow
```bash
# Create feature branch
git checkout -b feature/add-order-history

# Make changes, commit frequently
git add src/main/java/controller/OrderHistoryController.java
git commit -m "feat: Add order history controller"

# Push to remote
git push origin feature/add-order-history

# Create pull request on GitHub
```

## 7. Quick Reference

### Key Files to Reference
- `pom.xml` - Build configuration, dependencies, Maven plugins
- `src/main/java/config/DIContainer.java` - Dependency injection container
- `src/main/java/db/DBConnection.java` - Legacy database factory (avoid for new code)
- `src/main/java/controller/HomeController.java` - Example servlet pattern
- `src/main/java/service/UserService.java` - Example service layer pattern
- `src/main/java/dao/interfaces/UserDAO.java` - Example DAO interface
- `src/main/java/utils/ValidationUtil.java` - Input validation utilities
- `src/main/java/utils/PasswordUtil.java` - Password hashing/verification
- `src/main/java/utils/AuthUtil.java` - Session authentication
- `docs/2_architecture/COMPONENT_ARCHITECTURE.md` - Architecture documentation

### Dependencies (from pom.xml)
- **Jetty 9.4.12**: Embedded servlet container for development
- **SQLite JDBC 3.49.1.0**: Database driver (`org.sqlite.JDBC`)
- **GSON 2.10.1**: JSON serialization for API responses
- **JUnit 4.13.2**: Testing framework

### Common Commands
```bash
# Build project
mvn clean install

# Run development server
mvn jetty:run

# Run tests
mvn test

# Package as WAR
mvn package

# Clean build artifacts
mvn clean
```

## Notes

- **Prefer DIContainer over DBConnection**: All new code should use `DIContainer.getConnection()` for dependency injection compatibility
- **Exception Handling**: Controllers catch, services/DAOs throw (never catch SQLException in service layer)
- **Security**: Always use `PreparedStatement` for SQL, hash passwords with `PasswordUtil`, validate sessions with `AuthUtil`
- **Database**: Single SQLite file (`iotbay.db`) - no connection pooling needed, but DIContainer supports it for future upgrades
- **Frontend**: JSP pages can include TypeScript-enhanced components from `src/main/webapp/components/`
- **Documentation**: See `docs/` directory for detailed architecture, requirements, and development guides
- Use descriptive variable names matching database column names

---

**Last Updated**: 2025 | Generated for AI agent guidance
- Use descriptive variable names matching database column names

---

**Last Updated**: 2025 | Generated for AI agent guidance
