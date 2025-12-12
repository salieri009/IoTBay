<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
    <%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <%@ page import="model.User" %>

                <% User user=(User) session.getAttribute("user"); if (user==null ||
                    (!"staff".equalsIgnoreCase(user.getRole()) && !"admin".equalsIgnoreCase(user.getRole()))) {
                    response.sendRedirect(request.getContextPath() + "/login.jsp" ); return; } %>

                    <t:base title="View Supplier - ${supplier.companyName}" customCSS="modern-theme.css">
                        <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
                            <div class="l-container">
                                <div class="max-w-3xl mx-auto">
                                    <!-- Header -->
                                    <div class="mb-8">
                                        <a href="<c:url value='/admin/supplier/'/>"
                                            class="text-neutral-500 hover:text-neutral-900 flex items-center gap-2 mb-4">
                                            &larr; Back to Suppliers
                                        </a>
                                        <div class="flex items-center justify-between">
                                            <h1 class="text-display-md text-neutral-900">${supplier.companyName}</h1>
                                            <div class="flex gap-3">
                                                <a href="<c:url value='/admin/supplier/edit/${supplier.id}'/>"
                                                    class="btn btn--outline">Edit</a>
                                                <form action="<c:url value='/admin/supplier/delete'/>" method="post"
                                                    onsubmit="return confirm('Are you sure you want to delete this supplier?');">
                                                    <input type="hidden" name="id" value="${supplier.id}">
                                                    <input type="hidden" name="csrfToken"
                                                        value="${sessionScope.csrfToken}">
                                                    <button type="submit" class="btn btn--danger">Delete</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Supplier Details Card -->
                                    <div
                                        class="bg-white rounded-xl shadow-sm border border-neutral-200 overflow-hidden">
                                        <!-- Contact Section -->
                                        <div class="p-6 border-b border-neutral-100">
                                            <h2 class="text-lg font-semibold text-neutral-900">Contact Information</h2>
                                        </div>
                                        <div class="p-6 grid grid-cols-1 md:grid-cols-2 gap-6">
                                            <div>
                                                <p class="text-sm text-neutral-500 mb-1">Contact Person</p>
                                                <p class="font-medium">${supplier.contactName}</p>
                                            </div>
                                            <div>
                                                <p class="text-sm text-neutral-500 mb-1">Email</p>
                                                <p class="font-medium">${supplier.email}</p>
                                            </div>
                                            <div>
                                                <p class="text-sm text-neutral-500 mb-1">Phone</p>
                                                <p class="font-medium">${supplier.phoneNumber}</p>
                                            </div>
                                            <div>
                                                <p class="text-sm text-neutral-500 mb-1">Website</p>
                                                <p class="font-medium">
                                                    <c:choose>
                                                        <c:when test="${not empty supplier.website}">
                                                            <a href="${supplier.website}" target="_blank" rel="noopener"
                                                                class="text-brand-primary hover:underline">${supplier.website}</a>
                                                        </c:when>
                                                        <c:otherwise>-</c:otherwise>
                                                    </c:choose>
                                                </p>
                                            </div>
                                        </div>

                                        <!-- Address Section -->
                                        <div class="p-6 border-t border-neutral-100 bg-neutral-50">
                                            <h2 class="text-lg font-semibold text-neutral-900 mb-4">Address</h2>
                                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                                <div class="col-span-2">
                                                    <p class="text-sm text-neutral-500 mb-1">Street Address</p>
                                                    <p class="font-medium">${supplier.addressLine1}</p>
                                                </div>
                                                <div>
                                                    <p class="text-sm text-neutral-500 mb-1">City</p>
                                                    <p class="font-medium">${supplier.city}</p>
                                                </div>
                                                <div>
                                                    <p class="text-sm text-neutral-500 mb-1">State/Province</p>
                                                    <p class="font-medium">${supplier.state}</p>
                                                </div>
                                                <div>
                                                    <p class="text-sm text-neutral-500 mb-1">Zip/Postal Code</p>
                                                    <p class="font-medium">${supplier.postalCode}</p>
                                                </div>
                                                <div>
                                                    <p class="text-sm text-neutral-500 mb-1">Country</p>
                                                    <p class="font-medium">${supplier.country}</p>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- System Info Section -->
                                        <div class="p-6 border-t border-neutral-100">
                                            <h2 class="text-lg font-semibold text-neutral-900 mb-4">System Information
                                            </h2>
                                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                                <div>
                                                    <p class="text-sm text-neutral-500 mb-1">Status</p>
                                                    <span
                                                        class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${supplier.active ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}">
                                                        ${supplier.active ? 'Active' : 'Inactive'}
                                                    </span>
                                                </div>
                                                <div>
                                                    <p class="text-sm text-neutral-500 mb-1">Supplier ID</p>
                                                    <p class="font-medium">#${supplier.id}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </t:base>