<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

<%
    // Ensure session is created before generating CSRF token
    HttpSession session = request.getSession(true);
    
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
                            Email address <span class="text-red-500">*</span>
                        </label>
                        <input 
                            type="email" 
                            id="email" 
                            name="email" 
                            required 
                            autocomplete="email"
                            placeholder="your.email@example.com"
                            class="input w-full px-4 py-2 border border-neutral-300 rounded-md focus:outline-none focus:ring-2 focus:ring-brand-primary focus:border-transparent"
                            value="${param.email != null ? param.email : ''}" />
                        <p class="mt-1 text-sm text-neutral-500">Enter the email address associated with your account</p>
                    </div>
                    
                    <!-- Password Field -->
                    <div class="form-field space-y-1">
                        <label for="password" class="block text-sm font-medium text-neutral-900 mb-1">
                            Password <span class="text-red-500">*</span>
                        </label>
                        <input 
                            type="password" 
                            id="password" 
                            name="password" 
                            required 
                            autocomplete="current-password"
                            placeholder="********"
                            class="input w-full px-4 py-2 border border-neutral-300 rounded-md focus:outline-none focus:ring-2 focus:ring-brand-primary focus:border-transparent" />
                        <div class="flex justify-end">
                            <a href="forgot-password.jsp" class="text-sm font-medium text-brand-primary hover:text-brand-primary-700 transition-colors">
                                Forgot password?
                            </a>
                        </div>
                    </div>
                    
                    <!-- Remember Me -->
                    <div class="flex items-center">
                        <input id="remember-me" name="remember-me" type="checkbox" class="h-4 w-4 text-brand-primary focus:ring-brand-primary border-neutral-300 rounded">
                        <label for="remember-me" class="ml-2 block text-sm text-neutral-900">
                            Remember me
                        </label>
                    </div>
                    
                    <!-- Submit Button -->
                    <div class="pt-2">
                        <button 
                            type="submit" 
                            class="w-full inline-flex items-center justify-center px-6 py-3 text-lg font-medium text-white bg-brand-primary rounded-md hover:bg-brand-primary-dark focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-brand-primary disabled:opacity-50 disabled:cursor-not-allowed transition-colors">
                            Sign in
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
</t:base>
