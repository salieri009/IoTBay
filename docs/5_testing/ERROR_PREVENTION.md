# HTTP Error Prevention Guide

This guide helps prevent HTTP 403, 404, and 500 errors in the IoT Bay application. Use this during development, testing, and deployment.

**Status Scripts**:
- Linux/Mac: `./scripts/validate-403-404-prevention.sh`
- Windows: `.\\scripts\\validate-403-404-prevention.ps1`

---

## 🎯 Error Overview

| Error | Meaning | When to Use | How to Fix |
|---|---|---|---|
| **403 Forbidden** | User authenticated but not authorized | Insufficient permissions | Check user role/permissions |
| **404 Not Found** | Resource doesn't exist | URL/resource missing | Verify paths and resources exist |
| **500 Server Error** | Unexpected error occurred | Code exception | Check logs, fix bug |

---

## 🔐 Preventing 403 Forbidden

### Authentication Checks

- [ ] All protected endpoints verify user authentication
- [ ] Session validation checks for null session
- [ ] Session timeout redirects to login (not 403)
- [ ] Unauthenticated users go to login (not 403)
- [ ] Session invalidation works on logout

**Pattern**:
```java
HttpSession session = request.getSession(false);
if (session == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}

User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}
```

### Authorization Checks

- [ ] Role-based access control (RBAC) for admin/staff
- [ ] User roles checked before resource access
- [ ] Admin > Staff > Customer role hierarchy
- [ ] Users can only access own resources
- [ ] Resource ownership verified before access
- [ ] Cross-user data access prevented

**Pattern**:
```java
if (!"admin".equalsIgnoreCase(user.getRole())) {
    response.sendError(HttpServletResponse.SC_FORBIDDEN, 
        "Insufficient permissions");
    return;
}

// For resource ownership
Order order = orderDAO.findById(orderId);
if (order.getUserId() != user.getId() && 
    !"admin".equalsIgnoreCase(user.getRole())) {
    response.sendError(HttpServletResponse.SC_FORBIDDEN, 
        "Cannot access other users' resources");
    return;
}
```

### CSRF Protection

- [ ] CSRF tokens present in state-changing forms (POST, PUT, DELETE)
- [ ] CSRF tokens validated on server side
- [ ] Invalid tokens result in 403 Forbidden
- [ ] AJAX requests include CSRF token in headers

**Pattern**:
```jsp
<!-- In forms -->
<input type="hidden" name="csrfToken" value="${csrfToken}"/>

<!-- JavaScript AJAX -->
fetch('/api/endpoint', {
    method: 'POST',
    headers: {
        'X-CSRF-Token': document.querySelector('[name=csrfToken]').value
    }
});
```

### Session Security

- [ ] Session fixation prevention (new session on login)
- [ ] Session expiration configured
- [ ] Session cookies are HttpOnly and Secure
- [ ] Session invalidation on logout
- [ ] Concurrent session control if applicable

---

## 🔍 Preventing 404 Not Found

### JSP/View Files

- [ ] All JSP files referenced in controllers exist
- [ ] JSP include statements reference existing files
- [ ] View paths match actual project structure
- [ ] `RequestDispatcher.forward()` paths exist

**Check**:
```bash
# Verify JSP exists
find src/main/webapp -name "*.jsp" | grep "product-detail"

# View path example
src/main/webapp/WEB-INF/views/product-detail.jsp
```

### URL Routing

- [ ] All URL patterns in controllers map to existing resources
- [ ] Context path is correctly handled
- [ ] Redirect URLs include context path

**Pattern**:
```java
// ✅ Correct - includes context path
response.sendRedirect(request.getContextPath() + "/home.jsp");

// ❌ Wrong - missing context path
response.sendRedirect("/home.jsp");
```

### Static Resources

- [ ] CSS, JS, images exist at referenced paths
- [ ] Resources use correct context path
- [ ] Typos in resource paths fixed

**In JSP**:
```jsp
<!-- ✅ Correct -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<img src="${pageContext.request.contextPath}/images/logo.png">

<!-- ❌ Wrong - hardcoded paths -->
<link rel="stylesheet" href="/css/style.css">
```

### Web Application Configuration

- [ ] `web.xml` contains correct `<welcome-file-list>`
- [ ] Welcome files (index.jsp, index.html) exist
- [ ] Servlet/JSP mappings are correct
- [ ] Filter mappings don't block valid resources

**web.xml example**:
```xml
<welcome-file-list>
    <welcome-file>index.jsp</welcome-file>
    <welcome-file>index.html</welcome-file>
</welcome-file-list>
```

### Database Checks

- [ ] Resource IDs are validated before lookup
- [ ] Null results handled with appropriate error page
- [ ] Invalid IDs result in 404, not 500

**Pattern**:
```java
Product product = productDAO.findById(productId);
if (product == null) {
    response.sendError(HttpServletResponse.SC_NOT_FOUND, 
        "Product not found");
    return;
}
```

---

## ⚠️ Preventing 500 Server Error

### Exception Handling

- [ ] Null pointer exceptions prevented (null checks)
- [ ] Type casting checked before use
- [ ] Array bounds checked
- [ ] Exception handling logs errors

**Pattern**:
```java
try {
    Object obj = session.getAttribute("user");
    if (obj == null || !(obj instanceof User)) {
        // Handle gracefully
        response.sendRedirect("/login.jsp");
        return;
    }
    
    User user = (User) obj;
    // Safe to use user
} catch (Exception e) {
    logger.error("Unexpected error", e);
    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
}
```

### Resource Management

- [ ] Database connections closed properly
- [ ] Input streams closed
- [ ] Try-with-resources used for auto-closing

**Pattern**:
```java
try (Connection conn = pool.getConnection()) {
    // Use connection
} catch (SQLException e) {
    logger.error("Database error", e);
    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
}
```

### Input Validation

- [ ] User input validated before use
- [ ] Type conversions checked
- [ ] File operations validated
- [ ] Database operations checked

---

## ✅ Pre-Deployment Checklist

### 403 Errors
- [ ] All admin endpoints require admin role
- [ ] Users can only access own data
- [ ] CSRF tokens in all forms
- [ ] Session timeout redirects to login

### 404 Errors
- [ ] All JSP files exist at referenced paths
- [ ] All static resources exist
- [ ] URLs include context path
- [ ] Welcome files configured
- [ ] Invalid IDs return 404 (not 500)

### 500 Errors
- [ ] Null pointer exceptions prevented
- [ ] Exception handling in place
- [ ] Logging configured
- [ ] Resource cleanup (connections, streams)

---

## 🧪 Testing Error Prevention

### Manual Testing

```bash
# Test 403 - Access admin page without permissions
# Should redirect to login or show error page, not 403

# Test 404 - Visit non-existent page
# Should show friendly 404 page

# Test 500 - Break something intentionally
# Should show error page with ID for support
```

### Automated Testing

```bash
# Run validation scripts
./scripts/validate-403-404-prevention.ps1 -Verbose

# Check logs for errors
tail -f target/logs/application.log
```

---

## 📊 Error Reporting

When errors occur:
1. Log with error ID: `ERROR [ID-12345]: Description`
2. Show user-friendly message (not stack trace)
3. Provide error ID for support team
4. Track metrics for trending issues

---

## 🔗 Related Documentation

- [Testing Guide](./TEST_STRATEGY.md)
- [Security Architecture](../2_architecture/SECURITY_ARCHITECTURE.md)
- [Backend Guide](../4_development/BACKEND_GUIDE.md)

---

**Last Updated**: December 3, 2025  
**Version**: 1.0.0


---

**Document Version**: 1.0.0
**Status**: Published
**Audience**: Developers, Stakeholders
**Maintained By**: IoT Bay Documentation Team
