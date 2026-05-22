<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
<%@ page import="java.util.*, model.*" %>

<%
    Object userObj = session.getAttribute("user");
    if (!(userObj instanceof User)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    User user = (User) userObj;
    String csrfToken = utils.SecurityUtil.generateCSRFToken(request);
%>

<t:base title="Shipments | IoT Bay" description="View and manage your shipments">
    <!-- Page Header -->
    <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
        <div class="container">
            <div class="max-w-5xl mx-auto">
                <a href="${pageContext.request.contextPath}/orderList.jsp"
                    class="text-neutral-500 hover:text-neutral-900 flex items-center gap-2 mb-4 text-sm">
                    &larr; Back to Orders
                </a>
                <h1 class="text-display-lg text-neutral-900 mb-2">
                    My <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Shipments</span>
                </h1>
                <p class="text-neutral-600">Track and manage your delivery information.</p>
            </div>
        </div>
    </section>

    <section class="py-8">
        <div class="container">
            <div class="max-w-5xl mx-auto">

                <!-- Success/Error Messages -->
                <%
                    String successMsg = (String) session.getAttribute("successMessage");
                    if (successMsg != null) {
                        session.removeAttribute("successMessage");
                %>
                <div class="mb-6 rounded-lg border border-green-200 bg-green-50 p-4 text-sm text-green-800" role="alert">
                    <%= successMsg %>
                </div>
                <% } %>
                <c:if test="${not empty error}">
                    <div class="mb-6 rounded-lg border border-red-200 bg-red-50 p-4 text-sm text-red-800" role="alert">
                        <strong>Error:</strong> <c:out value="${error}"/>
                    </div>
                </c:if>

                <!-- Search Form -->
                <div class="bg-white rounded-xl shadow-sm border border-neutral-200 p-6 mb-6">
                    <h2 class="text-lg font-semibold text-neutral-900 mb-4">Search Shipments</h2>
                    <form action="${pageContext.request.contextPath}/shipment/search" method="get"
                          class="grid grid-cols-1 md:grid-cols-4 gap-4">
                        <div>
                            <label class="block text-sm font-medium text-neutral-700 mb-1">Shipment ID</label>
                            <input type="number" name="shipmentId" class="form-input w-full"
                                   placeholder="e.g. 5"
                                   value="${param.shipmentId}">
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-neutral-700 mb-1">Tracking #</label>
                            <input type="text" name="trackingNumber" class="form-input w-full"
                                   placeholder="Tracking number"
                                   value="${param.trackingNumber}">
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-neutral-700 mb-1">Status</label>
                            <select name="status" class="form-input w-full">
                                <option value="">All</option>
                                <option value="PENDING" ${param.status=='PENDING'?'selected':''}>Pending</option>
                                <option value="PREPARING" ${param.status=='PREPARING'?'selected':''}>Preparing</option>
                                <option value="SHIPPED" ${param.status=='SHIPPED'?'selected':''}>Shipped</option>
                                <option value="DELIVERED" ${param.status=='DELIVERED'?'selected':''}>Delivered</option>
                            </select>
                        </div>
                        <div class="flex items-end gap-2">
                            <button type="submit" class="btn btn--primary">Search</button>
                            <a href="${pageContext.request.contextPath}/shipment/" class="btn btn--outline">Reset</a>
                        </div>
                    </form>
                </div>

                <!-- Shipments List -->
                <div class="bg-white rounded-xl shadow-sm border border-neutral-200 overflow-hidden">
                    <div class="p-6 border-b border-neutral-200 flex items-center justify-between">
                        <h2 class="text-lg font-semibold text-neutral-900">
                            Shipments
                            <c:if test="${not empty shipments}">
                                <span class="ml-2 text-sm font-normal text-neutral-500">(${fn:length(shipments)} records)</span>
                            </c:if>
                        </h2>
                    </div>

                    <c:choose>
                        <c:when test="${empty shipments}">
                            <div class="text-center py-16">
                                <svg class="w-16 h-16 text-neutral-300 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"/>
                                </svg>
                                <h3 class="text-lg font-semibold text-neutral-700 mb-2">No shipments found</h3>
                                <p class="text-neutral-500 text-sm">No shipment records match your criteria.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="overflow-x-auto">
                                <table class="w-full text-left">
                                    <thead class="bg-neutral-50 border-b border-neutral-200">
                                        <tr>
                                            <th class="px-6 py-3 text-xs font-medium text-neutral-500 uppercase">ID</th>
                                            <th class="px-6 py-3 text-xs font-medium text-neutral-500 uppercase">Order</th>
                                            <th class="px-6 py-3 text-xs font-medium text-neutral-500 uppercase">Carrier</th>
                                            <th class="px-6 py-3 text-xs font-medium text-neutral-500 uppercase">Status</th>
                                            <th class="px-6 py-3 text-xs font-medium text-neutral-500 uppercase">Ship Date</th>
                                            <th class="px-6 py-3 text-xs font-medium text-neutral-500 uppercase">Tracking #</th>
                                            <th class="px-6 py-3 text-xs font-medium text-neutral-500 uppercase">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody class="divide-y divide-neutral-100">
                                        <c:forEach var="s" items="${shipments}">
                                            <tr class="hover:bg-neutral-50 transition-colors">
                                                <td class="px-6 py-4 text-sm font-semibold text-neutral-900">#${s.id}</td>
                                                <td class="px-6 py-4 text-sm text-neutral-600">Order #${s.orderId}</td>
                                                <td class="px-6 py-4 text-sm text-neutral-600">
                                                    <c:choose>
                                                        <c:when test="${not empty s.carrier}">${s.carrier}</c:when>
                                                        <c:otherwise><span class="text-neutral-400">—</span></c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="px-6 py-4">
                                                    <c:choose>
                                                        <c:when test="${s.shippingStatus == 'PENDING'}">
                                                            <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800">Pending</span>
                                                        </c:when>
                                                        <c:when test="${s.shippingStatus == 'PREPARING'}">
                                                            <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800">Preparing</span>
                                                        </c:when>
                                                        <c:when test="${s.shippingStatus == 'SHIPPED'}">
                                                            <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-purple-100 text-purple-800">Shipped</span>
                                                        </c:when>
                                                        <c:when test="${s.shippingStatus == 'DELIVERED'}">
                                                            <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">Delivered</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-neutral-100 text-neutral-700">${s.shippingStatus}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="px-6 py-4 text-sm text-neutral-600">
                                                    <c:choose>
                                                        <c:when test="${s.shippingDate != null}">${s.shippingDate}</c:when>
                                                        <c:otherwise><span class="text-neutral-400">—</span></c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="px-6 py-4 text-sm text-neutral-600">
                                                    <c:choose>
                                                        <c:when test="${not empty s.trackingNumber}">${s.trackingNumber}</c:when>
                                                        <c:otherwise><span class="text-neutral-400">—</span></c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="px-6 py-4">
                                                    <div class="flex gap-2">
                                                        <a href="${pageContext.request.contextPath}/shipment/view/${s.id}"
                                                           class="btn btn--secondary btn--sm">View</a>
                                                        <c:if test="${s.shippingStatus == 'PENDING' || s.shippingStatus == 'PREPARING'}">
                                                            <a href="${pageContext.request.contextPath}/shipment/form?shipmentId=${s.id}"
                                                               class="btn btn--outline btn--sm">Edit</a>
                                                            <form action="${pageContext.request.contextPath}/shipment/delete"
                                                                  method="post" style="display:inline;"
                                                                  onsubmit="return confirm('Delete this shipment?');">
                                                                <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                                                                <input type="hidden" name="shipmentId" value="${s.id}">
                                                                <button type="submit" class="btn btn--error btn--sm">Delete</button>
                                                            </form>
                                                        </c:if>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </section>
</t:base>
