<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.User" %>
<%@ page import="model.Order" %>
<%@ page import="java.util.List" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String contextPath = request.getContextPath();
    
    // Orders should be set by OrderHistoryController
    @SuppressWarnings("unchecked")
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    if (orders == null) {
        orders = new java.util.ArrayList<>();
    }
    
    String statusFilter = (String) request.getAttribute("statusFilter");
    String dateRange = (String) request.getAttribute("dateRange");
    String orderNumber = (String) request.getAttribute("orderNumber");
%>

<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="View your order history and track order status">
    <title>Order History | IoT Bay - Smart Technology Store</title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="<%= contextPath %>/css/modern-theme.css">
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="antialiased bg-neutral-50 text-neutral-900 min-h-screen flex flex-col">
    
    <!-- Header -->
    <c:import url="/components/organisms/header/header.jsp" />
    
    <main class="flex-1">
        <!-- Page Header -->
        <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
            <div class="container">
                <div class="max-w-4xl mx-auto text-center">
                    <h1 class="text-display-lg text-neutral-900 mb-4">
                        Order <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">History</span>
                    </h1>
                    <p class="text-lg text-neutral-600 max-w-2xl mx-auto">
                        Track your orders and view order details
                    </p>
                </div>
            </div>
        </section>

        <!-- Orders Section -->
        <section class="py-12">
            <div class="container">
                <div class="max-w-6xl mx-auto">
                    <!-- Filter and Search -->
                    <div class="mb-8">
                        <div class="flex flex-col md:flex-row gap-4 items-center justify-between">
                            <div class="flex flex-wrap items-center gap-4 flex-1">
                                <!-- Search by Order Number -->
                                <div class="relative flex-1 min-w-[200px]">
                                    <input type="text" 
                                           id="orderSearch" 
                                           placeholder="Search by order number..." 
                                           class="form-input pr-10"
                                           aria-label="Search orders by order number">
                                    <svg class="absolute right-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-neutral-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                                    </svg>
                                </div>
                                <!-- Filter by Status -->
                                <select id="statusFilter" class="form-select" aria-label="Filter by order status">
                                    <option value="">All Orders</option>
                                    <option value="pending">Pending</option>
                                    <option value="processing">Processing</option>
                                    <option value="shipped">Shipped</option>
                                    <option value="delivered">Delivered</option>
                                    <option value="cancelled">Cancelled</option>
                                    <option value="refunded">Refunded</option>
                                </select>
                                <!-- Filter by Date -->
                                <select id="dateFilter" class="form-select" aria-label="Filter by date range">
                                    <option value="">All Time</option>
                                    <option value="30">Last 30 Days</option>
                                    <option value="90">Last 90 Days</option>
                                    <option value="365">Last Year</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Orders List -->
                    <div class="space-y-6" id="orders-container">
                        <c:choose>
                            <c:when test="${empty orders}">
                                <!-- Empty State -->
                                <div class="empty-state text-center py-16">
                                    <svg class="w-20 h-20 text-neutral-400 mx-auto mb-6" fill="currentColor" viewBox="0 0 20 20">
                                        <path d="M3 4a1 1 0 011-1h12a1 1 0 011 1v2a1 1 0 01-1 1H4a1 1 0 01-1-1V4zM3 10a1 1 0 011-1h6a1 1 0 011 1v6a1 1 0 01-1 1H4a1 1 0 01-1-1v-6zM14 9a1 1 0 00-1 1v6a1 1 0 001 1h2a1 1 0 001-1v-6a1 1 0 00-1-1h-2z"></path>
                                    </svg>
                                    <h3 class="text-2xl font-semibold text-neutral-900 mb-3">No Orders Found</h3>
                                    <p class="text-neutral-600 mb-6">
                                        You haven't placed any orders yet. Start shopping to see your orders here.
                                    </p>
                                    <a href="${pageContext.request.contextPath}/browse.jsp" class="btn btn--primary">Start Shopping</a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="order" items="${orders}">
                                    <div class="card p-6 hover-lift mb-6" data-order-id="${order.id}">
                                        <div class="flex flex-col md:flex-row md:items-center justify-between mb-4">
                                            <div>
                                                <h3 class="text-lg font-semibold text-neutral-900">Order #ORD-${order.id}</h3>
                                                <p class="text-sm text-neutral-600">
                                                    Order Date: 
                                                    <c:choose>
                                                        <c:when test="${order.orderDate != null}">
                                                            <fmt:formatDate value="${order.orderDateAsTimestamp}" pattern="MMMM dd, yyyy" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            N/A
                                                        </c:otherwise>
                                                    </c:choose>
                                                </p>
                                            </div>
                                            <div class="flex items-center gap-4 mt-2 md:mt-0">
                                                <c:choose>
                                                    <c:when test="${order.status == 'SHIPPED'}">
                                                        <span class="badge badge--success">Shipped</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'PENDING'}">
                                                        <span class="badge badge--warning">Pending</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'DELIVERED'}">
                                                        <span class="badge badge--success">Delivered</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'CANCELLED'}">
                                                        <span class="badge badge--error">Cancelled</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge--info">${order.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                                <span class="text-lg font-semibold text-neutral-900">
                                                    $<fmt:formatNumber value="${order.totalAmount}" minFractionDigits="2" maxFractionDigits="2" />
                                                </span>
                                            </div>
                                        </div>
                                        
                                        <!-- Order Items Summary -->
                                        <div class="border-t border-neutral-200 pt-4 mb-4">
                                            <p class="text-sm text-neutral-600 mb-2">Order items will be displayed here</p>
                                        </div>
                                        
                                        <!-- Tracking Information -->
                                        <div class="border-t border-neutral-200 pt-4 mb-4">
                                            <div class="flex items-center gap-2 text-sm text-neutral-600">
                                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4"></path>
                                                </svg>
                                                <span>Status: ${order.status}</span>
                                            </div>
                                        </div>
                                        
                                        <!-- Order Actions -->
                                        <div class="flex flex-col sm:flex-row gap-3">
                                            <a href="${pageContext.request.contextPath}/orderhistory?orderId=${order.id}" 
                                               class="btn btn--outline btn--sm" 
                                               aria-label="View order details">View Details</a>
                                            <a href="${pageContext.request.contextPath}/shipment?orderId=${order.id}" 
                                               class="btn btn--secondary btn--sm" 
                                               aria-label="Track this order">Track Order</a>
                                            <a href="#" 
                                               class="btn btn--ghost btn--sm" 
                                               aria-label="Reorder these items">Reorder</a>
                                            <a href="#" 
                                               class="btn btn--ghost btn--sm" 
                                               aria-label="Download invoice">Download Invoice</a>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </section>
    </main>
    
    <!-- Footer -->
    <c:import url="/components/organisms/footer/footer.jsp" />
    
    <!-- JavaScript -->
    <script src="<%= contextPath %>/js/main.js"></script>
    <script>
        // Order filtering and search functionality
        document.addEventListener('DOMContentLoaded', function() {
            const orderSearch = document.getElementById('orderSearch');
            const statusFilter = document.getElementById('statusFilter');
            const dateFilter = document.getElementById('dateFilter');
            
            function filterOrders() {
                const searchTerm = orderSearch.value;
                const statusValue = statusFilter.value;
                const dateValue = dateFilter.value;
                
                // Build query parameters
                const params = new URLSearchParams();
                if (searchTerm) params.append('orderNumber', searchTerm);
                if (statusValue) params.append('status', statusValue);
                if (dateValue) params.append('dateRange', dateValue);
                
                // Reload page with filters
                const contextPath = '<%= contextPath %>';
                window.location.href = contextPath + '/orderhistory?' + params.toString();
            }
            
            if (orderSearch) {
                orderSearch.addEventListener('input', filterOrders);
            }
            if (statusFilter) {
                statusFilter.addEventListener('change', filterOrders);
            }
            if (dateFilter) {
                dateFilter.addEventListener('change', filterOrders);
            }
        });
    </script>
</body>
</html>