<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
<%@ page import="model.*" %>

<%
    Object userObj = session.getAttribute("user");
    if (!(userObj instanceof User)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    User user = (User) userObj;
    String csrfToken = utils.SecurityUtil.generateCSRFToken(request);
    model.Shipment shipment = (model.Shipment) request.getAttribute("shipment");
    if (shipment == null) {
        response.sendError(404);
        return;
    }
    boolean canModify = "PENDING".equals(shipment.getShippingStatus()) || "PREPARING".equals(shipment.getShippingStatus());
    boolean isStaff = "staff".equalsIgnoreCase(user.getRole());
%>

<t:base title="Shipment #<%= shipment.getId() %> | IoT Bay">
    <section class="py-8 bg-white border-b-2 border-brand-primary">
        <div class="l-container">
            <div class="max-w-3xl mx-auto">
                <a href="${pageContext.request.contextPath}/shipment/"
                   class="text-neutral-600 hover:text-brand-primary font-medium flex items-center gap-2 mb-4 text-sm transition-colors">
                    &larr; Back to Shipments
                </a>
                <div class="flex items-center justify-between">
                    <h1 class="text-display-md text-neutral-900">
                        Shipment <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">#<%= shipment.getId() %></span>
                    </h1>
                    <c:if test="${not empty error}">
                        <span class="text-red-600 text-sm"><c:out value="${error}"/></span>
                    </c:if>
                </div>
            </div>
        </div>
    </section>

    <section class="py-8">
        <div class="l-container">
            <div class="max-w-3xl mx-auto space-y-6">

                <!-- Success message -->
                <%
                    String successMsg = (String) session.getAttribute("successMessage");
                    if (successMsg != null) { session.removeAttribute("successMessage"); %>
                <div class="rounded-lg border border-green-200 bg-green-50 p-4 text-sm text-green-800"><%= successMsg %></div>
                <% } %>

                <!-- Shipment Details Card -->
                <div class="bg-white rounded-xl shadow-sm border border-neutral-200 p-6">
                    <h2 class="text-lg font-semibold text-neutral-900 mb-4">Shipment Details</h2>
                    <dl class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <dt class="text-xs font-medium uppercase tracking-wide text-neutral-600 mb-0.5">Shipment ID</dt>
                            <dd class="text-sm font-medium text-neutral-900">#<%= shipment.getId() %></dd>
                        </div>
                        <div>
                            <dt class="text-xs font-medium uppercase tracking-wide text-neutral-600 mb-0.5">Order</dt>
                            <dd class="text-sm font-medium text-neutral-900">
                                <a href="${pageContext.request.contextPath}/orderList.jsp" class="text-brand-primary hover:underline">
                                    Order #<%= shipment.getOrderId() %>
                                </a>
                            </dd>
                        </div>
                        <div>
                            <dt class="text-xs font-medium uppercase tracking-wide text-neutral-600 mb-0.5">Status</dt>
                            <dd>
                                <% String status = shipment.getShippingStatus(); if (status == null) status = "PENDING"; %>
                                <% if ("PENDING".equals(status)) { %>
                                    <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800">Pending</span>
                                <% } else if ("PREPARING".equals(status)) { %>
                                    <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800">Preparing</span>
                                <% } else if ("SHIPPED".equals(status)) { %>
                                    <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-purple-100 text-purple-800">Shipped</span>
                                <% } else if ("DELIVERED".equals(status)) { %>
                                    <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">Delivered</span>
                                <% } else { %>
                                    <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-neutral-100 text-neutral-700"><%= status %></span>
                                <% } %>
                            </dd>
                        </div>
                        <div>
                            <dt class="text-xs font-medium uppercase tracking-wide text-neutral-600 mb-0.5">Carrier</dt>
                            <dd class="text-sm font-medium text-neutral-900"><%= shipment.getCarrier() != null ? shipment.getCarrier() : "—" %></dd>
                        </div>
                        <div>
                            <dt class="text-xs font-medium uppercase tracking-wide text-neutral-600 mb-0.5">Shipping Date</dt>
                            <dd class="text-sm font-medium text-neutral-900"><%= shipment.getShippingDate() != null ? shipment.getShippingDate().toLocalDate() : "—" %></dd>
                        </div>
                        <div>
                            <dt class="text-xs font-medium uppercase tracking-wide text-neutral-600 mb-0.5">Delivery Date</dt>
                            <dd class="text-sm font-medium text-neutral-900"><%= shipment.getDeliveryDate() != null ? shipment.getDeliveryDate().toLocalDate() : "—" %></dd>
                        </div>
                        <div>
                            <dt class="text-xs font-medium uppercase tracking-wide text-neutral-600 mb-0.5">Tracking Number</dt>
                            <dd class="text-sm font-medium text-neutral-900"><%= shipment.getTrackingNumber() != null ? shipment.getTrackingNumber() : "—" %></dd>
                        </div>
                        <div>
                            <dt class="text-xs font-medium uppercase tracking-wide text-neutral-600 mb-0.5">Notes / Address</dt>
                            <dd class="text-sm font-medium text-neutral-900"><%= shipment.getNotes() != null ? shipment.getNotes() : "—" %></dd>
                        </div>
                    </dl>
                </div>

                <!-- Actions for editable shipments -->
                <% if (canModify) { %>
                <div class="bg-white rounded-xl shadow-sm border border-neutral-200 p-6">
                    <h2 class="text-lg font-semibold text-neutral-900 mb-4">Actions</h2>
                    <div class="flex gap-3">
                        <a href="${pageContext.request.contextPath}/shipment/form?shipmentId=<%= shipment.getId() %>"
                           class="btn btn--primary">Edit Shipment</a>
                        <form action="${pageContext.request.contextPath}/shipment/delete" method="post"
                              onsubmit="return confirm('Delete this shipment? This cannot be undone.');">
                            <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                            <input type="hidden" name="shipmentId" value="<%= shipment.getId() %>">
                            <button type="submit" class="btn btn--error">Delete Shipment</button>
                        </form>
                    </div>
                </div>
                <% } %>

                <!-- Staff status update -->
                <% if (isStaff) { %>
                <div class="bg-white rounded-xl shadow-sm border border-neutral-200 p-6">
                    <h2 class="text-lg font-semibold text-neutral-900 mb-4">Update Status (Staff)</h2>
                    <form action="${pageContext.request.contextPath}/shipment/update-status" method="post"
                          class="flex gap-4 items-end">
                        <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                        <input type="hidden" name="shipmentId" value="<%= shipment.getId() %>">
                        <div>
                            <label class="block text-sm font-medium text-neutral-700 mb-1">New Status</label>
                            <select name="status" class="form-input">
                                <option value="PENDING">Pending</option>
                                <option value="PREPARING">Preparing</option>
                                <option value="SHIPPED">Shipped</option>
                                <option value="DELIVERED">Delivered</option>
                            </select>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-neutral-700 mb-1">Tracking Number</label>
                            <input type="text" name="trackingNumber" class="form-input"
                                   placeholder="e.g. AUS1234567"
                                   value="<%= shipment.getTrackingNumber() != null ? shipment.getTrackingNumber() : "" %>">
                        </div>
                        <button type="submit" class="btn btn--secondary">Update Status</button>
                    </form>
                </div>
                <% } %>

            </div>
        </div>
    </section>
</t:base>
