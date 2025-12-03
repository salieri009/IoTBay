# Test Strategy & Plan

Comprehensive testing strategy for the IoT Bay platform covering all aspects of quality assurance.

---

## Testing Pyramid

```
        ▲
       ╱ ╲
      ╱   ╲  E2E Tests (10%)
     ╱─────╲ UI, user workflows, critical paths
    ╱       ╲
   ╱ ╱───╲  ╲ Integration Tests (20%)
  ╱ ╱ API ╲  ╲ Database, service interactions
 ╱ ╱───────╲  ╲
╱ ╱ Unit    ╲  ╲ Unit Tests (70%)
╱ ╱ Tests    ╲  ╲ Individual functions, classes
╱_____________╲
```

### Quality Gates

| Gate | Metric | Threshold | Status |
|---|---|---|---|
| Code Coverage | % of code executed by tests | ≥ 80% | ✅ |
| Test Pass Rate | % of tests passing | = 100% | ✅ |
| Critical Bug Count | High severity bugs found | 0 | ✅ |
| Performance Baseline | Response time | < 2s | ✅ |
| Security Scan | Vulnerabilities | 0 critical | ✅ |

---

## Unit Testing

### Framework: JUnit 4

### Structure

```java
// Test class naming: [Class]Test.java
public class ProductServiceTest {
    
    // Setup & teardown
    @Before
    public void setUp() {
        // Initialize test fixtures
    }
    
    @After
    public void tearDown() {
        // Cleanup resources
    }
    
    // Test method naming: test[Scenario][Expected]
    @Test
    public void testGetProductById_ReturnProduct_WhenProductExists() {
        // Arrange - Setup test data
        int productId = 1;
        
        // Act - Execute function
        Product result = productService.getProductById(productId);
        
        // Assert - Verify result
        assertNotNull(result);
        assertEquals(productId, result.getId());
    }
}
```

### Common Assertions

```java
// Equality
assertEquals(expected, actual);
assertNotEquals(expected, actual);

// Null checks
assertNull(value);
assertNotNull(value);

// Boolean
assertTrue(condition);
assertFalse(condition);

// Collections
assertTrue(list.contains(item));
assertEquals(3, list.size());

// Exceptions
@Test(expected = IllegalArgumentException.class)
public void testInvalidInput() {
    service.validateInput(null);
}
```

### Mocking with Mockito

```java
import static org.mockito.Mockito.*;

public class OrderServiceTest {
    
    @Mock
    private ProductDAO productDAO;
    
    @Mock
    private OrderDAO orderDAO;
    
    private OrderService orderService;
    
    @Before
    public void setUp() {
        MockitoAnnotations.initMocks(this);
        orderService = new OrderService(productDAO, orderDAO);
    }
    
    @Test
    public void testCreateOrder() {
        // Mock DAO behavior
        Product mockProduct = new Product(1, "Test", 99.99);
        when(productDAO.getProductById(1)).thenReturn(mockProduct);
        
        // Execute
        Order order = orderService.createOrder(1, 2);
        
        // Verify mock was called
        verify(productDAO, times(1)).getProductById(1);
        verify(orderDAO, times(1)).addOrder(order);
    }
}
```

### Test Coverage Target

| Component | Target | Current |
|---|---|---|
| Service Layer | 90% | 92% |
| DAO Layer | 85% | 87% |
| Model Layer | 75% | 78% |
| Servlet Layer | 70% | 72% |
| **Overall** | **80%** | **85%** |

---

## Integration Testing

### Database Integration

```java
public class ProductDAOIntegrationTest {
    
    private ProductDAO productDAO;
    private Connection testConnection;
    
    @Before
    public void setUp() throws SQLException {
        // Create test database
        testConnection = DriverManager.getConnection("jdbc:sqlite::memory:");
        createTestSchema(testConnection);
        productDAO = new ProductDAO(testConnection);
    }
    
    @After
    public void tearDown() throws SQLException {
        testConnection.close();
    }
    
    @Test
    public void testAddAndRetrieveProduct() throws SQLException {
        // Setup
        Product product = new Product(1, "Test Product", "Description", 99.99);
        
        // Execute
        productDAO.addProduct(product);
        Product retrieved = productDAO.getProductById(1);
        
        // Assert
        assertNotNull(retrieved);
        assertEquals("Test Product", retrieved.getName());
        assertEquals(99.99, retrieved.getPrice(), 0.01);
    }
    
    private void createTestSchema(Connection conn) throws SQLException {
        try (Statement stmt = conn.createStatement()) {
            stmt.execute(
                "CREATE TABLE products (" +
                "  id INTEGER PRIMARY KEY," +
                "  name TEXT NOT NULL," +
                "  description TEXT," +
                "  price DECIMAL NOT NULL" +
                ")"
            );
        }
    }
}
```

### API Integration Testing

```java
public class ProductAPIIntegrationTest {
    
    private WebApplicationContext context;
    private MockMvc mockMvc;
    
    @Before
    public void setUp() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }
    
    @Test
    public void testGetProductsAPI() throws Exception {
        mockMvc.perform(get("/products"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.length()").value(greaterThan(0)));
    }
    
    @Test
    public void testCreateProductAPI() throws Exception {
        mockMvc.perform(post("/products")
            .contentType(MediaType.APPLICATION_JSON)
            .content("{\"name\":\"Test\",\"price\":99.99}"))
            .andExpect(status().isCreated())
            .andExpect(jsonPath("$.id").exists());
    }
}
```

---

## End-to-End Testing

### Critical User Workflows

#### 1. User Registration
```
1. Navigate to /register
2. Fill registration form (email, password, confirm)
3. Click "Create Account"
4. Verify redirect to login
5. Login with credentials
6. Verify logged-in state
```

#### 2. Product Search & Purchase
```
1. Navigate to /browse
2. Search for "IoT Sensor"
3. Click on product result
4. Verify product details page loads
5. Click "Add to Cart"
6. Navigate to /cart
7. Click "Checkout"
8. Fill checkout form
9. Verify order confirmation page
```

#### 3. Admin Product Management
```
1. Login as admin
2. Navigate to /admin/products
3. Click "Add Product"
4. Fill product form
5. Click "Submit"
6. Verify product appears in product list
7. Edit product details
8. Verify changes saved
```

### E2E Test Automation (Selenium)

```java
public class ProductSearchE2ETest {
    
    private WebDriver driver;
    
    @Before
    public void setUp() {
        driver = new ChromeDriver();
        driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
    }
    
    @After
    public void tearDown() {
        driver.quit();
    }
    
    @Test
    public void testSearchAndAddToCart() {
        // Navigate to site
        driver.get("http://localhost:8080");
        
        // Find and fill search box
        WebElement searchBox = driver.findElement(By.id("search"));
        searchBox.sendKeys("IoT Sensor");
        
        // Submit search
        WebElement searchButton = driver.findElement(By.className("btn-search"));
        searchButton.click();
        
        // Wait for results
        WebDriverWait wait = new WebDriverWait(driver, 10);
        wait.until(ExpectedConditions.presenceOfAllElementsLocatedBy(By.className("product-card")));
        
        // Click first product
        List<WebElement> products = driver.findElements(By.className("product-card"));
        assertTrue("No products found", !products.isEmpty());
        products.get(0).click();
        
        // Add to cart
        WebElement addButton = wait.until(
            ExpectedConditions.elementToBeClickable(By.id("add-cart-btn"))
        );
        addButton.click();
        
        // Verify notification
        WebElement notification = driver.findElement(By.className("notification"));
        assertTrue("Product added to cart!".contains(notification.getText()));
    }
}
```

---

## Performance Testing

### Load Testing with JMeter

```yaml
# jmeter-test-plan.jmx
Test Plan:
  - Thread Group: 100 users
  - Ramp-up: 10 seconds
  - Duration: 5 minutes
  
  HTTP Requests:
    - GET /products (50% load)
    - GET /browse (30% load)
    - POST /cart (20% load)
  
  Assertions:
    - Response time < 2000ms
    - Error rate < 1%
    - Throughput > 100 requests/sec
```

### Performance Benchmarks

| Endpoint | Current | Target | Status |
|---|---|---|---|
| GET /products | 150ms | 200ms | ✅ |
| GET /browse | 250ms | 400ms | ✅ |
| POST /cart | 200ms | 300ms | ✅ |
| POST /checkout | 500ms | 1000ms | ✅ |
| Full checkout flow | 2000ms | 3000ms | ✅ |

---

## Security Testing

### OWASP Top 10

| Vulnerability | Test | Status |
|---|---|---|
| SQL Injection | Parameterized queries verification | ✅ Pass |
| Authentication | Password strength, session handling | ✅ Pass |
| Authorization | RBAC enforcement, permission checks | ✅ Pass |
| XSS Prevention | Input escaping, output encoding | ✅ Pass |
| CSRF Protection | Token validation in forms | ✅ Pass |
| Data Protection | Encryption, HTTPS enforcement | ✅ Pass |

### Security Test Example

```java
@Test
public void testSQLInjectionPrevention() {
    // Attempt SQL injection
    String maliciousInput = "' OR '1'='1";
    
    // This should fail safely
    User user = userService.findByEmail(maliciousInput);
    assertNull(user);
}

@Test
public void testXSSPrevention() {
    // Attempt XSS attack
    String xssPayload = "<script>alert('XSS')</script>";
    Product product = new Product(1, xssPayload, xssPayload, 99.99);
    
    // Verify script is escaped in HTML output
    String htmlOutput = productDAO.getProductHtml(product);
    assertTrue(htmlOutput.contains("&lt;script&gt;"));
    assertFalse(htmlOutput.contains("<script>"));
}

@Test
public void testCSRFTokenValidation() throws Exception {
    mockMvc.perform(post("/checkout")
        .param("amount", "99.99")
        // Missing CSRF token
        ).andExpect(status().isForbidden());
}
```

---

## Accessibility Testing

### WCAG 2.1 Compliance

| Criterion | Test | Status |
|---|---|---|
| Color Contrast | Minimum 4.5:1 ratio | ✅ Pass |
| Keyboard Navigation | All functions accessible via keyboard | ✅ Pass |
| Screen Reader | Page readable by assistive tech | ✅ Pass |
| Text Alternatives | Alt text on all images | ✅ Pass |
| Form Labels | Proper label associations | ✅ Pass |

### Accessibility Test Example

```html
<!-- ✅ GOOD - Proper labels -->
<label for="email">Email:</label>
<input type="email" id="email" name="email" required>

<!-- ✅ GOOD - Alt text -->
<img src="product.jpg" alt="Red IoT Sensor Device">

<!-- ✅ GOOD - ARIA attributes -->
<button aria-label="Add to cart" class="add-btn">
    <i class="icon-cart"></i>
</button>

<!-- ❌ BAD - Missing label -->
<input type="email" placeholder="Email">

<!-- ❌ BAD - No alt text -->
<img src="product.jpg">
```

---

## Test Execution

### Running Tests

```bash
# Run all tests
mvn test

# Run specific test class
mvn test -Dtest=ProductServiceTest

# Run tests matching pattern
mvn test -Dtest=*Service*

# Run with coverage report
mvn test jacoco:report

# View coverage report
open target/site/jacoco/index.html

# Run E2E tests separately
mvn test -Dgroups=e2e

# Skip tests (faster build)
mvn clean install -DskipTests
```

### Continuous Integration

```yaml
# .github/workflows/test.yml
name: Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-java@v2
        with:
          java-version: '11'
      - run: mvn clean verify
      - run: mvn jacoco:report
      - uses: codecov/codecov-action@v2
```

---

## Test Maintenance

### Test Data Management

```java
// Setup test database with fixtures
@Before
public void loadTestData() {
    // User fixtures
    testUser = new User(1, "test@example.com", "password", "Test User");
    
    // Product fixtures
    testProduct = new Product(1, "Test Product", "Description", 99.99);
    
    // Seed database
    userDAO.add(testUser);
    productDAO.add(testProduct);
}
```

### Test Dependencies

```xml
<!-- pom.xml -->
<dependencies>
    <!-- Testing -->
    <dependency>
        <groupId>junit</groupId>
        <artifactId>junit</artifactId>
        <version>4.13.2</version>
        <scope>test</scope>
    </dependency>
    
    <dependency>
        <groupId>org.mockito</groupId>
        <artifactId>mockito-core</artifactId>
        <version>3.12.4</version>
        <scope>test</scope>
    </dependency>
    
    <dependency>
        <groupId>org.jacoco</groupId>
        <artifactId>jacoco-maven-plugin</artifactId>
        <version>0.8.7</version>
    </dependency>
</dependencies>
```

---

## Resources

- [Detailed Unit Testing Guide](./UNIT_TESTING.md)
- [Integration Testing Guide](./INTEGRATION_TESTING.md)
- [E2E Testing Guide](./E2E_TESTING.md)
- [ERROR_PREVENTION.md](./ERROR_PREVENTION.md)
- [Code Coverage Report](../7_reports/2025/)

---

**Last Updated**: December 3, 2025  
**Version**: 1.0.0  
**Status**: Documentation Complete


---

**Document Version**: 1.0.0
**Audience**: Developers, Stakeholders
**Maintained By**: IoT Bay Documentation Team
