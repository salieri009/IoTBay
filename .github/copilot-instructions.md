# IoTBay JSP Development Guidelines

## JSP File Structure

All JSP files must follow this structure:

### 1. Page Directives and Taglibs (No Indentation)
```jsp
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
<%@ page import="model.User" %>
```

### 2. Scriptlets (Proper Java Formatting)
```jsp
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"role".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
```

### 3. Layout Tag Usage
```jsp
<t:base>
    <jsp:attribute name="title">Page Title</jsp:attribute>
    <jsp:attribute name="customCSS">CSS file name</jsp:attribute>
    
    <jsp:body>
        <!-- Page content here -->
    </jsp:body>
</t:base>
```

### 4. Component Includes
```jsp
<jsp:include page="/components/atoms/button/button.jsp">
    <jsp:param name="text" value="Button Text" />
    <jsp:param name="type" value="primary" />
</jsp:include>
```

## Common Mistakes to Avoid

❌ **Nested Indentation of Directives**
```jsp
<%@ page ... %>
    <%@ taglib ... %>  <!-- WRONG -->
```

✅ **Correct**
```jsp
<%@ page ... %>
<%@ taglib ... %>
```

❌ **Inline Scriptlet Logic**
```jsp
<% User user=(User)session.getAttribute("user");if(user==null){...} %>
```

✅ **Correct**
```jsp
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        // Handle logic
    }
%>
```

❌ **Incorrect Redirect Path**
```jsp
response.sendRedirect("../../login.jsp");  // WRONG
```

✅ **Correct**
```jsp
response.sendRedirect(request.getContextPath() + "/login.jsp");
```

## Atomic Component Usage

### Button Component
```jsp
<jsp:include page="/components/atoms/button/button.jsp">
    <jsp:param name="text" value="Button Text" />
    <jsp:param name="type" value="primary|secondary|outline|ghost|danger" />
    <jsp:param name="size" value="small|default|large" />
</jsp:include>
```

### Badge Component
```jsp
<jsp:include page="/components/atoms/badge/badge.jsp">
    <jsp:param name="text" value="Badge Text" />
    <jsp:param name="type" value="success|warning|error|info" />
</jsp:include>
```

## File Naming Conventions

- WEB-INF/views: Admin/management pages
- Root webapp: Public-facing pages
- components/: Reusable atomic components
- Legacy files: Mark with `.legacy` extension
