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
    // Expose values via EL — scriptlets are disallowed inside the scriptless <t:base> body.
    String orderIdParam = request.getParameter("orderId");
    pageContext.setAttribute("csrfToken", utils.SecurityUtil.generateCSRFToken(request));
    pageContext.setAttribute("orderIdParam", orderIdParam != null ? orderIdParam : "");
%>

<%-- The edit target (if any) is request attribute "shipment"; isEdit = it's present. --%>
<c:set var="isEdit" value="${not empty shipment}" />

<t:base title="${isEdit ? 'Edit Shipment' : 'Add Shipment'} | IoT Bay">
    <section class="py-8 bg-white border-b-2 border-brand-primary">
        <div class="l-container">
            <div class="max-w-2xl mx-auto">
                <a href="${pageContext.request.contextPath}/shipment/"
                   class="text-neutral-600 hover:text-brand-primary font-medium flex items-center gap-2 mb-4 text-sm transition-colors">
                    &larr; Back to Shipments
                </a>
                <h1 class="text-display-md text-neutral-900 mb-2">
                    ${isEdit ? 'Edit' : 'Add'}
                    <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Shipment</span>
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
                    <form action="${pageContext.request.contextPath}/shipment/${isEdit ? 'update' : 'create'}"
                          method="post" class="space-y-6">
                        <input type="hidden" name="csrfToken" value="${csrfToken}">

                        <c:choose>
                            <c:when test="${isEdit}">
                                <input type="hidden" name="shipmentId" value="${shipment.id}">
                                <input type="hidden" name="orderId" value="${shipment.orderId}">
                            </c:when>
                            <c:otherwise>
                                <input type="hidden" name="orderId" value="${orderIdParam}">
                            </c:otherwise>
                        </c:choose>

                        <!-- Order Reference (read-only info) -->
                        <div class="bg-neutral-50 rounded-lg p-4">
                            <p class="text-sm text-neutral-600">
                                Order #<strong>${isEdit ? shipment.orderId : orderIdParam}</strong>
                            </p>
                        </div>

                        <!-- Carrier & Method -->
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label class="block text-sm font-medium text-neutral-700 mb-1">Carrier / Method *</label>
                                <c:set var="carrier" value="${isEdit ? shipment.carrier : ''}" />
                                <select name="shipmentMethod" required class="form-input w-full">
                                    <option value="">Select carrier...</option>
                                    <c:forEach var="opt" items="Australia Post,StarTrack,DHL,FedEx,UPS,TNT,Couriers Please">
                                        <option value="${opt}" ${carrier == opt ? 'selected' : ''}>${opt}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-neutral-700 mb-1">Shipping Date</label>
                                <input type="date" name="shipmentDate" class="form-input w-full"
                                       value="${isEdit && shipment.shippingDate != null ? shipment.shippingDate : ''}">
                            </div>
                        </div>

                        <!-- Address -->
                        <div>
                            <label class="block text-sm font-medium text-neutral-700 mb-1">Delivery Address *</label>
                            <input type="text" name="address" required class="form-input w-full"
                                   placeholder="Street address"
                                   value="${isEdit && shipment.address != null ? shipment.address : ''}">
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                            <div>
                                <label class="block text-sm font-medium text-neutral-700 mb-1">City *</label>
                                <input type="text" name="city" required class="form-input w-full" placeholder="Sydney" value="">
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
                                <input type="text" name="zipCode" required class="form-input w-full" placeholder="2000" maxlength="4">
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
                                ${isEdit ? 'Update Shipment' : 'Create Shipment'}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>
</t:base>
