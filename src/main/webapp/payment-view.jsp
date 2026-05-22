<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
<%@ page import="model.User" %>

<%
    Object userObj = session.getAttribute("user");
    if (!(userObj instanceof User)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    String csrfToken = utils.SecurityUtil.generateCSRFToken(request);
%>

<t:base title="Payment Details | IoT Bay" description="View and edit your payment details">
    <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
        <div class="container">
            <div class="max-w-2xl mx-auto">
                <a href="${pageContext.request.contextPath}/api/payment/"
                   class="text-neutral-500 hover:text-neutral-900 flex items-center gap-2 mb-4 text-sm">
                    &larr; Back to Payment History
                </a>
                <h1 class="text-display-md text-neutral-900">
                    Payment <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Details</span>
                </h1>
            </div>
        </div>
    </section>

    <section class="py-8">
        <div class="container">
            <div class="max-w-2xl mx-auto">

                <c:if test="${not empty error}">
                    <div class="mb-6 rounded-lg border border-red-200 bg-red-50 p-4 text-sm text-red-800" role="alert">
                        <strong>Error:</strong> ${error}
                    </div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="mb-6 rounded-lg border border-green-200 bg-green-50 p-4 text-sm text-green-800" role="alert">
                        ${success}
                    </div>
                </c:if>

                <c:choose>
                    <c:when test="${empty payment}">
                        <div class="bg-white rounded-xl shadow-sm border border-neutral-200 p-12 text-center">
                            <h3 class="text-lg font-semibold text-neutral-700 mb-2">Payment Not Found</h3>
                            <p class="text-neutral-500 text-sm mb-4">This payment record does not exist or you do not have access.</p>
                            <a href="${pageContext.request.contextPath}/api/payment/" class="btn btn--primary">Back to Payments</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Payment Summary Card -->
                        <div class="bg-white rounded-xl shadow-sm border border-neutral-200 p-6 mb-6">
                            <div class="flex items-start justify-between mb-4">
                                <div>
                                    <h2 class="text-xl font-bold text-neutral-900">Payment #${payment.id}</h2>
                                    <p class="text-neutral-500 text-sm">Linked to Order #${payment.orderId}</p>
                                </div>
                                <c:choose>
                                    <c:when test="${payment.status == 'PENDING'}">
                                        <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-yellow-100 text-yellow-800">Pending</span>
                                    </c:when>
                                    <c:when test="${payment.status == 'COMPLETED' || payment.status == 'SUCCESS'}">
                                        <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-green-100 text-green-800">Completed</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-neutral-100 text-neutral-700">${payment.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="grid grid-cols-2 gap-4 text-sm">
                                <div>
                                    <span class="text-neutral-500">Amount</span>
                                    <p class="font-semibold text-neutral-900 text-lg">
                                        $<fmt:formatNumber value="${payment.amount}" minFractionDigits="2" maxFractionDigits="2"/>
                                    </p>
                                </div>
                                <div>
                                    <span class="text-neutral-500">Payment Method</span>
                                    <p class="font-medium text-neutral-900">${payment.paymentMethod}</p>
                                </div>
                                <div>
                                    <span class="text-neutral-500">Date</span>
                                    <p class="font-medium text-neutral-900">${payment.paymentDate}</p>
                                </div>
                                <c:if test="${not empty paymentDetail}">
                                    <div>
                                        <span class="text-neutral-500">Card</span>
                                        <p class="font-medium text-neutral-900">
                                            ${paymentDetail.cardType} ${paymentDetail.cardNumber}
                                        </p>
                                    </div>
                                    <c:if test="${not empty paymentDetail.expiryDate}">
                                        <div>
                                            <span class="text-neutral-500">Expiry</span>
                                            <p class="font-medium text-neutral-900">${paymentDetail.expiryDate}</p>
                                        </div>
                                    </c:if>
                                </c:if>
                            </div>
                        </div>

                        <!-- Edit Form (PENDING only) -->
                        <c:if test="${payment.status == 'PENDING'}">
                            <div class="bg-white rounded-xl shadow-sm border border-neutral-200 p-6 mb-6">
                                <h2 class="text-lg font-semibold text-neutral-900 mb-4">Update Payment Details</h2>
                                <form action="${pageContext.request.contextPath}/api/payment/update" method="post"
                                      class="space-y-4">
                                    <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                                    <input type="hidden" name="paymentId" value="${payment.id}">

                                    <div>
                                        <label class="block text-sm font-medium text-neutral-700 mb-1">Amount ($)</label>
                                        <input type="number" name="amount" step="0.01" min="0.01"
                                               class="form-input w-full"
                                               value="${payment.amount}" required>
                                    </div>

                                    <div>
                                        <label class="block text-sm font-medium text-neutral-700 mb-1">Payment Method</label>
                                        <select name="paymentMethod" class="form-select w-full">
                                            <option value="Credit Card" ${payment.paymentMethod == 'Credit Card' ? 'selected' : ''}>Credit Card</option>
                                            <option value="Debit Card" ${payment.paymentMethod == 'Debit Card' ? 'selected' : ''}>Debit Card</option>
                                            <option value="PayPal" ${payment.paymentMethod == 'PayPal' ? 'selected' : ''}>PayPal</option>
                                            <option value="Bank Transfer" ${payment.paymentMethod == 'Bank Transfer' ? 'selected' : ''}>Bank Transfer</option>
                                        </select>
                                    </div>

                                    <div class="flex gap-3 pt-2">
                                        <button type="submit" class="btn btn--primary">Save Changes</button>
                                        <a href="${pageContext.request.contextPath}/api/payment/" class="btn btn--outline">Cancel</a>
                                    </div>
                                </form>
                            </div>

                            <!-- Delete Section -->
                            <div class="bg-red-50 rounded-xl border border-red-200 p-6">
                                <h2 class="text-lg font-semibold text-red-800 mb-2">Delete Payment</h2>
                                <p class="text-sm text-red-700 mb-4">
                                    This will permanently remove this payment record. This action cannot be undone.
                                </p>
                                <form action="${pageContext.request.contextPath}/api/payment/delete" method="post"
                                      onsubmit="return confirm('Are you sure you want to delete this payment?');">
                                    <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                                    <input type="hidden" name="paymentId" value="${payment.id}">
                                    <input type="hidden" name="_method" value="DELETE">
                                    <button type="submit" class="btn btn--error">Delete Payment</button>
                                </form>
                            </div>
                        </c:if>

                        <!-- Navigation -->
                        <div class="mt-6 flex gap-3">
                            <a href="${pageContext.request.contextPath}/api/payment/" class="btn btn--outline">
                                &larr; All Payments
                            </a>
                            <a href="${pageContext.request.contextPath}/orderhistory" class="btn btn--secondary">
                                View Orders
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>
    </section>
</t:base>
