<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
<%@ page import="java.util.*, model.*" %>

<%
    Object userObj = session.getAttribute("user");
    if (!(userObj instanceof User)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    String csrfToken = utils.SecurityUtil.generateCSRFToken(request);
%>

<t:base title="Edit Order | IoT Bay" description="Modify your pending order">
    <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
        <div class="container">
            <div class="max-w-3xl mx-auto">
                <a href="${pageContext.request.contextPath}/orderhistory"
                   class="text-neutral-500 hover:text-neutral-900 flex items-center gap-2 mb-4 text-sm">
                    &larr; Back to Order History
                </a>
                <h1 class="text-display-md text-neutral-900">
                    Edit <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Order</span>
                </h1>
                <c:if test="${not empty order}">
                    <p class="text-neutral-600 mt-2">Order #ORD-${order.id} &bull; Status: ${order.status}</p>
                </c:if>
            </div>
        </div>
    </section>

    <section class="py-8">
        <div class="container">
            <div class="max-w-3xl mx-auto">

                <c:if test="${not empty error}">
                    <div class="mb-6 rounded-lg border border-red-200 bg-red-50 p-4 text-sm text-red-800" role="alert">
                        <strong>Error:</strong> ${error}
                    </div>
                </c:if>

                <c:choose>
                    <c:when test="${empty order}">
                        <div class="bg-white rounded-xl shadow-sm border border-neutral-200 p-12 text-center">
                            <h3 class="text-lg font-semibold text-neutral-700 mb-2">Order Not Found</h3>
                            <p class="text-neutral-500 text-sm mb-4">This order does not exist or cannot be edited.</p>
                            <a href="${pageContext.request.contextPath}/orderhistory" class="btn btn--primary">Back to Orders</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="bg-white rounded-xl shadow-sm border border-neutral-200 overflow-hidden">
                            <div class="p-6 border-b border-neutral-200">
                                <h2 class="text-lg font-semibold text-neutral-900">Order Items</h2>
                                <p class="text-sm text-neutral-500 mt-1">
                                    Adjust quantities or remove items. Set quantity to 0 to remove an item.
                                </p>
                            </div>

                            <form action="${pageContext.request.contextPath}/order/update" method="post">
                                <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                                <input type="hidden" name="orderId" value="${order.id}">

                                <div class="divide-y divide-neutral-100">
                                    <c:choose>
                                        <c:when test="${empty orderItems}">
                                            <div class="p-8 text-center text-neutral-500 text-sm">
                                                No items found in this order.
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="item" items="${orderItems}">
                                                <div class="p-6 flex flex-col sm:flex-row sm:items-center gap-4">
                                                    <div class="flex-1">
                                                        <p class="font-medium text-neutral-900">
                                                            <c:choose>
                                                                <c:when test="${not empty item.productName}">
                                                                    ${item.productName}
                                                                </c:when>
                                                                <c:otherwise>
                                                                    Product #${item.productId}
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </p>
                                                        <p class="text-sm text-neutral-500">
                                                            Unit price: $<fmt:formatNumber value="${item.priceAtOrderTime}" minFractionDigits="2" maxFractionDigits="2"/>
                                                        </p>
                                                    </div>
                                                    <div class="flex items-center gap-3">
                                                        <label class="text-sm text-neutral-600">Qty:</label>
                                                        <input type="number"
                                                               name="quantity_${item.productId}"
                                                               value="${item.quantity}"
                                                               min="0"
                                                               max="${item.quantity + 10}"
                                                               class="form-input w-20 text-center">
                                                        <input type="hidden" name="productId" value="${item.productId}">
                                                        <span class="text-sm font-medium text-neutral-700 w-20 text-right">
                                                            $<fmt:formatNumber value="${item.quantity * item.priceAtOrderTime}" minFractionDigits="2" maxFractionDigits="2"/>
                                                        </span>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="p-6 border-t border-neutral-200 flex justify-between items-center">
                                    <a href="${pageContext.request.contextPath}/orderhistory" class="btn btn--outline">
                                        Cancel
                                    </a>
                                    <button type="submit" class="btn btn--primary">
                                        Save Changes
                                    </button>
                                </div>
                            </form>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>
    </section>
</t:base>
