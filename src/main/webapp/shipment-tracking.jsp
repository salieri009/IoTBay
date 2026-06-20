<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
<%@ page import="model.*" %>

<%
    model.Shipment shipment = (model.Shipment) request.getAttribute("shipment");
    model.Order order = (model.Order) request.getAttribute("order");
    String errorMsg = (String) request.getAttribute("error");
%>

<t:base title="Track Shipment | IoT Bay" description="Track your shipment status by tracking number">

    <!-- Page Header -->
    <section class="py-8 bg-white border-b-2 border-brand-primary">
        <div class="l-container">
            <div class="max-w-3xl mx-auto">
                <a href="${pageContext.request.contextPath}/shipment/list"
                   class="text-neutral-500 hover:text-neutral-900 flex items-center gap-2 mb-4 text-sm">
                    &larr; Back to Shipments
                </a>
                <h1 class="text-display-lg text-neutral-900 mb-2">
                    Track <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Shipment</span>
                </h1>
                <p class="text-neutral-600">Enter your tracking number to see the latest status of your delivery.</p>
            </div>
        </div>
    </section>

    <section class="py-8">
        <div class="l-container">
            <div class="max-w-3xl mx-auto">

                <!-- Tracking Search Form -->
                <div class="card mb-8">
                    <div class="card-body p-6">
                        <h2 class="text-heading-md text-neutral-900 mb-4">Enter Tracking Number</h2>
                        <form method="GET" action="${pageContext.request.contextPath}/shipment/track" class="flex gap-3">
                            <input type="text"
                                   name="trackingNumber"
                                   placeholder="e.g. TRK-2025-001234"
                                   value="${param.trackingNumber}"
                                   class="form-input flex-1"
                                   required />
                            <button type="submit" class="btn btn-primary">Track</button>
                        </form>
                    </div>
                </div>

                <!-- Error Message -->
                <% if (errorMsg != null) { %>
                <div class="alert alert-error mb-6" role="alert">
                    <c:out value="<%= errorMsg %>" />
                </div>
                <% } %>

                <!-- Tracking Result -->
                <% if (shipment != null) { %>
                <div class="card">
                    <div class="card-header p-6 border-b border-neutral-100">
                        <div class="flex items-center justify-between">
                            <h2 class="text-heading-md text-neutral-900">
                                Shipment #<c:out value="<%= shipment.getId() %>" />
                            </h2>
                            <span class="badge
                                <% if ("DELIVERED".equals(shipment.getShippingStatus())) { %>badge-success<% }
                                   else if ("SHIPPED".equals(shipment.getShippingStatus())) { %>badge-info<% }
                                   else if ("CANCELLED".equals(shipment.getShippingStatus())) { %>badge-error<% }
                                   else { %>badge-warning<% } %>">
                                <c:out value="<%= shipment.getShippingStatus() %>" />
                            </span>
                        </div>
                    </div>

                    <div class="card-body p-6">
                        <dl class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <dt class="text-sm font-medium text-neutral-500 mb-1">Tracking Number</dt>
                                <dd class="text-neutral-900 font-mono">
                                    <c:out value="<%= shipment.getTrackingNumber() != null ? shipment.getTrackingNumber() : param.trackingNumber %>" />
                                </dd>
                            </div>
                            <% if (order != null) { %>
                            <div>
                                <dt class="text-sm font-medium text-neutral-500 mb-1">Order ID</dt>
                                <dd class="text-neutral-900">#<c:out value="<%= order.getOrderId() %>" /></dd>
                            </div>
                            <% } %>
                            <div>
                                <dt class="text-sm font-medium text-neutral-500 mb-1">Carrier</dt>
                                <dd class="text-neutral-900">
                                    <c:out value="<%= shipment.getCarrier() != null ? shipment.getCarrier() : 'N/A' %>" />
                                </dd>
                            </div>
                            <div>
                                <dt class="text-sm font-medium text-neutral-500 mb-1">Ship Date</dt>
                                <dd class="text-neutral-900">
                                    <% if (shipment.getShippingDate() != null) { %>
                                        <c:out value="<%= shipment.getShippingDate().toLocalDate() %>" />
                                    <% } else { %>
                                        N/A
                                    <% } %>
                                </dd>
                            </div>
                            <% if (shipment.getDeliveryDate() != null) { %>
                            <div>
                                <dt class="text-sm font-medium text-neutral-500 mb-1">Delivered</dt>
                                <dd class="text-neutral-900 text-green-600 font-medium">
                                    <c:out value="<%= shipment.getDeliveryDate().toLocalDate() %>" />
                                </dd>
                            </div>
                            <% } %>
                            <% if (shipment.getNotes() != null && !shipment.getNotes().isEmpty()) { %>
                            <div class="md:col-span-2">
                                <dt class="text-sm font-medium text-neutral-500 mb-1">Delivery Address</dt>
                                <dd class="text-neutral-900"><c:out value="<%= shipment.getNotes() %>" /></dd>
                            </div>
                            <% } %>
                        </dl>
                    </div>
                </div>
                <% } else if (param.trackingNumber != null && !param.trackingNumber.isEmpty() && errorMsg == null) { %>

                <!-- No Result -->
                <div class="card">
                    <div class="card-body p-8 text-center">
                        <div class="text-neutral-400 text-4xl mb-4">&#128269;</div>
                        <h3 class="text-heading-md text-neutral-700 mb-2">No shipment found</h3>
                        <p class="text-neutral-500">
                            No shipment was found for tracking number
                            <strong class="font-mono"><c:out value="${param.trackingNumber}" /></strong>.
                            Please check the number and try again.
                        </p>
                    </div>
                </div>
                <% } %>

            </div>
        </div>
    </section>

</t:base>
