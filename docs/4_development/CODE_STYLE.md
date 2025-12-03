# Code Style & Standards

Complete coding standards and conventions for the IoT Bay project.

---

## Java Code Standards

### Naming Conventions

#### Classes
- **Format**: PascalCase
- **Purpose**: Nouns describing entity or concept

```java
// ✅ Good
public class ProductService {}
public class UserDAO {}
public class ShoppingCart {}

// ❌ Bad
public class productService {}
public class user_DAO {}
public class cart {}
```

#### Methods
- **Format**: camelCase
- **Purpose**: Verbs describing action
- **Prefix**: get/set for accessors, is/has for booleans, find/create/update/delete for operations

```java
// ✅ Good
public Product getProductById(int id) {}
public void setPrice(double price) {}
public boolean isActive() {}
public List<Product> findProductsByCategory(int categoryId) {}
public void createOrder(Order order) {}
public void updateInventory(int quantity) {}
public void deleteProduct(int id) {}

// ❌ Bad
public Product product(int id) {}
public void Price(double price) {}
public boolean Active() {}
```

#### Variables
- **Format**: camelCase
- **Length**: Long enough to be meaningful (avoid single letters except loops)
- **Scope**: Local variables shorter, instance variables more descriptive

```java
// ✅ Good
int productId = 1;
String customerEmail = "john@example.com";
double discountPercentage = 0.15;
for (int i = 0; i < items.size(); i++) {}

// ❌ Bad
int pid = 1;
String e = "john@example.com";
double dp = 0.15;
```

#### Constants
- **Format**: UPPER_SNAKE_CASE
- **Location**: Static final fields

```java
// ✅ Good
public static final String DATABASE_URL = "jdbc:sqlite:iotbay.db";
public static final int MAX_CART_ITEMS = 100;
public static final double TAX_RATE = 0.10;

// ❌ Bad
public static final String database_url = "jdbc:sqlite:iotbay.db";
public static final int maxCartItems = 100;
```

#### Packages
- **Format**: lowercase with dots
- **Hierarchy**: Reverse domain notation

```
// ✅ Good
com.iotbay.servlet
com.iotbay.service
com.iotbay.dao
com.iotbay.model

// ❌ Bad
IOTBay.Servlet
iotbay-servlet
servlet.iotbay
```

---

## Code Formatting

### Line Length
- **Maximum**: 100 characters
- **Rationale**: Fits on standard monitors without wrapping

### Indentation
- **Style**: Spaces (not tabs)
- **Size**: 4 spaces per level

```java
public class Example {
    private String name;
    
    public void method() {
        if (condition) {
            doSomething();
        }
    }
}
```

### Braces
- **Style**: Opening brace on same line (Java convention)

```java
// ✅ Good
if (condition) {
    statement;
}

public void method() {
    // code
}

// ❌ Bad
if (condition)
{
    statement;
}
```

### Spacing

```java
// ✅ Good - Space after keywords, around operators
if (x > 5) {
    int result = a + b;
}

// ✅ Good - No space inside parentheses
method(parameter1, parameter2);

// ❌ Bad
if(x>5){
    int result=a+b;
}
```

---

## Organizing Classes

### Field Order
1. Static constants
2. Static variables
3. Instance variables (private)
4. Constructors
5. Public methods
6. Protected methods
7. Private methods
8. Getters/setters

```java
public class Product {
    // Static constants
    private static final double TAX_RATE = 0.10;
    
    // Static variables
    private static int productCount = 0;
    
    // Instance variables
    private int id;
    private String name;
    private double price;
    
    // Constructors
    public Product() {}
    
    public Product(int id, String name, double price) {
        this.id = id;
        this.name = name;
        this.price = price;
    }
    
    // Public methods
    public void purchase(int quantity) {
        // implementation
    }
    
    // Protected methods
    protected void validate() {
        // implementation
    }
    
    // Private methods
    private void calculateTax() {
        // implementation
    }
    
    // Getters/Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
}
```

---

## Documentation & Comments

### Javadoc
- **Use for**: Public classes, methods, and important fields
- **Format**: JavaDoc format with proper tags

```java
/**
 * Retrieves a product by its ID.
 *
 * @param id the product ID to search for
 * @return the Product if found, null otherwise
 * @throws SQLException if database access error occurs
 * 
 * @see Product
 * @author John Doe
 * @since 1.0.0
 */
public Product getProductById(int id) throws SQLException {
    // implementation
}
```

### Inline Comments
- **Use for**: Complex logic, non-obvious decisions
- **Style**: Clear and concise

```java
// ✅ Good - Explains WHY, not WHAT
// Check if user is eligible for bulk discount (>100 items)
if (cartSize > 100) {
    applyBulkDiscount();
}

// ❌ Bad - Comments obvious code
// Increment i
i++;

// ❌ Bad - Outdated comment
// TODO: Fix this later (left for 2 years)
```

### Block Comments
- **Use for**: Sections of related code

```java
// ====== Database Operations ======

public void saveProduct(Product product) {
    // implementation
}

// ====== Validation Methods ======

public boolean validateProduct(Product product) {
    // implementation
}
```

---

## Error Handling

### Exceptions
- **Rule**: Don't catch generic exceptions, be specific
- **Always close**: Resources in try-catch-finally or try-with-resources

```java
// ✅ Good - Specific exception handling
try (Connection conn = getConnection()) {
    // use connection
} catch (SQLException e) {
    logger.error("Database error: " + e.getMessage(), e);
    throw new DataAccessException("Failed to connect", e);
}

// ❌ Bad - Generic exception catching
try {
    // code
} catch (Exception e) {
    e.printStackTrace();  // Don't do this!
}
```

### Logging Levels
```java
logger.debug("Debug message for developers");           // Detailed info
logger.info("User logged in successfully");             // Important info
logger.warn("Product stock running low");               // Warning
logger.error("Failed to save order", exception);        // Error with stack trace
```

---

## Java Best Practices

### Use Collections API Properly

```java
// ✅ Good - Modern Java with generics
List<Product> products = new ArrayList<>();
for (Product product : products) {
    // process
}

// ❌ Bad - Raw types and old-style loops
List products = new ArrayList();
for (int i = 0; i < products.size(); i++) {
    // process
}
```

### String Operations

```java
// ✅ Good - StringBuilder for concatenation
StringBuilder sb = new StringBuilder();
for (String item : items) {
    sb.append(item);
}
String result = sb.toString();

// ✅ Good - String joining
String result = String.join(", ", items);

// ❌ Bad - String concatenation in loop
String result = "";
for (String item : items) {
    result += item;  // Creates new string each iteration!
}
```

### Null Checks

```java
// ✅ Good - Explicit null check
if (product != null) {
    product.setPrice(99.99);
}

// ✅ Good - Optional (Java 8+)
Optional.ofNullable(product)
    .ifPresent(p -> p.setPrice(99.99));

// ❌ Bad - Null pointer risk
product.setPrice(99.99);  // Will crash if product is null
```

---

## JSP/HTML Standards

### HTML Structure

```jsp
<%-- ✅ Good - Semantic HTML with proper indentation --%>
<div class="product-card">
    <img src="${product.imageUrl}" alt="${product.name}">
    <h3>${product.name}</h3>
    <p class="price">$${product.price}</p>
    <button onclick="addToCart(${product.id})">Add to Cart</button>
</div>

<%-- ❌ Bad - Invalid structure, poor formatting --%>
<div>
<img src="<% out.print(product.getImageUrl()); %>">
<h3><% out.print(product.getName()); %></h3>
Add to cart:<input type="button" onclick="addToCart(${product.id});">
</div>
```

### CSS Conventions

```css
/* ✅ Good - Clear selectors, BEM naming */
.product-card {
    border: 1px solid #ddd;
    border-radius: 4px;
}

.product-card__title {
    font-size: 18px;
    font-weight: bold;
}

.product-card__price {
    color: #007bff;
    font-weight: bold;
}

.product-card--featured {
    border: 2px solid gold;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

/* ❌ Bad - Vague selectors */
.card {
    border: 1px solid #ddd;
}

.card h3 {
    font-size: 18px;
}
```

### CSS Property Order

```css
.element {
    /* Display & positioning */
    display: block;
    position: relative;
    float: left;
    
    /* Box model */
    width: 100%;
    height: auto;
    margin: 10px;
    padding: 15px;
    border: 1px solid #ddd;
    
    /* Typography */
    font-size: 16px;
    color: #333;
    line-height: 1.5;
    
    /* Visual effects */
    background: #fff;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    opacity: 1;
    
    /* Animation */
    transition: all 0.3s ease;
}
```

---

## JavaScript/TypeScript Standards

### Function Naming

```javascript
// ✅ Good - Clear verb-noun names
function fetchProducts() {}
function handleAddToCart(productId) {}
function validateEmail(email) {}
function formatCurrency(amount) {}

// ❌ Bad - Unclear names
function process() {}
function doStuff() {}
function f(x) {}
```

### Variable Declarations

```javascript
// ✅ Good - Use const by default
const MAX_RETRIES = 3;
const product = { id: 1, name: "Sensor" };

// ✅ Good - Use let for loop variables
for (let i = 0; i < 10; i++) {
    // process
}

// ❌ Bad - Avoid var (hoisting confusion)
var product = { id: 1, name: "Sensor" };
```

### Error Handling

```javascript
// ✅ Good - Proper async error handling
async function addToCart(productId) {
    try {
        const response = await fetch('/cart', {
            method: 'POST',
            body: JSON.stringify({ productId: productId })
        });
        
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        return await response.json();
    } catch (error) {
        console.error('Failed to add to cart:', error);
        showNotification('Error adding to cart', 'error');
    }
}

// ❌ Bad - Silent failures
function addToCart(productId) {
    fetch('/cart', { method: 'POST', body: JSON.stringify({ productId: productId }) });
}
```

---

## SQL Standards

### Query Formatting

```sql
-- ✅ Good - Formatted, readable
SELECT 
    p.id,
    p.name,
    p.price,
    COUNT(r.id) AS review_count
FROM products p
LEFT JOIN reviews r ON p.id = r.product_id
WHERE p.active = 1
GROUP BY p.id
ORDER BY p.name ASC;

-- ❌ Bad - Unreadable, all on one line
SELECT p.id, p.name, p.price, COUNT(r.id) AS review_count FROM products p LEFT JOIN reviews r ON p.id = r.product_id WHERE p.active = 1 GROUP BY p.id ORDER BY p.name ASC;
```

### Prepared Statements (Always)

```java
// ✅ Good - Prevents SQL injection
String sql = "SELECT * FROM users WHERE email = ? AND active = ?";
PreparedStatement stmt = conn.prepareStatement(sql);
stmt.setString(1, email);
stmt.setBoolean(2, true);

// ❌ Bad - SQL injection vulnerability
String sql = "SELECT * FROM users WHERE email = '" + email + "' AND active = true";
Statement stmt = conn.createStatement();
```

---

## Files & Organization

### File Size
- **Classes**: Maximum 500 lines (split if larger)
- **Methods**: Maximum 50 lines (consider extraction)

### File Naming
- **Java files**: `ClassName.java` (matches public class)
- **JSP files**: `kebab-case.jsp` (e.g., `product-detail.jsp`)
- **CSS files**: `purpose.css` (e.g., `atoms.css`, `forms.css`)
- **JS files**: `camelCase.js` (e.g., `apiClient.js`)

---

## Code Review Checklist

Before submitting code, verify:

- [ ] **Naming**: All identifiers follow conventions
- [ ] **Formatting**: Code is properly formatted (indentation, spacing)
- [ ] **Comments**: Complex logic is documented with JavaDoc
- [ ] **Error Handling**: Exceptions are caught and handled appropriately
- [ ] **Resources**: All resources (connections, streams) are closed
- [ ] **Security**: No SQL injection, XSS, or authentication issues
- [ ] **Testing**: Code has appropriate unit tests
- [ ] **Performance**: No obvious N+1 queries or memory leaks
- [ ] **Warnings**: No compiler warnings
- [ ] **Documentation**: Updated relevant documentation

---

## IDE Configuration

### Eclipse Setup
1. Window → Preferences → Java → Code Style → Formatter
2. Import formatter profile from project (if available)
3. Enable "Format source code" on save

### IntelliJ Setup
1. IntelliJ IDEA → Preferences → Editor → Code Style
2. Set indentation to 4 spaces
3. Configure line length to 100 characters

---

## Resources

- See [Backend Guide](./BACKEND_GUIDE.md) for architectural patterns
- See [Frontend Guide](./FRONTEND_GUIDE.md) for component structure
- See [Contributing Guidelines](./CONTRIBUTING.md) for workflow

---

**Last Updated**: December 3, 2025  
**Version**: 1.0.0  
**Status**: Documentation Complete


---

**Document Version**: 1.0.0
**Audience**: Developers, Stakeholders
**Maintained By**: IoT Bay Documentation Team
