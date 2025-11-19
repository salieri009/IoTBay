<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

<%
    // Ensure session is created before generating CSRF token
    request.getSession(true);
    
    // Generate CSRF token for form submission
    String csrfToken = utils.SecurityUtil.generateCSRFToken(request);
    pageContext.setAttribute("csrfToken", csrfToken);
%>

<t:base title="Sign In - IoT Bay" description="Sign in to your IoT Bay account">
    <main class="min-h-screen flex items-center justify-center bg-neutral-50 py-12 px-4">
        <!-- Auth Card -->
        <div class="w-full max-w-[440px]">
            <div class="bg-white rounded-2xl shadow-sm border border-neutral-200 p-6 md:p-10">
                <div class="text-center mb-8">
                    <h1 class="text-2xl md:text-3xl font-bold text-neutral-900 mb-2">Welcome back</h1>
                    <p class="text-lg text-neutral-600">Sign in to your IoT Bay account</p>
                </div>
                
                <c:if test="${not empty errorMessage}">
                    <div class="mb-6 bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg flex items-start gap-3" role="alert">
                        <svg class="w-5 h-5 flex-shrink-0 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd"></path>
                        </svg>
                        <span><c:out value="${errorMessage}" /></span>
                    </div>
                </c:if>
                
                <form class="space-y-6" method="post" action="${pageContext.request.contextPath}/api/login" id="loginForm" enctype="application/x-www-form-urlencoded">
                    <input type="hidden" name="csrfToken" value="${csrfToken}" />
                    
                    <!-- Email Field -->
                    <div class="form-field">
                        <label for="email" class="block text-sm font-medium text-neutral-900 mb-1">
                            Email address <span class="text-red-500" aria-label="required">*</span>
                        </label>
                        <input 
                            type="email" 
                            id="email" 
                            name="email" 
                            required 
                            autocomplete="email"
                            placeholder="your.email@example.com"
                            aria-describedby="email-help"
                            aria-invalid="${not empty errorMessage ? 'true' : 'false'}"
                            class="input w-full px-4 py-2 border ${not empty errorMessage ? 'border-red-300' : 'border-neutral-300'} rounded-md focus:outline-none focus:ring-2 focus:ring-brand-primary focus:border-transparent transition-colors"
                            value="${param.email != null ? param.email : ''}" />
                        <p id="email-help" class="mt-1 text-sm text-neutral-500">Enter the email address associated with your account</p>
                    </div>
                    
                    <!-- Password Field -->
                    <div class="form-field space-y-1">
                        <label for="password" class="block text-sm font-medium text-neutral-900 mb-1">
                            Password <span class="text-red-500" aria-label="required">*</span>
                        </label>
                        <div class="relative">
                            <input 
                                type="password" 
                                id="password" 
                                name="password" 
                                required 
                                autocomplete="current-password"
                                placeholder="********"
                                aria-describedby="password-help"
                                aria-invalid="${not empty errorMessage ? 'true' : 'false'}"
                                class="input w-full px-4 py-2 border ${not empty errorMessage ? 'border-red-300' : 'border-neutral-300'} rounded-md focus:outline-none focus:ring-2 focus:ring-brand-primary focus:border-transparent transition-colors" />
                            <button 
                                type="button"
                                id="togglePassword"
                                class="absolute right-3 top-1/2 transform -translate-y-1/2 text-neutral-500 hover:text-neutral-700 focus:outline-none"
                                aria-label="Toggle password visibility"
                                tabindex="0">
                                <svg id="eyeIcon" class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                                </svg>
                            </button>
                        </div>
                        <div class="flex justify-between items-center mt-1">
                            <p id="password-help" class="text-sm text-neutral-500">Enter your account password</p>
                            <a href="forgot-password.jsp" class="text-sm font-medium text-brand-primary hover:text-brand-primary-700 transition-colors">
                                Forgot password?
                            </a>
                        </div>
                    </div>
                    
                    <!-- Remember Me -->
                    <div class="flex items-center">
                        <input id="remember-me" name="remember-me" type="checkbox" class="h-4 w-4 text-brand-primary focus:ring-brand-primary border-neutral-300 rounded" aria-describedby="remember-help">
                        <label for="remember-me" class="ml-2 block text-sm text-neutral-900">
                            Remember me
                        </label>
                    </div>
                    <p id="remember-help" class="sr-only">Keep me signed in on this device</p>
                    
                    <!-- Submit Button -->
                    <div class="pt-2">
                        <button 
                            type="submit" 
                            id="submitBtn"
                            class="w-full inline-flex items-center justify-center px-6 py-3 text-lg font-medium text-white bg-brand-primary rounded-md hover:bg-brand-primary-dark focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-brand-primary disabled:opacity-50 disabled:cursor-not-allowed transition-colors">
                            <span id="submitText">Sign in</span>
                            <span id="submitSpinner" class="hidden ml-2">
                                <svg class="animate-spin h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                                    <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                                </svg>
                            </span>
                        </button>
                    </div>
                </form>
                
                <div class="mt-8 pt-6 border-t border-neutral-200 text-center">
                    <p class="text-neutral-600">
                        Don't have an account? 
                        <a href="${pageContext.request.contextPath}/register.jsp" class="font-medium text-brand-primary hover:text-brand-primary-700 transition-colors">
                            Create account
                        </a>
                    </p>
                </div>
            </div>
            
            <div class="mt-8 text-center text-sm text-neutral-500">
                <p>&copy; 2024 IoT Bay. All rights reserved.</p>
                <div class="mt-2 space-x-4">
                    <a href="#" class="hover:text-neutral-900 transition-colors">Privacy Policy</a>
                    <a href="#" class="hover:text-neutral-900 transition-colors">Terms of Service</a>
                </div>
            </div>
        </div>
    </main>
    
    <script>
        // Password visibility toggle
        document.addEventListener('DOMContentLoaded', function() {
            const togglePassword = document.getElementById('togglePassword');
            const passwordInput = document.getElementById('password');
            const eyeIcon = document.getElementById('eyeIcon');
            
            if (togglePassword && passwordInput) {
                togglePassword.addEventListener('click', function() {
                    const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                    passwordInput.setAttribute('type', type);
                    
                    // Update icon
                    if (type === 'text') {
                        eyeIcon.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21"></path>';
                    } else {
                        eyeIcon.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>';
                    }
                });
                
                // Keyboard support
                togglePassword.addEventListener('keydown', function(e) {
                    if (e.key === 'Enter' || e.key === ' ') {
                        e.preventDefault();
                        togglePassword.click();
                    }
                });
            }
            
            // Form submission with loading state
            const loginForm = document.getElementById('loginForm');
            const submitBtn = document.getElementById('submitBtn');
            const submitText = document.getElementById('submitText');
            const submitSpinner = document.getElementById('submitSpinner');
            
            if (loginForm && submitBtn) {
                loginForm.addEventListener('submit', function(e) {
                    // Show loading state
                    submitBtn.disabled = true;
                    if (submitText) submitText.textContent = 'Signing in...';
                    if (submitSpinner) submitSpinner.classList.remove('hidden');
                    
                    // Announce to screen readers
                    const liveRegion = document.getElementById('aria-live-announcements');
                    if (liveRegion) {
                        liveRegion.textContent = 'Signing in, please wait...';
                    }
                });
            }
            
            // Keyboard shortcut: Focus search on '/' key
            document.addEventListener('keydown', function(e) {
                // Don't trigger if user is typing in an input
                if (e.target.tagName === 'INPUT' || e.target.tagName === 'TEXTAREA') {
                    return;
                }
                
                // Focus email field on 'e' key
                if (e.key === 'e' || e.key === 'E') {
                    e.preventDefault();
                    const emailInput = document.getElementById('email');
                    if (emailInput) {
                        emailInput.focus();
                    }
                }
            });
            
            // Auto-focus email field on page load
            const emailInput = document.getElementById('email');
            if (emailInput && !emailInput.value) {
                emailInput.focus();
            }
        });
    </script>
</t:base>
