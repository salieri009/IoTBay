<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
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
    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Your IoT Bay shopping cart - Review and manage your selected products">
    <title>Shopping Cart | IoT Bay - Smart Technology Store</title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="<%= contextPath %>/css/modern-theme.css">
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="antialiased bg-neutral-50 text-neutral-900 min-h-screen flex flex-col">
    
    <!-- Header -->
    <jsp:include page="components/header.jsp" />

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
                                <div class="cart-item">
                                    <div class="cart-item-image">
                                        <img src="<%= contextPath %>/images/sample1.png" alt="<%= item.getProduct().getName() %>" class="cart-item-img">
                                    </div>
                                    
                                    <div class="cart-item-details">
                                        <h3 class="cart-item-name"><%= item.getProduct().getName() %></h3>
                                        <p class="cart-item-description"><%= item.getProduct().getDescription() %></p>
                                        <div class="cart-item-price">$<%= String.format("%.2f", item.getPrice()) %></div>
                                    </div>
                                    
                                    <div class="cart-item-controls">
                                        <div class="quantity-controls">
                                            <button class="quantity-btn" onclick="updateQuantity(<%= item.getId() %>, <%= item.getQuantity() - 1 %>)">-</button>
                                            <span class="quantity-value"><%= item.getQuantity() %></span>
                                            <button class="quantity-btn" onclick="updateQuantity(<%= item.getId() %>, <%= item.getQuantity() + 1 %>)">+</button>
                                        </div>
                                        
                                        <div class="cart-item-subtotal">
                                            $<%= String.format("%.2f", item.getSubtotal(item.getPrice())) %>
                                        </div>
                                        
                                        <button class="remove-btn" onclick="removeItem(<%= item.getId() %>)">
                                            <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                                                <path fill-rule="evenodd" d="M9 2a1 1 0 000 2H2a1 1 0 000 2h7a1 1 0 100-2zm3.293 4.293a1 1 0 011.414 0L15 7.586l1.293-1.293a1 1 0 111.414 1.414L16.414 9l1.293 1.293a1 1 0 01-1.414 1.414L15 10.414l-1.293 1.293a1 1 0 01-1.414-1.414L13.586 9l-1.293-1.293a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                                            </svg>
                                        </button>
                                    </div>
                                </div>
                            <% } %>
                        </div>
                    <% } else { %>
                        <!-- Empty Cart State -->
                        <div class="empty-cart">
                            <div class="empty-cart-icon">
                                <svg class="w-20 h-20 text-neutral-400" fill="currentColor" viewBox="0 0 20 20">
                                    <path d="M3 1a1 1 0 000 2h1.22l.305 1.222a.997.997 0 00.01.042l1.358 5.43-.893.892C3.74 11.846 4.632 14 6.414 14H15a1 1 0 000-2H6.414l1-1H14a1 1 0 00.894-.553l3-6A1 1 0 0017 3H6.28l-.31-1.243A1 1 0 005 1H3zM16 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM6.5 18a1.5 1.5 0 100-3 1.5 1.5 0 000 3z"></path>
                                </svg>
                            </div>
                            <h3 class="empty-cart-title">Your cart is empty</h3>
                            <p class="empty-cart-description">Add some products to get started!</p>
                            <a href="<%= contextPath %>/browse.jsp" class="btn btn--primary">Browse Products</a>
                        </div>
                    <% } %>
                </div>

                <!-- Cart Summary Section -->
                <% if (cartItems != null && !cartItems.isEmpty()) { %>
                    <div class="cart-summary-section">
                        <div class="cart-summary-card">
                            <h3 class="cart-summary-title">Order Summary</h3>
                            
                            <div class="cart-summary-details">
                                <div class="summary-row">
                                    <span>Subtotal (<%= totalItems %> items)</span>
                                    <span>$<%= String.format("%.2f", subtotal) %></span>
                                </div>
                                <div class="summary-row">
                                    <span>Tax</span>
                                    <span>$<%= String.format("%.2f", tax) %></span>
                                </div>
                                <div class="summary-row summary-row--total">
                                    <span>Total</span>
                                    <span>$<%= String.format("%.2f", total) %></span>
                                </div>
                            </div>
                            
                            <div class="cart-actions">
                                <a href="<%= contextPath %>/checkout.jsp" class="btn btn--primary btn--lg w-full">
                                    Proceed to Checkout
                                </a>
                                <a href="<%= contextPath %>/browse.jsp" class="btn btn--ghost w-full">
                                    Continue Shopping
                                </a>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        </div>
    </main>
    
    <!-- Footer -->
    <jsp:include page="components/footer.jsp" />
    
    <!-- JavaScript -->
    <script src="<%= contextPath %>/js/main.js"></script>
    
    <script>
        function updateQuantity(itemId, newQuantity) {
            if (newQuantity < 1) {
                removeItem(itemId);
                return;
            }
            
            // Send AJAX request to update quantity
            fetch('<%= contextPath %>/api/cart/update', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `itemId=${itemId}&quantity=${newQuantity}`
            })
            .then(response => {
                if (response.ok) {
                    location.reload();
                } else {
                    console.error('Failed to update quantity');
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
        }
        
        function removeItem(itemId) {
            if (confirm('Are you sure you want to remove this item from your cart?')) {
                fetch('<%= contextPath %>/api/cart/remove', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: `itemId=${itemId}`
                })
                .then(response => {
                    if (response.ok) {
                        location.reload();
                    } else {
                        console.error('Failed to remove item');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                });
            }
        }
    </script>
</body>
</html>