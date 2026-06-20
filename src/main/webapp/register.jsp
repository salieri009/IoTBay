<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

<%
    // Generate CSRF token for form submission
    String csrfToken = utils.SecurityUtil.generateCSRFToken(request);
    pageContext.setAttribute("csrfToken", csrfToken);
%>

<t:base title="Create Account - IoT Bay" description="Create your IoT Bay account to access exclusive IoT products and services">
    <main class="min-h-screen flex items-center justify-center bg-gradient-to-br from-neutral-950 to-neutral-800 py-12 px-4">
        <!-- Auth Card Container -->
        <div class="w-full max-w-5xl">
            <div class="bg-white rounded-2xl shadow-sm border border-neutral-200 overflow-hidden">
                <div class="grid grid-cols-1 lg:grid-cols-2">
                    <!-- Benefits Section (Sidebar) -->
                    <div class="bg-neutral-50 p-8 lg:p-12 border-b lg:border-b-0 lg:border-r border-neutral-200">
                        <div class="text-center lg:text-left mb-8">
                            <h1 class="text-3xl font-bold text-neutral-900 mb-2">Join IoT Bay</h1>
                            <p class="text-lg text-neutral-600">Create your account to start shopping for IoT solutions</p>
                        </div>
                        
                        <figure class="text-center mb-8">
                            <img src="${pageContext.request.contextPath}/images/wewantyou.png" alt="Join IoT Bay community" class="w-full max-w-xs mx-auto rounded-lg shadow-sm" />
                        </figure>
                        
                        <div class="space-y-6">
                            <h2 class="text-xl font-semibold text-neutral-900">Why join IoT Bay?</h2>
                            <dl class="space-y-4">
                                <div class="flex items-start gap-3">
                                    <svg class="w-5 h-5 text-success flex-shrink-0 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                                    </svg>
                                    <div>
                                        <dt class="text-sm font-medium text-neutral-900">Exclusive access</dt>
                                        <dd class="text-sm text-neutral-600 mt-1">Latest IoT products and early releases</dd>
                                    </div>
                                </div>
                                <div class="flex items-start gap-3">
                                    <svg class="w-5 h-5 text-success flex-shrink-0 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                                    </svg>
                                    <div>
                                        <dt class="text-sm font-medium text-neutral-900">Member discounts</dt>
                                        <dd class="text-sm text-neutral-600 mt-1">Special pricing and promotional deals</dd>
                                    </div>
                                </div>
                                <div class="flex items-start gap-3">
                                    <svg class="w-5 h-5 text-success flex-shrink-0 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                                    </svg>
                                    <div>
                                        <dt class="text-sm font-medium text-neutral-900">Secure checkout</dt>
                                        <dd class="text-sm text-neutral-600 mt-1">Fast and encrypted payment processing</dd>
                                    </div>
                                </div>
                            </dl>
                        </div>
                    </div>
                    
                    <!-- Registration Form -->
                    <div class="p-8 lg:p-12 flex flex-col justify-center space-y-8">
                        <form class="space-y-8" id="registerForm" action="${pageContext.request.contextPath}/api/auth/register" method="post">
                            <input type="hidden" name="csrfToken" value="${csrfToken}" />

                            <c:if test="${not empty error}">
                                <div class="alert alert--error" role="alert">
                                    <strong>Error:</strong> <c:out value="${error}" escapeXml="true" />
                                </div>
                            </c:if>

                            <!-- Account Information -->
                            <fieldset class="space-y-4">
                                <legend class="text-lg font-semibold text-neutral-900 border-b border-neutral-200 pb-2 w-full">Account information</legend>
                                
                                <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                    <jsp:param name="label" value="Email Address *" />
                                    <jsp:param name="name" value="email" />
                                    <jsp:param name="type" value="email" />
                                    <jsp:param name="placeholder" value="Enter your email" />
                                    <jsp:param name="required" value="true" />
                                    <jsp:param name="helpText" value="We'll use this to send order confirmations" />
                                    <jsp:param name="id" value="email" />
                                </jsp:include>
                                
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                    <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                        <jsp:param name="label" value="Password *" />
                                        <jsp:param name="name" value="password" />
                                        <jsp:param name="type" value="password" />
                                        <jsp:param name="placeholder" value="Create a password" />
                                        <jsp:param name="required" value="true" />
                                        <jsp:param name="helpText" value="Must be at least 8 characters" />
                                        <jsp:param name="id" value="password" />
                                    </jsp:include>
                                    
                                    <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                        <jsp:param name="label" value="Confirm Password *" />
                                        <jsp:param name="name" value="confirmPassword" />
                                        <jsp:param name="type" value="password" />
                                        <jsp:param name="placeholder" value="Confirm your password" />
                                        <jsp:param name="required" value="true" />
                                        <jsp:param name="id" value="confirmPassword" />
                                    </jsp:include>
                                </div>
                            </fieldset>
                            
                            <!-- Personal Information -->
                            <fieldset class="space-y-4">
                                <legend class="text-lg font-semibold text-neutral-900 border-b border-neutral-200 pb-2 w-full">Personal information</legend>
                                
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                    <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                        <jsp:param name="label" value="First Name *" />
                                        <jsp:param name="name" value="firstName" />
                                        <jsp:param name="placeholder" value="Your first name" />
                                        <jsp:param name="required" value="true" />
                                        <jsp:param name="id" value="firstName" />
                                    </jsp:include>
                                    
                                    <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                        <jsp:param name="label" value="Last Name *" />
                                        <jsp:param name="name" value="lastName" />
                                        <jsp:param name="placeholder" value="Your last name" />
                                        <jsp:param name="required" value="true" />
                                        <jsp:param name="id" value="lastName" />
                                    </jsp:include>
                                </div>
                                
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                    <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                        <jsp:param name="label" value="Phone Number *" />
                                        <jsp:param name="name" value="phone" />
                                        <jsp:param name="type" value="tel" />
                                        <jsp:param name="placeholder" value="Your phone number" />
                                        <jsp:param name="required" value="true" />
                                        <jsp:param name="id" value="phone" />
                                    </jsp:include>
                                    
                                    <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                        <jsp:param name="label" value="Date of Birth" />
                                        <jsp:param name="name" value="dateOfBirth" />
                                        <jsp:param name="type" value="date" />
                                        <jsp:param name="id" value="dateOfBirth" />
                                    </jsp:include>
                                </div>
                            </fieldset>
                            
                            <!-- Address Information -->
                            <fieldset class="space-y-4">
                                <legend class="text-lg font-semibold text-neutral-900 border-b border-neutral-200 pb-2 w-full">Address information</legend>
                                
                                <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                    <jsp:param name="label" value="Address Line 1 *" />
                                    <jsp:param name="name" value="addressLine1" />
                                    <jsp:param name="placeholder" value="Street address" />
                                    <jsp:param name="required" value="true" />
                                    <jsp:param name="id" value="addressLine1" />
                                </jsp:include>
                                
                                <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                    <jsp:param name="label" value="Address Line 2" />
                                    <jsp:param name="name" value="addressLine2" />
                                    <jsp:param name="placeholder" value="Apartment, suite, etc. (optional)" />
                                    <jsp:param name="id" value="addressLine2" />
                                </jsp:include>
                                
                                <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                    <jsp:param name="label" value="Postal Code *" />
                                    <jsp:param name="name" value="postalCode" />
                                    <jsp:param name="placeholder" value="Postal code" />
                                    <jsp:param name="required" value="true" />
                                    <jsp:param name="id" value="postalCode" />
                                </jsp:include>
                            </fieldset>
                            
                            <!-- Payment Method -->
                            <fieldset class="space-y-4">
                                <legend class="text-lg font-semibold text-neutral-900 border-b border-neutral-200 pb-2 w-full">Payment method</legend>
                                
                                <div class="form-group">
                                    <label for="paymentMethod" class="form-label">Preferred payment method</label>
                                    <select name="paymentMethod" id="paymentMethod" class="form-select" aria-describedby="paymentMethod-help">
                                        <option value="CreditCard">Credit Card</option>
                                        <option value="PayPal">PayPal</option>
                                        <option value="BankTransfer">Bank Transfer</option>
                                    </select>
                                    <div id="paymentMethod-help" class="form-help text-xs text-neutral-500 mt-1">You can change this later in your account settings</div>
                                </div>
                            </fieldset>
                            
                            <!-- Terms and Conditions -->
                            <div class="space-y-4">
                                <label class="checkbox">
                                    <input type="checkbox" name="tos" id="tos" class="checkbox__input" required aria-describedby="tos-help">
                                    <span class="checkbox__mark"></span>
                                    <span class="checkbox__label">
                                        I agree to the <a href="terms.jsp" class="text-brand-primary hover:text-brand-primary-600">Terms of Service</a> 
                                        and <a href="privacy.jsp" class="text-brand-primary hover:text-brand-primary-600">Privacy Policy</a>
                                    </span>
                                </label>
                                <div id="tos-help" class="sr-only">Required to create an account</div>
                            </div>
                            
                            <input type="hidden" name="from" value="register" />
                            <button type="submit" class="btn btn--primary btn--lg w-full">Create account</button>
                        </form>
                        
                        <div class="text-center">
                            <p class="text-neutral-600">Already have an account? <a href="${pageContext.request.contextPath}/login.jsp" class="text-primary-600 hover:text-primary-700 font-medium">Sign in</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</t:base>
