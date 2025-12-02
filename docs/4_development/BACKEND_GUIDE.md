# Backend Development Guide

Comprehensive guide for backend developers working on the IoT Bay platform.

---

## Architecture Overview

### MVC Architecture
```
┌─────────────────────────────────┐
│       Servlet (Controller)       │  HTTP Requests
├─────────────────────────────────┤
│      Service Layer (Logic)       │  Business Logic
├─────────────────────────────────┤
│    DAO Layer (Data Access)       │  Database Operations
├─────────────────────────────────┤
│      Database (SQLite/PG)        │  Persistent Storage
└─────────────────────────────────┘
```

### Layer Responsibilities

| Layer | Package | Responsibility | Example |
|---|---|---|---|
| **Controller** | `servlet` | HTTP handling, request validation, response | `ProductServlet.java` |
| **Service** | `service` | Business logic, calculations, transactions | `ProductService.java` |
| **DAO** | `dao` | Database operations, SQL execution | `ProductDAO.java` |
| **Model** | `model` | Data representation, POJO classes | `Product.java` |
| **Utility** | `util` | Helper functions, constants | `DatabaseUtil.java` |

---

## Project Structure

```
src/main/java/
├── iotbay/
│   ├── servlet/          # HTTP Controllers
│   │   ├── ProductServlet.java
│   │   ├── CartServlet.java
│   │   └── ...
│   ├── service/          # Business Logic
│   │   ├── ProductService.java
│   │   ├── CartService.java
│   │   └── ...
│   ├── dao/              # Data Access Objects
│   │   ├── ProductDAO.java
│   │   ├── CartDAO.java
│   │   └── ...
│   ├── model/            # Data Models (POJOs)
│   │   ├── Product.java
│   │   ├── Cart.java
│   │   └── ...
│   └── util/             # Utilities & Helpers
│       ├── DatabaseUtil.java
│       └── ...

src/main/resources/
├── database/
│   ├── schema.sql        # Database schema
│   └── init.sql          # Initial data
└── config/
    └── config.properties # Configuration

src/main/webapp/
└── WEB-INF/
    ├── web.xml           # Web application descriptor
    └── views/            # JSP files
```

---

## Common Development Tasks

### Creating a New Feature

#### Step 1: Define Data Model

Create `src/main/java/iotbay/model/Feature.java`:

```java
package iotbay.model;

public class Feature {
    private int id;
    private String name;
    private String description;
    private boolean active;
    
    // Constructors
    public Feature() {}
    
    public Feature(int id, String name, String description, boolean active) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.active = active;
    }
    
    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }
}
```

#### Step 2: Create DAO Layer

Create `src/main/java/iotbay/dao/FeatureDAO.java`:

```java
package iotbay.dao;

import iotbay.model.Feature;
import iotbay.util.DatabaseUtil;
import java.sql.*;
import java.util.*;

public class FeatureDAO {
    
    public List<Feature> getAllFeatures() throws SQLException {
        List<Feature> features = new ArrayList<>();
        String sql = "SELECT * FROM features";
        
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                features.add(new Feature(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getBoolean("active")
                ));
            }
        }
        return features;
    }
    
    public Feature getFeatureById(int id) throws SQLException {
        String sql = "SELECT * FROM features WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Feature(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getBoolean("active")
                    );
                }
            }
        }
        return null;
    }
    
    public void addFeature(Feature feature) throws SQLException {
        String sql = "INSERT INTO features (name, description, active) VALUES (?, ?, ?)";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, feature.getName());
            stmt.setString(2, feature.getDescription());
            stmt.setBoolean(3, feature.isActive());
            stmt.executeUpdate();
        }
    }
    
    public void updateFeature(Feature feature) throws SQLException {
        String sql = "UPDATE features SET name = ?, description = ?, active = ? WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, feature.getName());
            stmt.setString(2, feature.getDescription());
            stmt.setBoolean(3, feature.isActive());
            stmt.setInt(4, feature.getId());
            stmt.executeUpdate();
        }
    }
    
    public void deleteFeature(int id) throws SQLException {
        String sql = "DELETE FROM features WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
}
```

#### Step 3: Create Service Layer

Create `src/main/java/iotbay/service/FeatureService.java`:

```java
package iotbay.service;

import iotbay.model.Feature;
import iotbay.dao.FeatureDAO;
import java.sql.SQLException;
import java.util.List;

public class FeatureService {
    private FeatureDAO featureDAO = new FeatureDAO();
    
    public List<Feature> getAllActiveFeatures() {
        try {
            return featureDAO.getAllFeatures();
        } catch (SQLException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
    
    public Feature getFeatureById(int id) {
        try {
            return featureDAO.getFeatureById(id);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public boolean createFeature(String name, String description) {
        try {
            Feature feature = new Feature(0, name, description, true);
            featureDAO.addFeature(feature);
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
```

#### Step 4: Create Servlet Controller

Create `src/main/java/iotbay/servlet/FeatureServlet.java`:

```java
package iotbay.servlet;

import iotbay.service.FeatureService;
import iotbay.model.Feature;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/feature")
public class FeatureServlet extends HttpServlet {
    private FeatureService featureService = new FeatureService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("list".equals(action)) {
            List<Feature> features = featureService.getAllActiveFeatures();
            request.setAttribute("features", features);
            request.getRequestDispatcher("/WEB-INF/views/feature-list.jsp")
                .forward(request, response);
        } else if ("view".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Feature feature = featureService.getFeatureById(id);
            request.setAttribute("feature", feature);
            request.getRequestDispatcher("/WEB-INF/views/feature-detail.jsp")
                .forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("create".equals(action)) {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            
            boolean success = featureService.createFeature(name, description);
            
            if (success) {
                response.sendRedirect("feature?action=list");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        }
    }
}
```

---

## Database Operations

### Using PreparedStatements (Prevent SQL Injection)

```java
// ✅ GOOD - Uses PreparedStatement
String sql = "SELECT * FROM users WHERE email = ? AND active = ?";
try (PreparedStatement stmt = conn.prepareStatement(sql)) {
    stmt.setString(1, email);
    stmt.setBoolean(2, true);
    ResultSet rs = stmt.executeQuery();
}

// ❌ BAD - Vulnerable to SQL injection
String sql = "SELECT * FROM users WHERE email = '" + email + "' AND active = true";
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);
```

### Transaction Management

```java
public void transferBalance(int fromUserId, int toUserId, double amount) throws SQLException {
    Connection conn = DatabaseUtil.getConnection();
    conn.setAutoCommit(false);  // Disable auto-commit
    
    try {
        // Debit from-user
        debitAccount(conn, fromUserId, amount);
        
        // Credit to-user
        creditAccount(conn, toUserId, amount);
        
        conn.commit();  // Commit transaction
    } catch (SQLException e) {
        conn.rollback();  // Rollback on error
        throw e;
    } finally {
        conn.setAutoCommit(true);
        conn.close();
    }
}
```

### Try-with-resources (Automatic Resource Closing)

```java
// ✅ GOOD - Automatically closes resources
try (Connection conn = DatabaseUtil.getConnection();
     PreparedStatement stmt = conn.prepareStatement(sql)) {
    stmt.setInt(1, id);
    ResultSet rs = stmt.executeQuery();
    // Process results
} catch (SQLException e) {
    e.printStackTrace();
}

// ❌ BAD - May leak resources
Connection conn = DatabaseUtil.getConnection();
PreparedStatement stmt = conn.prepareStatement(sql);
ResultSet rs = stmt.executeQuery();
// Resources may not be closed if exception occurs
```

---

## Testing Backend Code

### Unit Testing with JUnit

Create `src/test/java/iotbay/service/FeatureServiceTest.java`:

```java
package iotbay.service;

import static org.junit.Assert.*;
import org.junit.Before;
import org.junit.Test;
import iotbay.model.Feature;

public class FeatureServiceTest {
    private FeatureService featureService;
    
    @Before
    public void setUp() {
        featureService = new FeatureService();
    }
    
    @Test
    public void testGetAllActiveFeatures() {
        assertNotNull(featureService.getAllActiveFeatures());
    }
    
    @Test
    public void testCreateFeature() {
        boolean result = featureService.createFeature("Test", "Test Description");
        assertTrue(result);
    }
    
    @Test
    public void testGetFeatureById() {
        Feature feature = featureService.getFeatureById(1);
        assertNotNull(feature);
    }
}
```

### Running Tests

```bash
# Run all tests
mvn test

# Run specific test
mvn test -Dtest=FeatureServiceTest

# Run with coverage
mvn test jacoco:report
```

---

## Security Considerations

### Authentication & Authorization

```java
// Check user authentication
User user = (User) request.getSession().getAttribute("user");
if (user == null) {
    response.sendRedirect("login");
    return;
}

// Check user authorization
if (!user.hasRole("ADMIN")) {
    response.sendError(HttpServletResponse.SC_FORBIDDEN);
    return;
}
```

### Input Validation

```java
public void validateProductInput(String name, double price) throws IllegalArgumentException {
    if (name == null || name.trim().isEmpty()) {
        throw new IllegalArgumentException("Product name cannot be empty");
    }
    if (name.length() > 255) {
        throw new IllegalArgumentException("Product name too long");
    }
    if (price < 0) {
        throw new IllegalArgumentException("Price cannot be negative");
    }
}
```

### SQL Injection Prevention

- Always use `PreparedStatement` instead of string concatenation
- Never concatenate user input into SQL queries
- Use parameterized queries with `?` placeholders

---

## Debugging

### Logging

```java
import java.util.logging.*;

private static final Logger logger = Logger.getLogger(ProductService.class.getName());

public void deleteProduct(int id) {
    logger.info("Deleting product with ID: " + id);
    try {
        productDAO.deleteProduct(id);
        logger.info("Successfully deleted product: " + id);
    } catch (SQLException e) {
        logger.severe("Error deleting product: " + e.getMessage());
        e.printStackTrace();
    }
}
```

### Debugging in IDE

**Eclipse**:
1. Set breakpoint (double-click line number)
2. Run → Debug As → Java Application
3. Step through code with F6 (step over), F5 (step into)

**IntelliJ**:
1. Set breakpoint (click line number)
2. Run → Debug → Select Application
3. Use debugging toolbar to step through code

---

## Common Patterns

### Singleton Pattern (Database Connection Pool)

```java
public class DatabaseUtil {
    private static DatabaseUtil instance;
    private DataSource dataSource;
    
    private DatabaseUtil() {
        // Initialize connection pool
    }
    
    public static synchronized DatabaseUtil getInstance() {
        if (instance == null) {
            instance = new DatabaseUtil();
        }
        return instance;
    }
    
    public Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }
}
```

### Factory Pattern (DAO Creation)

```java
public class DAOFactory {
    public static ProductDAO createProductDAO() {
        return new ProductDAO();
    }
    
    public static CartDAO createCartDAO() {
        return new CartDAO();
    }
}
```

---

## Performance Tips

### Database Optimization

```java
// ✅ Use indexes on frequently queried columns
CREATE INDEX idx_user_email ON users(email);

// ✅ Batch operations for multiple inserts
PreparedStatement stmt = conn.prepareStatement("INSERT INTO logs VALUES (?, ?)");
for (int i = 0; i < 1000; i++) {
    stmt.setInt(1, i);
    stmt.setString(2, "log message");
    stmt.addBatch();
}
stmt.executeBatch();

// ❌ Avoid N+1 queries - load all data in one query
List<Order> orders = orderDAO.getAllOrders();  // 1 query
for (Order order : orders) {
    // Instead of: order.setItems(itemDAO.getItems(order.getId()));
    // Load all items in one query before the loop
}
```

### Memory Management

```java
// ✅ Close resources properly
try (Connection conn = DatabaseUtil.getConnection()) {
    // Use connection
} // Automatically closed

// ✅ Use StringBuilder for string concatenation in loops
StringBuilder sb = new StringBuilder();
for (String item : items) {
    sb.append(item);
}
String result = sb.toString();
```

---

## Resources

- See [COMPONENT_ARCHITECTURE.md](../2_architecture/COMPONENT_ARCHITECTURE.md) for frontend integration
- See [DATABASE_DESIGN.md](../2_architecture/DATABASE_DESIGN.md) for schema details
- See [CODE_STYLE.md](./CODE_STYLE.md) for naming conventions
- See [ERROR_PREVENTION.md](../5_testing/ERROR_PREVENTION.md) for common errors

---

**Last Updated**: December 3, 2025  
**Version**: 1.0.0  
**Status**: Documentation Complete
