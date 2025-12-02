# IoT Bay Copilot Instructions

Guide for AI coding agents working with the IoT Bay codebase.

## Architecture Overview

**Pattern**: MVC with 3-tier design (Servlet → Service → DAO → Database)

- **Controllers** (`src/main/java/controller/`): Servlet-based HTTP handlers using `@WebServlet` annotations
- **Services** (`src/main/java/service/`): Business logic layer (UserService, ProductService, CartService, OrderService)
- **DAOs** (`src/main/java/dao/`): Data access layer with interface-based design (interfaces/, impl/ subdirectories)
- **Models** (`src/main/java/model/`): JavaBeans representing database entities
- **Database**: SQLite via JDBC (`jdbc:sqlite:iotbay.db`)

Build: Maven with Java 8, Jetty 9.4.12 server, GSON 2.10.1 for JSON, JUnit 4.13.2 for testing.

## Critical Patterns

### 1. Servlet Controller Pattern
Controllers initialize DAOs in `init()` method, dispatch requests in `doGet()`/`doPost()`:

```java
@WebServlet("/cart/*")
public class CartController extends HttpServlet {
    private CartItemDAO cartItemDAO;
    
    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DIContainer.getConnection();
            cartItemDAO = new CartItemDAO(connection);
        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException("Failed to initialize database", e);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Dispatch logic here
    }
}
```

**Key Points**:
- Always throw `ServletException` from `init()` on database errors
- Use either `DBConnection.getConnection()` (direct JDBC) or `DIContainer.getConnection()` (DI)
- Initialize all DAOs in init() to prevent null pointers

### 2. Service Layer Delegation
Services contain business logic and validate data before DAO calls:

```java
public class UserService {
    private final UserDAO userDAO;
    
    public UserService() {
        this.userDAO = DIContainer.get(UserDAO.class);  // Always use DIContainer
    }
    
    public User registerUser(UserRegistrationRequest request) throws SQLException {
        // Validation happens BEFORE database calls
        ValidationUtil.validateEmail(request.getEmail());
        
        // Business rule: check uniqueness
        if (userDAO.getUserByEmail(request.getEmail()) != null) {
            throw new IllegalArgumentException("Email already exists");
        }
        
        // Then create via DAO
        User user = new User(request);
        userDAO.createUser(user);
        return user;
    }
}
```

**Key Points**:
- Services validate using `ValidationUtil` and `PasswordUtil`
- Services throw `IllegalArgumentException` for validation errors (caught by controller)
- Services throw `SQLException` for database errors (propagated to controller)
- Always obtain DAOs via `DIContainer.get(UserDAO.class)`

### 3. DAO Interface-Based Design
DAOs follow interface contracts in `src/main/java/dao/interfaces/` with multiple implementations:

```java
// Interface in dao/interfaces/UserDAO.java
public interface UserDAO {
    void createUser(User user) throws SQLException;
    User getUserById(int id) throws SQLException;
    User getUserByEmail(String email) throws SQLException;
    void updateUser(User user) throws SQLException;
    void deleteUser(int id) throws SQLException;
}

// Implementation in dao/UserDAOImpl.java
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

**Key Points**:
- Always use `PreparedStatement` to prevent SQL injection
- Use try-with-resources (`try (...)`) for automatic resource cleanup
- All methods throw `SQLException` (never catch, propagate to caller)
- DAO constructors accept `Connection` from servlet init()

### 4. Database Connection Management
Two connection patterns exist:

**Pattern A - Direct Factory (HomeController style)**:
```java
Connection connection = DBConnection.getConnection();  // Static factory
productDAO = new ProductDAOImpl(connection);
```

**Pattern B - Dependency Injection (CartController style)**:
```java
Connection connection = DIContainer.getConnection();  // From DI container
cartItemDAO = new CartItemDAO(connection);
```

- `DBConnection.getConnection()` uses `AppConfig` for jdbc:sqlite:iotbay.db
- `DIContainer.getConnection()` manages connection lifecycle
- **Prefer DIContainer pattern** for new code (enables testing, pooling)

### 5. Error Handling Flow
- **Controllers**: Catch `IllegalArgumentException` (validation) → display error to user; catch `SQLException` → log error, show generic message
- **Services**: Throw `IllegalArgumentException` for validation failures; throw `SQLException` if DAO call fails (never catch)
- **DAOs**: Throw `SQLException` from JDBC; use try-with-resources for cleanup

Example:
```java
try {
    User user = userService.registerUser(request);
    // Success - redirect
} catch (IllegalArgumentException e) {
    // Validation error - show form with error message
    request.setAttribute("error", e.getMessage());
    request.getRequestDispatcher("/register.jsp").forward(request, response);
} catch (SQLException e) {
    // Database error - log and show generic message
    throw new ServletException("Failed to register user", e);
}
```

## File Organization

- **Controller package**: Servlet endpoints (`controller/`), one per resource (UserController, CartController, ProductController)
- **Service package**: Business logic (`service/UserService.java`, `service/ProductService.java`)
- **DAO interfaces**: Contracts in `dao/interfaces/` (UserDAO.java, ProductDAO.java, etc.)
- **DAO implementations**: JDBC code in `dao/` root or `dao/impl/` (UserDAOImpl.java, ProductDAOImpl.java)
- **DAO stubs**: Testing implementations in `dao/stub/`

## Common Tasks

### Adding a new controller
1. Create `src/main/java/controller/[Resource]Controller.java`
2. Annotate with `@WebServlet("/resource-path/*")`
3. In `init()`, use `DIContainer.getConnection()` to get DAOs
4. Implement `doGet()`, `doPost()` methods with request dispatch
5. Catch `IllegalArgumentException` for validation, `SQLException` for DB errors

### Adding a new DAO method
1. Add method signature to `src/main/java/dao/interfaces/[Entity]DAO.java`
2. Implement in `src/main/java/dao/[Entity]DAOImpl.java` using PreparedStatement
3. Use try-with-resources for resource cleanup
4. Throw `SQLException`, never catch

### Adding business logic
1. Add method to `src/main/java/service/[Entity]Service.java`
2. Get DAO via `DIContainer.get([Entity]DAO.class)`
3. Validate input using `ValidationUtil` or `PasswordUtil`
4. Call DAO method
5. Return result or throw `IllegalArgumentException` if validation fails

## Dependencies

- **Jetty 9.4.12**: Servlet container
- **SQLite JDBC 3.49.1.0**: Database driver (`org.sqlite.JDBC`)
- **GSON 2.10.1**: JSON serialization (for API responses)
- **JUnit 4.13.2**: Testing framework

## Key Files to Reference

- `pom.xml` - Build configuration, dependencies
- `src/main/java/db/DBConnection.java` - Database connection factory
- `src/main/java/config/DIContainer.java` - Dependency injection container
- `src/main/java/controller/HomeController.java` - Example servlet pattern
- `src/main/java/service/UserService.java` - Example service layer pattern
- `src/main/java/dao/interfaces/UserDAO.java` - Example DAO interface
- `src/main/java/utils/ValidationUtil.java` - Validation utilities
- `docs/2_architecture/COMPONENT_ARCHITECTURE.md` - Architecture documentation

## Testing

- Test DAOs using stub implementations in `dao/stub/`
- Test services by mocking DAO dependencies
- Use JUnit 4 conventions (`@Before`, `@Test`, `@After`)
- Build: `mvn clean install`
- Run tests: `mvn test`

## Code Style

- Java 8 target (`maven.compiler.source 1.8`)
- Use `final` keyword for class-level DAO fields
- Use try-with-resources for JDBC resources
- Always use PreparedStatement (prevent SQL injection)
- Throw exceptions rather than returning null
- Use descriptive variable names matching database column names

---

**Last Updated**: 2025 | Generated for AI agent guidance
