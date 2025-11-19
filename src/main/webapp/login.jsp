<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

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
                        <span>${errorMessage}</span>
                    </div>
                </c:if>
                
                <form class="space-y-6" method="post" action="${pageContext.request.contextPath}/api/login" id="loginForm">
                    <fieldset class="space-y-6">
                        <legend class="sr-only">Sign in to your account</legend>
                        
                        <jsp:include page="/components/molecules/form-field/form-field.jsp">
                            <jsp:param name="label" value="Email address" />
                            <jsp:param name="name" value="email" />
                            <jsp:param name="type" value="email" />
                            <jsp:param name="placeholder" value="your.email@example.com" />
                            <jsp:param name="required" value="true" />
                            <jsp:param name="helpText" value="Enter the email address associated with your account" />
                            <jsp:param name="id" value="email" />
                        </jsp:include>
                        
                        <div class="space-y-1">
                            <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                <jsp:param name="label" value="Password" />
                                <jsp:param name="name" value="password" />
                                <jsp:param name="type" value="password" />
                                <jsp:param name="placeholder" value="••••••••" />
                                <jsp:param name="required" value="true" />
                                <jsp:param name="id" value="password" />
                            </jsp:include>
                            <div class="flex justify-end">
                                <a href="forgot-password.jsp" class="text-sm font-medium text-brand-primary hover:text-brand-primary-700 transition-colors">
                                    Forgot password?
                                </a>
                            </div>
                        </div>
                        
                        <div class="flex items-center">
                            <input id="remember-me" name="remember-me" type="checkbox" class="h-4 w-4 text-brand-primary focus:ring-brand-primary border-neutral-300 rounded">
                            <label for="remember-me" class="ml-2 block text-sm text-neutral-900">
                                Remember me
                            </label>
                        </div>
                    </fieldset>
                    
                    <div class="pt-2">
                        <jsp:include page="/components/atoms/button/button.jsp">
                            <jsp:param name="type" value="primary" />
                            <jsp:param name="htmlType" value="submit" />
                            <jsp:param name="text" value="Sign in" />
                            <jsp:param name="fullWidth" value="true" />
                            <jsp:param name="size" value="large" />
                        </jsp:include>
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