<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

            <t:base title="My Access Logs" description="View your account access history">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
                    <!-- Header -->
                    <div class="mb-8">
                        <h1 class="text-3xl font-bold text-neutral-900">Access Logs</h1>
                        <p class="mt-2 text-neutral-600">View your account activity and security history.</p>
                    </div>

                    <!-- Error Message -->
                    <c:if test="${not empty error}">
                        <div class="mb-6 bg-red-50 border-l-4 border-red-500 p-4" role="alert">
                            <div class="flex">
                                <div class="flex-shrink-0">
                                    <svg class="h-5 w-5 text-red-400" viewBox="0 0 20 20" fill="currentColor">
                                        <path fill-rule="evenodd"
                                            d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z"
                                            clip-rule="evenodd" />
                                    </svg>
                                </div>
                                <div class="ml-3">
                                    <p class="text-sm text-red-700">
                                        <c:out value="${error}" />
                                    </p>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Search/Filter Section -->
                    <div class="bg-white shadow rounded-lg mb-8">
                        <div class="px-4 py-5 sm:p-6">
                            <form action="${pageContext.request.contextPath}/api/accessLog" method="get"
                                class="grid grid-cols-1 gap-y-6 gap-x-4 sm:grid-cols-6 items-end">
                                <div class="sm:col-span-2">
                                    <label for="startDate" class="block text-sm font-medium text-neutral-700">Start
                                        Date</label>
                                    <div class="mt-1">
                                        <input type="date" name="startDate" id="startDate" value="${param.startDate}"
                                            class="shadow-sm focus:ring-brand-primary focus:border-brand-primary block w-full sm:text-sm border-neutral-300 rounded-md">
                                    </div>
                                </div>

                                <div class="sm:col-span-2">
                                    <label for="endDate" class="block text-sm font-medium text-neutral-700">End
                                        Date</label>
                                    <div class="mt-1">
                                        <input type="date" name="endDate" id="endDate" value="${param.endDate}"
                                            class="shadow-sm focus:ring-brand-primary focus:border-brand-primary block w-full sm:text-sm border-neutral-300 rounded-md">
                                    </div>
                                </div>

                                <div class="sm:col-span-2 flex space-x-3">
                                    <button type="submit"
                                        class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-brand-primary hover:bg-brand-secondary focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-brand-primary">
                                        Search
                                    </button>
                                    <a href="${pageContext.request.contextPath}/api/accessLog"
                                        class="inline-flex items-center px-4 py-2 border border-neutral-300 text-sm font-medium rounded-md text-neutral-700 bg-white hover:bg-neutral-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-brand-primary">
                                        Reset
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Results Table -->
                    <div class="bg-white shadow overflow-hidden sm:rounded-lg">
                        <div class="px-4 py-5 sm:px-6 flex justify-between items-center">
                            <h3 class="text-lg leading-6 font-medium text-neutral-900">Log Entries</h3>
                            <c:if test="${not empty accessLogList}">
                                <span
                                    class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                                    ${accessLogList.size()} records
                                </span>
                            </c:if>
                        </div>

                        <div class="border-t border-neutral-200">
                            <div class="overflow-x-auto">
                                <table class="min-w-full divide-y divide-neutral-200">
                                    <thead class="bg-neutral-50">
                                        <tr>
                                            <th scope="col"
                                                class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                No.</th>
                                            <th scope="col"
                                                class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                Action</th>
                                            <th scope="col"
                                                class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                Timestamp</th>
                                            <th scope="col"
                                                class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                IP Address</th>
                                        </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-neutral-200">
                                        <c:choose>
                                            <c:when test="${not empty accessLogList}">
                                                <c:forEach var="log" items="${accessLogList}" varStatus="status">
                                                    <tr class="hover:bg-neutral-50 transition-colors duration-150">
                                                        <td
                                                            class="px-6 py-4 whitespace-nowrap text-sm text-neutral-500">
                                                            ${status.count}
                                                        </td>
                                                        <td
                                                            class="px-6 py-4 whitespace-nowrap text-sm font-medium text-neutral-900">
                                                            <c:out value="${log.action}" />
                                                        </td>
                                                        <td
                                                            class="px-6 py-4 whitespace-nowrap text-sm text-neutral-500">
                                                            <c:out value="${log.formattedTimestamp}" />
                                                        </td>
                                                        <td
                                                            class="px-6 py-4 whitespace-nowrap text-sm text-neutral-500">
                                                            <c:out
                                                                value="${log.ipAddress != null ? log.ipAddress : '-'}" />
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="4"
                                                        class="px-6 py-12 text-center text-sm text-neutral-500">
                                                        <svg class="mx-auto h-12 w-12 text-neutral-400" fill="none"
                                                            viewBox="0 0 24 24" stroke="currentColor">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2"
                                                                d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                                        </svg>
                                                        <p class="mt-2">No access logs found matching your criteria.</p>
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
            </t:base>