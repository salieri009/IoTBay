<jsp:body>
    <!-- Page Header -->
    <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
        <div class="container">
            <div class="max-w-6xl mx-auto">
                <div class="flex items-center justify-between">
                    <div>
                        <h1 class="text-display-lg text-neutral-900 mb-2">
                            Manage <span
                                class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Orders</span>
                        </h1>
                        <p class="text-lg text-neutral-600">View and manage
                            customer orders</p>
                    </div>
                    <div class="flex items-center gap-3">
                        <jsp:include page="/components/atoms/button/button.jsp">
                            <jsp:param name="text" value="Export Orders" />
                            <jsp:param name="type" value="secondary" />
                            <jsp:param name="href"
                                value="${pageContext.request.contextPath}/api/dataManagement/exportOrders" />
                        </jsp:include>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Orders Table -->
    <section class="py-8">
        <div class="container">
            <div class="max-w-6xl mx-auto">
                <div class="bg-white rounded-xl shadow-sm border border-neutral-200 overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="w-full text-left border-collapse">
                            <thead>
                                <tr class="bg-neutral-50 border-b border-neutral-200">
                                    <th class="p-4 font-semibold text-neutral-700">
                                        Order ID</th>
                                    <th class="p-4 font-semibold text-neutral-700">
                                        User ID</th>
                                    <th class="p-4 font-semibold text-neutral-700">
                                        Date</th>
                                    <th class="p-4 font-semibold text-neutral-700">
                                        Status</th>
                                    <th class="p-4 font-semibold text-neutral-700">
                                        Total</th>
                                    <th class="p-4 font-semibold text-neutral-700">
                                        Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-neutral-200">
                                <c:forEach var="order" items="<%= orders %>">
                                    <tr class="hover:bg-neutral-50 transition-colors">
                                        <td class="p-4 font-medium text-neutral-900">
                                            #${order.id}</td>
                                        <td class="p-4 text-neutral-600">
                                            ${order.userId}</td>
                                        <td class="p-4 text-neutral-600">
                                            ${order.orderDate}</td>
                                        <td class="p-4">
                                            <c:set var="badgeType" value="neutral" />
                                            <c:choose>
                                                <c:when test="${order.status == 'delivered'}">
                                                    <c:set var="badgeType" value="success" />
                                                </c:when>
                                                <c:when test="${order.status == 'pending'}">
                                                    <c:set var="badgeType" value="warning" />
                                                </c:when>
                                                <c:when test="${order.status == 'cancelled'}">
                                                    <c:set var="badgeType" value="error" />
                                                </c:when>
                                                <c:otherwise>
                                                    <c:set var="badgeType" value="neutral" />
                                                </c:otherwise>
                                            </c:choose>
                                            <jsp:include page="/components/atoms/badge/badge.jsp">
                                                <jsp:param name="text" value="${order.status}" />
                                                <jsp:param name="type" value="${badgeType}" />
                                            </jsp:include>
                                        </td>
                                        <td class="p-4 font-medium text-neutral-900">
                                            $${order.totalAmount}</td>
                                        <td class="p-4">
                                            <div class="flex items-center gap-2">
                                                <jsp:include page="/components/atoms/button/button.jsp">
                                                    <jsp:param name="text" value="View" />
                                                    <jsp:param name="type" value="ghost" />
                                                    <jsp:param name="size" value="small" />
                                                </jsp:include>
                                                <jsp:include page="/components/atoms/button/button.jsp">
                                                    <jsp:param name="text" value="Edit" />
                                                    <jsp:param name="type" value="ghost" />
                                                    <jsp:param name="size" value="small" />
                                                </jsp:include>
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
</jsp:body>
</t:base>