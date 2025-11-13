<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String contextPath = request.getContextPath();
    
    // Mock order data
    List<Object> orders = new ArrayList<>();
    // This would normally come from a service/DAO
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
    <jsp:include page="components/header.jsp" />
    
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
                            <div class="flex items-center gap-4">
                                <div class="relative">
                                    <input type="text" placeholder="Search orders..." class="form-input pr-10">
                                    <svg class="absolute right-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-neutral-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                                    </svg>
                                </div>
                                <select class="form-select">
                                    <option>All Status</option>
                                    <option>Pending</option>
                                    <option>Processing</option>
                                    <option>Shipped</option>
                                    <option>Delivered</option>
                                    <option>Cancelled</option>
                                </select>
                            </div>
                            <div class="flex items-center gap-2">
                                <span class="text-sm text-neutral-600">Sort by:</span>
                                <select class="form-select form-select--sm">
                                    <option>Most Recent</option>
                                    <option>Oldest First</option>
                                    <option>Order Total</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Orders List -->
                    <div class="space-y-6">
                        <% if (orders.isEmpty()) { %>
                            <!-- Empty State -->
                            <div class="empty-state text-center py-16">
                                <svg class="w-20 h-20 text-neutral-400 mx-auto mb-6" fill="currentColor" viewBox="0 0 20 20">
                                    <path d="M3 4a1 1 0 011-1h12a1 1 0 011 1v2a1 1 0 01-1 1H4a1 1 0 01-1-1V4zM3 10a1 1 0 011-1h6a1 1 0 011 1v6a1 1 0 01-1 1H4a1 1 0 01-1-1v-6zM14 9a1 1 0 00-1 1v6a1 1 0 001 1h2a1 1 0 001-1v-6a1 1 0 00-1-1h-2z"></path>
                                </svg>
                                <h3 class="text-2xl font-semibold text-neutral-900 mb-3">No Orders Found</h3>
                                <p class="text-neutral-600 mb-6">
                                    You haven't placed any orders yet. Start shopping to see your orders here.
                                </p>
                                <a href="<%= contextPath %>/browse.jsp" class="btn btn--primary">Start Shopping</a>
                            </div>
                        <% } else { %>
                            <!-- Sample Order Card -->
                            <div class="card p-6 hover-lift">
                                <div class="flex flex-col md:flex-row md:items-center justify-between mb-4">
                                    <div>
                                        <h3 class="text-lg font-semibold text-neutral-900">Order #ORD-2024-001</h3>
                                        <p class="text-sm text-neutral-600">Placed on March 15, 2024</p>
                                    </div>
                                    <div class="flex items-center gap-4 mt-2 md:mt-0">
                                        <span class="badge badge--success">Delivered</span>
                                        <span class="text-lg font-semibold text-neutral-900">$299.99</span>
                                    </div>
                                </div>
                                
                                <div class="border-t border-neutral-200 pt-4">
                                    <div class="flex items-center gap-4">
                                        <img src="<%= contextPath %>/images/sample1.png" alt="Product" class="w-16 h-16 rounded-lg object-cover">
                                        <div class="flex-1">
                                            <h4 class="font-medium text-neutral-900">Smart Home Hub Pro</h4>
                                            <p class="text-sm text-neutral-600">Quantity: 1</p>
                                        </div>
                                        <div class="text-right">
                                            <p class="font-medium text-neutral-900">$299.99</p>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="flex flex-col sm:flex-row gap-3 mt-4">
                                    <a href="#" class="btn btn--outline btn--sm">View Details</a>
                                    <a href="#" class="btn btn--secondary btn--sm">Reorder</a>
                                    <a href="#" class="btn btn--ghost btn--sm">Track Package</a>
                                </div>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </section>
    </main>
    
    <!-- Footer -->
    <jsp:include page="components/footer.jsp" />
    
    <!-- JavaScript -->
    <script src="<%= contextPath %>/js/main.js"></script>
</body>
</html>