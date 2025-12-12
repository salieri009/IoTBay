<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
    <%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <%@ page import="model.User" %>

                <% User user=(User) session.getAttribute("user"); if (user==null ||
                    (!"staff".equalsIgnoreCase(user.getRole()) && !"admin".equalsIgnoreCase(user.getRole()))) {
                    response.sendRedirect(request.getContextPath() + "/login.jsp" ); return; } %>

                    <t:base title="Manage Suppliers" customCSS="modern-theme.css">
                        <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
                            <div class="l-container">
                                <div class="max-w-6xl mx-auto">
                                    <!-- Header -->
                                    <div class="flex items-center justify-between mb-8">
                                        <div>
                                            <h1 class="text-display-lg text-neutral-900 mb-2">
                                                Manage <span
                                                    class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Suppliers</span>
                                            </h1>
                                            <p class="text-lg text-neutral-600">Manage supplier relationships and
                                                contacts</p>
                                        </div>
                                        <div class="flex items-center gap-3">
                                            <a href="<c:url value='/admin/supplier/form'/>" class="btn btn--primary">Add
                                                Supplier</a>
                                        </div>
                                    </div>

                                    <!-- Filters -->
                                    <div class="bg-white p-4 rounded-xl shadow-sm border border-neutral-200 mb-6">
                                        <form action="<c:url value='/admin/supplier/'/>" method="get"
                                            class="flex gap-4 items-center">
                                            <select name="status" class="form-input w-auto"
                                                onchange="this.form.submit()">
                                                <option value="all" ${statusFilter=='all' ? 'selected' : '' }>All Status
                                                </option>
                                                <option value="active" ${statusFilter=='active' ? 'selected' : '' }>
                                                    Active</option>
                                                <option value="inactive" ${statusFilter=='inactive' ? 'selected' : '' }>
                                                    Inactive</option>
                                            </select>
                                        </form>
                                    </div>

                                    <!-- Suppliers Table -->
                                    <div
                                        class="bg-white rounded-xl shadow-sm border border-neutral-200 overflow-hidden">
                                        <div class="overflow-x-auto">
                                            <table class="w-full text-left border-collapse">
                                                <thead>
                                                    <tr class="bg-neutral-50 border-b border-neutral-200">
                                                        <th class="p-4 font-semibold text-neutral-700">Company</th>
                                                        <th class="p-4 font-semibold text-neutral-700">Contact</th>
                                                        <th class="p-4 font-semibold text-neutral-700">Email</th>
                                                        <th class="p-4 font-semibold text-neutral-700">Phone</th>
                                                        <th class="p-4 font-semibold text-neutral-700">Status</th>
                                                        <th class="p-4 font-semibold text-neutral-700">Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="divide-y divide-neutral-200">
                                                    <c:forEach var="supplier" items="${suppliers}">
                                                        <tr class="hover:bg-neutral-50 transition-colors">
                                                            <td class="p-4 font-medium text-neutral-900">
                                                                ${supplier.companyName}</td>
                                                            <td class="p-4 text-neutral-600">${supplier.contactName}
                                                            </td>
                                                            <td class="p-4 text-neutral-600">${supplier.email}</td>
                                                            <td class="p-4 text-neutral-600">${supplier.phoneNumber}
                                                            </td>
                                                            <td class="p-4">
                                                                <span
                                                                    class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${supplier.active ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}">
                                                                    ${supplier.active ? 'Active' : 'Inactive'}
                                                                </span>
                                                            </td>
                                                            <td class="p-4">
                                                                <div class="flex items-center gap-2">
                                                                    <a href="<c:url value='/admin/supplier/view/${supplier.id}'/>"
                                                                        class="text-brand-primary hover:text-brand-secondary font-medium text-sm">View</a>
                                                                    <a href="<c:url value='/admin/supplier/edit/${supplier.id}'/>"
                                                                        class="text-neutral-600 hover:text-neutral-900 font-medium text-sm">Edit</a>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${empty suppliers}">
                                                        <tr>
                                                            <td colspan="6" class="p-8 text-center text-neutral-500">
                                                                No suppliers found.
                                                            </td>
                                                        </tr>
                                                    </c:if>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                    <!-- Back to Dashboard -->
                                    <div class="mt-8">
                                        <a href="<c:url value='/admin-dashboard'/>" class="btn btn--outline">
                                            ← Back to Dashboard
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </t:base>