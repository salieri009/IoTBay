<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ page import="model.User" %>
<%
    // Staff authorization check
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"staff".equalsIgnoreCase(currentUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    // Redirect to admin dashboard
    response.sendRedirect(request.getContextPath() + "/admin-dashboard");
%>

