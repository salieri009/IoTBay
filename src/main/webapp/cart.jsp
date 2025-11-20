<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="model.CartItem" %>
<%@ page import="model.User" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- Logic refactored to JSTL/EL --%>
<c:set var="cartItems" value="${requestScope.cartItems}" />
<c:if test="${empty cartItems}">
    <jsp:useBean id="cartItems" class="java.util.ArrayList" scope="request" />
</c:if>

<%-- Calculate Totals --%>
<c:set var="subtotal" value="0.0" />
<c:set var="totalItems" value="0" />

<c:forEach var="item" items="${cartItems}">
    <c:set var="subtotal" value="${subtotal + item.subtotal}" />
    <c:set var="totalItems" value="${totalItems + item.quantity}" />
</c:forEach>

<c:set var="tax" value="${subtotal * 0.1}" />
<c:set var="shipping" value="${subtotal >= 50.0 ? 0.0 : 15.0}" />
<c:set var="total" value="${subtotal + tax + shipping}" />
<c:set var="freeShippingDelta" value="${subtotal >= 50.0 ? 0.0 : 50.0 - subtotal}" />

<%-- Summary Text --%>
<c:choose>
    <c:when test="${totalItems == 0}">
        <c:set var="cartSummary" value="Your cart is currently empty." />
    </c:when>
    <c:otherwise>
        <c:set var="cartSummary" value="${totalItems} ${totalItems == 1 ? 'item' : 'items'} in your cart." />
    </c:otherwise>
</c:choose>

<t:base title="Shopping Cart - IoT Bay" description="Review and manage your selected IoT products">
    <main class="py-12 bg-neutral-50">
        <div class="container mx-auto px-4">
            <!-- Breadcrumb Navigation -->
            <nav aria-label="Breadcrumb" class="mb-8">
                <ol class="flex flex-wrap items-center gap-2 text-sm text-neutral-600">
                    <li><a href="${pageContext.request.contextPath}/" class="hover:text-brand-primary transition-colors">Home</a></li>
                    <li aria-hidden="true" class="text-neutral-400">/</li>
                    <li class="text-neutral-900 font-medium" aria-current="page">Shopping Cart</li>
                </ol>
            </nav>

            <!-- Page Header -->
            <section class="mb-8">
                <h1 class="text-3xl md:text-4xl font-bold text-neutral-900 leading-tight mb-2">Shopping cart</h1>
                <p class="text-lg text-neutral-600" id="cart-summary-text">${cartSummary}</p>
            </section>

            <!-- Compatibility Warnings -->
            <div id="compatibility-warnings-container" class="bg-warning-50 border border-warning-200 rounded-lg p-4 mb-8 hidden" role="region" aria-live="polite" aria-label="Compatibility warnings"></div>

            <!-- Main cart layout - Two Column: Order Items / Summary -->
            <div class="grid grid-cols-1 lg:grid-cols-12 gap-8">
                <!-- Cart Items Section (Order Items) -->
                <div class="lg:col-span-8">
                    <div class="bg-white rounded-lg shadow-sm border border-neutral-200 overflow-hidden">
                        <div class="px-6 py-4 border-b border-neutral-200 bg-neutral-50">
                            <h2 class="text-lg font-semibold text-neutral-900">Order Items</h2>
                        </div>
                        <div class="p-6">
                            <c:choose>
                                <c:when test="${cartItems != null && !empty cartItems}">
                                    <div class="space-y-6">
                                        <c:forEach var="item" items="${cartItems}">
                                            <jsp:include page="/components/molecules/cart-item/cart-item.jsp">
                                                <jsp:param name="itemId" value="${item.id}" />
                                                <jsp:param name="productId" value="${item.product.id}" />
                                                <jsp:param name="productName" value="${item.product.name}" />
                                                <jsp:param name="productDescription" value="${item.product.description}" />
                                                <jsp:param name="productImageUrl" value="${item.product.imageUrl}" />
                                                <jsp:param name="price" value="${item.price}" />
                                                <jsp:param name="quantity" value="${item.quantity}" />
                                                <jsp:param name="maxQuantity" value="${item.product.stockQuantity}" />
                                            </jsp:include>
                                        </c:forEach>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <!-- Empty Cart State -->
                                    <div class="text-center py-12">
                                        <div class="mb-6">
                                            <svg class="w-24 h-24 mx-auto text-neutral-300" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"></path>
                                            </svg>
                                        </div>
                                        <h3 class="text-xl font-bold text-neutral-900 mb-2">Your cart is empty</h3>
                                        <p class="text-neutral-600 mb-8">Looks like you haven't added anything to your cart yet.</p>
                                        <jsp:include page="/components/atoms/button/button.jsp">
                                            <jsp:param name="type" value="primary" />
                                            <jsp:param name="size" value="large" />
                                            <jsp:param name="text" value="Start Shopping" />
                                            <jsp:param name="href" value="${pageContext.request.contextPath}/browse.jsp" />
                                        </jsp:include>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- Cart Summary Section (Payment/Shipping Summary) -->
                <c:if test="${cartItems != null && !empty cartItems}">
                    <aside class="lg:col-span-4">
                        <div class="bg-white rounded-lg shadow-sm border border-neutral-200 p-6 sticky top-24">
                            <h2 class="text-lg font-semibold text-neutral-900 mb-6">Order Summary</h2>
                            
                            <div class="space-y-4">
                                <div class="flex justify-between items-center text-neutral-600">
                                    <span>Subtotal (<span data-cart-summary="items-count"><c:out value="${totalItems}" /></span> items)</span>
                                    <span class="font-medium text-neutral-900" data-cart-summary="subtotal">&#36;<fmt:formatNumber value="${subtotal}" type="number" minFractionDigits="2" maxFractionDigits="2" /></span>
                                </div>
                                <div class="flex justify-between items-center text-neutral-600">
                                    <span>Shipping</span>
                                    <span class="font-medium text-neutral-900" data-cart-summary="shipping">
                                        <c:choose>
                                            <c:when test="${shipping == 0}">
                                                <span class="text-green-600">Free</span>
                                            </c:when>
                                            <c:otherwise>
                                            <c:choose>
                                                <c:when test="${shipping == 0}">Free</c:when>
                                                <c:otherwise>&#36;<fmt:formatNumber value="${shipping}" type="number" minFractionDigits="2" maxFractionDigits="2" /></c:otherwise>
                                            </c:choose>
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <c:if test="${subtotal < 50}">
                                    <div class="text-sm text-neutral-500 italic bg-neutral-50 p-2 rounded" data-cart-summary="shipping-note">
                                        Add &#36;<fmt:formatNumber value="${freeShippingDelta}" type="number" minFractionDigits="2" maxFractionDigits="2" /> more for free shipping
                                    </div>
                                </c:if>
                                <div class="flex justify-between items-center text-neutral-600">
                                    <span>Tax</span>
                                    <span class="font-medium text-neutral-900" data-cart-summary="tax">&#36;<fmt:formatNumber value="${tax}" type="number" minFractionDigits="2" maxFractionDigits="2" /></span>
                                </div>
                                
                                <div class="border-t border-neutral-200 pt-4 mt-4">
                                    <div class="flex justify-between items-center">
                                        <span class="text-lg font-bold text-neutral-900">Total</span>
                                        <span class="text-xl font-bold text-brand-primary" data-cart-summary="total">&#36;<fmt:formatNumber value="${total}" type="number" minFractionDigits="2" maxFractionDigits="2" /></span>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mt-8">
                                <jsp:include page="/components/atoms/button/button.jsp">
                                    <jsp:param name="type" value="primary" />
                                    <jsp:param name="size" value="large" />
                                    <jsp:param name="fullWidth" value="true" />
                                    <jsp:param name="text" value="Proceed to Checkout" />
                                    <jsp:param name="href" value="${pageContext.request.contextPath}/checkout.jsp" />
                                    <jsp:param name="ariaLabel" value="Proceed to checkout" />
                                </jsp:include>
                            </div>
                            
                            <!-- Trust Indicators -->
                            <div class="mt-8 pt-6 border-t border-neutral-200">
                                <div class="space-y-3 text-xs text-neutral-500">
                                    <div class="flex items-center gap-2">
                                        <svg class="w-4 h-4 text-green-600 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                        </svg>
                                        <span>Secure checkout</span>
                                    </div>
                                    <div class="flex items-center gap-2">
                                        <svg class="w-4 h-4 text-green-600 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                            <path d="M8 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM15 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0z"></path>
                                            <path d="M3 4a1 1 0 00-1 1v10a1 1 0 001 1h1.05a2.5 2.5 0 014.9 0H10a1 1 0 001-1V5a1 1 0 00-1-1H3zM14 7a1 1 0 00-1 1v6.05A2.5 2.5 0 0115.95 16H17a1 1 0 001-1v-5a1 1 0 00-.293-.707l-2-2A1 1 0 0015 7h-1z"></path>
                                        </svg>
                                        <span>Free shipping on orders $50+</span>
                                    </div>
                                    <div class="flex items-center gap-2">
                                        <svg class="w-4 h-4 text-green-600 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                            <path fill-rule="evenodd" d="M4 4a2 2 0 00-2 2v4a2 2 0 002 2V6h10a2 2 0 00-2-2H4zm2 6a2 2 0 012-2h8a2 2 0 012 2v4a2 2 0 01-2 2H8a2 2 0 01-2-2v-4zm6 4a2 2 0 100-4 2 2 0 000 4z" clip-rule="evenodd"></path>
                                        </svg>
                                        <span>30-day return policy</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </aside>
                </c:if>
            </div>
        </div>
    </main>
</t:base>
    
    <script>
        // Load compatibility warnings on page load
        document.addEventListener('DOMContentLoaded', function() {
            // Check compatibility when cart page loads
            if (typeof CompatibilityEngine !== 'undefined') {
                CompatibilityEngine.checkCartCompatibility().then(warnings => {
                    const container = document.getElementById('compatibility-warnings-container');
                    if (!container) return;
                    if (warnings && warnings.length > 0) {
                        container.classList.remove('hidden');
                        CompatibilityEngine.displayWarnings(warnings, container);
                    } else {
                        container.classList.add('hidden');
                        container.innerHTML = '';
                    }
                });
            }
        });
        
        // Mock CompatibilityEngine if not defined
        if (typeof CompatibilityEngine === 'undefined') {
            window.CompatibilityEngine = {
                checkCartCompatibility: function() {
                    // In a real implementation, this would check for incompatible items in the cart
                    // For now, we return an empty array to prevent errors
                    return Promise.resolve([]); 
                },
                displayWarnings: function(warnings, container) {
                    if (!container) return;
                    container.innerHTML = '';
                    if (warnings.length === 0) return;
                    
                    const title = document.createElement('h3');
                    title.className = 'text-sm font-medium text-warning-800 mb-2';
                    title.textContent = 'Compatibility Warnings';
                    container.appendChild(title);
                    
                    const list = document.createElement('ul');
                    list.className = 'list-disc list-inside text-sm text-warning-700';
                    warnings.forEach(warning => {
                        const item = document.createElement('li');
                        item.textContent = warning;
                        list.appendChild(item);
                    });
                    container.appendChild(list);
                }
            };
        }
        
        function updateQuantity(event, itemId, newQuantity) {
            event.preventDefault();
            if (newQuantity < 1) {
                removeItem(event, itemId);
                return;
            }
            
            const quantityBtn = event.currentTarget;
            const cartItem = quantityBtn.closest('.cart-item');
            const quantityInput = cartItem.querySelector('.quantity-value');
            const originalValue = quantityInput.value;
            
            const productId = cartItem.getAttribute('data-product-id') || itemId;
            
            quantityBtn.disabled = true;
            // quantityInput.value = '...'; // Loading state
            if (typeof showLoading === 'function') {
                showLoading(quantityBtn);
            }
            
            // Client-side stock validation
            const maxStock = parseInt(quantityInput.getAttribute('max') || quantityInput.getAttribute('data-max-stock') || '999');
            if (newQuantity > maxStock) {
                if (typeof showToast === 'function') {
                    showToast('Only ' + maxStock + ' items available in stock', 'warning');
                } else {
                    alert('Only ' + maxStock + ' items available in stock');
                }
                quantityInput.value = maxStock;
                quantityBtn.disabled = false;
                if (typeof hideLoading === 'function') {
                    hideLoading(quantityBtn);
                }
                return;
            }
            
            const contextPath = '${pageContext.request.contextPath}';
            fetch(contextPath + '/api/cart/update', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `productId=${productId}&quantity=${newQuantity}`
            })
            .then(response => {
                if (response.ok) {
                    return response.json();
                } else {
                    return response.json().then(data => {
                        throw new Error(data.errorMessage || data.message || 'Failed to update quantity');
                    });
                }
            })
            .then(data => {
                if (typeof showToast === 'function') {
                    showToast('Quantity updated successfully', 'success');
                }
                quantityInput.value = newQuantity;
                quantityBtn.disabled = false;
                if (typeof hideLoading === 'function') {
                    hideLoading(quantityBtn);
                }
                refreshCartSummary(data);
            })
            .catch(error => {
                console.error('Error:', error);
                if (typeof showToast === 'function') {
                    showToast(error.message || 'Failed to update quantity. Please try again.', 'error');
                }
                quantityInput.value = originalValue;
                quantityBtn.disabled = false;
                if (typeof hideLoading === 'function') {
                    hideLoading(quantityBtn);
                }
            });
        }
        
        function removeItem(event, itemId) {
            event.preventDefault();
            const cartItem = document.querySelector(`[data-item-id="${itemId}"]`) || 
                           event.currentTarget.closest('.cart-item');
            const productName = cartItem ? cartItem.querySelector('.cart-item-name')?.textContent.trim() : 'this item';
            
            const productId = cartItem ? (cartItem.getAttribute('data-product-id') || itemId) : itemId;
            
            if (!confirm(`Remove "${productName}" from your cart?`)) {
                return;
            }
            
            const removeBtn = event.currentTarget;
            removeBtn.disabled = true;
            if (typeof showLoading === 'function') {
                showLoading(removeBtn);
            }
            
            const contextPath = '${pageContext.request.contextPath}';
            fetch(contextPath + '/api/cart/remove', {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `productId=${productId}`
            })
            .then(response => {
                if (response.ok) {
                    return response.json();
                }
                return response.json().then(data => {
                    throw new Error(data.message || 'Failed to remove item');
                });
            })
            .then(data => {
                if (typeof showToast === 'function') {
                    showToast(`"${productName}" removed from cart`, 'success');
                }
                cartItem?.remove();
                if (data) {
                    refreshCartSummary(data);
                }
                const container = document.getElementById('compatibility-warnings-container');
                if (container) {
                    if (data && data.compatibilityWarnings && data.compatibilityWarnings.length > 0 && typeof CompatibilityEngine !== 'undefined') {
                        container.classList.remove('hidden');
                        CompatibilityEngine.displayWarnings(data.compatibilityWarnings, container);
                    } else {
                        container.classList.add('hidden');
                        container.innerHTML = '';
                    }
                }
                if (!document.querySelector('.cart-item')) {
                    location.reload();
                }
            })
            .catch(error => {
                console.error('Error:', error);
                if (typeof showToast === 'function') {
                    showToast(error.message || 'Failed to remove item. Please try again.', 'error');
                } else {
                    alert(error.message || 'Failed to remove item. Please try again.');
                }
            })
            .finally(() => {
                removeBtn.disabled = false;
                if (typeof hideLoading === 'function') {
                    hideLoading(removeBtn);
                }
            });
        }

        function refreshCartSummary(data) {
            if (!data) return;
            const formatCurrency = (value) => new Intl.NumberFormat(undefined, { style: 'currency', currency: 'USD' }).format(value || 0);
            const itemsCountEl = document.querySelector('[data-cart-summary="items-count"]');
            const subtotalEl = document.querySelector('[data-cart-summary="subtotal"]');
            const shippingEl = document.querySelector('[data-cart-summary="shipping"]');
            const shippingNoteEl = document.querySelector('[data-cart-summary="shipping-note"]');
            const taxEl = document.querySelector('[data-cart-summary="tax"]');
            const totalEl = document.querySelector('[data-cart-summary="total"]');
            const summaryBadges = document.querySelectorAll('[data-cart-summary-badge]');
            const cartSummaryText = document.getElementById('cart-summary-text');

            if (itemsCountEl && typeof data.totalItems !== 'undefined') {
                itemsCountEl.textContent = data.totalItems;
            }
            if (subtotalEl && typeof data.subtotal !== 'undefined') {
                subtotalEl.textContent = formatCurrency(data.subtotal);
            }
            if (shippingEl && typeof data.shipping !== 'undefined') {
                shippingEl.textContent = data.shipping <= 0 ? 'Free' : formatCurrency(data.shipping);
            }
            if (shippingNoteEl) {
                if (data.freeShippingDelta && data.freeShippingDelta > 0) {
                    shippingNoteEl.textContent = `Add ${formatCurrency(data.freeShippingDelta)} more for free shipping`;
                    shippingNoteEl.classList.remove('hidden');
                } else {
                    shippingNoteEl.classList.add('hidden');
                }
            }
            if (taxEl && typeof data.tax !== 'undefined') {
                taxEl.textContent = formatCurrency(data.tax);
            }
            if (totalEl && typeof data.total !== 'undefined') {
                totalEl.textContent = formatCurrency(data.total);
            }
            if (summaryBadges.length) {
                summaryBadges.forEach((badge) => {
                    const type = badge.getAttribute('data-cart-summary-badge');
                    if (type === 'subtotal' && typeof data.subtotal !== 'undefined') {
                        badge.textContent = `Subtotal: ${formatCurrency(data.subtotal)}`;
                    }
                    if (type === 'total' && typeof data.total !== 'undefined') {
                        badge.textContent = `Estimated total: ${formatCurrency(data.total)}`;
                    }
                });
            }
            if (cartSummaryText) {
                const noun = data.totalItems === 1 ? 'item' : 'items';
                cartSummaryText.textContent = data.totalItems === 0 ? 'Your cart is currently empty.' : `${data.totalItems} ${noun} in your cart.`;
            }
        }
    </script>
</body>
</html>
</html>
