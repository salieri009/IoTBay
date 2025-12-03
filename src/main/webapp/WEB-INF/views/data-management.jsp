<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

            <t:base title="Data Management" description="Import, export, and manage system data">
                <!-- Page Header -->
                <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
                    <div class="container mx-auto px-4 sm:px-6 lg:px-8">
                        <div class="max-w-6xl mx-auto">
                            <h1 class="text-3xl font-bold text-neutral-900 mb-2">
                                Data <span
                                    class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Management</span>
                            </h1>
                            <p class="text-lg text-neutral-600">
                                Import, export, and manage system data
                            </p>
                        </div>
                    </div>
                </section>

                <section class="py-12">
                    <div class="container mx-auto px-4 sm:px-6 lg:px-8">
                        <div class="max-w-6xl mx-auto space-y-8">

                            <!-- Success/Error Messages -->
                            <c:if test="${not empty successMessage}">
                                <div class="rounded-md bg-green-50 p-4">
                                    <div class="flex">
                                        <div class="flex-shrink-0">
                                            <svg class="h-5 w-5 text-green-400" viewBox="0 0 20 20" fill="currentColor">
                                                <path fill-rule="evenodd"
                                                    d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                                                    clip-rule="evenodd" />
                                            </svg>
                                        </div>
                                        <div class="ml-3">
                                            <p class="text-sm font-medium text-green-800">
                                                <c:out value="${successMessage}" />
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${not empty errorMessage}">
                                <div class="rounded-md bg-red-50 p-4">
                                    <div class="flex">
                                        <div class="flex-shrink-0">
                                            <svg class="h-5 w-5 text-red-400" viewBox="0 0 20 20" fill="currentColor">
                                                <path fill-rule="evenodd"
                                                    d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z"
                                                    clip-rule="evenodd" />
                                            </svg>
                                        </div>
                                        <div class="ml-3">
                                            <p class="text-sm font-medium text-red-800">
                                                <c:out value="${errorMessage}" />
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <!-- Export Section -->
                            <div class="bg-white shadow rounded-lg p-6">
                                <h2 class="text-xl font-semibold text-neutral-900 mb-6">Export Data</h2>
                                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                                    <!-- Users Export -->
                                    <div
                                        class="border border-neutral-200 rounded-lg p-4 hover:border-brand-primary transition-colors">
                                        <h3 class="text-lg font-medium text-neutral-900 mb-2">Users</h3>
                                        <p class="text-sm text-neutral-600 mb-4">Export all user data to CSV</p>
                                        <a href="${pageContext.request.contextPath}/api/dataManagement/exportUsers"
                                            class="inline-flex items-center justify-center w-full px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-brand-primary hover:bg-brand-secondary focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-brand-primary">
                                            Export Users
                                        </a>
                                    </div>

                                    <!-- Products Export -->
                                    <div
                                        class="border border-neutral-200 rounded-lg p-4 hover:border-brand-primary transition-colors">
                                        <h3 class="text-lg font-medium text-neutral-900 mb-2">Products</h3>
                                        <p class="text-sm text-neutral-600 mb-4">Export product catalog to CSV</p>
                                        <a href="${pageContext.request.contextPath}/api/dataManagement/exportProducts"
                                            class="inline-flex items-center justify-center w-full px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-brand-primary hover:bg-brand-secondary focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-brand-primary">
                                            Export Products
                                        </a>
                                    </div>

                                    <!-- Orders Export -->
                                    <div
                                        class="border border-neutral-200 rounded-lg p-4 hover:border-brand-primary transition-colors">
                                        <h3 class="text-lg font-medium text-neutral-900 mb-2">Orders</h3>
                                        <p class="text-sm text-neutral-600 mb-4">Export order history to CSV</p>
                                        <a href="${pageContext.request.contextPath}/api/dataManagement/exportOrders"
                                            class="inline-flex items-center justify-center w-full px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-brand-primary hover:bg-brand-secondary focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-brand-primary">
                                            Export Orders
                                        </a>
                                    </div>

                                    <!-- Access Logs Export -->
                                    <div
                                        class="border border-neutral-200 rounded-lg p-4 hover:border-brand-primary transition-colors">
                                        <h3 class="text-lg font-medium text-neutral-900 mb-2">Access Logs</h3>
                                        <p class="text-sm text-neutral-600 mb-4">Export access log data to CSV</p>
                                        <a href="${pageContext.request.contextPath}/api/dataManagement/exportAccessLogs"
                                            class="inline-flex items-center justify-center w-full px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-brand-primary hover:bg-brand-secondary focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-brand-primary">
                                            Export Access Logs
                                        </a>
                                    </div>
                                </div>
                            </div>

                            <!-- Import Section -->
                            <div class="bg-white shadow rounded-lg p-6">
                                <h2 class="text-xl font-semibold text-neutral-900 mb-2">Import Data</h2>
                                <p class="text-neutral-600 mb-6">Upload CSV files to import data into the system</p>

                                <form method="POST"
                                    action="${pageContext.request.contextPath}/api/dataManagement/import"
                                    enctype="multipart/form-data" class="space-y-6 max-w-lg">
                                    <div>
                                        <label for="entityType"
                                            class="block text-sm font-medium text-neutral-700">Entity Type</label>
                                        <select id="entityType" name="entityType" required
                                            class="mt-1 block w-full pl-3 pr-10 py-2 text-base border-neutral-300 focus:outline-none focus:ring-brand-primary focus:border-brand-primary sm:text-sm rounded-md">
                                            <option value="">Select entity type...</option>
                                            <option value="users">Users</option>
                                            <option value="products">Products</option>
                                            <option value="orders">Orders</option>
                                            <option value="accessLogs">Access Logs</option>
                                        </select>
                                    </div>

                                    <div>
                                        <label for="csvFile" class="block text-sm font-medium text-neutral-700">CSV
                                            File</label>
                                        <div
                                            class="mt-1 flex justify-center px-6 pt-5 pb-6 border-2 border-neutral-300 border-dashed rounded-md">
                                            <div class="space-y-1 text-center">
                                                <svg class="mx-auto h-12 w-12 text-neutral-400" stroke="currentColor"
                                                    fill="none" viewBox="0 0 48 48" aria-hidden="true">
                                                    <path
                                                        d="M28 8H12a4 4 0 00-4 4v20m32-12v8m0 0v8a4 4 0 01-4 4H12a4 4 0 01-4-4v-4m32-4l-3.172-3.172a4 4 0 00-5.656 0L28 28M8 32l9.172-9.172a4 4 0 015.656 0L28 28m0 0l4 4m4-24h8m-4-4v8m-12 4h.02"
                                                        stroke-width="2" stroke-linecap="round"
                                                        stroke-linejoin="round" />
                                                </svg>
                                                <div class="flex text-sm text-neutral-600">
                                                    <label for="csvFile"
                                                        class="relative cursor-pointer bg-white rounded-md font-medium text-brand-primary hover:text-brand-secondary focus-within:outline-none focus-within:ring-2 focus-within:ring-offset-2 focus-within:ring-brand-primary">
                                                        <span>Upload a file</span>
                                                        <input id="csvFile" name="csvFile" type="file" accept=".csv"
                                                            required class="sr-only">
                                                    </label>
                                                    <p class="pl-1">or drag and drop</p>
                                                </div>
                                                <p class="text-xs text-neutral-500">CSV up to 10MB</p>
                                            </div>
                                        </div>
                                    </div>

                                    <button type="submit"
                                        class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-brand-primary hover:bg-brand-secondary focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-brand-primary">
                                        Upload and Import
                                    </button>
                                </form>
                            </div>

                            <!-- Backup Section -->
                            <div class="bg-white shadow rounded-lg p-6">
                                <h2 class="text-xl font-semibold text-neutral-900 mb-6">Backup & Restore</h2>
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <div class="border border-neutral-200 rounded-lg p-6">
                                        <h3 class="text-lg font-medium text-neutral-900 mb-2">Create Backup</h3>
                                        <p class="text-sm text-neutral-600 mb-4">Last backup: <strong
                                                id="lastBackupTime">Never</strong></p>
                                        <form method="POST"
                                            action="${pageContext.request.contextPath}/api/dataManagement/backup">
                                            <input type="hidden" name="backupType" value="full">
                                            <button type="submit"
                                                class="inline-flex items-center px-4 py-2 border border-neutral-300 shadow-sm text-sm font-medium rounded-md text-neutral-700 bg-white hover:bg-neutral-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-brand-primary">
                                                Create Full Backup
                                            </button>
                                        </form>
                                    </div>
                                    <div class="border border-neutral-200 rounded-lg p-6">
                                        <h3 class="text-lg font-medium text-neutral-900 mb-2">Restore from Backup</h3>
                                        <p class="text-sm text-neutral-600 mb-4">Upload a backup file to restore</p>
                                        <form method="POST"
                                            action="${pageContext.request.contextPath}/api/dataManagement/restore"
                                            enctype="multipart/form-data" class="flex gap-2">
                                            <input type="file" name="backupFile" accept=".zip,.sql"
                                                class="block w-full text-sm text-neutral-500 file:mr-4 file:py-2 file:px-4 file:rounded-md file:border-0 file:text-sm file:font-semibold file:bg-brand-50 file:text-brand-700 hover:file:bg-brand-100">
                                            <button type="submit"
                                                class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-yellow-600 hover:bg-yellow-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-yellow-500">
                                                Restore
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <!-- Operation Log -->
                            <div class="bg-white shadow rounded-lg overflow-hidden">
                                <div class="px-6 py-5 border-b border-neutral-200 flex items-center justify-between">
                                    <h2 class="text-xl font-semibold text-neutral-900">Recent Operations</h2>
                                    <button onclick="location.reload()"
                                        class="text-sm text-brand-primary hover:text-brand-secondary font-medium">
                                        Refresh
                                    </button>
                                </div>
                                <div class="overflow-x-auto">
                                    <table class="min-w-full divide-y divide-neutral-200">
                                        <thead class="bg-neutral-50">
                                            <tr>
                                                <th scope="col"
                                                    class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                    Operation</th>
                                                <th scope="col"
                                                    class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                    Entity Type</th>
                                                <th scope="col"
                                                    class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                    Records</th>
                                                <th scope="col"
                                                    class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                    Status</th>
                                                <th scope="col"
                                                    class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                    User</th>
                                                <th scope="col"
                                                    class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                    Timestamp</th>
                                            </tr>
                                        </thead>
                                        <tbody class="bg-white divide-y divide-neutral-200">
                                            <c:choose>
                                                <c:when test="${not empty operationLogs}">
                                                    <c:forEach items="${operationLogs}" var="log">
                                                        <tr>
                                                            <td
                                                                class="px-6 py-4 whitespace-nowrap text-sm text-neutral-900">
                                                                <c:out value="${log.operation}" />
                                                            </td>
                                                            <td
                                                                class="px-6 py-4 whitespace-nowrap text-sm text-neutral-500">
                                                                <c:out value="${log.entityType}" />
                                                            </td>
                                                            <td
                                                                class="px-6 py-4 whitespace-nowrap text-sm text-neutral-500">
                                                                <c:out value="${log.recordCount}" />
                                                            </td>
                                                            <td class="px-6 py-4 whitespace-nowrap">
                                                                <span
                                                                    class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${log.status == 'SUCCESS' ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}">
                                                                    <c:out value="${log.status}" />
                                                                </span>
                                                            </td>
                                                            <td
                                                                class="px-6 py-4 whitespace-nowrap text-sm text-neutral-500">
                                                                <c:out value="${log.userName}" />
                                                            </td>
                                                            <td
                                                                class="px-6 py-4 whitespace-nowrap text-sm text-neutral-500">
                                                                <c:out value="${log.timestamp}" />
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <tr>
                                                        <td colspan="6"
                                                            class="px-6 py-12 text-center text-sm text-neutral-500">
                                                            No recent operations
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
            </t:base>