# Testing Guide for QA & Test Engineers

**Version**: 1.0.0  
**Last Updated**: December 3, 2025  
**Status**: Published  
**Audience**: QA Engineers, Test Leads, Testers  
**Prerequisite**: [Project Overview](./1_getting-started/PROJECT_OVERVIEW.md)

---

## 🧪 Testing at a Glance

IoT Bay testing spans **unit tests, integration tests, E2E tests, and acceptance testing** to ensure quality and reliability.

### Testing Pyramid
```
           /\
          /  \
         / E2E \         ← Few E2E scenarios
        /------\
       /        \
      / Integr. \       ← Some integration tests
     /----------\
    /            \
   /   Unit       \     ← Many unit tests
  /________________\
```

### Testing Goals
✅ Prevent bugs before production  
✅ Catch regressions early  
✅ Ensure accessibility compliance (WCAG 2.1 AA)  
✅ Validate acceptance criteria  
✅ Enable confident refactoring  

---

## 🎯 What to Test

### 1. User Management (FR-001)
**Acceptance Criteria**: [01_USER_MANAGEMENT.md](./3_requirements/acceptance-criteria/01_USER_MANAGEMENT.md)

**Key Test Cases**:
- ✅ Valid registration (email, password, terms)
- ✅ Invalid email format (rejection)
- ✅ Weak password (rejection with feedback)
- ✅ Password mismatch (rejection)
- ✅ Duplicate email (rejection)
- ✅ Login with correct credentials (success)
- ✅ Login with wrong password (failure)
- ✅ Logout (session cleared)
- ✅ Profile edit (name, email, address)
- ✅ Password reset flow

### 2. Product Catalog (FR-002)
**Acceptance Criteria**: [02_PRODUCT_CATALOG.md](./3_requirements/acceptance-criteria/02_PRODUCT_CATALOG.md)

**Key Test Cases**:
- ✅ Browse all products (pagination works)
- ✅ Search by keyword (returns matching products)
- ✅ Filter by category (correct subset)
- ✅ Sort by price (ascending/descending)
- ✅ View product details (all info displays)
- ✅ See product reviews (ratings + comments)

### 3. E-commerce (FR-003)
**Acceptance Criteria**: [03_ECOMMERCE.md](./3_requirements/acceptance-criteria/03_ECOMMERCE.md)

**Key Test Cases**:
- ✅ Add product to cart (quantity updates)
- ✅ Update cart quantity (reflects total price)
- ✅ Remove from cart (item deleted)
- ✅ View cart total (calculation correct)
- ✅ Checkout flow (all steps work)
- ✅ Order confirmation (receipt sent)
- ✅ Order history (user can see past orders)

### 4. Admin Functions (FR-005)
**Acceptance Criteria**: [05_ADMIN_FEATURES.md](./3_requirements/acceptance-criteria/05_ADMIN_FEATURES.md)

**Key Test Cases**:
- ✅ Admin dashboard access (only admins)
- ✅ Add product (with all fields)
- ✅ Edit product (changes persist)
- ✅ Delete product (removed from catalog)
- ✅ View user list (pagination)
- ✅ View order list (searchable)

---

## 🧬 Testing Types & Strategies

### 1. Unit Tests
**Purpose**: Test individual functions/methods in isolation

**Tools**: JUnit 4.13.2, Mockito  
**Location**: `src/test/java/`  
**Coverage Target**: 70%+ code coverage

**Example**:
```java
@Test
public void testUserRegistration_ValidData_Success() throws SQLException {
    // Given
    UserRegistrationRequest request = new UserRegistrationRequest("test@example.com", "Password123!");
    
    // When
    User user = userService.registerUser(request);
    
    // Then
    assertNotNull(user);
    assertEquals("test@example.com", user.getEmail());
}

@Test(expected = IllegalArgumentException.class)
public void testUserRegistration_InvalidEmail_Throws() throws SQLException {
    UserRegistrationRequest request = new UserRegistrationRequest("invalid", "Password123!");
    userService.registerUser(request);
}
```

[Read: Test Strategy](./5_testing/TEST_STRATEGY.md#unit-tests)

### 2. Integration Tests
**Purpose**: Test components working together (Service + DAO + DB)

**Tools**: JUnit, test database (SQLite)  
**Location**: `src/test/java/`  
**Naming Convention**: `*IntegrationTest.java`

**Example**:
```java
@Before
public void setUp() throws SQLException {
    // Create test database
    Connection testDb = DriverManager.getConnection("jdbc:sqlite::memory:");
    userDAO = new UserDAOImpl(testDb);
    userService = new UserService(); // Mocked DAO
}

@Test
public void testUserCreation_PersistsToDatabase() throws SQLException {
    User user = new User("test@example.com", "HashedPassword", "Test User");
    userDAO.createUser(user);
    
    User retrieved = userDAO.getUserByEmail("test@example.com");
    assertNotNull(retrieved);
    assertEquals("Test User", retrieved.getName());
}
```

### 3. Acceptance Tests
**Purpose**: Verify acceptance criteria are met

**Tools**: Manual testing + checklists  
**Location**: [Acceptance Criteria](./3_requirements/acceptance-criteria/)

**Process**:
1. Get acceptance criteria for feature
2. Create test cases for each AC
3. Execute test cases
4. Mark pass/fail with evidence (screenshots)

[Read: Acceptance Criteria by Feature](./3_requirements/acceptance-criteria/)

### 4. Error Prevention Tests
**Purpose**: Ensure 403/404/500 errors are prevented

**Common Errors**:
- **403 Forbidden**: User lacks permission
- **404 Not Found**: Resource doesn't exist
- **500 Internal Server Error**: Unhandled exception

**Test Scenarios**:
- [ ] Non-logged-in user tries to access user-only page
- [ ] User tries to access another user's profile
- [ ] Request for non-existent product ID
- [ ] Null pointer exceptions are caught
- [ ] Database connection failures are handled

[Read: Error Prevention Guide](./5_testing/ERROR_PREVENTION.md)

### 5. Accessibility Tests
**Purpose**: Ensure WCAG 2.1 AA compliance

**Standards**: WCAG 2.1 Level AA  
**Tools**: Axe DevTools, Wave, Manual inspection

**Key Checks**:
- [ ] Color contrast (4.5:1 for text)
- [ ] Keyboard navigation (all interactive elements)
- [ ] Screen reader compatibility (semantic HTML)
- [ ] Images have alt text
- [ ] Form labels associated with inputs
- [ ] Focus indicators visible

[Read: Accessibility Testing](./5_testing/ACCESSIBILITY_TESTING.md)

---

## 🚀 Running Tests

### Run All Tests
```bash
mvn test
```

### Run Specific Test Class
```bash
mvn test -Dtest=UserServiceTest
```

### Run Specific Test Method
```bash
mvn test -Dtest=UserServiceTest#testRegistrationValidation
```

### Run with Coverage Report
```bash
mvn test jacoco:report
# Report in: target/site/jacoco/index.html
```

### Run E2E Tests (Manual)
```bash
# 1. Start server
mvn jetty:run

# 2. Open browser
# http://localhost:8080

# 3. Execute test scenarios from acceptance criteria
```

---

## 📋 Test Checklist by Feature Area

### User Management (FR-001)
- [ ] Register with valid data
- [ ] Register with invalid email
- [ ] Register with weak password
- [ ] Register with duplicate email
- [ ] Login with correct credentials
- [ ] Login with wrong password
- [ ] Logout clears session
- [ ] Profile edit saves changes
- [ ] Password reset works
- [ ] User can view account details

### Product Catalog (FR-002)
- [ ] Browse all products
- [ ] Search returns correct results
- [ ] Filter by category works
- [ ] Sort by price (asc/desc)
- [ ] Product details display
- [ ] Reviews display with ratings
- [ ] Pagination works
- [ ] No results message shows when appropriate

### Shopping Cart (FR-003)
- [ ] Add product to cart
- [ ] Quantity increases
- [ ] Remove product from cart
- [ ] Update quantity works
- [ ] Cart total calculates correctly
- [ ] Empty cart shows message
- [ ] Cart persists across pages

### Checkout (FR-003)
- [ ] Proceed to checkout
- [ ] Shipping address required
- [ ] Payment method required
- [ ] Order confirmation shows
- [ ] Confirmation email sent
- [ ] Order appears in order history

### Admin Dashboard (FR-005)
- [ ] Non-admin cannot access
- [ ] Admin can see dashboard
- [ ] Add product works
- [ ] Edit product works
- [ ] Delete product works
- [ ] User list displays
- [ ] Order list displays

---

## 🐛 Bug Reporting Template

When you find a bug, create an issue with:

```markdown
## Bug Title

**Severity**: [Critical | High | Medium | Low]  
**Status**: Unverified | Verified | In Progress | Fixed

### Steps to Reproduce
1. [First step]
2. [Second step]
3. [Third step]

### Expected Result
[What should happen]

### Actual Result
[What actually happens]

### Environment
- Browser: [Chrome/Firefox/Safari]
- OS: [Windows/macOS/Linux]
- User Type: [Admin/User/Guest]

### Screenshots/Evidence
[Attach screenshots or video]

### Related AC
Fails acceptance criteria: [Link to 03_ECOMMERCE.md#AC-name]
```

---

## 📊 Test Metrics

| Metric | Target | Current |
|--------|--------|---------|
| Unit Test Coverage | 70%+ | [Run: `mvn jacoco:report`] |
| Acceptance Criteria Pass Rate | 100% | [Update after testing] |
| Critical Bug Count | 0 | [Track in issues] |
| Accessibility Issues | 0 | [Run: Axe DevTools] |
| Error Prevention Score | 100% | [Run: ERROR_PREVENTION.md checks] |

---

## 🔄 Testing Workflow

```
1. Developer commits code
   ↓
2. CI/CD runs unit tests (mvn test)
   ↓
3. If tests pass, deploy to staging
   ↓
4. QA runs acceptance tests
   ↓
5. QA runs accessibility tests
   ↓
6. QA runs error prevention checks
   ↓
7. If all pass, ready for production
   ↓
8. Deploy to production
```

---

## 📚 Complete Testing Documentation

### Detailed Guides
- [Test Strategy](./5_testing/TEST_STRATEGY.md) - Full testing approach
- [Error Prevention](./5_testing/ERROR_PREVENTION.md) - Prevent 403/404/500
- [Accessibility Testing](./5_testing/ACCESSIBILITY_TESTING.md) - WCAG compliance

### Requirements
- [Acceptance Criteria](./3_requirements/acceptance-criteria/) - Feature-by-feature AC
- [Features List](./3_requirements/FEATURES.md) - What to test

### Tools & Setup
- [Backend Guide](./4_development/BACKEND_GUIDE.md#testing) - Testing setup
- [TECH_STACK.md](./1_getting-started/TECH_STACK.md) - Test frameworks

---

## ❓ Common Questions

**Q: How do I run tests locally?**  
A: `mvn test` runs all tests. See [Running Tests](#running-tests) above.

**Q: How do I know what to test?**  
A: See [Acceptance Criteria](./3_requirements/acceptance-criteria/) for each feature.

**Q: Where do I write new unit tests?**  
A: Create file in `src/test/java/` following naming convention `*Test.java`.

**Q: How do I test a Servlet?**  
A: Use JUnit + mocked HttpServletRequest/Response. See [Backend Guide](./4_development/BACKEND_GUIDE.md#testing).

**Q: What's the accessibility standard?**  
A: WCAG 2.1 Level AA. See [Accessibility Testing](./5_testing/ACCESSIBILITY_TESTING.md).

**Q: How do I report a bug?**  
A: Use [Bug Reporting Template](#bug-reporting-template) above.

---

## 🎯 Your First Test

### Create Your First Unit Test

1. Navigate to: `src/test/java/service/`
2. Create file: `MyFirstTest.java`
3. Copy template:

```java
package service;

import static org.junit.Assert.*;
import org.junit.Before;
import org.junit.Test;

public class MyFirstTest {
    @Before
    public void setUp() {
        // Setup test data
    }
    
    @Test
    public void testSomething_GivenInput_ExpectOutput() {
        // Arrange
        String input = "test";
        
        // Act
        String output = input.toUpperCase();
        
        // Assert
        assertEquals("TEST", output);
    }
}
```

4. Run: `mvn test -Dtest=MyFirstTest`

---

## 📞 Getting Help

| Question | Answer |
|----------|--------|
| What are acceptance criteria? | [03_ECOMMERCE.md](./3_requirements/acceptance-criteria/03_ECOMMERCE.md) |
| How do I write a unit test? | [Test Strategy](./5_testing/TEST_STRATEGY.md) |
| How do I prevent 404 errors? | [Error Prevention](./5_testing/ERROR_PREVENTION.md) |
| Is the app accessible? | [Accessibility Testing](./5_testing/ACCESSIBILITY_TESTING.md) |
| Need full documentation index? | [Documentation Index](./INDEX.md) |

---

**Version**: 1.0.0  
**Status**: Published  
**Maintained By**: IoT Bay QA Team  
**Last Updated**: December 3, 2025
