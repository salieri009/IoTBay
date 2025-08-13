<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<%@ page import="model.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/modern-theme.css"/>
    <title>Your Orders - IoT Bay</title>
</head>
<body>
    <jsp:include page="components/header.jsp" />
    
    <main class="orders-page">
        <div class="container">
            <div class="page-header">
                <h1 class="page-title">Your Orders</h1>
                <p class="page-description">View and track your order history</p>
            </div>
            
            <div class="orders-container">
                <% if (orders != null && !orders.isEmpty()) { %>
                    <div class="orders-grid">
                        <% for (Order order : orders) { %>
                        <div class="order-card">
                            <div class="order-card__header">
                                <div class="order-card__info">
                                    <h3 class="order-card__number">Order #<%= order.getOrderId() %></h3>
                                    <span class="order-card__date">
                                        <%= order.getOrderDate() != null ? order.getOrderDate().toString() : "N/A" %>
                                    </span>
                                </div>
                                <span class="badge badge--<%= order.getStatus() != null ? order.getStatus().toLowerCase().replace(" ", "-") : "pending" %>">
                                    <%= order.getStatus() != null ? order.getStatus() : "Pending" %>
                                </span>
                            </div>
                            
                            <div class="order-card__content">
                                <div class="order-detail">
                                    <span class="order-detail__label">Total Amount:</span>
                                    <span class="order-detail__value">$<%= String.format("%.2f", order.getTotalAmount()) %></span>
                                </div>
                                
                                <% if (order.getShippingAddress() != null) { %>
                                <div class="order-detail">
                                    <span class="order-detail__label">Shipping Address:</span>
                                    <span class="order-detail__value"><%= order.getShippingAddress() %></span>
                                </div>
                                <% } %>
                                
                                <% if (order.getPaymentMethod() != null) { %>
                                <div class="order-detail">
                                    <span class="order-detail__label">Payment Method:</span>
                                    <span class="order-detail__value"><%= order.getPaymentMethod() %></span>
                                </div>
                                <% } %>
                            </div>
                            
                            <div class="order-card__actions">
                                <a href="orderDetails?orderId=<%= order.getOrderId() %>" class="btn btn--outline btn--sm">
                                    View Details
                                </a>
                                <% if ("Processing".equals(order.getStatus())) { %>
                                <button class="btn btn--primary btn--sm" onclick="trackOrder('<%= order.getOrderId() %>')">
                                    Track Order
                                </button>
                                <% } %>
                            </div>
                        </div>
                        <% } %>
                    </div>
                    
                    <!-- Pagination -->
                    <div class="pagination-container">
                        <nav class="pagination">
                            <a href="#" class="pagination__link pagination__link--prev">
                                <svg class="pagination__icon" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                                </svg>
                                Previous
                            </a>
                            <span class="pagination__current">Page 1 of 1</span>
                            <a href="#" class="pagination__link pagination__link--next">
                                Next
                                <svg class="pagination__icon" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path>
                                </svg>
                            </a>
                        </nav>
                    </div>
                <% } else { %>
                    <div class="empty-state">
                        <div class="empty-state__icon">
                            <svg fill="currentColor" viewBox="0 0 20 20">
                                <path d="M3 4a1 1 0 011-1h12a1 1 0 011 1v2a1 1 0 01-1 1H4a1 1 0 01-1-1V4zM3 10a1 1 0 011-1h6a1 1 0 011 1v6a1 1 0 01-1 1H4a1 1 0 01-1-1v-6zM14 9a1 1 0 00-1 1v6a1 1 0 001 1h2a1 1 0 001-1v-6a1 1 0 00-1-1h-2z"></path>
                            </svg>
                        </div>
                        <h3 class="empty-state__title">No orders yet</h3>
                        <p class="empty-state__description">
                            When you place your first order, it will appear here.
                        </p>
                        <a href="browse" class="btn btn--primary">Start Shopping</a>
                    </div>
                <% } %>
            </div>
        </div>
    </main>
    
    <jsp:include page="components/footer.jsp" />
    <script src="js/main.js"></script>
    <script>
        function trackOrder(orderId) {
            if (window.showToast) {
                window.showToast('Order tracking feature coming soon!', 'info');
            }
        }
    </script>
</body>
</html>