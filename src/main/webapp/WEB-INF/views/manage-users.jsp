<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

                    <t:admin-base title="Manage Users" activeNav="users">
                        <!-- Page Header -->
                        <section class="py-8 bg-white border-b-2 border-brand-primary">
                            <div class="l-container">
                                <div class="max-w-6xl mx-auto">
                                    <div class="flex items-center justify-between">
                                        <div>
                                            <h1 class="text-3xl font-bold text-neutral-900 mb-2">
                                                Manage <span
                                                    class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Users</span>
                                            </h1>
                                            <p class="text-lg text-neutral-600">
                                                Manage customer accounts and user permissions
                                            </p>
                                        </div>
                                        <div class="flex items-center gap-3">
                                            <button
                                                onclick="window.location.href='${pageContext.request.contextPath}/api/dataManagement/exportUsers'"
                                                class="inline-flex items-center px-4 py-2 border border-neutral-300 shadow-sm text-sm font-medium rounded-md text-neutral-700 bg-white hover:bg-neutral-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-brand-primary">
                                                Export Users
                                            </button>

                                            <a href="${pageContext.request.contextPath}/api/manage/users/form"
                                                class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-brand-primary hover:bg-brand-secondary focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-brand-primary">
                                                Add User
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>

                        <!-- Users Management -->
                        <section class="py-12">
                            <div class="l-container">
                                <div class="max-w-6xl mx-auto">
                                    <!-- Filters and Search -->
                                    <form action="${pageContext.request.contextPath}/api/manage/users/" method="get"
                                          class="bg-white shadow rounded-lg p-6 mb-8">
                                        <div class="flex flex-col md:flex-row gap-4 items-end">
                                            <div class="flex-1">
                                                <label class="block text-xs font-medium text-neutral-600 mb-1">Search by Name</label>
                                                <div class="relative">
                                                    <input type="text" name="search" placeholder="Search by name..."
                                                        value="${searchQuery}"
                                                        class="shadow-sm focus:ring-brand-primary focus:border-brand-primary block w-full sm:text-sm border-neutral-300 rounded-md pr-10">
                                                    <svg class="absolute right-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-neutral-500"
                                                        fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round"
                                                            stroke-width="2"
                                                            d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                                                    </svg>
                                                </div>
                                            </div>
                                            <div>
                                                <label class="block text-xs font-medium text-neutral-600 mb-1">Phone</label>
                                                <input type="text" name="phone" placeholder="Phone number..."
                                                    value="${phoneQuery}"
                                                    class="shadow-sm focus:ring-brand-primary focus:border-brand-primary block w-full sm:text-sm border-neutral-300 rounded-md">
                                            </div>
                                            <div class="flex items-end gap-3">
                                                <div>
                                                    <label class="block text-xs font-medium text-neutral-600 mb-1">Role</label>
                                                    <select name="role"
                                                        class="shadow-sm focus:ring-brand-primary focus:border-brand-primary block w-full sm:text-sm border-neutral-300 rounded-md">
                                                        <option value="all" ${roleFilter=='all'||empty roleFilter?'selected':''}>All Roles</option>
                                                        <option value="customer" ${roleFilter=='customer'?'selected':''}>Customer</option>
                                                        <option value="staff" ${roleFilter=='staff'?'selected':''}>Staff</option>
                                                    </select>
                                                </div>
                                                <div>
                                                    <label class="block text-xs font-medium text-neutral-600 mb-1">Status</label>
                                                    <select name="status"
                                                        class="shadow-sm focus:ring-brand-primary focus:border-brand-primary block w-full sm:text-sm border-neutral-300 rounded-md">
                                                        <option value="all" ${statusFilter=='all'||empty statusFilter?'selected':''}>All Status</option>
                                                        <option value="active" ${statusFilter=='active'?'selected':''}>Active</option>
                                                        <option value="inactive" ${statusFilter=='inactive'?'selected':''}>Inactive</option>
                                                    </select>
                                                </div>
                                                <button type="submit"
                                                    class="inline-flex items-center px-4 py-2 border border-neutral-300 shadow-sm text-sm font-medium rounded-md text-neutral-700 bg-white hover:bg-neutral-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-brand-primary">
                                                    Search
                                                </button>
                                                <a href="${pageContext.request.contextPath}/api/manage/users/"
                                                    class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-neutral-600 bg-neutral-100 hover:bg-neutral-200">
                                                    Reset
                                                </a>
                                            </div>
                                        </div>
                                    </form>

                                    <!-- Users Table -->
                                    <div class="bg-white shadow overflow-hidden sm:rounded-lg">
                                        <div class="overflow-x-auto">
                                            <table class="min-w-full divide-y divide-neutral-200">
                                                <thead class="bg-neutral-50">
                                                    <tr>
                                                        <th scope="col"
                                                            class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                            <input type="checkbox"
                                                                class="rounded border-neutral-300 text-brand-primary focus:ring-brand-primary">
                                                        </th>
                                                        <th scope="col"
                                                            class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                            User</th>
                                                        <th scope="col"
                                                            class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                            Email</th>
                                                        <th scope="col"
                                                            class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                            Role</th>
                                                        <th scope="col"
                                                            class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                            Status</th>
                                                        <th scope="col"
                                                            class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                            Joined</th>
                                                        <th scope="col"
                                                            class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                            Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="bg-white divide-y divide-neutral-200">
                                                    <c:choose>
                                                        <c:when test="${not empty users}">
                                                            <c:forEach var="userItem" items="${users}">
                                                                <tr class="hover:bg-neutral-50 transition-colors">
                                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                                        <input type="checkbox"
                                                                            class="rounded border-neutral-300 text-brand-primary focus:ring-brand-primary">
                                                                    </td>
                                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                                        <div class="flex items-center gap-3">
                                                                            <div
                                                                                class="flex-shrink-0 h-10 w-10 rounded-full bg-gradient-to-br from-blue-500 to-purple-500 flex items-center justify-center text-white font-semibold text-sm">
                                                                                <c:choose>
                                                                                    <c:when
                                                                                        test="${not empty userItem.firstName && not empty userItem.lastName}">
                                                                                        <c:out
                                                                                            value="${fn:toUpperCase(fn:substring(userItem.firstName, 0, 1))}${fn:toUpperCase(fn:substring(userItem.lastName, 0, 1))}" />
                                                                                    </c:when>
                                                                                    <c:when
                                                                                        test="${not empty userItem.firstName}">
                                                                                        <c:out
                                                                                            value="${fn:toUpperCase(fn:substring(userItem.firstName, 0, 1))}" />
                                                                                    </c:when>
                                                                                    <c:otherwise>U</c:otherwise>
                                                                                </c:choose>
                                                                            </div>
                                                                            <div>
                                                                                <div
                                                                                    class="text-sm font-medium text-neutral-900">
                                                                                    <c:out
                                                                                        value="${userItem.firstName} ${userItem.lastName}" />
                                                                                </div>
                                                                                <div class="text-sm text-neutral-500">
                                                                                    ID:
                                                                                    <c:out value="${userItem.id}" />
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                                        <div class="text-sm text-neutral-900">
                                                                            <c:out value="${userItem.email}" />
                                                                        </div>
                                                                        <div class="text-sm text-neutral-500">
                                                                            <c:out
                                                                                value="${userItem.phoneNumber != null ? userItem.phoneNumber : 'N/A'}" />
                                                                        </div>
                                                                    </td>
                                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                                        <span
                                                                            class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${userItem.role eq 'staff' || userItem.role eq 'admin' ? 'bg-blue-100 text-blue-800' : 'bg-gray-100 text-gray-800'}">
                                                                            <c:out value="${userItem.role}" />
                                                                        </span>
                                                                    </td>
                                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                                        <span
                                                                            class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${userItem.active ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}">
                                                                            ${userItem.active ? 'Active' : 'Inactive'}
                                                                        </span>
                                                                    </td>
                                                                    <td
                                                                        class="px-6 py-4 whitespace-nowrap text-sm text-neutral-500">
                                                                        <c:choose>
                                                                            <c:when
                                                                                test="${userItem.createdAt != null}">
                                                                                <c:out value="${userItem.createdAt}" />
                                                                            </c:when>
                                                                            <c:otherwise>N/A</c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td
                                                                        class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                                                        <div class="flex items-center gap-2">
                                                                            <a href="${pageContext.request.contextPath}/manage/users/update?id=${userItem.id}"
                                                                                class="text-brand-primary hover:text-brand-secondary" title="Edit user">Edit</a>
                                                                            <a href="${pageContext.request.contextPath}/profile.jsp?id=${userItem.id}"
                                                                                class="text-brand-primary hover:text-brand-secondary">View</a>
                                                                            <a href="${pageContext.request.contextPath}/manage/users/delete?id=${userItem.id}"
                                                                                onclick="return confirm('Are you sure you want to delete this user?');"
                                                                                class="text-red-600 hover:text-red-900">Delete</a>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <tr>
                                                                <td colspan="7"
                                                                    class="px-6 py-12 text-center text-sm text-neutral-500">
                                                                    No users found.
                                                                </td>
                                                            </tr>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </t:admin-base>