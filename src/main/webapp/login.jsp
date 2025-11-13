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
            <div class="rounded-2xl border border-neutral-200 bg-white shadow-sm p-8">
                <div class="text-center mb-8">
                    <h1 class="text-display-m font-bold text-neutral-900 mb-2">Welcome back</h1>
                    <p class="text-lg text-neutral-600">Sign in to your IoT Bay account</p>
                </div>
                
                <% if (errorMessage != null) { %>
                <div class="alert alert--error mb-6" role="alert" aria-live="polite">
                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                        <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd"></path>
                    </svg>
                    <span><%= errorMessage %></span>
                </div>
                <% } %>
                
                <form class="space-y-6" method="post" action="<%= contextPath %>/api/login" id="loginForm">
                    <fieldset class="space-y-6">
                        <legend class="sr-only">Sign in to your account</legend>
                        
                        <div class="form-group">
                            <label for="email" class="form-label form-label--required">Email address</label>
                            <input type="email" id="email" name="email" class="form-input" 
                                   placeholder="your.email@example.com" required autocomplete="email" 
                                   aria-describedby="email-help emailError" />
                            <div id="email-help" class="form-help text-xs text-neutral-500 mt-1">Enter the email address associated with your account</div>
                            <div class="form-error" id="emailError" style="display: none;" role="alert" aria-live="polite"></div>
                        </div>
                        
                        <div class="form-group">
                            <label for="password" class="form-label form-label--required">Password</label>
                            <input type="password" id="password" name="password" class="form-input" 
                                   placeholder="Enter your password" required autocomplete="current-password" 
                                   aria-describedby="password-help passwordError" />
                            <div id="password-help" class="form-help text-xs text-neutral-500 mt-1">Case-sensitive password</div>
                            <div class="form-error" id="passwordError" style="display: none;" role="alert" aria-live="polite"></div>
                        </div>
                        
                        <div class="flex items-center justify-between">
                            <label class="checkbox">
                                <input type="checkbox" name="remember" class="checkbox__input" aria-describedby="remember-help">
                                <span class="checkbox__mark"></span>
                                <span class="checkbox__label">Remember me</span>
                            </label>
                            <a href="forgot-password.jsp" class="text-sm text-brand-primary hover:text-brand-primary-600">Forgot password?</a>
                        </div>
                        <div id="remember-help" class="sr-only">Keep you signed in on this device</div>
                        
                        <input type="hidden" name="source" value="logins" />
                        <button type="submit" class="btn btn--primary btn--lg w-full" id="submitBtn">Sign in</button>
                    </fieldset>
                </form>
                
                <div class="mt-6 text-center">
                    <p class="text-sm text-neutral-600">Don't have an account? <a href="register.jsp" class="text-brand-primary hover:text-brand-primary-600 font-medium">Sign up</a></p>
                </div>
            </div>
        </div>
    </main>

    <script src="<%= contextPath %>/js/main.js"></script>
    <script>
        // Form submission with loading state and better error handling
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const submitBtn = document.getElementById('submitBtn');
            const originalText = submitBtn.textContent;
            const emailInput = document.getElementById('email');
            const passwordInput = document.getElementById('password');
            
            // Basic validation
            let hasErrors = false;
            
            if (!emailInput.value.trim()) {
                showFieldError('emailError', 'Email address is required');
                hasErrors = true;
            } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(emailInput.value)) {
                showFieldError('emailError', 'Please enter a valid email address');
                hasErrors = true;
            } else {
                hideFieldError('emailError');
            }
            
            if (!passwordInput.value) {
                showFieldError('passwordError', 'Password is required');
                hasErrors = true;
            } else {
                hideFieldError('passwordError');
            }
            
            if (hasErrors) {
                return;
            }
            
            // Show loading state
            submitBtn.textContent = 'Signing in...';
            submitBtn.disabled = true;
            if (typeof showLoading === 'function') {
                showLoading(submitBtn);
            }
            
            // Submit form
            const formData = new FormData(this);
            
            fetch(this.action, {
                method: 'POST',
                body: formData
            })
            .then(response => {
                if (response.ok) {
                    return response.text();
                } else {
                    return response.text().then(text => {
                        throw new Error('Login failed');
                    });
                }
            })
            .then(html => {
                // Check if response contains error indicators
                if (html.includes('error') || html.includes('Invalid')) {
                    throw new Error('Invalid email or password. Please try again.');
                }
                // Success - redirect or reload
                if (typeof showToast === 'function') {
                    showToast('Login successful! Redirecting...', 'success');
                }
                setTimeout(() => {
                    window.location.href = '<%= contextPath %>/';
                }, 500);
            })
            .catch(error => {
                console.error('Error:', error);
                
                // Reset button
                submitBtn.textContent = originalText;
                submitBtn.disabled = false;
                if (typeof hideLoading === 'function') {
                    hideLoading(submitBtn);
                }
                
                // Show helpful error message
                let errorMsg = 'Login failed. ';
                if (error.message.includes('email') || error.message.includes('Email')) {
                    errorMsg += 'The email address you entered is not registered. Would you like to <a href="register.jsp">create an account</a>?';
                } else if (error.message.includes('password') || error.message.includes('Password')) {
                    errorMsg += 'The password you entered is incorrect. Please try again or <a href="forgot-password.jsp">reset your password</a>.';
                } else {
                    errorMsg += 'Please check your email and password and try again.';
                }
                
                // Show error in password field
                showFieldError('passwordError', errorMsg);
                
                // Focus on password field
                passwordInput.focus();
            });
        });
        
        function showFieldError(fieldId, message) {
            const errorDiv = document.getElementById(fieldId);
            if (errorDiv) {
                errorDiv.innerHTML = message;
                errorDiv.style.display = 'block';
                const input = errorDiv.previousElementSibling;
                if (input && input.classList) {
                    input.classList.add('form-input--error');
                }
            }
        }
        
        function hideFieldError(fieldId) {
            const errorDiv = document.getElementById(fieldId);
            if (errorDiv) {
                errorDiv.style.display = 'none';
                const input = errorDiv.previousElementSibling;
                if (input && input.classList) {
                    input.classList.remove('form-input--error');
                }
            }
        }
    </script>
</body>
</html>