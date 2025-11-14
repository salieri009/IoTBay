<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="model.CartItem" %>
<%@ page import="model.User" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    HttpSession sessionObj = request.getSession(false);
    User user = (sessionObj != null) ? (User) sessionObj.getAttribute("user") : null;
    Integer userId;

    if (user != null) {
        userId = user.getId();
    } else {
        userId = (sessionObj != null) ? (Integer) sessionObj.getAttribute("guestId") : null;
    }

    // cartItems should already be set as a request attribute by a servlet
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
    if (cartItems == null) {
        cartItems = new java.util.ArrayList<>();
    }
    
    // Calculate totals
    double subtotal = 0.0;
    int totalItems = 0;
    if (cartItems != null && !cartItems.isEmpty()) {
        for (CartItem item : cartItems) {
            if (item != null && item.getPrice() != null) {
                // Use getSubtotal() which uses item's own price, or convert BigDecimal to double
                subtotal += item.getSubtotal().doubleValue();
                totalItems += item.getQuantity();
            }
        }
    }
    double tax = subtotal * 0.1; // 10% tax
    double shipping = subtotal >= 50.0 ? 0.0 : 15.0; // Free shipping over $50
    double total = subtotal + tax + shipping;
    String contextPath = request.getContextPath();

    double freeShippingDelta = subtotal >= 50.0 ? 0.0 : 50.0 - subtotal;
    String cartSummary = totalItems == 0 ? "Your cart is currently empty." : totalItems + (totalItems == 1 ? " item" : " items") + " in your cart.";
    String subtotalFormatted = String.format("%1$,.2f", subtotal);
    String taxFormatted = String.format("%1$,.2f", tax);
    String shippingFormatted = shipping == 0.0 ? "Free" : String.format("%1$,.2f", shipping);
    String totalFormatted = String.format("%1$,.2f", total);
    String freeShippingDeltaFormatted = String.format("%1$,.2f", freeShippingDelta);

    // Expose to EL
    request.setAttribute("cartItems", cartItems);
    request.setAttribute("subtotal", subtotal);
    request.setAttribute("tax", tax);
    request.setAttribute("shipping", shipping);
    request.setAttribute("total", total);
    request.setAttribute("totalItems", totalItems);
    request.setAttribute("cartSummary", cartSummary);
    request.setAttribute("subtotalFormatted", subtotalFormatted);
    request.setAttribute("taxFormatted", taxFormatted);
    request.setAttribute("shippingFormatted", shippingFormatted);
    request.setAttribute("totalFormatted", totalFormatted);
    request.setAttribute("freeShippingDeltaFormatted", freeShippingDeltaFormatted);
%>

<t:base title="Shopping Cart - IoT Bay" description="Review and manage your selected IoT products">
    <main class="py-12">
        <div class="container space-y-10">
            <!-- Breadcrumb Navigation -->
            <nav aria-label="Breadcrumb">
                <ol class="flex flex-wrap items-center gap-2 text-sm text-neutral-600">
                    <li><a href="${pageContext.request.contextPath}/" class="hover:text-brand-primary">Home</a></li>
                    <li aria-hidden="true">/</li>
                    <li class="text-neutral-900 font-medium" aria-current="page">Shopping Cart</li>
                </ol>
            </nav>

            <!-- Cart Overview -->
            <section class="grid gap-8 lg:grid-cols-[minmax(0,1fr)_minmax(0,360px)]">
                <div class="space-y-4">
                    <h1 class="text-display-l font-bold text-neutral-900 leading-tight">Shopping cart</h1>
                    <p class="text-lg text-neutral-600" id="cart-summary-text">${cartSummary}</p>
                    <div class="flex flex-wrap items-center gap-3 text-sm text-neutral-600">
                        <span class="inline-flex items-center gap-2 rounded-full bg-neutral-100 px-3 py-1 font-medium text-neutral-700" data-cart-summary-badge="subtotal">
                            <span class="inline-flex h-2 w-2 rounded-full bg-brand-primary"></span>
                            Subtotal: &#36;${subtotalFormatted}
                        </span>
                        <span class="inline-flex items-center gap-2 rounded-full bg-neutral-100 px-3 py-1 font-medium text-neutral-700" data-cart-summary-badge="total">
                            <span class="inline-flex h-2 w-2 rounded-full bg-brand-secondary"></span>
                            Estimated total: &#36;${totalFormatted}
                        </span>
                    </div>
                </div>
                <aside class="rounded-2xl border border-neutral-200 bg-neutral-50 p-6 space-y-4" aria-label="Checkout guidance">
                    <div>
                        <h2 class="text-sm font-semibold uppercase tracking-wide text-neutral-700">Next steps</h2>
                        <p class="mt-2 text-sm text-neutral-600">Review quantities, confirm compatibility, then proceed to checkout. We’ll keep your cart synced across devices when you sign in.</p>
                    </div>
                    <ul class="space-y-3 text-sm text-neutral-600">
                        <li>Items remain reserved for 30 minutes while you complete checkout.</li>
                        <li>Orders over &#36;100 qualify for free shipping at the payment step.</li>
                        <li>Need procurement documents? Download quotes directly from checkout.</li>
                    </ul>
                    <a href="${pageContext.request.contextPath}/browse" class="btn btn--outline btn--sm">Continue shopping</a>
                </aside>
            </section>

            <!-- Compatibility Warnings -->
            <div id="compatibility-warnings-container" class="rounded-2xl border border-warning-200 bg-warning-50 p-4 hidden" role="region" aria-live="polite" aria-label="Compatibility warnings"></div>

            <div class="grid grid-cols-1 gap-8 lg:grid-cols-[minmax(0,1fr)_360px]">
                <!-- Cart Items Section -->
                <div>
                    <c:choose>
                        <c:when test="${cartItems != null && !empty cartItems}">
                            <div class="space-y-4">
                                <c:forEach var="item" items="${cartItems}">
                                    <div class="cart-item bg-white rounded-lg shadow-sm border border-neutral-200 p-6" 
                                         data-item-id="${item.id}"
                                         data-product-id="${item.product.id}"
                                         role="article"
                                         aria-label="Cart item: ${item.product.name}">
                                        <div class="flex flex-col sm:flex-row gap-4">
                                            <!-- Product Image -->
                                            <div class="cart-item-image flex-shrink-0">
                                                <a href="${pageContext.request.contextPath}/product?productId=${item.product.id}" 
                                                   class="block aspect-square w-24 h-24 sm:w-32 sm:h-32 rounded-lg overflow-hidden bg-neutral-100"
                                                   aria-label="View ${item.product.name} details">
                                                    <img src="${item.product.imageUrl != null && !empty item.product.imageUrl ? item.product.imageUrl : 'images/default-product.png'}" 
                                                         alt="${item.product.name}" 
                                                         class="w-full h-full object-cover"
                                                         loading="lazy"
                                                         onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default-product.png';">
                                                </a>
                                            </div>
                                            
                                            <!-- Product Details -->
                                            <div class="flex-1 min-w-0">
                                                <div class="flex items-start justify-between gap-4 mb-2">
                                                    <div class="flex-1 min-w-0">
                                                        <h3 class="cart-item-name text-lg font-semibold text-neutral-900 mb-1">
                                                            <a href="${pageContext.request.contextPath}/product?productId=${item.product.id}" 
                                                               class="hover:text-brand-primary">
                                                                ${item.product.name}
                                                            </a>
                                                        </h3>
                                                        <p class="cart-item-description text-sm text-neutral-600 line-clamp-2 mb-2">
                                                            ${item.product.description}
                                                        </p>
                                                        <!-- Key Spec Badge -->
                                                        <div class="flex flex-wrap gap-2 mb-3">
                                                            <span class="inline-flex items-center px-2 py-1 rounded text-xs font-medium bg-brand-primary-100 text-brand-primary">
                                                                LoRaWAN
                                                            </span>
                                                            <span class="inline-flex items-center px-2 py-1 rounded text-xs font-medium bg-neutral-100 text-neutral-700">
                                                                12V DC
                                                            </span>
                                                        </div>
                                                        <div class="cart-item-price text-lg font-bold text-brand-primary">
                                                            $<fmt:formatNumber value="${item.price}" pattern="#,##0.00" />
                                                        </div>
                                                    </div>
                                                    
                                                    <!-- Remove Button -->
                                                    <button 
                                                        class="remove-btn flex-shrink-0 p-2 text-neutral-400 hover:text-error transition-colors"
                                                        onclick="removeItem(event, ${item.id})" 
                                                        aria-label="Remove ${item.product.name} from cart"
                                                        title="Remove item">
                                                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                                            <path fill-rule="evenodd" d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z" clip-rule="evenodd"></path>
                                                        </svg>
                                                    </button>
                                                </div>
                                                
                                                <!-- Quantity Controls and Subtotal -->
                                                <div class="flex items-center justify-between pt-4 border-t border-neutral-200">
                                                    <div class="quantity-controls flex items-center gap-3">
                                                        <label for="quantity-${item.id}" class="sr-only">Quantity for ${item.product.name}</label>
                                                        <button 
                                                            class="btn btn--ghost btn--sm"
                                                            onclick="updateQuantity(event, ${item.id}, ${item.quantity - 1})" 
                                                            aria-label="Decrease quantity">
                                                            <span aria-hidden="true">&minus;</span>
                                                        </button>
                                                        <input 
                                                            type="number" 
                                                            id="quantity-${item.id}"
                                                            value="${item.quantity}" 
                                                            min="1" 
                                                            max="${item.product.stockQuantity}"
                                                            class="quantity-value form-input w-20 text-center"
                                                            readonly
                                                            aria-label="Quantity">
                                                        <button 
                                                            class="btn btn--ghost btn--sm"
                                                            onclick="updateQuantity(event, ${item.id}, ${item.quantity + 1})" 
                                                            aria-label="Increase quantity">
                                                            <span aria-hidden="true">+</span>
                                                        </button>
                                                    </div>
                                                    
                                                    <div class="cart-item-subtotal text-right">
                                                        <div class="text-sm text-neutral-600">Subtotal</div>
                                                        <div class="text-xl font-bold text-neutral-900">
                                                            $<fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- Empty Cart State (Section 4.4) -->
                            <div class="empty-cart bg-white rounded-lg shadow-sm border border-neutral-200 p-12 text-center">
                                <div class="empty-cart-icon mb-6">
                                    <svg class="w-24 h-24 mx-auto text-neutral-400" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                        <path d="M3 1a1 1 0 000 2h1.22l.305 1.222a.997.997 0 00.01.042l1.358 5.43-.893.892C3.74 11.846 4.632 14 6.414 14H15a1 1 0 000-2H6.414l1-1H14a1 1 0 00.894-.553l3-6A1 1 0 0017 3H6.28l-.31-1.243A1 1 0 005 1H3zM16 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM6.5 18a1.5 1.5 0 100-3 1.5 1.5 0 000 3z"></path>
                                    </svg>
                                </div>
                                <h3 class="text-2xl font-bold text-neutral-900 mb-2">Your cart is empty</h3>
                                <p class="text-lg text-neutral-600 mb-8">Add some products to get started!</p>
                                <a href="${pageContext.request.contextPath}/browse.jsp" class="btn btn--primary btn--lg">
                                    Browse Products
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Cart Summary Section -->
                <c:if test="${cartItems != null && !empty cartItems}">
                    <div>
                        <div class="sticky top-8">
                            <div class="cart-summary-card bg-white rounded-lg shadow-sm border border-neutral-200 p-6">
                                <h3 class="cart-summary-title text-xl font-semibold text-neutral-900 mb-6">Order Summary</h3>
                                
                                <div class="cart-summary-details space-y-4 mb-6">
                                    <div class="summary-row flex justify-between text-sm">
                                        <span class="text-neutral-600">Subtotal (<span data-cart-summary="items-count"><c:out value="${totalItems}" /></span> items)</span>
                                        <span class="font-medium text-neutral-900" data-cart-summary="subtotal">&#36;${subtotalFormatted}</span>
                                    </div>
                                    <div class="summary-row flex justify-between text-sm">
                                        <span class="text-neutral-600">Shipping</span>
                                        <span class="font-medium text-neutral-900" data-cart-summary="shipping">
                                            <c:choose>
                                                <c:when test="${shipping == 0}">
                                                    <span class="text-success">Free</span>
                                                </c:when>
                                                <c:otherwise>
                                                    &#36;${shippingFormatted}
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                    <c:if test="${subtotal < 50}">
                                        <div class="text-xs text-neutral-500 italic" data-cart-summary="shipping-note">
                                            Add &#36;${freeShippingDeltaFormatted} more for free shipping
                                        </div>
                                    </c:if>
                                    <div class="summary-row flex justify-between text-sm">
                                        <span class="text-neutral-600">Tax</span>
                                        <span class="font-medium text-neutral-900" data-cart-summary="tax">&#36;${taxFormatted}</span>
                                    </div>
                                    <div class="summary-row summary-row--total flex justify-between pt-4 border-t border-neutral-200">
                                        <span class="text-lg font-semibold text-neutral-900">Total</span>
                                        <span class="text-2xl font-bold text-brand-primary" data-cart-summary="total">&#36;${totalFormatted}</span>
                                    </div>
                                </div>
                                
                                <div class="cart-actions space-y-3">
                                    <a href="${pageContext.request.contextPath}/checkout.jsp" 
                                       class="btn btn--primary btn--lg w-full"
                                       aria-label="Proceed to checkout">
                                        Proceed to Checkout
                                        <svg class="w-5 h-5 inline ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                                        </svg>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/browse.jsp" 
                                       class="btn btn--ghost w-full">
                                        Continue Shopping
                                    </a>
                                </div>
                                
                                <!-- Trust Indicators -->
                                <div class="mt-6 pt-6 border-t border-neutral-200">
                                    <div class="space-y-3 text-xs text-neutral-600">
                                        <div class="flex items-center gap-2">
                                            <svg class="w-4 h-4 text-success flex-shrink-0" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                            </svg>
                                            <span>Secure checkout</span>
                                        </div>
                                        <div class="flex items-center gap-2">
                                            <svg class="w-4 h-4 text-success flex-shrink-0" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                                <path d="M8 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM15 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0z"></path>
                                                <path d="M3 4a1 1 0 00-1 1v10a1 1 0 001 1h1.05a2.5 2.5 0 014.9 0H10a1 1 0 001-1V5a1 1 0 00-1-1H3zM14 7a1 1 0 00-1 1v6.05A2.5 2.5 0 0115.95 16H17a1 1 0 001-1v-5a1 1 0 00-.293-.707l-2-2A1 1 0 0015 7h-1z"></path>
                                            </svg>
                                            <span>Free shipping on orders $50+</span>
                                        </div>
                                        <div class="flex items-center gap-2">
                                            <svg class="w-4 h-4 text-success flex-shrink-0" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                                <path fill-rule="evenodd" d="M4 4a2 2 0 00-2 2v4a2 2 0 002 2V6h10a2 2 0 00-2-2H4zm2 6a2 2 0 012-2h8a2 2 0 012 2v4a2 2 0 01-2 2H8a2 2 0 01-2-2v-4zm6 4a2 2 0 100-4 2 2 0 000 4z" clip-rule="evenodd"></path>
                                            </svg>
                                            <span>30-day return policy</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
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
            quantityInput.value = '…';
            if (typeof showLoading === 'function') {
                showLoading(quantityBtn);
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