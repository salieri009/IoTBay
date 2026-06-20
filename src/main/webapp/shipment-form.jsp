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
    String csrfToken = utils.SecurityUtil.generateCSRFToken(request);
    model.Shipment editShipment = (model.Shipment) request.getAttribute("shipment");
    boolean isEdit = editShipment != null;
    String orderId = request.getParameter("orderId");
    if (!isEdit && orderId == null) orderId = "";
%>

<t:base title="${isEdit ? 'Edit Shipment' : 'Add Shipment'} | IoT Bay">
    <section class="py-8 bg-white border-b-2 border-brand-primary">
        <div class="l-container">
            <div class="max-w-2xl mx-auto">
                <a href="${pageContext.request.contextPath}/shipment/"
                   class="text-neutral-500 hover:text-neutral-900 flex items-center gap-2 mb-4 text-sm">
                    &larr; Back to Shipments
                </a>
                <h1 class="text-display-md text-neutral-900 mb-2">
                    <% if (isEdit) { %>
                        Edit <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Shipment</span>
                    <% } else { %>
                        Add <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Shipment</span>
                    <% } %>
                </h1>
            </div>
        </div>
    </section>

    <section class="py-8">
        <div class="l-container">
            <div class="max-w-2xl mx-auto">

                <c:if test="${not empty error}">
                    <div class="mb-6 rounded-lg border border-red-200 bg-red-50 p-4 text-sm text-red-800">
                        <strong>Error:</strong> <c:out value="${error}"/>
                    </div>
                </c:if>

                <div class="bg-white rounded-xl shadow-sm border border-neutral-200 p-8">
                    <form action="${pageContext.request.contextPath}/shipment/<%= isEdit ? "update" : "create" %>"
                          method="post" class="space-y-6">
                        <input type="hidden" name="csrfToken" value="<%= csrfToken %>">

                        <% if (isEdit) { %>
                            <input type="hidden" name="shipmentId" value="<%= editShipment.getId() %>">
                            <input type="hidden" name="orderId" value="<%= editShipment.getOrderId() %>">
                        <% } else { %>
                            <input type="hidden" name="orderId" value="<%= orderId %>">
                        <% } %>

                        <!-- Order Reference (read-only info) -->
                        <div class="bg-neutral-50 rounded-lg p-4">
                            <p class="text-sm text-neutral-600">
                                Order #<strong>
                                    <% if (isEdit) { %><%= editShipment.getOrderId() %><% } else { %><%= orderId %><% } %>
                                </strong>
                            </p>
                        </div>

                        <!-- Carrier & Method -->
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label class="block text-sm font-medium text-neutral-700 mb-1">Carrier / Method *</label>
                                <select name="shipmentMethod" required class="form-input w-full">
                                    <option value="">Select carrier...</option>
                                    <% String carrier = isEdit ? editShipment.getCarrier() : ""; if (carrier == null) carrier = ""; %>
                                    <option value="Australia Post" <%= "Australia Post".equals(carrier) ? "selected" : "" %>>Australia Post</option>
                                    <option value="StarTrack" <%= "StarTrack".equals(carrier) ? "selected" : "" %>>StarTrack</option>
                                    <option value="DHL" <%= "DHL".equals(carrier) ? "selected" : "" %>>DHL</option>
                                    <option value="FedEx" <%= "FedEx".equals(carrier) ? "selected" : "" %>>FedEx</option>
                                    <option value="UPS" <%= "UPS".equals(carrier) ? "selected" : "" %>>UPS</option>
                                    <option value="TNT" <%= "TNT".equals(carrier) ? "selected" : "" %>>TNT</option>
                                    <option value="Couriers Please" <%= "Couriers Please".equals(carrier) ? "selected" : "" %>>Couriers Please</option>
                                </select>
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-neutral-700 mb-1">Shipping Date</label>
                                <input type="date" name="shipmentDate" class="form-input w-full"
                                       value="<%= isEdit && editShipment.getShippingDate() != null ? editShipment.getShippingDate().toLocalDate() : "" %>">
                            </div>
                        </div>

                        <!-- Address -->
                        <div>
                            <label class="block text-sm font-medium text-neutral-700 mb-1">Delivery Address *</label>
                            <input type="text" name="address" required class="form-input w-full"
                                   placeholder="Street address"
                                   value="<%= isEdit && editShipment.getAddress() != null ? editShipment.getAddress() : "" %>">
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                            <div>
                                <label class="block text-sm font-medium text-neutral-700 mb-1">City *</label>
                                <input type="text" name="city" required class="form-input w-full"
                                       placeholder="Sydney"
                                       value="">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-neutral-700 mb-1">State *</label>
                                <select name="state" required class="form-input w-full">
                                    <option value="">Select...</option>
                                    <option value="NSW">NSW</option>
                                    <option value="VIC">VIC</option>
                                    <option value="QLD">QLD</option>
                                    <option value="WA">WA</option>
                                    <option value="SA">SA</option>
                                    <option value="TAS">TAS</option>
                                    <option value="NT">NT</option>
                                    <option value="ACT">ACT</option>
                                </select>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-neutral-700 mb-1">Postcode *</label>
                                <input type="text" name="zipCode" required class="form-input w-full"
                                       placeholder="2000" maxlength="4">
                            </div>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-neutral-700 mb-1">Country *</label>
                            <input type="text" name="country" required class="form-input w-full"
                                   placeholder="Australia" value="Australia">
                        </div>

                        <!-- Notes -->
                        <div>
                            <label class="block text-sm font-medium text-neutral-700 mb-1">Notes</label>
                            <textarea name="notes" rows="3" class="form-input w-full" placeholder="Delivery instructions..."></textarea>
                        </div>

                        <div class="flex justify-end gap-4 pt-4 border-t border-neutral-100">
                            <a href="${pageContext.request.contextPath}/shipment/" class="btn btn--outline">Cancel</a>
                            <button type="submit" class="btn btn--primary">
                                <%= isEdit ? "Update Shipment" : "Create Shipment" %>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>
</t:base>
