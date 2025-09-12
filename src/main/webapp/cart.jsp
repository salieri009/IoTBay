<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.CartItem" %>
<%@ page import="model.User" %>

<%
    User user = (User) session.getAttribute("user");
    Integer userId;

    if (user != null) {
        userId = user.getId();
    } else {
        userId = (Integer) session.getAttribute("guestId");
    }

    // cartItems should already be set as a request attribute by a servlet
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
    
    // Calculate totals
    double subtotal = 0.0;
    int totalItems = 0;
    if (cartItems != null) {
        for (CartItem item : cartItems) {
            subtotal += item.getSubtotal(item.getPrice());
            totalItems += item.getQuantity();
        }
    }
    double tax = subtotal * 0.1; // 10% tax
    double total = subtotal + tax;
%>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
<t:base title="Shopping Cart" description="Your IoT Bay shopping cart">

    <main class="cart-page">
        <div class="container">
            <!-- Cart Header -->
            <div class="cart-header">
                <h1 class="cart-title">Shopping Cart</h1>
                <div class="cart-summary">
                    <span class="cart-item-count"><%= totalItems %> item<%= totalItems != 1 ? "s" : "" %></span>
                </div>
            </div>

            <div class="cart-layout">
                <!-- Cart Items Section -->
                <div class="cart-items-section">
                    <% if (cartItems != null && !cartItems.isEmpty()) { %>
                        <div class="cart-items">
                            <% for (CartItem item : cartItems) { %>
                                <div class="cart-item" data-product-id="<%= item.getProductId() %>">
                                    <div class="cart-item__image">
                                        <img src="images/default-product.png" 
                                             alt="Product <%= item.getProductId() %>" 
                                             class="product-image">
                                    </div>
                                    
                                    <div class="cart-item__details">
                                        <h3 class="cart-item__name">Product #<%= item.getProductId() %></h3>
                                        <p class="cart-item__price">$<%= String.format("%.2f", item.getPrice()) %> each</p>
                                        <p class="cart-item__added">Added: <%= item.getAddedAt() %></p>
                                    </div>
                                    
                                    <div class="cart-item__quantity">
                                        <label class="quantity-label">Quantity:</label>
                                        <div class="quantity-controls">
                                            <button type="button" class="quantity-controls__btn" 
                                                    onclick="updateQuantity('<%= item.getProductId() %>', '<%= item.getQuantity() - 1 %>')"
                                                    <%= item.getQuantity() <= 1 ? "disabled" : "" %>>
                                                -
                                            </button>
                                            <span class="quantity-display"><%= item.getQuantity() %></span>
                                            <button type="button" class="quantity-controls__btn" 
                                                    onclick="updateQuantity('<%= item.getProductId() %>', '<%= item.getQuantity() + 1 %>')">
                                                +
                                            </button>
                                        </div>
                                    </div>
                                    
                                    <div class="cart-item__total">
                                        <span class="item-total">$<%= String.format("%.2f", item.getSubtotal(item.getPrice())) %></span>
                                    </div>
                                    
                                    <div class="cart-item__actions">
                                        <button type="button" class="btn btn--ghost btn--sm remove-item-btn" 
                                                onclick="removeItem('<%= item.getProductId() %>')">
                                            <svg fill="currentColor" viewBox="0 0 20 20" class="btn-icon">
                                                <path fill-rule="evenodd" d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z" clip-rule="evenodd"></path>
                                            </svg>
                                            Remove
                                        </button>
                                    </div>
                                </div>
                            <% } %>
                        </div>
                    <% } else { %>
                        <div class="empty-cart">
                            <div class="empty-cart__icon">
                                <svg fill="currentColor" viewBox="0 0 20 20">
                                    <path d="M3 1a1 1 0 000 2h1.22l.305 1.222a.997.997 0 00.01.042l1.358 5.43-.893.892C3.74 11.846 4.632 14 6.414 14H15a1 1 0 000-2H6.414l1-1H14a1 1 0 00.894-.553l3-6A1 1 0 0017 3H6.28l-.31-1.243A1 1 0 005 1H3zM16 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM6.5 18a1.5 1.5 0 100-3 1.5 1.5 0 000 3z"></path>
                                </svg>
                            </div>
                            <h3 class="empty-cart__title">Your cart is empty</h3>
                            <p class="empty-cart__description">
                                Start shopping to add items to your cart.
                            </p>
                            <a href="search" class="btn btn--primary">Continue Shopping</a>
                        </div>
                    <% } %>
                </div>

                <!-- Cart Summary Section -->
                <% if (cartItems != null && !cartItems.isEmpty()) { %>
                <div class="cart-summary-section">
                    <div class="cart-summary-card">
                        <h3 class="summary-title">Order Summary</h3>
                        
                        <div class="summary-breakdown">
                            <div class="summary-line">
                                <span class="summary-label">Subtotal (<%= totalItems %> items)</span>
                                <span class="summary-value">$<%= String.format("%.2f", subtotal) %></span>
                            </div>
                            <div class="summary-line">
                                <span class="summary-label">Shipping</span>
                                <span class="summary-value">Free</span>
                            </div>
                            <div class="summary-line">
                                <span class="summary-label">Tax</span>
                                <span class="summary-value">$<%= String.format("%.2f", tax) %></span>
                            </div>
                            <hr class="summary-divider">
                            <div class="summary-line summary-line--total">
                                <span class="summary-label">Total</span>
                                <span class="summary-value">$<%= String.format("%.2f", total) %></span>
                            </div>
                        </div>
                        
                        <div class="summary-actions">
                            <% if (user != null) { %>
                                <form action="checkout" method="post" class="checkout-form">
                                    <button type="submit" class="btn btn--primary btn--full">
                                        Proceed to Checkout
                                    </button>
                                </form>
                            <% } else { %>
                                <a href="login.jsp?redirect=cart" class="btn btn--primary btn--full">
                                    Sign in to Checkout
                                </a>
                            <% } %>
                            
                            <button type="button" class="btn btn--outline btn--full" onclick="clearCart()">
                                Clear Cart
                            </button>
                        </div>
                        
                        <!-- Trust Badges -->
                        <div class="trust-badges trust-badges--compact">
                            <div class="trust-badge">
                                <svg class="trust-badge__icon" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M2.166 4.999A11.954 11.954 0 0010 1.944 11.954 11.954 0 0017.834 5c.11.65.166 1.32.166 2.001 0 5.225-3.34 9.67-8 11.317C5.34 16.67 2 12.225 2 7c0-.682.057-1.35.166-2.001zm11.541 3.708a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                </svg>
                                <span>Secure Payment</span>
                            </div>
                            <div class="trust-badge">
                                <svg class="trust-badge__icon" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M4 2a1 1 0 011 1v2.101a7.002 7.002 0 0111.601 2.566 1 1 0 11-1.885.666A5.002 5.002 0 005.999 7H9a1 1 0 010 2H4a1 1 0 01-1-1V3a1 1 0 011-1zm.008 9.057a1 1 0 011.276.61A5.002 5.002 0 0014.001 13H11a1 1 0 110-2h5a1 1 0 011 1v5a1 1 0 11-2 0v-2.101a7.002 7.002 0 01-11.601-2.566 1 1 0 01.61-1.276z" clip-rule="evenodd"></path>
                                </svg>
                                <span>Free Returns</span>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Continue Shopping -->
                    <div class="continue-shopping">
                        <a href="search" class="link link--primary">
                            ← Continue Shopping
                        </a>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </main>

    <script src="js/main.js"></script>
    <script>
        function updateQuantity(productId, newQuantity) {
            const quantity = parseInt(newQuantity);
            if (quantity < 1) return;
            
            const formData = new FormData();
            formData.append('action', 'update');
            formData.append('productId', productId);
            formData.append('quantity', quantity);
            
            fetch('cart', {
                method: 'POST',
                body: formData
            })
            .then(response => {
                if (response.ok) {
                    location.reload();
                } else {
                    throw new Error('Failed to update quantity');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                if (window.showToast) {
                    window.showToast('Failed to update quantity. Please try again.', 'error');
                }
            });
        }
        
        function removeItem(productId) {
            if (!confirm('Are you sure you want to remove this item from your cart?')) {
                return;
            }
            
            const formData = new FormData();
            formData.append('action', 'remove');
            formData.append('productId', productId);
            
            fetch('cart', {
                method: 'POST',
                body: formData
            })
            .then(response => {
                if (response.ok) {
                    location.reload();
                } else {
                    throw new Error('Failed to remove item');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                if (window.showToast) {
                    window.showToast('Failed to remove item. Please try again.', 'error');
                }
            });
        }
        
        function clearCart() {
            if (!confirm('Are you sure you want to clear your entire cart?')) {
                return;
            }
            
            const formData = new FormData();
            formData.append('action', 'clear');
            
            fetch('cart', {
                method: 'POST',
                body: formData
            })
            .then(response => {
                if (response.ok) {
                    location.reload();
                } else {
                    throw new Error('Failed to clear cart');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                if (window.showToast) {
                    window.showToast('Failed to clear cart. Please try again.', 'error');
                }
            });
        }
    </script>
</t:base>
