# HTTP 403 Forbidden & 404 Not Found Error Prevention Checklist

This comprehensive checklist helps prevent and handle HTTP 403 Forbidden and 404 Not Found errors in the IoTBay web application. Use this checklist during pre-deployment QA and CI/CD pipeline validation.

**Quick Start - Automated Validation:**
```powershell
.\scripts\validate-403-404-prevention.ps1 -Verbose
```

This will automatically check many items in this checklist. See [scripts/README.md](../../scripts/README.md) for details.

**Priority Levels:**
- 🔴 **Critical**: Must be checked before any deployment
- 🟠 **High**: Should be verified in most deployments
- 🟡 **Medium**: Recommended for production deployments
- 🟢 **Low**: Best practice improvements

---

## 1. HTTP 403 Forbidden Error Prevention

### Authentication Verification
- [ ] 🔴 All protected endpoints verify user authentication before processing
- [ ] 🔴 Session validation checks for null session before accessing attributes
- [ ] 🔴 Session timeout handling redirects to login with appropriate message
- [ ] 🔴 Unauthenticated users are redirected to login page (not shown 403)
- [ ] 🟠 Session invalidation on logout is properly implemented
- [ ] 🟠 Session fixation prevention (new session on login)
- [ ] 🟡 Session attributes are validated for type safety (instanceof checks)

**Example Pattern:**
```java
HttpSession session = request.getSession(false);
if (session == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}

Object userObj = session.getAttribute("user");
if (!(userObj instanceof User)) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}
```

### Authorization Checks (Role-Based)
- [ ] 🔴 Role-based access control (RBAC) implemented for admin/staff endpoints
- [ ] 🔴 User roles are checked before allowing access to protected resources
- [ ] 🔴 Role checks use case-insensitive comparison (e.g., `"staff".equalsIgnoreCase(user.getRole())`)
- [ ] 🔴 Authorization checks occur before any resource access or processing
- [ ] 🟠 Role hierarchy is properly implemented (admin > staff > customer)
- [ ] 🟡 Role changes are validated and logged
- [ ] 🟡 Role-based UI elements are conditionally rendered

**Example Pattern:**
```java
private boolean isAdmin(HttpServletRequest request) {
    HttpSession session = request.getSession(false);
    if (session == null) return false;
    
    Object userObj = session.getAttribute("user");
    if (!(userObj instanceof User)) return false;
    
    User user = (User) userObj;
    return "staff".equalsIgnoreCase(user.getRole()) || 
           "admin".equalsIgnoreCase(user.getRole());
}

if (!isAdmin(request)) {
    utils.ErrorAction.handleAuthorizationError(request, response, "ControllerName.methodName");
    return;
}
```

### Authorization Checks (Resource-Based)
- [ ] 🔴 Users can only access their own resources (e.g., own orders, own profile)
- [ ] 🔴 Resource ownership is verified before allowing access
- [ ] 🔴 Cross-user data access is prevented
- [ ] 🟠 Resource-level permissions are checked for shared resources
- [ ] 🟡 Resource access is logged for audit purposes

**Example Pattern:**
```java
Order order = orderDAO.findById(orderId);
if (order.getUserId() != currentUser.getId() && 
    !"staff".equalsIgnoreCase(currentUser.getRole())) {
    utils.ErrorAction.handleAuthorizationError(request, response, "ControllerName.methodName");
    return;
}
```

### Access Control Patterns
- [ ] 🔴 Consistent authorization pattern used across all controllers
- [ ] 🔴 Authorization checks are centralized (e.g., `isAdmin()`, `isStaff()` methods)
- [ ] 🔴 Authorization failures use `ErrorAction.handleAuthorizationError()`
- [ ] 🟠 Authorization logic is not duplicated across controllers
- [ ] 🟡 Authorization can be easily extended for new roles/permissions

### CSRF Token Validation
- [ ] 🔴 CSRF tokens are validated for state-changing operations (POST, PUT, DELETE)
- [ ] 🔴 CSRF validation failures return appropriate error (403 or 400)
- [ ] 🔴 CSRF tokens are generated and included in forms
- [ ] 🟠 CSRF tokens are validated using `SecurityUtil.validateCSRFToken()`
- [ ] 🟡 CSRF token validation is logged for security monitoring

**Example Pattern:**
```java
if (!utils.SecurityUtil.validateCSRFToken(request)) {
    utils.ErrorAction.handleValidationError(request, response, 
        "CSRF token validation failed", "ControllerName.methodName");
    return;
}
```

### Rate Limiting Considerations
- [ ] 🟠 Rate limiting is implemented for sensitive endpoints
- [ ] 🟠 Rate limit exceeded returns 429 (Too Many Requests), not 403
- [ ] 🟡 Rate limiting is configured appropriately per endpoint
- [ ] 🟢 Rate limit headers are included in responses

### API Endpoint Protection
- [ ] 🔴 API endpoints require authentication unless explicitly public
- [ ] 🔴 API endpoints validate authorization for protected operations
- [ ] 🔴 API endpoints return proper HTTP status codes (401 for auth, 403 for authorization)
- [ ] 🟠 API endpoints use consistent error response format
- [ ] 🟡 API versioning is considered for authorization changes

### CSRF Protection
- [ ] 🔴 CSRF tokens are present in all state-changing forms (POST, PUT, DELETE)
- [ ] 🔴 CSRF tokens are validated on the server side
- [ ] 🔴 Missing or invalid CSRF tokens result in 403 Forbidden
- [ ] 🟠 AJAX requests include CSRF token in headers
- [ ] 🟡 CSRF protection is enabled for all authenticated sessions

### Role-Based Access Control (RBAC) Verification
- [ ] 🔴 Users cannot access admin pages by guessing URLs
- [ ] 🔴 Users cannot perform actions they are not authorized for (e.g., editing another user's profile)
- [ ] 🔴 Role checks are performed on the server side, not just client side (hiding buttons is not enough)
- [ ] 🟠 Access denied pages are user-friendly (explain why access is denied)
- [ ] 🟡 Role hierarchy is respected (e.g., Admin > Manager > User)

### Session Management
- [ ] 🔴 Session fixation protection is enabled (new session ID on login)
- [ ] 🔴 Sessions expire after inactivity
- [ ] 🔴 Expired sessions redirect to login page, not 403 error page (unless accessing API)
- [ ] 🟠 Concurrent session control is configured (if applicable)
- [ ] 🟡 Session cookies are HttpOnly and Secure

### File & Directory Permissions
- [ ] 🔴 Sensitive directories (e.g., `/WEB-INF`, `/META-INF`) are not directly accessible
- [ ] 🔴 Configuration files are not accessible via web browser
- [ ] 🔴 Upload directories do not allow execution of scripts
- [ ] 🟠 Directory listing is disabled in web server configuration
- [ ] 🟡 File permissions on the server are restrictive (least privilege)

---

## 2. HTTP 404 Not Found Error Prevention

### URL Routing Configuration
- [ ] 🔴 All servlet mappings in web.xml are correct and match controller classes
- [ ] 🔴 @WebServlet annotations match web.xml mappings (if both used)
- [ ] 🔴 URL patterns are consistent and follow naming conventions
- [ ] 🔴 No duplicate URL patterns exist
- [ ] 🟠 URL patterns use appropriate wildcards (*) where needed
- [ ] 🟡 URL patterns are documented

**Current Configuration:**
- Servlets mapped in web.xml: `/api/manage/products`, `/api/login`, `/product`, etc.
- @WebServlet annotations: `/admin/supplier/*`, `/manage/products/update`, etc.

### Servlet Mapping Verification
- [ ] 🔴 All servlet classes exist and are properly compiled
- [ ] 🔴 Servlet class names match web.xml servlet-class declarations
- [ ] 🔴 Servlet initialization doesn't fail silently
- [ ] 🟠 Servlet mappings are tested after deployment
- [ ] 🟡 Servlet mapping conflicts are resolved

### Path Parameter Validation
- [ ] 🔴 Path parameters (e.g., `/product/{id}`) are validated before use
- [ ] 🔴 Invalid path parameters return 404, not 500
- [ ] 🔴 Path parameters are sanitized to prevent path traversal
- [ ] 🟠 Path parameter format is validated (e.g., numeric IDs)
- [ ] 🟡 Path parameter validation uses SecurityUtil methods

**Example Pattern:**
```java
String pathInfo = request.getPathInfo();
if (pathInfo == null || pathInfo.isEmpty()) {
    response.sendError(HttpServletResponse.SC_NOT_FOUND);
    return;
}

// Extract and validate ID from path
String idStr = pathInfo.substring(1); // Remove leading /
try {
    int id = Integer.parseInt(idStr);
    // ... process with validated ID
} catch (NumberFormatException e) {
    response.sendError(HttpServletResponse.SC_NOT_FOUND);
    return;
}
```

### Resource Existence Checks
- [ ] 🔴 Database resources (products, users, orders) are checked for existence before access
- [ ] 🔴 Missing resources return 404, not 500 or 403
- [ ] 🔴 Resource existence checks occur before authorization checks
- [ ] 🟠 Resource existence is checked efficiently (single query when possible)
- [ ] 🟡 Resource existence errors are logged

**Example Pattern:**
```java
Product product = productDAO.getProductById(productId);
if (product == null) {
    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
    return;
}
// ... continue with existing product
```

### File and Static Resource Management
- [ ] 🔴 Static resources (CSS, JS, images) are in correct directories
- [ ] 🔴 Static resource paths are correct and accessible
- [ ] 🔴 Missing static resources don't cause 500 errors
- [ ] 🟠 Static resource paths use context path correctly
- [ ] 🟡 Static resources are versioned to prevent caching issues

### API Endpoint Validation
- [ ] 🔴 API endpoints validate HTTP methods (GET, POST, PUT, DELETE)
- [ ] 🔴 Unsupported HTTP methods return 405 (Method Not Allowed), not 404
- [ ] 🔴 API versioning is handled correctly (`/api/v1/...`)
- [ ] 🟠 API endpoints return consistent 404 format
- [ ] 🟡 API endpoint documentation is up to date

### JSP & View Layer Verification
- [ ] 🔴 All JSP files referenced in `RequestDispatcher.forward()` actually exist
- [ ] 🔴 View paths in controllers match the actual project structure (e.g., `/WEB-INF/views/...`)
- [ ] 🔴 JSP includes (`<jsp:include>`, `<%@ include %>`) reference existing files
- [ ] 🟠 View resolution logic handles missing views gracefully (logs error, shows 404)
- [ ] 🟡 Unused JSP files are removed to avoid confusion

**Example Pattern:**
```java
// Verify this path exists in your project structure
request.getRequestDispatcher("/WEB-INF/views/product-detail.jsp").forward(request, response);
```

### Deployment & Environment Verification
- [ ] 🔴 WAR file structure matches expectation (classes in `WEB-INF/classes`, libs in `WEB-INF/lib`)
- [ ] 🔴 Case sensitivity is checked (Windows is case-insensitive, Linux is case-sensitive)
- [ ] 🔴 Deployment context path matches application configuration
- [ ] 🟠 Build process verifies existence of critical resources
- [ ] 🟡 Environment-specific configuration (dev vs prod) doesn't cause 404s

### Welcome File Configuration
- [ ] 🔴 `web.xml` contains correct `<welcome-file-list>` configuration
- [ ] 🔴 Welcome files (index.jsp, index.html) exist in the web root
- [ ] 🔴 Directory access without welcome file is handled (usually 403 or 404, not directory listing)
- [ ] 🟠 Default servlet is configured correctly

### Context Path Handling
- [ ] 🔴 All internal links use `${pageContext.request.contextPath}` or `<c:url>`
- [ ] 🔴 JavaScript AJAX calls dynamically determine context path
- [ ] 🔴 Redirects include context path: `response.sendRedirect(request.getContextPath() + "/...")`
- [ ] 🟠 CSS/JS references use absolute paths with context root
- [ ] 🟡 Hardcoded paths starting with `/` are avoided unless relative to context root

### Filter Interception
- [ ] 🔴 Filters don't accidentally block valid resources (causing 404 or 403)
- [ ] 🔴 Filter mappings are specific enough to avoid intercepting static resources
- [ ] 🔴 Filters pass control to the next filter in chain (`chain.doFilter()`)
- [ ] 🟠 Filter ordering is correct (e.g., authentication before authorization)
- [ ] 🟡 Filter exclusions are configured for public resources

---

## 3. Authentication & Authorization Best Practices

### Session Management
- [ ] 🔴 Sessions are created only when needed (use `getSession(false)` for checks)
- [ ] 🔴 Session timeout is configured appropriately (currently 30 minutes)
- [ ] 🔴 Session invalidation occurs on logout
- [ ] 🔴 Session attributes are cleared on logout
- [ ] 🟠 Session fixation is prevented (new session ID on login)
- [ ] 🟡 Session size is monitored to prevent memory issues

**Current Configuration:**
- `security.session.timeout=30` (minutes in application.properties)

### Role-Based Access Control (RBAC)
- [ ] 🔴 User roles are stored securely in database
- [ ] 🔴 Role assignments are validated
- [ ] 🔴 Role checks are consistent across application
- [ ] 🟠 Role hierarchy is properly implemented
- [ ] 🟡 Role changes are logged for audit

**Current Roles:**
- `admin` - Full access
- `staff` - Administrative access
- `customer` - Standard user access

### Permission Checks
- [ ] 🔴 Permissions are checked at method/endpoint level
- [ ] 🔴 Permission checks occur before resource access
- [ ] 🔴 Permission failures are logged
- [ ] 🟠 Permissions are granular enough for security needs
- [ ] 🟡 Permission system is extensible

### User Enumeration Prevention
- [ ] 🔴 Authentication errors don't reveal if user exists
- [ ] 🔴 Generic error messages used for login failures
- [ ] 🔴 Registration errors don't reveal existing users
- [ ] 🟠 Password reset doesn't reveal user existence
- [ User enumeration attempts are logged

**Current Pattern:**
```java
// Generic error message to prevent user enumeration
String genericError = "Invalid login credentials";
// Use same message whether user exists or not
```

### Secure Error Messages
- [ ] 🔴 Error messages don't reveal system internals
- [ ] 🔴 403 errors don't reveal why access was denied (specific resource/permission)
- [ ] 🔴 404 errors don't reveal what resources exist
- [ ] 🟠 Error messages are user-friendly but generic
- [ ] 🟡 Detailed errors are logged server-side only

### Token Validation
- [ ] 🟠 CSRF tokens are validated for state-changing operations
- [ ] 🟠 Token expiration is handled appropriately
- [ ] 🟡 Token format is validated
- [ ] 🟢 Token rotation is implemented (if applicable)

---

## 4. URL Routing & Navigation

### Route Configuration (web.xml, @WebServlet)
- [ ] 🔴 All routes are properly configured in web.xml or @WebServlet
- [ ] 🔴 No conflicting route patterns exist
- [ ] 🔴 Route patterns match actual controller implementations
- [ ] 🟠 Route patterns follow consistent naming conventions
- [ ] 🟡 Routes are documented

**Current Patterns:**
- API routes: `/api/*`, `/api/v1/*`
- Admin routes: `/admin/*`, `/manage/*`
- Public routes: `/product`, `/search`, `/cart`

### Path Parameter Handling
- [ ] 🔴 Path parameters are extracted correctly from request.getPathInfo()
- [ ] 🔴 Path parameters are validated before use
- [ ] 🔴 Invalid path parameters return 404
- [ ] 🟠 Path parameter extraction handles edge cases (null, empty, malformed)
- [ ] 🟡 Path parameters are sanitized

**Example Pattern:**
```java
String pathInfo = request.getPathInfo();
if (pathInfo == null || pathInfo.isEmpty()) {
    response.sendError(HttpServletResponse.SC_NOT_FOUND);
    return;
}
// Extract ID from /view/123 -> 123
String[] parts = pathInfo.split("/");
if (parts.length < 2) {
    response.sendError(HttpServletResponse.SC_NOT_FOUND);
    return;
}
```

### Query Parameter Validation
- [ ] 🔴 Query parameters are validated using SecurityUtil methods
- [ ] 🔴 Missing required query parameters return 400, not 404
- [ ] 🔴 Invalid query parameter values return 400
- [ ] 🟠 Query parameters are sanitized
- [ ] 🟡 Query parameter validation is consistent

### URL Canonicalization
- [ ] 🟠 URLs are normalized (trailing slashes, case)
- [ ] 🟠 Canonical URLs redirect to preferred form
- [ ] 🟡 URL encoding is handled correctly
- [ ] 🟢 URL canonicalization prevents duplicate content issues

### Case Sensitivity Handling
- [ ] 🟡 URL case sensitivity is consistent
- [ ] 🟡 Case-insensitive matching is used where appropriate
- [ ] 🟢 Case sensitivity is documented

### Trailing Slash Handling
- [ ] 🟡 Trailing slash behavior is consistent
- [ ] 🟡 Trailing slash redirects are implemented if needed
- [ ] 🟢 Trailing slash policy is documented

---

## 5. Broken Link Detection & Prevention

### Internal Link Validation
- [ ] 🔴 All internal links in JSP pages are validated
- [ ] 🔴 Internal links use correct context path
- [ ] 🔴 Internal links don't reference non-existent pages
- [ ] 🟠 Internal links are tested during QA
- [ ] 🟡 Internal link validation is automated where possible

**Example Pattern:**
```jsp
<a href="<%= request.getContextPath() %>/product?id=<%= product.getId() %>">
    View Product
</a>
```

### External Link Checking
- [ ] 🟡 External links are validated periodically
- [ ] 🟡 External links open in new tabs (target="_blank")
- [ ] 🟡 External links use rel="noopener noreferrer"
- [ ] 🟢 External link checking is automated

### Resource Path Verification
- [ ] 🔴 Image paths are correct and files exist
- [ ] 🔴 CSS file paths are correct
- [ ] 🔴 JavaScript file paths are correct
- [ ] 🟠 Resource paths use context path correctly
- [ ] 🟡 Resource paths are relative or use absolute paths consistently

### Image/CSS/JS File References
- [ ] 🔴 All referenced image files exist
- [ ] 🔴 All referenced CSS files exist
- [ ] 🔴 All referenced JavaScript files exist
- [ ] 🟠 File references use versioning or cache busting
- [ ] 🟡 Missing file references are caught during build

### Dynamic Link Generation
- [ ] 🔴 Dynamically generated links are validated
- [ ] 🔴 Dynamic links use proper URL encoding
- [ ] 🔴 Dynamic links don't create broken references
- [ ] 🟠 Dynamic link generation is tested
- [ ] 🟡 Dynamic links are logged for debugging

### Link Maintenance Strategies
- [ ] 🟡 Link checking is part of CI/CD pipeline
- [ ] 🟡 Broken links are tracked and fixed
- [ ] 🟡 Link maintenance process is documented
- [ ] 🟢 Automated link checking tools are used

---

## 6. Redirect Strategies

### 301 vs 302 Redirects
- [ ] 🟠 Permanent redirects (301) are used for moved resources
- [ ] 🟠 Temporary redirects (302) are used for login redirects
- [ ] 🟡 Redirect type is appropriate for use case
- [ ] 🟢 Redirect type is documented

**Example Pattern:**
```java
// 302 redirect for login (temporary)
response.sendRedirect(request.getContextPath() + "/login.jsp");

// 301 redirect for moved resource (permanent)
response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
response.setHeader("Location", newUrl);
```

### Redirect Loops Prevention
- [ ] 🔴 Redirect loops are prevented (max redirect count)
- [ ] 🔴 Post-login redirects don't create loops
- [ ] 🔴 Error page redirects don't create loops
- [ ] 🟠 Redirect targets are validated
- [ ] 🟡 Redirect loops are logged and monitored

### Post-Login Redirects
- [ ] 🔴 Post-login redirects go to intended destination
- [ ] 🔴 Post-login redirects validate destination is safe
- [ ] 🔴 Post-login redirects don't expose sensitive URLs
- [ ] 🟠 Post-login redirects use returnUrl parameter safely
- [ ] 🟡 Post-login redirects are logged

**Current Pattern:**
```java
// After successful login
response.sendRedirect(request.getContextPath() + "/index.jsp");
```

### Error Page Redirects
- [ ] 🔴 Error page redirects use ErrorAction utility
- [ ] 🔴 Error page redirects don't expose error details
- [ ] 🔴 Error page redirects are user-friendly
- [ ] 🟠 Error page redirects provide navigation options
- [ ] 🟡 Error page redirects are logged

### Canonical URL Redirects
- [ ] 🟡 Canonical URLs redirect to preferred form
- [ ] 🟡 WWW vs non-WWW redirects are configured
- [ ] 🟡 HTTPS redirects are configured
- [ ] 🟢 Canonical redirects are tested

### Security Considerations
- [ ] 🔴 Redirects don't allow open redirects (redirect to external sites)
- [ ] 🔴 Redirect URLs are validated before redirecting
- [ ] 🔴 Redirect URLs are whitelisted or validated
- [ ] 🟠 Redirect security is tested
- [ ] 🟡 Redirect attempts are logged

**Security Pattern:**
```java
String returnUrl = request.getParameter("returnUrl");
if (returnUrl != null) {
    // Validate returnUrl is internal
    if (!returnUrl.startsWith(request.getContextPath()) && 
        !returnUrl.startsWith("/")) {
        returnUrl = request.getContextPath() + "/index.jsp";
    }
    response.sendRedirect(returnUrl);
}
```

---

## 7. User-Friendly Error Pages

### 403 Error Page Design
- [ ] 🔴 403 error page exists and is accessible
- [ ] 🔴 403 error page is configured in web.xml
- [ ] 🔴 403 error page provides clear, user-friendly message
- [ ] 🔴 403 error page doesn't reveal why access was denied
- [ ] 🟠 403 error page provides navigation options (home, back, contact)
- [ ] 🟡 403 error page suggests contacting administrator if needed
- [ ] 🟡 403 error page is styled consistently with application

**Current Configuration:**
- 403 errors use `/error.jsp` (configured via ErrorAction.handleAuthorizationError)

### 404 Error Page Design
- [ ] 🔴 404 error page exists and is accessible
- [ ] 🔴 404 error page is configured in web.xml
- [ ] 🔴 404 error page provides clear, user-friendly message
- [ ] 🔴 404 error page doesn't reveal what resources exist
- [ ] 🟠 404 error page provides navigation options (home, search, sitemap)
- [ ] 🟡 404 error page suggests common pages or search
- [ ] 🟡 404 error page is styled consistently with application

**Current Configuration:**
```xml
<error-page>
    <error-code>404</error-code>
    <location>/error.jsp</location>
</error-page>
```

### Error Page Messaging
- [ ] 🔴 Error messages are user-friendly and clear
- [ ] 🔴 Error messages don't expose technical details
- [ ] 🔴 Error messages are consistent across error types
- [ ] 🟠 Error messages provide actionable guidance
- [ ] 🟡 Error messages are localized (if applicable)

### Navigation Options
- [ ] 🟠 Error pages provide "Go Home" link
- [ ] 🟠 Error pages provide "Go Back" button
- [ ] 🟠 Error pages provide "Contact Support" link (for 403)
- [ ] 🟡 Error pages provide search functionality (for 404)
- [ ] 🟡 Error pages provide sitemap link (for 404)

### Search Functionality
- [ ] 🟡 404 page includes search box
- [ ] 🟡 404 page suggests popular pages
- [ ] 🟡 404 page provides category links
- [ ] 🟢 404 page uses analytics to suggest relevant pages

### Helpful Suggestions
- [ ] 🟡 404 page suggests checking URL spelling
- [ ] 🟡 404 page suggests using search
- [ ] 🟡 404 page provides links to common pages
- [ ] 🟢 404 page uses machine learning for suggestions

---

## 8. Frontend Considerations

### Client-Side Routing
- [ ] 🟡 Client-side routes match server-side routes
- [ ] 🟡 Client-side 404 handling is implemented (if SPA)
- [ ] 🟡 Client-side route validation occurs
- [ ] 🟢 Client-side routing is tested

### Link Validation
- [ ] 🟠 Frontend links are validated before navigation
- [ ] 🟠 Broken links are caught during development
- [ ] 🟡 Link validation is automated
- [ ] 🟢 Link validation is part of build process

### Form Action URLs
- [ ] 🔴 Form action URLs are correct and exist
- [ ] 🔴 Form action URLs use correct HTTP methods
- [ ] 🟠 Form action URLs are validated
- [ ] 🟡 Form action URLs are tested

### AJAX Endpoint Handling
- [ ] 🔴 AJAX endpoints handle 403/404 errors gracefully
- [ ] 🔴 AJAX error responses are user-friendly
- [ ] 🟠 AJAX endpoints validate authentication
- [ ] 🟡 AJAX error handling is consistent

### SPA Routing (if applicable)
- [ ] 🟡 SPA routes are protected client-side
- [ ] 🟡 SPA 404 handling is implemented
- [ ] 🟡 SPA routes match backend API routes
- [ ] 🟢 SPA routing is tested

### Error Boundary Handling
- [ ] 🟡 Frontend error boundaries catch 403/404 errors
- [ ] 🟡 Error boundaries provide user-friendly messages
- [ ] 🟡 Error boundaries log errors appropriately
- [ ] 🟢 Error boundaries are tested

---

## 9. Backend Considerations

### Servlet Mapping
- [ ] 🔴 All servlets are properly mapped in web.xml
- [ ] 🔴 @WebServlet annotations are correct
- [ ] 🔴 Servlet mappings don't conflict
- [ ] 🟠 Servlet mappings are tested
- [ ] 🟡 Servlet mapping documentation is up to date

### Filter Configuration
- [ ] 🟠 Security filters are configured correctly
- [ ] 🟠 Authentication filters are applied to protected resources
- [ ] 🟡 Filter order is correct
- [ ] 🟡 Filter configuration is tested

### Security Constraints
- [ ] 🟠 Security constraints are defined in web.xml (if used)
- [ ] 🟠 Security constraints match servlet mappings
- [ ] 🟡 Security constraints are tested
- [ ] 🟢 Security constraints are documented

### Resource Protection
- [ ] 🔴 Protected resources require authentication
- [ ] 🔴 Protected resources check authorization
- [ ] 🔴 Resource protection is consistent
- [ ] 🟠 Resource protection is tested
- [ ] 🟡 Resource protection is documented

### API Versioning
- [ ] 🟡 API versioning is implemented (`/api/v1/...`)
- [ ] 🟡 Old API versions return appropriate errors
- [ ] 🟡 API versioning is documented
- [ ] 🟢 API versioning strategy is defined

### Endpoint Documentation
- [ ] 🟡 API endpoints are documented
- [ ] 🟡 Endpoint documentation includes authentication requirements
- [ ] 🟡 Endpoint documentation includes possible error codes
- [ ] 🟢 Endpoint documentation is up to date

---

## 10. Testing & Validation

### Manual Testing Scenarios
- [ ] 🔴 Test accessing protected resource without authentication (should redirect to login)
- [ ] 🔴 Test accessing protected resource with wrong role (should return 403)
- [ ] 🔴 Test accessing non-existent resource (should return 404)
- [ ] 🔴 Test accessing resource with invalid ID (should return 404)
- [ ] 🟠 Test all internal links for validity
- [ ] 🟠 Test redirect flows (login, logout, errors)
- [ ] 🟡 Test edge cases (malformed URLs, special characters)
- [ ] 🟡 Test authorization edge cases (role changes, resource ownership)

### Automated Link Checking
- [ ] 🟡 Automated link checking is implemented
- [ ] 🟡 Broken links are detected automatically
- [ ] 🟡 Link checking is part of CI/CD pipeline
- [ ] 🟢 Link checking tools are configured

### Authorization Testing
- [ ] 🔴 Authorization tests cover all roles
- [ ] 🔴 Authorization tests cover all protected endpoints
- [ ] 🔴 Authorization tests verify 403 responses
- [ ] 🟠 Authorization tests are automated
- [ ] 🟡 Authorization tests cover edge cases

### URL Testing
- [ ] 🔴 All URL patterns are tested
- [ ] 🔴 Invalid URLs return appropriate errors
- [ ] 🔴 Path parameters are tested
- [ ] 🟠 URL testing is automated
- [ ] 🟡 URL edge cases are tested

### Edge Case Testing
- [ ] 🟠 Very long URLs are handled
- [ ] 🟠 Special characters in URLs are handled
- [ ] 🟠 Unicode characters in URLs are handled
- [ ] 🟠 Malformed URLs are handled
- [ ] 🟡 Edge cases are documented

### Security Testing
- [ ] 🔴 Authorization bypass attempts are tested
- [ ] 🔴 Path traversal attempts are tested
- [ ] 🔴 Open redirect attempts are tested
- [ ] 🟠 Security testing is automated
- [ ] 🟡 Security testing covers OWASP Top 10

---

## 11. CI/CD Integration

### Link Checking in Pipeline
- [ ] 🟡 Link checking is part of CI/CD pipeline
- [ ] 🟡 Broken links fail the build (or warn)
- [ ] 🟡 Link checking tools are configured
- [ ] 🟢 Link checking reports are generated

### Route Validation
- [ ] 🟡 Route validation is part of CI/CD pipeline
- [ ] 🟡 Route conflicts are detected
- [ ] 🟡 Route validation is automated
- [ ] 🟢 Route validation reports are generated

### Security Scanning
- [ ] 🟠 Security scanning includes 403/404 handling
- [ ] 🟠 Authorization vulnerabilities are detected
- [ ] 🟡 Security scanning is automated
- [ ] 🟢 Security scanning reports are reviewed

### Broken Link Detection
- [ ] 🟡 Broken link detection is automated
- [ ] 🟡 Broken links are reported
- [ ] 🟡 Broken link detection is part of deployment
- [ ] 🟢 Broken link detection tools are configured

### Automated Testing
- [ ] 🔴 Unit tests cover authorization logic
- [ ] 🔴 Integration tests cover 403/404 scenarios
- [ ] 🟠 Tests are run in CI/CD pipeline
- [ ] 🟡 Test coverage meets thresholds
- [ ] 🟢 Test results are reported

---

## 12. Monitoring & Logging

### 403/404 Error Tracking
- [ ] 🟠 403 error rate is monitored
- [ ] 🟠 404 error rate is monitored
- [ ] 🟠 Error trends are tracked over time
- [ ] 🟡 Error categorization is implemented
- [ ] 🟢 Error dashboards are available

### Access Attempt Logging
- [ ] 🔴 Failed authorization attempts are logged
- [ ] 🔴 Access attempts include user, resource, IP, timestamp
- [ ] 🟠 Access attempt logs are reviewed regularly
- [ ] 🟡 Access attempt patterns are analyzed
- [ ] 🟢 Access attempt alerts are configured

**Current Pattern:**
```java
logger.warning(String.format("[AUTHORIZATION_ERROR] Context: %s, IP: %s, User: %s",
    logContext, getClientIP(request), getCurrentUser(request)));
```

### Security Event Logging
- [ ] 🔴 Security events (403, unauthorized access) are logged
- [ ] 🔴 Security logs include sufficient context
- [ ] 🟠 Security logs are stored securely
- [ ] 🟡 Security log analysis is performed
- [ ] 🟢 Security log retention policy is defined

### Error Rate Monitoring
- [ ] 🟠 403 error rate alerts are configured
- [ ] 🟠 404 error rate alerts are configured
- [ ] 🟡 Error rate thresholds are defined
- [ ] 🟡 Error rate trends are analyzed
- [ ] 🟢 Error rate dashboards are available

### Alert Configuration
- [ ] 🟠 Alerts are configured for high 403 rates
- [ ] 🟠 Alerts are configured for high 404 rates
- [ ] 🟡 Alert thresholds are appropriate
- [ ] 🟡 Alert recipients are configured
- [ ] 🟢 Alert escalation process is defined

**Suggested Alert Thresholds:**
- 403 error rate > 5% of authenticated requests
- 404 error rate > 10% of total requests
- Unusual 403 patterns (potential attack)
- Unusual 404 patterns (broken links)

---

## Quick Reference: Common 403/404 Error Causes

### 403 Forbidden Common Causes
- Missing or invalid authentication: Check session, login status
- Insufficient permissions: Check user role, resource ownership
- CSRF token failure: Check CSRF token validation
- Session expired: Check session timeout configuration
- Authorization logic error: Check isAdmin(), isStaff() methods

### 404 Not Found Common Causes
- Incorrect URL pattern: Check web.xml and @WebServlet mappings
- Missing servlet mapping: Check servlet configuration
- Invalid path parameter: Check path parameter extraction and validation
- Resource doesn't exist: Check database query results
- Static resource missing: Check file paths and existence
- Typo in URL: Check link generation and user input

---

## Checklist Usage

### Automated Validation

**Quick Start:**
```powershell
# Run automated validation script
.\scripts\validate-403-404-prevention.ps1 -Verbose
```

The automated validation script checks many items automatically:
- Authentication verification patterns
- Authorization checks in admin controllers
- ErrorAction usage for 403 errors
- Servlet mapping configuration
- Path parameter validation
- Resource existence checks
- Error page configuration
- CSRF token validation
- Redirect security
- Type safety (instanceof checks)

See [scripts/README.md](../../scripts/README.md) for details.

### Pre-Deployment
1. **Run automated validation script** (see above)
2. Review all Critical (🔴) items manually
3. Review all High (🟠) items relevant to your changes
4. Complete manual testing of authorization and routing
5. Run automated tests
6. Verify error pages are accessible

### CI/CD Integration
- **Add validation script to pipeline** (see scripts/README.md)
- Automate Critical items where possible
- Include High-priority checks in pipeline
- Generate reports from checklist results
- Integrate link checking and route validation

**Example CI/CD Integration:**
```yaml
- name: Validate 403/404 Error Prevention
  run: pwsh -File scripts/validate-403-404-prevention.ps1 -Verbose
```

### Post-Incident Review
- Use checklist to identify root cause
- Add new items based on incident learnings
- Update priorities based on actual issues
- Review and update error handling patterns

---

## Notes

- This checklist is specific to the IoTBay application architecture
- Update checklist as application evolves
- Share learnings and improvements with team
- Regular review and update of checklist items
- Coordinate with 500 Error Prevention Checklist for comprehensive error handling

**Last Updated:** 2025-01-XX
**Application Version:** 1.0.0
**Related Checklists:** [500 Error Prevention Checklist](./500_ERROR_PREVENTION_CHECKLIST.md)

