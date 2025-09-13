<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

<%
    String contextPath = request.getContextPath();
    String errorMessage = (String) request.getAttribute("errorMessage");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In - IoT Bay</title>
    <meta name="description" content="Sign in to your IoT Bay account">
    <link rel="stylesheet" href="<%= contextPath %>/css/modern-theme.css">
</head>
<body>
    <main class="min-h-screen flex items-center justify-center bg-neutral-50 py-12 px-4">
        <div class="max-w-md w-full">
            <div class="card p-8">
                <div class="text-center mb-6">
                    <h1 class="text-2xl font-bold text-neutral-900 mb-2">Welcome Back</h1>
                    <p class="text-neutral-600">Sign in to your IoT Bay account</p>
                </div>
                
                <% if (errorMessage != null) { %>
                <div class="alert alert--error mb-6">
                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd"></path>
                    </svg>
                    <span><%= errorMessage %></span>
                </div>
                <% } %>
                
                <form class="space-y-6" method="post" action="<%= contextPath %>/api/login">
                    <div class="form-group">
                        <label for="email" class="form-label">Email Address</label>
                        <input type="email" id="email" name="email" class="form-input" 
                               placeholder="Enter your email" required />
                    </div>
                    
                    <div class="form-group">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" id="password" name="password" class="form-input" 
                               placeholder="Enter your password" required />
                    </div>
                    
                    <div class="flex items-center justify-between">
                        <label class="checkbox">
                            <input type="checkbox" name="remember" class="checkbox__input">
                            <span class="checkbox__mark"></span>
                            <span class="checkbox__label">Remember me</span>
                        </label>
                        <a href="forgot-password.jsp" class="text-sm text-brand-primary hover:text-brand-primary-600">Forgot password?</a>
                    </div>
                    
                    <input type="hidden" name="source" value="logins" />
                    <button type="submit" class="btn btn--primary btn--full">Sign In</button>
                </form>
                
                <div class="mt-6 text-center">
                    <p class="text-sm text-neutral-600">Don't have an account? <a href="register.jsp" class="text-brand-primary hover:text-brand-primary-600 font-medium">Sign up</a></p>
                </div>
            </div>
        </div>
    </main>

    <script src="<%= contextPath %>/js/main.js"></script>
</body>
</html>