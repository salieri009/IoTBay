<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

            <t:base title="Manage Orders" description="View and manage customer orders">
                <!-- Page Header -->
                <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
                    <div class="container mx-auto px-4 sm:px-6 lg:px-8">
                        <div class="max-w-6xl mx-auto">
                            <div class="flex items-center justify-between">
                                <div>
                                    <h1 class="text-3xl font-bold text-neutral-900 mb-2">
                                        Manage <span
                                            class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Orders</span>
                                    </h1>
                                    <p class="text-lg text-neutral-600">View and manage customer orders</p>
                                </div>
                                <div class="flex items-center gap-3">
                                    <a href="${pageContext.request.contextPath}/api/dataManagement/exportOrders"
                                        class="inline-flex items-center px-4 py-2 border border-neutral-300 shadow-sm text-sm font-medium rounded-md text-neutral-700 bg-white hover:bg-neutral-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-brand-primary">
                                        Export Orders
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Orders Table -->
                <section class="py-8">
                    <div class="container mx-auto px-4 sm:px-6 lg:px-8">
                        <div class="max-w-6xl mx-auto">
                            <div class="bg-white rounded-xl shadow-sm border border-neutral-200 overflow-hidden">
                                <div class="overflow-x-auto">
                                    <table class="min-w-full divide-y divide-neutral-200">
                                        <thead class="bg-neutral-50">
                                            <tr>
                                                <th scope="col"
                                                    class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                    Order ID</th>
                                                <th scope="col"
                                                    class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                    User ID</th>
                                                <th scope="col"
                                                    class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                    Date</th>
                                                <th scope="col"
                                                    class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                    Status</th>
                                                <th scope="col"
                                                    class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                    Total</th>
                                                <th scope="col"
                                                    class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                    Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody class="bg-white divide-y divide-neutral-200">
                                            <c:choose>
                                                <c:when test="${not empty orders}">
                                                    <c:forEach var="order" items="${orders}">
                                                        <tr class="hover:bg-neutral-50 transition-colors">
                                                            <td
                                                                class="px-6 py-4 whitespace-nowrap text-sm font-medium text-neutral-900">
                                                                #
                                                                <c:out value="${order.id}" />
                                                            </td>
                                                            <td
                                                                class="px-6 py-4 whitespace-nowrap text-sm text-neutral-500">
                                                                <c:out value="${order.userId}" />
                                                            </td>
                                                            <td
                                                                class="px-6 py-4 whitespace-nowrap text-sm text-neutral-500">
                                                                <c:out value="${order.orderDate}" />
                                                            </td>
                                                            <td class="px-6 py-4 whitespace-nowrap">
                                                                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium
                                                        <c:choose>
                                                            <c:when test=" ${order.status=='delivered' }">bg-green-100
                                                                    text-green-800
                                                </c:when>
                                                <c:when test="${order.status == 'pending'}">bg-yellow-100
                                                    text-yellow-800</c:when>
                                                <c:when test="${order.status == 'cancelled'}">bg-red-100 text-red-800
                                                </c:when>
                                                <c:otherwise>bg-gray-100 text-gray-800</c:otherwise>
                                            </c:choose>">
                                            <c:out value="${order.status}" />
                                            </span>
                                            </td>
                                            <td
                                                class="px-6 py-4 whitespace-nowrap text-sm font-medium text-neutral-900">
                                                $
                                                <c:out value="${order.totalAmount}" />
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                                <div class="flex items-center gap-2">
                                                    <a href="#"
                                                        class="text-brand-primary hover:text-brand-secondary">View</a>
                                                    <a href="#"
                                                        class="text-brand-primary hover:text-brand-secondary">Edit</a>
                                                </div>
                                            </td>
                                            </tr>
                                            </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="6"
                                                        class="px-6 py-12 text-center text-sm text-neutral-500">
                                                        No orders found.
                                                    </td>
                                                </tr>
                                            </c:otherwise>
                                            </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </t:base>