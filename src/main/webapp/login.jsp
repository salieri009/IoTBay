<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
<t:base title="Sign In" description="Sign in to your IoT Bay account">

    <main class="auth-page">
        <div class="container">
            <div class="auth-card">
                <div class="auth-card__header">
                    <h1 class="auth-card__title">Welcome Back</h1>
                    <p class="auth-card__subtitle">Sign in to your IoT Bay account</p>
                </div>
                
                <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
                <% if (errorMessage != null) { %>
                <div class="alert alert--error">
                    <svg class="alert__icon" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd"></path>
                    </svg>
                    <span><%= errorMessage %></span>
                </div>
                <% } %>
                
                <form class="auth-form" method="post" action="<%=request.getContextPath()%>/api/login">
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
                    
                    <div class="form__options">
                        <label class="checkbox">
                            <input type="checkbox" name="remember" class="checkbox__input">
                            <span class="checkbox__mark"></span>
                            <span class="checkbox__label">Remember me</span>
                        </label>
                        <a href="forgot-password.jsp" class="link">Forgot password?</a>
                    </div>
                    
                    <input type="hidden" name="source" value="logins" />
                    <button type="submit" class="btn btn--primary btn--full">Sign In</button>
                </form>
                
                <div class="auth-card__footer">
                    <p>Don't have an account? <a href="register.jsp" class="link link--primary">Sign up</a></p>
                </div>
            </div>
        </div>
    </main>

    <script src="js/main.js"></script>
</t:base>
