<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
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

<t:base 
    title="Order History" 
    description="View your order history and track order status">
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
                                <jsp:include page="/components/atoms/button/button.jsp">
                                    <jsp:param name="type" value="primary" />
                                    <jsp:param name="text" value="Start Shopping" />
                                    <jsp:param name="href" value="${pageContext.request.contextPath}/browse.jsp" />
                                </jsp:include>
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
                                                    <jsp:include page="/components/atoms/badge/badge.jsp">
                                                        <jsp:param name="type" value="success" />
                                                        <jsp:param name="text" value="Shipped" />
                                                    </jsp:include>
                                                </c:when>
                                                <c:when test="${order.status == 'PENDING'}">
                                                    <jsp:include page="/components/atoms/badge/badge.jsp">
                                                        <jsp:param name="type" value="warning" />
                                                        <jsp:param name="text" value="Pending" />
                                                    </jsp:include>
                                                </c:when>
                                                <c:when test="${order.status == 'DELIVERED'}">
                                                    <jsp:include page="/components/atoms/badge/badge.jsp">
                                                        <jsp:param name="type" value="success" />
                                                        <jsp:param name="text" value="Delivered" />
                                                    </jsp:include>
                                                </c:when>
                                                <c:when test="${order.status == 'CANCELLED'}">
                                                    <jsp:include page="/components/atoms/badge/badge.jsp">
                                                        <jsp:param name="type" value="error" />
                                                        <jsp:param name="text" value="Cancelled" />
                                                    </jsp:include>
                                                </c:when>
                                                <c:otherwise>
                                                    <jsp:include page="/components/atoms/badge/badge.jsp">
                                                        <jsp:param name="type" value="info" />
                                                        <jsp:param name="text" value="${order.status}" />
                                                    </jsp:include>
                                                </c:otherwise>
                                            </c:choose>
                                            <span class="text-lg font-semibold text-neutral-900">
                                                $<fmt:formatNumber value="${order.totalAmount}" minFractionDigits="2" maxFractionDigits="2" />
                                            </span>
                                        </div>
                                    </div>
                                    
                                    <!-- Order Items Summary -->
                                    <div class="border-t border-neutral-200 pt-4 mb-4">
                                        <div class="flex -space-x-2 overflow-hidden mb-2">
                                            <c:forEach var="item" items="${order.orderItems}" end="4">
                                                <img class="inline-block h-10 w-10 rounded-full ring-2 ring-white object-cover" 
                                                     src="${not empty item.product.imageUrl ? item.product.imageUrl : 'images/default-product.png'}" 
                                                     alt="${item.product.name}"
                                                     title="${item.product.name} (x${item.quantity})"
                                                     onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default-product.png';">
                                            </c:forEach>
                                            <c:if test="${fn:length(order.orderItems) > 5}">
                                                <div class="flex items-center justify-center h-10 w-10 rounded-full ring-2 ring-white bg-neutral-100 text-xs font-medium text-neutral-600">
                                                    +${fn:length(order.orderItems) - 5}
                                                </div>
                                            </c:if>
                                        </div>
                                        <p class="text-sm text-neutral-600">
                                            <c:forEach var="item" items="${order.orderItems}" varStatus="status">
                                                <c:if test="${status.index < 2}">
                                                    ${item.product.name} (x${item.quantity})<c:if test="${!status.last && status.index < 1}">, </c:if>
                                                </c:if>
                                            </c:forEach>
                                            <c:if test="${fn:length(order.orderItems) > 2}">
                                                and ${fn:length(order.orderItems) - 2} more items
                                            </c:if>
                                        </p>
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
                                        <!-- View Details Button -->
                                        <jsp:include page="/components/atoms/button/button.jsp">
                                            <jsp:param name="type" value="secondary" />
                                            <jsp:param name="text" value="View Details" />
                                            <jsp:param name="href" value="${pageContext.request.contextPath}/order-details.jsp?orderId=${order.id}" />
                                        </jsp:include>
                                        <!-- Reorder Button (if delivered or cancelled) -->
                                        <c:choose>
                                            <c:when test="${order.status == 'DELIVERED' || order.status == 'CANCELLED'}">
                                                <jsp:include page="/components/atoms/button/button.jsp">
                                                    <jsp:param name="type" value="primary" />
                                                    <jsp:param name="text" value="Reorder" />
                                                    <jsp:param name="href" value="${pageContext.request.contextPath}/reorder.jsp?orderId=${order.id}" />
                                                </jsp:include>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </section>
</t:base>
