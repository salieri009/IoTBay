<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="model.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

<%
    HttpSession sessionObj = request.getSession(false);
    User user = (sessionObj != null) ? (User) sessionObj.getAttribute("user") : null;
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Get cartItems from request attribute (set by CheckoutController)
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
    if (cartItems == null) {
        // Fallback to session if not in request
        cartItems = (sessionObj != null) ? (List<CartItem>) sessionObj.getAttribute("cartItems") : new ArrayList<>();
    }
    
    // Calculate totals from request attributes if available
    java.math.BigDecimal subtotalBD = (java.math.BigDecimal) request.getAttribute("subtotal");
    java.math.BigDecimal shippingBD = (java.math.BigDecimal) request.getAttribute("shipping");
    java.math.BigDecimal taxBD = (java.math.BigDecimal) request.getAttribute("tax");
    java.math.BigDecimal totalBD = (java.math.BigDecimal) request.getAttribute("total");
    
    double totalAmount = 0.0;
    if (cartItems != null && !cartItems.isEmpty()) {
        for (CartItem item : cartItems) {
            if (item != null && item.getProduct() != null && item.getProduct().getPrice() != null) {
                totalAmount += item.getProduct().getPrice() * item.getQuantity();
            }
        }
    }
    
    // Use values from request attributes if available (set by CheckoutController)
    double subtotal = (subtotalBD != null) ? subtotalBD.doubleValue() : totalAmount;
    double tax = (taxBD != null) ? taxBD.doubleValue() : (subtotal * 0.1);
    double shipping = (shippingBD != null) ? shippingBD.doubleValue() : (subtotal >= 50.0 ? 0.0 : 15.0);
    double total = (totalBD != null) ? totalBD.doubleValue() : (subtotal + tax + shipping);
    
    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");

    // Expose values for EL/JSTL inside the layout body
    request.setAttribute("cartItems", cartItems);
    request.setAttribute("totalAmount", totalAmount);
    request.setAttribute("subtotal", subtotal);
    request.setAttribute("tax", tax);
    request.setAttribute("shipping", shipping);
    request.setAttribute("total", total);
%>

<%
    String totalFormatted = String.format("%1$,.2f", total);
    String subtotalFormatted = String.format("%1$,.2f", totalAmount);
    String taxFormatted = String.format("%1$,.2f", tax);
    String shippingFormatted = shipping == 0.0 ? "Free" : String.format("%1$,.2f", shipping);
    int itemCount = cartItems != null ? cartItems.size() : 0;
    request.setAttribute("totalFormatted", totalFormatted);
    request.setAttribute("subtotalFormatted", subtotalFormatted);
    request.setAttribute("taxFormatted", taxFormatted);
    request.setAttribute("shippingFormatted", shippingFormatted);
    request.setAttribute("itemCount", itemCount);
%>

<t:base title="Checkout - IoT Bay" description="Secure checkout and order review">
    <main class="py-12">
        <div class="container space-y-10">
            <!-- Breadcrumb Navigation -->
            <nav aria-label="Breadcrumb">
                <ol class="flex flex-wrap items-center gap-2 text-sm text-neutral-600">
                    <li><a href="${pageContext.request.contextPath}/" class="hover:text-brand-primary">Home</a></li>
                    <li aria-hidden="true">/</li>
                    <li><a href="${pageContext.request.contextPath}/cart.jsp" class="hover:text-brand-primary">Cart</a></li>
                    <li aria-hidden="true">/</li>
                    <li class="text-neutral-900 font-medium" aria-current="page">Checkout</li>
                </ol>
            </nav>

            <!-- Page Header -->
            <section class="grid gap-8 lg:grid-cols-[minmax(0,1fr)_minmax(0,360px)]">
                <div class="space-y-4">
                    <h1 class="text-display-l font-bold text-neutral-900 leading-tight">Secure checkout</h1>
                    <p class="text-lg text-neutral-600">Review your order and complete your purchase</p>
                    <div class="flex flex-wrap items-center gap-3 text-sm text-neutral-600">
                        <span class="inline-flex items-center gap-2 rounded-full bg-neutral-100 px-3 py-1 font-medium text-neutral-700">
                            <span class="inline-flex h-2 w-2 rounded-full bg-brand-primary"></span>
                            ${itemCount} ${itemCount == 1 ? 'item' : 'items'}
                        </span>
                        <span class="inline-flex items-center gap-2 rounded-full bg-neutral-100 px-3 py-1 font-medium text-neutral-700">
                            <span class="inline-flex h-2 w-2 rounded-full bg-brand-secondary"></span>
                            Total: &#36;${totalFormatted}
                        </span>
                    </div>
                </div>
                <aside class="rounded-2xl border border-neutral-200 bg-neutral-50 p-6 space-y-4" aria-label="Checkout guidance">
                    <div>
                        <h2 class="text-sm font-semibold uppercase tracking-wide text-neutral-700">What to expect</h2>
                        <p class="mt-2 text-sm text-neutral-600">Complete shipping details, select a payment method, and review your order before confirming. All information is encrypted and secure.</p>
                    </div>
                    <ul class="space-y-3 text-sm text-neutral-600">
                        <li>Your cart items are reserved for 30 minutes during checkout.</li>
                        <li>Orders over &#36;100 qualify for free shipping automatically.</li>
                        <li>You'll receive an email confirmation once your order is placed.</li>
                    </ul>
                </aside>
            </section>

            <!-- Checkout Progress Indicator (Section 4.5) -->
            <div class="checkout-progress mb-8 bg-white rounded-lg shadow-sm border border-neutral-200 p-6">
                <div class="flex items-center justify-between max-w-3xl mx-auto">
                    <!-- Step 1: Cart (Completed) -->
                    <div class="progress-step progress-step--completed flex flex-col items-center flex-1">
                        <div class="progress-step__circle w-10 h-10 rounded-full bg-success text-white flex items-center justify-center mb-2">
                            <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                            </svg>
                        </div>
                        <div class="progress-step__label text-sm font-medium text-success">Cart</div>
                        <div class="progress-step__status text-xs text-neutral-500 mt-1">Complete</div>
                    </div>
                    
                    <div class="progress-step__line flex-1 h-0.5 bg-success mx-2 mt-[-20px]"></div>
                    
                    <!-- Step 2: Shipping (Current) -->
                    <div class="progress-step progress-step--active flex flex-col items-center flex-1">
                        <div class="progress-step__circle w-10 h-10 rounded-full bg-brand-primary text-white flex items-center justify-center mb-2 ring-4 ring-brand-primary-100">
                            <span class="text-sm font-bold">2</span>
                        </div>
                        <div class="progress-step__label text-sm font-semibold text-brand-primary">Shipping</div>
                        <div class="progress-step__status text-xs text-neutral-500 mt-1">Current</div>
                    </div>
                    
                    <div class="progress-step__line flex-1 h-0.5 bg-neutral-200 mx-2 mt-[-20px]"></div>
                    
                    <!-- Step 3: Payment -->
                    <div class="progress-step flex flex-col items-center flex-1">
                        <div class="progress-step__circle w-10 h-10 rounded-full bg-neutral-200 text-neutral-500 flex items-center justify-center mb-2">
                            <span class="text-sm font-bold">3</span>
                        </div>
                        <div class="progress-step__label text-sm font-medium text-neutral-500">Payment</div>
                        <div class="progress-step__status text-xs text-neutral-400 mt-1">Upcoming</div>
                    </div>
                    
                    <div class="progress-step__line flex-1 h-0.5 bg-neutral-200 mx-2 mt-[-20px]"></div>
                    
                    <!-- Step 4: Review -->
                    <div class="progress-step flex flex-col items-center flex-1">
                        <div class="progress-step__circle w-10 h-10 rounded-full bg-neutral-200 text-neutral-500 flex items-center justify-center mb-2">
                            <span class="text-sm font-bold">4</span>
                        </div>
                        <div class="progress-step__label text-sm font-medium text-neutral-500">Review</div>
                        <div class="progress-step__status text-xs text-neutral-400 mt-1">Upcoming</div>
                    </div>
                </div>
                
                <!-- Mobile Progress Text -->
                <div class="text-center mt-4 lg:hidden">
                    <span class="text-sm font-medium text-neutral-700">Step 2 of 4</span>
                </div>
            </div>

        <!-- Alert Messages -->
        <c:if test="${error != null}">
            <div class="alert alert--error mb-6">
                <div class="alert__icon">
                    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/>
                    </svg>
                </div>
                <div>
                    <strong>Error:</strong> ${error}
                </div>
            </div>
        </c:if>

        <c:if test="${success != null}">
            <div class="alert alert--success mb-6">
                <div class="alert__icon">
                    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                    </svg>
                </div>
                <div>
                    <strong>Success:</strong> ${success}
                </div>
            </div>
        </c:if>

        <!-- Checkout Form -->
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
            <!-- Checkout Form -->
            <div class="lg:col-span-2">
                <form id="checkoutForm" action="${pageContext.request.contextPath}/checkout" method="post" class="space-y-8" onsubmit="return validateCheckoutForm(event)">
                    <!-- STEP 2: Shipping Information -->
                    <section class="rounded-2xl border border-neutral-200 bg-white shadow-sm">
                        <div class="p-6 border-b border-neutral-200">
                            <h2 class="text-xl font-semibold text-neutral-900 flex items-center gap-3">
                                <div class="w-10 h-10 bg-brand-primary text-white rounded-full flex items-center justify-center flex-shrink-0" aria-hidden="true">
                                    <span class="text-sm font-bold">2</span>
                                </div>
                                Shipping information
                            </h2>
                            <p class="mt-2 text-sm text-neutral-600">Enter the delivery address for your order</p>
                        </div>
                        <div class="p-6">
                            <fieldset class="space-y-6">
                                <legend class="sr-only">Shipping address details</legend>
                                
                                <!-- Saved Addresses -->
                                <div>
                                    <label for="savedAddress" class="form-label">Use saved address</label>
                                    <select id="savedAddress" name="savedAddress" class="form-input" onchange="loadSavedAddress(this.value)" aria-describedby="savedAddress-help">
                                        <option value="">Select a saved address...</option>
                                        <option value="1">Home Address</option>
                                        <option value="2">Work Address</option>
                                    </select>
                                    <div id="savedAddress-help" class="form-help text-xs text-neutral-500 mt-1">Quickly load a previously saved address</div>
                                </div>
                                
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div class="form-group md:col-span-2">
                                    <label for="fullName" class="form-label form-label--required">Full Name</label>
                                    <input type="text" id="fullName" name="fullName" 
                                           value="${user.firstName} ${user.lastName}" 
                                           class="form-input" 
                                           placeholder="John Doe"
                                           required
                                           aria-describedby="fullName-help">
                                    <div id="fullName-help" class="form-help text-xs text-neutral-500 mt-1">
                                        Enter the recipient's full name
                                    </div>
                                </div>
                                
                                <div class="form-group md:col-span-2">
                                    <label for="email" class="form-label form-label--required">Email Address</label>
                                    <input type="email" id="email" name="email" 
                                           value="${user.email}" 
                                           class="form-input" 
                                           placeholder="your.email@example.com"
                                           required
                                           aria-describedby="email-help"
                                           onblur="validateBusinessEmail(this)">
                                    <div id="email-help" class="form-help text-xs text-neutral-500 mt-1">
                                        For order confirmation and tracking
                                    </div>
                                    <div id="email-error" class="form-error text-xs text-error mt-1 hidden"></div>
                                </div>
                                
                                <div class="form-group md:col-span-2">
                                    <label for="phone" class="form-label form-label--required">Phone Number</label>
                                    <input type="tel" id="phone" name="phone" 
                                           value="${empty user.phone ? '' : user.phone}" 
                                           class="form-input" 
                                           placeholder="+1 (555) 123-4567"
                                           pattern="[+]?[0-9\s\-\(\)]+"
                                           required
                                           aria-describedby="phone-help"
                                           oninput="formatPhoneNumber(this)">
                                    <div id="phone-help" class="form-help text-xs text-neutral-500 mt-1">
                                        Format: +1 (555) 123-4567
                                    </div>
                                </div>
                                
                                <div class="form-group md:col-span-2">
                                    <label for="address1" class="form-label form-label--required">Address Line 1</label>
                                    <input type="text" id="address1" name="address1" 
                                           value="${empty user.addressLine1 ? '' : user.addressLine1}" 
                                           class="form-input" 
                                           placeholder="Street address, P.O. box, company name" 
                                           required
                                           aria-describedby="address1-help">
                                    <div id="address1-help" class="form-help text-xs text-neutral-500 mt-1">
                                        Street address or P.O. box
                                    </div>
                                </div>
                                
                                <div class="form-group md:col-span-2">
                                    <label for="address2" class="form-label">Address Line 2 <span class="text-neutral-500 text-sm">(Optional)</span></label>
                                    <input type="text" id="address2" name="address2" 
                                           value="${empty user.addressLine2 ? '' : user.addressLine2}" 
                                           class="form-input" 
                                           placeholder="Apartment, suite, unit, building, floor, etc."
                                           aria-describedby="address2-help">
                                    <div id="address2-help" class="form-help text-xs text-neutral-500 mt-1">
                                        Additional address information
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="city" class="form-label form-label--required">City</label>
                                    <input type="text" id="city" name="city" 
                                           value="${empty user.city ? '' : user.city}"
                                           class="form-input" 
                                           placeholder="New York"
                                           required>
                                </div>
                                
                                <div class="form-group">
                                    <label for="state" class="form-label form-label--required">State/Province</label>
                                    <input type="text" id="state" name="state" 
                                           value="${empty user.state ? '' : user.state}"
                                           class="form-input" 
                                           placeholder="NY"
                                           required>
                                </div>
                                
                                <div class="form-group">
                                    <label for="postalCode" class="form-label form-label--required">Postal/ZIP Code</label>
                                    <input type="text" id="postalCode" name="postalCode" 
                                           value="${empty user.postalCode ? '' : user.postalCode}" 
                                           class="form-input" 
                                           placeholder="10001"
                                           pattern="[0-9]{5}(-[0-9]{4})?"
                                           required
                                           aria-describedby="postalCode-help">
                                    <div id="postalCode-help" class="form-help text-xs text-neutral-500 mt-1">
                                        5-digit ZIP code or ZIP+4
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="country" class="form-label form-label--required">Country</label>
                                    <select id="country" name="country" class="form-input" required>
                                        <option value="US" selected>United States</option>
                                        <option value="CA">Canada</option>
                                        <option value="AU">Australia</option>
                                        <option value="GB">United Kingdom</option>
                                        <option value="DE">Germany</option>
                                        <option value="FR">France</option>
                                        <option value="JP">Japan</option>
                                        <option value="KR">South Korea</option>
                                    </select>
                                </div>
                            </div>
                            
                                <!-- Address Options -->
                                <div class="pt-6 border-t border-neutral-200 space-y-3">
                                    <label class="flex items-center gap-2 cursor-pointer">
                                        <input type="checkbox" id="useBillingAddress" name="useBillingAddress" class="form-checkbox">
                                        <span class="text-sm text-neutral-700">Use billing address as shipping address</span>
                                    </label>
                                    <label class="flex items-center gap-2 cursor-pointer">
                                        <input type="checkbox" id="saveAddress" name="saveAddress" class="form-checkbox">
                                        <span class="text-sm text-neutral-700">Save this address for future orders</span>
                                    </label>
                                </div>
                            </fieldset>
                        </div>
                    </section>
                    
                    <!-- Shipping Method Selection -->
                    <section class="rounded-2xl border border-neutral-200 bg-white shadow-sm">
                        <div class="p-6 border-b border-neutral-200">
                            <h2 class="text-xl font-semibold text-neutral-900">Shipping method</h2>
                            <p class="mt-2 text-sm text-neutral-600">Choose how quickly you'd like to receive your order</p>
                        </div>
                        <div class="p-6">
                            <fieldset class="space-y-4">
                                <legend class="sr-only">Select shipping method</legend>
                                <label class="shipping-option flex items-start gap-4 p-4 border-2 border-brand-primary rounded-lg cursor-pointer bg-brand-primary-50">
                                    <input type="radio" name="shippingMethod" value="standard" class="radio__input mt-1" checked>
                                    <div class="flex-1">
                                        <div class="flex items-center justify-between mb-2">
                                            <span class="font-semibold text-neutral-900">Standard Shipping</span>
                                            <span class="text-lg font-bold text-brand-primary">$15.00</span>
                                        </div>
                                        <p class="text-sm text-neutral-600">5-7 business days</p>
                                    </div>
                                </label>
                                
                                <label class="shipping-option flex items-start gap-4 p-4 border-2 border-neutral-300 rounded-lg cursor-pointer hover:border-brand-primary transition-colors">
                                    <input type="radio" name="shippingMethod" value="express" class="radio__input mt-1">
                                    <div class="flex-1">
                                        <div class="flex items-center justify-between mb-2">
                                            <span class="font-semibold text-neutral-900">Express Shipping</span>
                                            <span class="text-lg font-bold text-neutral-900">$25.00</span>
                                        </div>
                                        <p class="text-sm text-neutral-600">2-3 business days</p>
                                    </div>
                                </label>
                                
                                <label class="shipping-option flex items-start gap-4 p-4 border-2 border-neutral-300 rounded-lg cursor-pointer hover:border-brand-primary transition-colors">
                                    <input type="radio" name="shippingMethod" value="overnight" class="radio__input mt-1">
                                    <div class="flex-1">
                                        <div class="flex items-center justify-between mb-2">
                                            <span class="font-semibold text-neutral-900">Overnight</span>
                                            <span class="text-lg font-bold text-neutral-900">$45.00</span>
                                        </div>
                                        <p class="text-sm text-neutral-600">Next business day</p>
                                    </div>
                                </label>
                            </fieldset>
                        </div>
                    </section>

                    <!-- STEP 3: Payment Information -->
                    <section class="rounded-2xl border border-neutral-200 bg-white shadow-sm">
                        <div class="p-6 border-b border-neutral-200">
                            <h2 class="text-xl font-semibold text-neutral-900 flex items-center gap-3">
                                <div class="w-10 h-10 bg-brand-primary text-white rounded-full flex items-center justify-center flex-shrink-0" aria-hidden="true">
                                    <span class="text-sm font-bold">3</span>
                                </div>
                                Payment information
                            </h2>
                            <p class="mt-2 text-sm text-neutral-600">Select your preferred payment method and enter details</p>
                        </div>
                        <div class="p-6">
                            <div class="space-y-6">
                                <fieldset>
                                    <legend class="form-label form-label--required mb-4">Payment method</legend>
                                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                        <label class="payment-option flex flex-col items-center gap-2 p-4 border-2 border-brand-primary rounded-lg cursor-pointer bg-brand-primary-50">
                                            <input type="radio" name="paymentMethod" value="credit" class="radio__input" checked onchange="togglePaymentForm('credit')">
                                            <svg class="w-8 h-8 text-brand-primary" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                                <path d="M4 4a2 2 0 00-2 2v1h16V6a2 2 0 00-2-2H4zM18 9H2v5a2 2 0 002 2h12a2 2 0 002-2V9zM4 13a1 1 0 011-1h1a1 1 0 110 2H5a1 1 0 01-1-1zm5-1a1 1 0 100 2h1a1 1 0 100-2H9z"/>
                                            </svg>
                                            <span class="font-medium text-neutral-900">Credit/Debit Card</span>
                                        </label>
                                        
                                        <label class="payment-option flex flex-col items-center gap-2 p-4 border-2 border-neutral-300 rounded-lg cursor-pointer hover:border-brand-primary transition-colors">
                                            <input type="radio" name="paymentMethod" value="paypal" class="radio__input" onchange="togglePaymentForm('paypal')">
                                            <svg class="w-8 h-8 text-blue-600" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                                <path d="M6.5 2.5C7.9 2.5 9.8 3.2 9.8 5.5c0 2.3-1.9 3-3.3 3H5L6.5 2.5zM2 17l2-10h4c3.5 0 6 1.5 6 5s-2.5 5-6 5H4L2 17z"/>
                                            </svg>
                                            <span class="font-medium text-neutral-900">PayPal</span>
                                        </label>
                                        
                                        <label class="payment-option flex flex-col items-center gap-2 p-4 border-2 border-neutral-300 rounded-lg cursor-pointer hover:border-brand-primary transition-colors">
                                            <input type="radio" name="paymentMethod" value="bank" class="radio__input" onchange="togglePaymentForm('bank')">
                                            <svg class="w-8 h-8 text-green-600" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                                <path d="M4 4a2 2 0 00-2 2v8a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2H4zm5 3a1 1 0 000 2h2a1 1 0 100-2H9z"/>
                                            </svg>
                                            <span class="font-medium text-neutral-900">Bank Transfer</span>
                                            <span class="text-xs text-neutral-500">For orders $1000+</span>
                                        </label>
                                    </div>
                                </fieldset>

                                <!-- Credit Card Form -->
                                <fieldset id="creditCardForm" class="space-y-4">
                                    <legend class="sr-only">Credit card details</legend>
                                    <div class="form-group">
                                        <label for="cardNumber" class="form-label form-label--required">Card Number</label>
                                        <div class="relative">
                                            <input type="text" 
                                                   id="cardNumber" 
                                                   name="cardNumber" 
                                                   class="form-input pr-12" 
                                                   placeholder="1234 5678 9012 3456" 
                                                   maxlength="19"
                                                   required
                                                   aria-describedby="cardNumber-help"
                                                   oninput="formatCardNumber(this); detectCardType(this)"
                                                   autocomplete="cc-number">
                                            <div id="cardTypeIcon" class="absolute right-3 top-1/2 transform -translate-y-1/2 hidden">
                                                <!-- Card type icon will be inserted here -->
                                            </div>
                                        </div>
                                        <div id="cardNumber-help" class="form-help text-xs text-neutral-500 mt-1">
                                            Enter your 16-digit card number
                                        </div>
                                        <div id="cardNumber-error" class="form-error text-xs text-error mt-1 hidden"></div>
                                    </div>
                                    
                                    <div class="grid grid-cols-2 gap-4">
                                        <div class="form-group">
                                            <label for="expiryDate" class="form-label form-label--required">Expiry Date</label>
                                            <input type="text" 
                                                   id="expiryDate" 
                                                   name="expiryDate" 
                                                   class="form-input" 
                                                   placeholder="MM/YY" 
                                                   maxlength="5"
                                                   required
                                                   aria-describedby="expiryDate-help"
                                                   oninput="formatExpiryDate(this)"
                                                   autocomplete="cc-exp">
                                            <div id="expiryDate-help" class="form-help text-xs text-neutral-500 mt-1">
                                                MM/YY format
                                            </div>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="cvv" class="form-label form-label--required">
                                                CVV
                                                <button type="button" 
                                                        class="help-tooltip ml-1" 
                                                        aria-label="What is CVV?"
                                                        data-tooltip="The 3-4 digit security code on the back of your card"
                                                        onclick="showCVVHelp()">
                                                    <svg class="w-4 h-4 text-neutral-400 inline" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                                        <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-8-3a1 1 0 00-.867.5 1 1 0 11-1.731-1A3 3 0 0113 8a3.001 3.001 0 01-2 2.83V11a1 1 0 11-2 0v-1a1 1 0 011-1 1 1 0 100-2zm0 8a1 1 0 100-2 1 1 0 000 2z" clip-rule="evenodd"></path>
                                                    </svg>
                                                </button>
                                            </label>
                                            <input type="text" 
                                                   id="cvv" 
                                                   name="cvv" 
                                                   class="form-input" 
                                                   placeholder="123" 
                                                   maxlength="4"
                                                   required
                                                   aria-describedby="cvv-help"
                                                   autocomplete="cc-csc">
                                            <div id="cvv-help" class="form-help text-xs text-neutral-500 mt-1">
                                                3-4 digits on the back of your card
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="cardholderName" class="form-label form-label--required">Cardholder Name</label>
                                        <input type="text" 
                                               id="cardholderName" 
                                               name="cardholderName" 
                                               class="form-input" 
                                               placeholder="Name as it appears on card"
                                               required
                                               autocomplete="cc-name">
                                    </div>
                                    
                                    <div class="form-group">
                                        <label class="flex items-center gap-2 cursor-pointer">
                                            <input type="checkbox" id="saveCard" name="saveCard" class="form-checkbox">
                                            <span class="text-sm text-neutral-700">Save card for future purchases</span>
                                        </label>
                                        <div class="form-help text-xs text-neutral-500 mt-1">
                                            Your card information will be encrypted and stored securely
                                        </div>
                                    </div>
                                </fieldset>
                                
                                <!-- PayPal Form (Hidden by default) -->
                                <fieldset id="paypalForm" class="hidden space-y-4">
                                    <legend class="sr-only">PayPal payment</legend>
                                    <div class="bg-blue-50 border border-blue-200 rounded-lg p-4">
                                        <p class="text-sm text-blue-900 mb-4">
                                            You will be redirected to PayPal to complete your payment securely.
                                        </p>
                                        <button type="button" class="btn btn--primary w-full" onclick="redirectToPayPal()">
                                            Continue to PayPal
                                        </button>
                                    </div>
                                </fieldset>
                                
                                <!-- Bank Transfer Form (Hidden by default) -->
                                <fieldset id="bankForm" class="hidden space-y-4">
                                    <legend class="sr-only">Bank transfer details</legend>
                                    <div class="bg-neutral-50 border border-neutral-200 rounded-lg p-4">
                                        <p class="text-sm text-neutral-700 mb-2">
                                            <strong>Bank Transfer Details:</strong>
                                        </p>
                                        <div class="space-y-2 text-sm text-neutral-600">
                                            <p>Account Name: IoTBay Inc.</p>
                                            <p>Account Number: 1234 5678 9012</p>
                                            <p>Bank: Example Bank</p>
                                            <p>SWIFT: EXMPUS33</p>
                                        </div>
                                        <p class="text-xs text-neutral-500 mt-4">
                                            Please include your order number in the transfer reference. Orders will be processed after payment confirmation (2-3 business days).
                                        </p>
                                    </div>
                                </fieldset>
                            </div>
                        </div>
                    </section>

                    <!-- STEP 4: Review & Confirm -->
                    <section class="rounded-2xl border border-neutral-200 bg-white shadow-sm">
                        <div class="p-6 border-b border-neutral-200">
                            <h2 class="text-xl font-semibold text-neutral-900 flex items-center gap-3">
                                <div class="w-10 h-10 bg-brand-primary text-white rounded-full flex items-center justify-center flex-shrink-0" aria-hidden="true">
                                    <span class="text-sm font-bold">4</span>
                                </div>
                                Review & confirm
                            </h2>
                            <p class="mt-2 text-sm text-neutral-600">Verify your information before placing your order</p>
                        </div>
                        <div class="p-6">
                            <!-- Shipping Address Review -->
                            <div class="mb-6 pb-6 border-b border-neutral-200">
                                <div class="flex items-start justify-between mb-2">
                                    <h3 class="text-lg font-semibold text-neutral-900">Shipping Address</h3>
                                    <button type="button" onclick="editShippingAddress()" class="text-sm text-brand-primary hover:underline">
                                        Edit
                                    </button>
                                </div>
                                <div id="shippingAddressReview" class="text-sm text-neutral-600">
                                    <p id="reviewFullName">${user.firstName} ${user.lastName}</p>
                                    <p id="reviewAddress1">${empty user.addressLine1 ? 'Address Line 1' : user.addressLine1}</p>
                                    <p id="reviewAddress2">${empty user.addressLine2 ? '' : user.addressLine2}</p>
                                    <p id="reviewCityState">${empty user.city ? 'City' : user.city}, ${empty user.state ? 'State' : user.state} ${empty user.postalCode ? 'ZIP' : user.postalCode}</p>
                                    <p id="reviewCountry">United States</p>
                                </div>
                            </div>
                            
                            <!-- Payment Method Review -->
                            <div class="mb-6 pb-6 border-b border-neutral-200">
                                <div class="flex items-start justify-between mb-2">
                                    <h3 class="text-lg font-semibold text-neutral-900">Payment Method</h3>
                                    <button type="button" onclick="editPaymentMethod()" class="text-sm text-brand-primary hover:underline">
                                        Edit
                                    </button>
                                </div>
                                <div id="paymentMethodReview" class="text-sm text-neutral-600">
                                    <p>Credit/Debit Card ending in •••• <span id="reviewCardLast4">4242</span></p>
                                </div>
                            </div>
                            
                            <!-- Terms & Conditions (Section 4.5) -->
                            <div class="mb-6 space-y-3">
                                <label class="flex items-start gap-3 cursor-pointer">
                                    <input type="checkbox" id="agreeTerms" name="agreeTerms" class="form-checkbox mt-1" required>
                                    <span class="text-sm text-neutral-700">
                                        I agree to the <a href="#" class="text-brand-primary hover:underline">Terms & Conditions</a> and <a href="#" class="text-brand-primary hover:underline">Privacy Policy</a>
                                    </span>
                                </label>
                                <label class="flex items-start gap-3 cursor-pointer">
                                    <input type="checkbox" id="agreePrivacy" name="agreePrivacy" class="form-checkbox mt-1" required>
                                    <span class="text-sm text-neutral-700">
                                        I consent to receive order updates via email and SMS
                                    </span>
                                </label>
                            </div>
                            
                            <!-- Place Order Button -->
                            <button type="submit" 
                                    id="placeOrderBtn"
                                    form="checkoutForm"
                                    class="btn btn--primary btn--lg w-full"
                                    onclick="confirmPlaceOrder(event)"
                                    aria-label="Place order">
                                <span id="placeOrderText">Place Order</span>
                                <span id="placeOrderLoading" class="hidden">
                                    <svg class="animate-spin h-5 w-5 inline ml-2" fill="none" viewBox="0 0 24 24" aria-hidden="true">
                                        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                                        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                                    </svg>
                                    Processing...
                                </span>
                            </button>
                            
                            <!-- Back to Cart Link -->
                            <div class="mt-4 text-center">
                                <a href="${pageContext.request.contextPath}/cart.jsp" class="text-sm text-brand-primary hover:underline">
                                    ← Back to Cart
                                </a>
                            </div>
                        </div>
                    </section>
                </form>
            </div>

            <!-- Order Summary Sidebar -->
            <aside class="lg:col-span-1">
                <div class="sticky top-8">
                    <div class="rounded-2xl border border-neutral-200 bg-white shadow-sm">
                        <div class="p-6 border-b border-neutral-200">
                            <h2 class="text-xl font-semibold text-neutral-900">Order summary</h2>
                        </div>
                        <div class="p-6 space-y-4">
                            <!-- Cart Items List -->
                            <c:choose>
                                <c:when test="${not empty cartItems}">
                                    <div class="space-y-3 max-h-64 overflow-y-auto">
                                        <c:forEach var="item" items="${cartItems}">
                                            <div class="flex gap-3 p-3 bg-neutral-50 rounded-lg">
                                                <img src="${item.product.imageUrl != null && !empty item.product.imageUrl ? item.product.imageUrl : 'images/default-product.png'}" 
                                                     alt="${item.product.name}"
                                                     class="w-16 h-16 object-cover rounded-md bg-neutral-200 flex-shrink-0"
                                                     loading="lazy"
                                                     onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default-product.png';">
                                                <div class="flex-1 min-w-0">
                                                    <h4 class="text-sm font-medium text-neutral-900 line-clamp-2 mb-1">
                                                        ${item.product.name}
                                                    </h4>
                                                    <div class="flex justify-between items-center">
                                                        <span class="text-xs text-neutral-600">Qty: ${item.quantity}</span>
                                                        <span class="text-sm font-semibold text-brand-primary">
                                                            $<fmt:formatNumber value="${item.product.price * item.quantity}" pattern="#,##0.00"/>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    
                                    <!-- Price Breakdown -->
                                    <dl class="border-t border-neutral-200 pt-4 space-y-3" aria-label="Order totals">
                                        <div class="flex justify-between text-sm">
                                            <dt class="text-neutral-600">Subtotal (<c:out value="${itemCount}" /> items)</dt>
                                            <dd class="font-medium text-neutral-900">&#36;${subtotalFormatted}</dd>
                                        </div>
                                        <div class="flex justify-between text-sm">
                                            <dt class="text-neutral-600">Shipping</dt>
                                            <dd class="font-medium text-neutral-900" id="shippingCost">
                                                <c:choose>
                                                    <c:when test="${totalAmount >= 50}">
                                                        <span class="text-success">Free</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        &#36;${shippingFormatted}
                                                    </c:otherwise>
                                                </c:choose>
                                            </dd>
                                        </div>
                                        <c:if test="${totalAmount < 50}">
                                            <div class="text-xs text-neutral-500 italic">
                                                Add &#36;<fmt:formatNumber value="${50 - totalAmount}" pattern="#,##0.00" /> more for free shipping
                                            </div>
                                        </c:if>
                                        <div class="flex justify-between text-sm">
                                            <dt class="text-neutral-600">Tax</dt>
                                            <dd class="font-medium text-neutral-900">&#36;${taxFormatted}</dd>
                                        </div>
                                        <div class="border-t border-neutral-200 pt-3">
                                            <div class="flex justify-between items-center">
                                                <dt class="text-lg font-semibold text-neutral-900">Total</dt>
                                                <dd class="text-2xl font-bold text-brand-primary" id="orderTotal">
                                                    &#36;${totalFormatted}
                                                </dd>
                                            </div>
                                        </div>
                                    </dl>
                                    
                                    <!-- Security Badges (Section 4.5) -->
                                    <div class="border-t border-neutral-200 pt-4">
                                        <div class="flex items-center gap-2 mb-3">
                                            <svg class="w-5 h-5 text-success" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                                <path fill-rule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clip-rule="evenodd"></path>
                                            </svg>
                                            <span class="text-sm font-medium text-neutral-700">SSL Encrypted</span>
                                        </div>
                                        <div class="flex items-center gap-2 mb-3">
                                            <svg class="w-5 h-5 text-success" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                            </svg>
                                            <span class="text-sm font-medium text-neutral-700">Secure Checkout</span>
                                        </div>
                                        
                                        <!-- Estimated Delivery -->
                                        <div class="mt-4 pt-4 border-t border-neutral-200">
                                            <p class="text-sm font-medium text-neutral-900 mb-1">Estimated Delivery</p>
                                            <p class="text-sm text-neutral-600" id="estimatedDelivery">5-7 business days</p>
                                        </div>
                                        
                                        <!-- Edit Cart Link -->
                                        <div class="mt-4 text-center">
                                            <a href="${pageContext.request.contextPath}/cart.jsp" class="text-sm text-brand-primary hover:underline">
                                                Edit Cart
                                            </a>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center py-8">
                                        <div class="w-16 h-16 bg-neutral-100 rounded-full flex items-center justify-center mx-auto mb-4">
                                            <svg class="w-8 h-8 text-neutral-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l-1 12H6L5 9z"/>
                                            </svg>
                                        </div>
                                        <p class="text-neutral-600">Your cart is empty</p>
                                        <a href="${pageContext.request.contextPath}/browse" class="btn btn--primary btn--sm mt-4">
                                            Continue Shopping
                                        </a>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </aside>
        </div>
    </main>

    <script>
        // Payment form toggle (Section 4.5)
        function togglePaymentForm(method) {
            const creditForm = document.getElementById('creditCardForm');
            const paypalForm = document.getElementById('paypalForm');
            const bankForm = document.getElementById('bankForm');
            
            // Update payment option styles
            document.querySelectorAll('.payment-option').forEach(option => {
                option.classList.remove('border-brand-primary', 'bg-brand-primary-50');
                option.classList.add('border-neutral-300');
            });
            
            const selectedOption = event.target.closest('.payment-option');
            if (selectedOption) {
                selectedOption.classList.remove('border-neutral-300');
                selectedOption.classList.add('border-brand-primary', 'bg-brand-primary-50');
            }
            
            // Show/hide forms
            if (method === 'credit') {
                creditForm?.classList.remove('hidden');
                paypalForm?.classList.add('hidden');
                bankForm?.classList.add('hidden');
            } else if (method === 'paypal') {
                creditForm?.classList.add('hidden');
                paypalForm?.classList.remove('hidden');
                bankForm?.classList.add('hidden');
            } else if (method === 'bank') {
                creditForm?.classList.add('hidden');
                paypalForm?.classList.add('hidden');
                bankForm?.classList.remove('hidden');
            }
        }
        
        // Card number formatting (Section 4.5)
        function formatCardNumber(input) {
            let value = input.value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
            let formattedValue = value.match(/.{1,4}/g)?.join(' ') || value;
            if (formattedValue.length > 19) formattedValue = formattedValue.substr(0, 19);
            input.value = formattedValue;
        }
        
        // Detect card type (Section 4.5)
        function detectCardType(input) {
            const value = input.value.replace(/\s+/g, '');
            const iconContainer = document.getElementById('cardTypeIcon');
            
            let cardType = '';
            if (/^4/.test(value)) {
                cardType = 'Visa';
            } else if (/^5[1-5]/.test(value)) {
                cardType = 'Mastercard';
            } else if (/^3[47]/.test(value)) {
                cardType = 'Amex';
            } else if (/^6/.test(value)) {
                cardType = 'Discover';
            }
            
            if (cardType && value.length > 0) {
                iconContainer?.classList.remove('hidden');
                if (iconContainer) {
                    iconContainer.innerHTML = `<span class="text-xs font-medium text-neutral-600">${cardType}</span>`;
                }
            } else {
                iconContainer?.classList.add('hidden');
            }
        }
        
        // Expiry date formatting (Section 4.5)
        function formatExpiryDate(input) {
            let value = input.value.replace(/\D/g, '');
            if (value.length >= 2) {
                value = value.substring(0, 2) + '/' + value.substring(2, 4);
            }
            input.value = value;
        }
        
        // Phone number formatting (Section 4.5)
        function formatPhoneNumber(input) {
            let value = input.value.replace(/\D/g, '');
            if (value.length > 0) {
                if (value.length <= 3) {
                    value = `(${value}`;
                } else if (value.length <= 6) {
                    value = `(${value.substring(0, 3)}) ${value.substring(3)}`;
                } else {
                    value = `(${value.substring(0, 3)}) ${value.substring(3, 6)}-${value.substring(6, 10)}`;
                }
            }
            input.value = value;
        }
        
        // Business email validation (Section 4.5)
        function validateBusinessEmail(input) {
            const email = input.value;
            const errorDiv = document.getElementById('email-error');
            
            // Basic email validation
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                if (errorDiv) {
                    errorDiv.textContent = 'Please enter a valid email address';
                    errorDiv.classList.remove('hidden');
                }
                input.classList.add('border-error');
                return false;
            }
            
            // Business email check (optional - can be enhanced)
            const freeEmailDomains = ['gmail.com', 'yahoo.com', 'hotmail.com', 'outlook.com'];
            const domain = email.split('@')[1];
            
            if (freeEmailDomains.includes(domain?.toLowerCase())) {
                if (errorDiv) {
                    errorDiv.textContent = 'Business email recommended for order confirmations';
                    errorDiv.classList.remove('hidden');
                }
                input.classList.add('border-warning');
            } else {
                errorDiv?.classList.add('hidden');
                input.classList.remove('border-error', 'border-warning');
            }
            
            return true;
        }
        
        // Load saved address (Section 4.5)
        function loadSavedAddress(addressId) {
            // This would typically fetch from an API
            console.log('Loading saved address:', addressId);
            // Populate form fields with saved address data
        }
        
        // Edit shipping address (Section 4.5)
        function editShippingAddress() {
            // Scroll to shipping section
            const addressInput = document.querySelector('[name="address1"]');
            if (addressInput) {
                addressInput.scrollIntoView({ behavior: 'smooth', block: 'center' });
                addressInput.focus();
            }
        }
        
        // Edit payment method (Section 4.5)
        function editPaymentMethod() {
            // Scroll to payment section
            const paymentInput = document.querySelector('[name="paymentMethod"]');
            if (paymentInput) {
                paymentInput.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
        }
        
        // Show CVV help (Section 4.5)
        function showCVVHelp() {
            if (typeof showToast === 'function') {
                showToast('CVV is the 3-4 digit security code on the back of your card (or front for Amex)', 'info');
            } else {
                alert('CVV is the 3-4 digit security code on the back of your card (or front for Amex)');
            }
        }
        
        // Redirect to PayPal (Section 4.5)
        function redirectToPayPal() {
            // This would redirect to PayPal checkout
            console.log('Redirecting to PayPal...');
        }
        
        // Update shipping cost in summary (Section 4.5)
        function updateShippingCost(method) {
            const shippingCosts = {
                'standard': 15.00,
                'express': 25.00,
                'overnight': 45.00
            };
            
            const shippingCost = shippingCosts[method] || 15.00;
            const subtotal = parseFloat('${totalAmount}') || 0;
            const tax = subtotal * 0.1;
            const total = subtotal + tax + shippingCost;
            
            const shippingElement = document.getElementById('shippingCost');
            const totalElement = document.getElementById('orderTotal');
            
            if (shippingElement) {
                shippingElement.innerHTML = `$${shippingCost.toFixed(2)}`;
            }
            
            if (totalElement) {
                totalElement.textContent = `$${total.toFixed(2)}`;
            }
            
            // Update estimated delivery
            const deliveryTexts = {
                'standard': '5-7 business days',
                'express': '2-3 business days',
                'overnight': 'Next business day'
            };
            const deliveryElement = document.getElementById('estimatedDelivery');
            if (deliveryElement) {
                deliveryElement.textContent = deliveryTexts[method] || '5-7 business days';
            }
        }
        
        // Confirm place order (Section 4.5)
        function confirmPlaceOrder(event) {
            const agreeTerms = document.getElementById('agreeTerms');
            const agreePrivacy = document.getElementById('agreePrivacy');
            
            if (!agreeTerms?.checked || !agreePrivacy?.checked) {
                event.preventDefault();
                if (typeof showToast === 'function') {
                    showToast('Please accept the Terms & Conditions and Privacy Policy', 'error');
                } else {
                    alert('Please accept the Terms & Conditions and Privacy Policy');
                }
                return false;
            }
            
            // Show confirmation dialog
            if (!confirm('Are you sure you want to place this order? This action cannot be undone.')) {
                event.preventDefault();
                return false;
            }
            
            // Show loading state
            const btn = document.getElementById('placeOrderBtn');
            const text = document.getElementById('placeOrderText');
            const loading = document.getElementById('placeOrderLoading');
            
            if (btn && text && loading) {
                btn.disabled = true;
                text.classList.add('hidden');
                loading.classList.remove('hidden');
            }
            
            return true;
        }
        
        // Validate checkout form (Section 4.5)
        function validateCheckoutForm(event) {
            // Additional validation can be added here
            return true;
        }
        
        // Update review sections when form changes (Section 4.5)
        document.addEventListener('DOMContentLoaded', function() {
            // Watch for shipping method changes
            document.querySelectorAll('[name="shippingMethod"]').forEach(radio => {
                radio.addEventListener('change', function() {
                    updateShippingCost(this.value);
                });
            });
            
            // Watch for address changes
            const addressFields = ['fullName', 'address1', 'address2', 'city', 'state', 'postalCode', 'country'];
            addressFields.forEach(field => {
                const input = document.getElementById(field);
                if (input) {
                    input.addEventListener('blur', function() {
                        updateShippingAddressReview();
                    });
                }
            });
            
            // Watch for card number changes
            const cardNumber = document.getElementById('cardNumber');
            if (cardNumber) {
                cardNumber.addEventListener('input', function() {
                    const value = this.value.replace(/\s+/g, '');
                    if (value.length >= 4) {
                        const last4 = value.substring(value.length - 4);
                        const reviewElement = document.getElementById('reviewCardLast4');
                        if (reviewElement) {
                            reviewElement.textContent = last4;
                        }
                    }
                });
            }
        });
        
        // Update shipping address review (Section 4.5)
        function updateShippingAddressReview() {
            const fullName = document.getElementById('fullName')?.value || '';
            const address1 = document.getElementById('address1')?.value || '';
            const address2 = document.getElementById('address2')?.value || '';
            const city = document.getElementById('city')?.value || '';
            const state = document.getElementById('state')?.value || '';
            const postalCode = document.getElementById('postalCode')?.value || '';
            const country = document.getElementById('country')?.value || 'US';
            
            const reviewFullName = document.getElementById('reviewFullName');
            const reviewAddress1 = document.getElementById('reviewAddress1');
            const reviewAddress2 = document.getElementById('reviewAddress2');
            const reviewCityState = document.getElementById('reviewCityState');
            const reviewCountry = document.getElementById('reviewCountry');
            
            if (reviewFullName) reviewFullName.textContent = fullName || 'Full Name';
            if (reviewAddress1) reviewAddress1.textContent = address1 || 'Address Line 1';
            if (reviewAddress2) reviewAddress2.textContent = address2;
            if (reviewCityState) {
                reviewCityState.textContent = `${city || 'City'}, ${state || 'State'} ${postalCode || 'ZIP'}`;
            }
            if (reviewCountry) {
                const countryNames = {
                    'US': 'United States',
                    'CA': 'Canada',
                    'AU': 'Australia',
                    'GB': 'United Kingdom',
                    'DE': 'Germany',
                    'FR': 'France',
                    'JP': 'Japan',
                    'KR': 'South Korea'
                };
                reviewCountry.textContent = countryNames[country] || country;
            }
        }
    </script>
</t:base>
