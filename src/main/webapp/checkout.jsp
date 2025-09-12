<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ page import="java.util.*, model.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
    double totalAmount = 0.0;
    if (cartItems != null) {
        for (CartItem item : cartItems) {
            totalAmount += item.getProduct().getPrice() * item.getQuantity();
        }
    }
    
    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");

    // Expose values for EL/JSTL inside the layout body
    request.setAttribute("cartItems", cartItems);
    request.setAttribute("totalAmount", totalAmount);
%>

<t:base title="Checkout - IoT Bay" description="Secure checkout and order review">
    <!-- Include Navigation -->
    <nav class="nav__container">
        <div class="container">
            <ul class="nav__list">
                <li class="nav__item">
                    <a href="${pageContext.request.contextPath}/index.jsp" class="nav__link">Home</a>
                </li>
                <li class="nav__item">
                    <a href="${pageContext.request.contextPath}/browse" class="nav__link">Browse</a>
                </li>
                <li class="nav__item">
                    <a href="${pageContext.request.contextPath}/cart" class="nav__link">Cart</a>
                </li>
                <li class="nav__item">
                    <a href="${pageContext.request.contextPath}/checkout" class="nav__link nav__link--active">Checkout</a>
                </li>
            </ul>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="container py-8">
        <!-- Breadcrumb -->
        <nav class="mb-6">
            <ol class="flex items-center gap-2 text-sm text-neutral-600">
                <li><a href="${pageContext.request.contextPath}/index.jsp" class="hover:text-primary">Home</a></li>
                <li>/</li>
                <li><a href="${pageContext.request.contextPath}/cart" class="hover:text-primary">Cart</a></li>
                <li>/</li>
                <li class="text-neutral-900 font-medium">Checkout</li>
            </ol>
        </nav>

        <!-- Page Header -->
        <div class="mb-8">
            <h1 class="text-display-md font-bold text-neutral-900 mb-2">Secure Checkout</h1>
            <p class="text-lg text-neutral-600">Review your order and complete your purchase</p>
        </div>

        <!-- Alert Messages -->
        <% if (error != null) { %>
            <div class="alert alert--error mb-6">
                <div class="alert__icon">
                    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/>
                    </svg>
                </div>
                <div>
                    <strong>Error:</strong> <%= error %>
                </div>
            </div>
        <% } %>

        <% if (success != null) { %>
            <div class="alert alert--success mb-6">
                <div class="alert__icon">
                    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                    </svg>
                </div>
                <div>
                    <strong>Success:</strong> <%= success %>
                </div>
            </div>
        <% } %>

        <!-- Checkout Form -->
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
            <!-- Checkout Form -->
            <div class="lg:col-span-2">
                <form action="${pageContext.request.contextPath}/checkout" method="post" class="space-y-8">
                    <!-- Shipping Information -->
                    <div class="card">
                        <div class="card__header">
                            <h2 class="text-xl font-semibold text-neutral-900 flex items-center gap-3">
                                <div class="w-8 h-8 bg-brand-primary text-white rounded-full flex items-center justify-content-center">
                                    <span class="text-sm font-bold">1</span>
                                </div>
                                Shipping Information
                            </h2>
                        </div>
                        <div class="card__body">
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div class="form-group">
                                    <label for="firstName" class="form-label form-label--required">First Name</label>
                                    <input type="text" id="firstName" name="firstName" value="${user.firstName}" 
                                           class="form-input" required>
                                </div>
                                <div class="form-group">
                                    <label for="lastName" class="form-label form-label--required">Last Name</label>
                                    <input type="text" id="lastName" name="lastName" value="${user.lastName}" 
                                           class="form-input" required>
                                </div>
                                <div class="form-group md:col-span-2">
                                    <label for="email" class="form-label form-label--required">Email</label>
                                    <input type="email" id="email" name="email" value="${user.email}" 
                                           class="form-input" required>
                                </div>
                                <div class="form-group md:col-span-2">
                                    <label for="phone" class="form-label form-label--required">Phone Number</label>
                                    <input type="tel" id="phone" name="phone" value="${empty user.phone ? '' : user.phone}" 
                                           class="form-input" required>
                                </div>
                                <div class="form-group md:col-span-2">
                                    <label for="address1" class="form-label form-label--required">Address Line 1</label>
                                    <input type="text" id="address1" name="address1" 
                                           value="${empty user.addressLine1 ? '' : user.addressLine1}" 
                                           class="form-input" placeholder="Street address, P.O. box, company name" required>
                                </div>
                                <div class="form-group md:col-span-2">
                                    <label for="address2" class="form-label">Address Line 2</label>
                                    <input type="text" id="address2" name="address2" 
                                           value="${empty user.addressLine2 ? '' : user.addressLine2}" 
                                           class="form-input" placeholder="Apartment, suite, unit, building, floor, etc.">
                                </div>
                                <div class="form-group">
                                    <label for="city" class="form-label form-label--required">City</label>
                                    <input type="text" id="city" name="city" class="form-input" required>
                                </div>
                                <div class="form-group">
                                    <label for="postalCode" class="form-label form-label--required">Postal Code</label>
                                    <input type="text" id="postalCode" name="postalCode" 
                                           value="${empty user.postalCode ? '' : user.postalCode}" 
                                           class="form-input" required>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Payment Information -->
                    <div class="card">
                        <div class="card__header">
                            <h2 class="text-xl font-semibold text-neutral-900 flex items-center gap-3">
                                <div class="w-8 h-8 bg-brand-primary text-white rounded-full flex items-center justify-content-center">
                                    <span class="text-sm font-bold">2</span>
                                </div>
                                Payment Information
                            </h2>
                        </div>
                        <div class="card__body">
                            <div class="space-y-6">
                                <!-- Payment Method Selection -->
                                <div class="form-group">
                                    <label class="form-label">Payment Method</label>
                                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                        <div class="radio">
                                            <input type="radio" id="credit" name="paymentMethod" value="credit" class="radio__input" checked>
                                            <label for="credit" class="radio__label">
                                                <div class="p-4 border border-neutral-300 rounded-lg cursor-pointer hover:border-brand-primary">
                                                    <div class="flex items-center gap-3">
                                                        <svg class="w-6 h-6 text-brand-primary" fill="currentColor" viewBox="0 0 20 20">
                                                            <path d="M4 4a2 2 0 00-2 2v1h16V6a2 2 0 00-2-2H4zM18 9H2v5a2 2 0 002 2h12a2 2 0 002-2V9zM4 13a1 1 0 011-1h1a1 1 0 110 2H5a1 1 0 01-1-1zm5-1a1 1 0 100 2h1a1 1 0 100-2H9z"/>
                                                        </svg>
                                                        <span class="font-medium">Credit Card</span>
                                                    </div>
                                                </div>
                                            </label>
                                        </div>
                                        <div class="radio">
                                            <input type="radio" id="paypal" name="paymentMethod" value="paypal" class="radio__input">
                                            <label for="paypal" class="radio__label">
                                                <div class="p-4 border border-neutral-300 rounded-lg cursor-pointer hover:border-brand-primary">
                                                    <div class="flex items-center gap-3">
                                                        <svg class="w-6 h-6 text-blue-600" fill="currentColor" viewBox="0 0 20 20">
                                                            <path d="M6.5 2.5C7.9 2.5 9.8 3.2 9.8 5.5c0 2.3-1.9 3-3.3 3H5L6.5 2.5zM2 17l2-10h4c3.5 0 6 1.5 6 5s-2.5 5-6 5H4L2 17z"/>
                                                        </svg>
                                                        <span class="font-medium">PayPal</span>
                                                    </div>
                                                </div>
                                            </label>
                                        </div>
                                        <div class="radio">
                                            <input type="radio" id="bank" name="paymentMethod" value="bank" class="radio__input">
                                            <label for="bank" class="radio__label">
                                                <div class="p-4 border border-neutral-300 rounded-lg cursor-pointer hover:border-brand-primary">
                                                    <div class="flex items-center gap-3">
                                                        <svg class="w-6 h-6 text-green-600" fill="currentColor" viewBox="0 0 20 20">
                                                            <path d="M4 4a2 2 0 00-2 2v8a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2H4zm5 3a1 1 0 000 2h2a1 1 0 100-2H9z"/>
                                                        </svg>
                                                        <span class="font-medium">Bank Transfer</span>
                                                    </div>
                                                </div>
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <!-- Credit Card Form -->
                                <div id="creditCardForm" class="space-y-4">
                                    <div class="form-group">
                                        <label for="cardNumber" class="form-label form-label--required">Card Number</label>
                                        <input type="text" id="cardNumber" name="cardNumber" 
                                               class="form-input" placeholder="1234 5678 9012 3456" maxlength="19">
                                    </div>
                                    <div class="grid grid-cols-2 gap-4">
                                        <div class="form-group">
                                            <label for="expiryDate" class="form-label form-label--required">Expiry Date</label>
                                            <input type="text" id="expiryDate" name="expiryDate" 
                                                   class="form-input" placeholder="MM/YY" maxlength="5">
                                        </div>
                                        <div class="form-group">
                                            <label for="cvv" class="form-label form-label--required">CVV</label>
                                            <input type="text" id="cvv" name="cvv" 
                                                   class="form-input" placeholder="123" maxlength="4">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="cardholderName" class="form-label form-label--required">Cardholder Name</label>
                                        <input type="text" id="cardholderName" name="cardholderName" 
                                               class="form-input" placeholder="Name as it appears on card">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Order Notes -->
                    <div class="card">
                        <div class="card__header">
                            <h2 class="text-xl font-semibold text-neutral-900 flex items-center gap-3">
                                <div class="w-8 h-8 bg-neutral-300 text-neutral-700 rounded-full flex items-center justify-content-center">
                                    <span class="text-sm font-bold">3</span>
                                </div>
                                Order Notes <span class="text-sm font-normal text-neutral-500">(Optional)</span>
                            </h2>
                        </div>
                        <div class="card__body">
                            <div class="form-group">
                                <label for="orderNotes" class="form-label">Special Instructions</label>
                                <textarea id="orderNotes" name="orderNotes" rows="4" 
                                          class="form-textarea" 
                                          placeholder="Any special delivery instructions or notes about your order..."></textarea>
                                <div class="form-help">
                                    Let us know if you have any special requirements for delivery or handling.
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Order Summary -->
            <div class="lg:col-span-1">
                <div class="sticky top-8">
                    <div class="card">
                        <div class="card__header">
                            <h2 class="text-xl font-semibold text-neutral-900">Order Summary</h2>
                        </div>
                        <div class="card__body space-y-4">
                            <!-- Cart Items -->
                            <c:choose>
                                <c:when test="${not empty cartItems}">
                                    <div class="space-y-3">
                                        <c:forEach var="item" items="${cartItems}">
                                            <div class="flex gap-3 p-3 bg-neutral-50 rounded-lg">
                                                <img src="${item.product.imageUrl}" 
                                                     alt="${item.product.name}"
                                                     class="w-12 h-12 object-cover rounded-md bg-neutral-200">
                                                <div class="flex-1 min-w-0">
                                                    <h4 class="text-sm font-medium text-neutral-900 truncate">
                                                        ${item.product.name}
                                                    </h4>
                                                    <div class="flex justify-between items-center mt-1">
                                                        <span class="text-xs text-neutral-600">Qty: ${item.quantity}</span>
                                                        <span class="text-sm font-semibold text-brand-primary">
                                                            $<fmt:formatNumber value="${item.product.price * item.quantity}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    
                                    <!-- Price Breakdown -->
                                    <div class="border-t border-neutral-200 pt-4 space-y-2">
                                        <div class="flex justify-between text-sm">
                                            <span class="text-neutral-600">Subtotal</span>
                                            <span class="text-neutral-900">$
                                                <fmt:formatNumber value="${totalAmount}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                                            </span>
                                        </div>
                                        <div class="flex justify-between text-sm">
                                            <span class="text-neutral-600">Shipping</span>
                                            <span class="text-neutral-900">$15.00</span>
                                        </div>
                                        <div class="flex justify-between text-sm">
                                            <span class="text-neutral-600">Tax</span>
                                            <span class="text-neutral-900">$
                                                <fmt:formatNumber value="${totalAmount * 0.1}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                                            </span>
                                        </div>
                                        <div class="border-t border-neutral-200 pt-2">
                                            <div class="flex justify-between text-lg font-semibold">
                                                <span class="text-neutral-900">Total</span>
                                                <span class="text-brand-primary">$
                                                    <fmt:formatNumber value="${totalAmount + 15.00 + (totalAmount * 0.1)}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                                                </span>
                                            </div>
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
                        
                        <% if (cartItems != null && !cartItems.isEmpty()) { %>
                            <div class="card__footer">
                                <button type="submit" form="checkoutForm" class="btn btn--primary btn--full btn--lg">
                                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/>
                                    </svg>
                                    Place Order Securely
                                </button>
                                
                                <!-- Trust Badges -->
                                <div class="flex items-center justify-center gap-4 mt-4 pt-4 border-t border-neutral-200">
                                    <div class="flex items-center gap-2 text-xs text-neutral-600">
                                        <svg class="w-4 h-4 text-green-600" fill="currentColor" viewBox="0 0 20 20">
                                            <path fill-rule="evenodd" d="M2.166 4.999A11.954 11.954 0 0010 1.944 11.954 11.954 0 0017.834 5c.11.65.166 1.32.166 2.001 0 5.225-3.34 9.67-8 11.317C5.34 16.67 2 12.225 2 7c0-.682.057-1.35.166-2.001zm11.541 3.708a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                                        </svg>
                                        SSL Secure
                                    </div>
                                    <div class="flex items-center gap-2 text-xs text-neutral-600">
                                        <svg class="w-4 h-4 text-blue-600" fill="currentColor" viewBox="0 0 20 20">
                                            <path d="M4 4a2 2 0 00-2 2v1h16V6a2 2 0 00-2-2H4zM18 9H2v5a2 2 0 002 2h12a2 2 0 002-2V9zM4 13a1 1 0 011-1h1a1 1 0 110 2H5a1 1 0 01-1-1zm5-1a1 1 0 100 2h1a1 1 0 100-2H9z"/>
                                        </svg>
                                        Secure Payment
                                    </div>
                                </div>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- JavaScript -->
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        // Form validation and enhancement
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.querySelector('form');
            const paymentMethods = document.querySelectorAll('input[name="paymentMethod"]');
            const creditCardForm = document.getElementById('creditCardForm');
            const cardNumberInput = document.getElementById('cardNumber');
            const expiryInput = document.getElementById('expiryDate');
            const cvvInput = document.getElementById('cvv');

            // Payment method change handler
            paymentMethods.forEach(method => {
                method.addEventListener('change', function() {
                    if (this.value === 'credit') {
                        creditCardForm.style.display = 'block';
                        setRequiredFields(true);
                    } else {
                        creditCardForm.style.display = 'none';
                        setRequiredFields(false);
                    }
                });
            });

            // Set required fields for credit card
            function setRequiredFields(required) {
                const fields = ['cardNumber', 'expiryDate', 'cvv', 'cardholderName'];
                fields.forEach(fieldId => {
                    const field = document.getElementById(fieldId);
                    if (field) {
                        field.required = required;
                    }
                });
            }

            // Card number formatting
            if (cardNumberInput) {
                cardNumberInput.addEventListener('input', function(e) {
                    let value = e.target.value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
                    let matches = value.match(/\d{4,16}/g);
                    let match = matches && matches[0] || '';
                    let parts = [];
                    for (let i = 0, len = match.length; i < len; i += 4) {
                        parts.push(match.substring(i, i + 4));
                    }
                    if (parts.length) {
                        e.target.value = parts.join(' ');
                    } else {
                        e.target.value = value;
                    }
                });
            }

            // Expiry date formatting
            if (expiryInput) {
                expiryInput.addEventListener('input', function(e) {
                    let value = e.target.value.replace(/\D/g, '');
                    if (value.length >= 2) {
                        value = value.substring(0, 2) + '/' + value.substring(2, 4);
                    }
                    e.target.value = value;
                });
            }

            // CVV validation
            if (cvvInput) {
                cvvInput.addEventListener('input', function(e) {
                    e.target.value = e.target.value.replace(/\D/g, '');
                });
            }

            // Form submission handler
            if (form) {
                form.addEventListener('submit', function(e) {
                    e.preventDefault();
                    
                    // Show loading state
                    const submitBtn = form.querySelector('button[type="submit"]');
                    const originalText = submitBtn.innerHTML;
                    submitBtn.innerHTML = '<div class="loading mr-2"></div> Processing...';
                    submitBtn.disabled = true;
                    
                    // Simulate processing time
                    setTimeout(() => {
                        // Reset button state
                        submitBtn.innerHTML = originalText;
                        submitBtn.disabled = false;
                        
                        // Show success message (in real app, submit the form)
                        showToast('Order placed successfully! Redirecting to confirmation...', 'success');
                        
                        // Redirect after delay
                        setTimeout(() => {
                            window.location.href = '${pageContext.request.contextPath}/orderList.jsp';
                        }, 2000);
                    }, 2000);
                });
            }
        });
    </script>
</t:base>
