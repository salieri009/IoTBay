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
    // Exposed via EL (scriptlets are disallowed inside the scriptless <t:base> body).
    pageContext.setAttribute("csrfToken", utils.SecurityUtil.generateCSRFToken(request));
%>

<t:base title="Payment History | IoT Bay" description="View and manage your payment records">
    <!-- Page Header -->
    <section class="py-8 bg-white border-b-2 border-brand-primary">
        <div class="l-container">
            <div class="max-w-4xl mx-auto">
                <a href="${pageContext.request.contextPath}/profile.jsp"
                    class="text-neutral-600 hover:text-brand-primary font-medium flex items-center gap-2 mb-4 text-sm transition-colors">
                    &larr; Back to Profile
                </a>
                <h1 class="text-display-lg text-neutral-900 mb-2">
                    Payment <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">History</span>
                </h1>
                <p class="text-neutral-600">View, search, and manage your payment records.</p>
            </div>
        </div>
    </section>

    <section class="py-8">
        <div class="l-container">
            <div class="max-w-4xl mx-auto">

                <!-- Error / Success Messages -->
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

                <!-- Search Form -->
                <div class="bg-white rounded-xl shadow-sm border border-neutral-200 p-6 mb-6">
                    <h2 class="text-lg font-semibold text-neutral-900 mb-4">Search Payments</h2>
                    <form action="${pageContext.request.contextPath}/api/payment/history" method="get"
                          class="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <div>
                            <label class="block text-sm font-medium text-neutral-700 mb-1">Payment ID</label>
                            <input type="number" name="paymentId" class="form-input w-full"
                                   placeholder="e.g. 42"
                                   value="${param.paymentId}">
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-neutral-700 mb-1">From Date</label>
                            <input type="date" name="dateFrom" class="form-input w-full"
                                   value="${param.dateFrom}">
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-neutral-700 mb-1">To Date</label>
                            <input type="date" name="dateTo" class="form-input w-full"
                                   value="${param.dateTo}">
                        </div>
                        <div class="md:col-span-3 flex gap-3">
                            <button type="submit" class="btn btn--primary">Search</button>
                            <a href="${pageContext.request.contextPath}/api/payment/" class="btn btn--outline">Reset</a>
                        </div>
                    </form>
                </div>

                <!-- Payments List -->
                <div class="bg-white rounded-xl shadow-sm border border-neutral-200 overflow-hidden">
                    <div class="p-6 border-b border-neutral-200 flex items-center justify-between">
                        <h2 class="text-lg font-semibold text-neutral-900">
                            Your Payments
                            <c:if test="${not empty payments}">
                                <span class="ml-2 text-sm font-normal text-neutral-600">(${fn:length(payments)} records)</span>
                            </c:if>
                        </h2>
                    </div>

                    <c:choose>
                        <c:when test="${empty payments}">
                            <div class="text-center py-16">
                                <svg class="w-16 h-16 text-neutral-300 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"/>
                                </svg>
                                <h3 class="text-lg font-semibold text-neutral-800 mb-2">No payments found</h3>
                                <p class="text-neutral-600 text-sm">No payment records match your search criteria.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="divide-y divide-neutral-100">
                                <c:forEach var="payment" items="${payments}">
                                    <div class="p-6 hover:bg-neutral-50 transition-colors">
                                        <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
                                            <div>
                                                <div class="flex items-center gap-3 mb-1">
                                                    <span class="text-sm font-semibold text-neutral-900">Payment #${payment.id}</span>
                                                    <c:choose>
                                                        <c:when test="${payment.status == 'PENDING'}">
                                                            <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800">Pending</span>
                                                        </c:when>
                                                        <c:when test="${payment.status == 'COMPLETED' || payment.status == 'SUCCESS'}">
                                                            <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">Completed</span>
                                                        </c:when>
                                                        <c:when test="${payment.status == 'FAILED' || payment.status == 'CANCELLED'}">
                                                            <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">${fn:toLowerCase(payment.status) == 'failed' ? 'Failed' : 'Cancelled'}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-neutral-100 text-neutral-700">${payment.status}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <p class="text-sm text-neutral-600">
                                                    Order #${payment.orderId} &bull;
                                                    ${payment.paymentMethod} &bull;
                                                    <c:if test="${payment.paymentDate != null}">
                                                        ${payment.paymentDate}
                                                    </c:if>
                                                </p>
                                            </div>
                                            <div class="flex items-center gap-4">
                                                <span class="text-lg font-bold text-neutral-900">
                                                    $<fmt:formatNumber value="${payment.amount}" minFractionDigits="2" maxFractionDigits="2"/>
                                                </span>
                                                <div class="flex gap-2">
                                                    <a href="${pageContext.request.contextPath}/api/payment/view/${payment.id}"
                                                       class="btn btn--secondary btn--sm">View</a>
                                                    <c:if test="${payment.status == 'PENDING'}">
                                                        <a href="${pageContext.request.contextPath}/api/payment/view/${payment.id}"
                                                           class="btn btn--outline btn--sm">Edit</a>
                                                        <!-- Delete form -->
                                                        <form action="${pageContext.request.contextPath}/api/payment/delete" method="post"
                                                              class="inline"
                                                              onsubmit="return confirm('Delete this payment record?');">
                                                            <input type="hidden" name="csrfToken" value="${csrfToken}">
                                                            <input type="hidden" name="paymentId" value="${payment.id}">
                                                            <input type="hidden" name="_method" value="DELETE">
                                                            <button type="submit" class="btn btn--error btn--sm">Delete</button>
                                                        </form>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

            </div>
        </div>
    </section>
</t:base>
