<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.User" %>
<%@ page import="model.Order" %>
<%@ page import="java.util.List" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || (!"staff".equalsIgnoreCase(user.getRole()) && !"admin".equalsIgnoreCase(user.getRole()))) {
        response.sendRedirect("../../login.jsp");
        return;
    }
    String contextPath = request.getContextPath();
    
    @SuppressWarnings("unchecked")
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    if (orders == null) {
        orders = new java.util.ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Orders | IoT Bay - Admin Portal</title>
    <link rel="stylesheet" href="<%= contextPath %>/css/modern-theme.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="antialiased bg-neutral-50 text-neutral-900 min-h-screen flex flex-col">
    
    <c:import url="/components/organisms/header/header.jsp" />
    
    <main class="flex-1">
        <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
            <div class="container">
                <div class="max-w-6xl mx-auto">
                    <div class="flex items-center justify-between">
                        <div>
                            <h1 class="text-display-lg text-neutral-900 mb-2">
                                Manage <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Orders</span>
                            </h1>
                            <p class="text-lg text-neutral-600">View and manage customer orders</p>
                        </div>
                        <div class="flex items-center gap-3">
                            <a href="<%= contextPath %>/api/dataManagement/exportOrders" class="btn btn--secondary">Export Orders</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="py-8">
            <div class="container">
                <div class="max-w-6xl mx-auto">
                    <div class="bg-white rounded-xl shadow-sm border border-neutral-200 overflow-hidden">
                        <div class="overflow-x-auto">
                            <table class="w-full text-left border-collapse">
                                <thead>
                                    <tr class="bg-neutral-50 border-b border-neutral-200">
                                        <th class="p-4 font-semibold text-neutral-700">Order ID</th>
                                        <th class="p-4 font-semibold text-neutral-700">User ID</th>
                                        <th class="p-4 font-semibold text-neutral-700">Date</th>
                                        <th class="p-4 font-semibold text-neutral-700">Status</th>
                                        <th class="p-4 font-semibold text-neutral-700">Total</th>
                                        <th class="p-4 font-semibold text-neutral-700">Actions</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-neutral-200">
                                    <c:forEach var="order" items="<%= orders %>">
                                        <tr class="hover:bg-neutral-50 transition-colors">
                                            <td class="p-4 font-medium text-neutral-900">#${order.id}</td>
                                            <td class="p-4 text-neutral-600">${order.userId}</td>
                                            <td class="p-4 text-neutral-600">${order.orderDate}</td>
                                            <td class="p-4">
                                                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium
                                                    ${order.status == 'delivered' ? 'bg-green-100 text-green-800' : 
                                                      order.status == 'pending' ? 'bg-yellow-100 text-yellow-800' : 
                                                      order.status == 'cancelled' ? 'bg-red-100 text-red-800' : 'bg-blue-100 text-blue-800'}">
                                                    ${order.status}
                                                </span>
                                            </td>
                                            <td class="p-4 font-medium text-neutral-900">$${order.totalAmount}</td>
                                            <td class="p-4">
                                                <div class="flex items-center gap-2">
                                                    <button class="text-brand-primary hover:text-brand-secondary font-medium text-sm">View</button>
                                                    <button class="text-neutral-500 hover:text-neutral-700 font-medium text-sm">Edit</button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty orders}">
                                        <tr>
                                            <td colspan="6" class="p-8 text-center text-neutral-500">
                                                No orders found.
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <c:import url="/components/organisms/footer/footer.jsp" />

</body>
</html>
