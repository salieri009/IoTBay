<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

                <t:base title="Access Logs" description="Monitor system access and user activities">
                    <!-- Page Header -->
                    <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
                        <div class="container mx-auto px-4 sm:px-6 lg:px-8">
                            <div class="max-w-6xl mx-auto">
                                <div class="flex items-center justify-between mb-8">
                                    <div>
                                        <h1 class="text-3xl font-bold text-neutral-900 mb-2">
                                            Access <span
                                                class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Logs</span>
                                        </h1>
                                        <p class="text-lg text-neutral-600">
                                            Monitor system access and user activities
                                        </p>
                                    </div>
                                    <div class="flex items-center gap-3">
                                        <button onclick="alert('Export feature coming soon')"
                                            class="inline-flex items-center px-4 py-2 border border-neutral-300 shadow-sm text-sm font-medium rounded-md text-neutral-700 bg-white hover:bg-neutral-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-brand-primary">
                                            Export Logs
                                        </button>

                                        <button onclick="location.reload()"
                                            class="inline-flex items-center px-4 py-2 border border-neutral-300 shadow-sm text-sm font-medium rounded-md text-neutral-700 bg-white hover:bg-neutral-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-brand-primary">
                                            Refresh
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- Logs Table -->
                    <section class="py-12">
                        <div class="container mx-auto px-4 sm:px-6 lg:px-8">
                            <div class="max-w-6xl mx-auto">
                                <div class="bg-white shadow overflow-hidden sm:rounded-lg">
                                    <div class="overflow-x-auto">
                                        <table class="min-w-full divide-y divide-neutral-200">
                                            <thead class="bg-neutral-50">
                                                <tr>
                                                    <th scope="col"
                                                        class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                        ID</th>
                                                    <th scope="col"
                                                        class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                        User ID</th>
                                                    <th scope="col"
                                                        class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                        Action</th>
                                                    <th scope="col"
                                                        class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                        IP Address</th>
                                                    <th scope="col"
                                                        class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                        User Agent</th>
                                                    <th scope="col"
                                                        class="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                                        Timestamp</th>
                                                </tr>
                                            </thead>
                                            <tbody class="bg-white divide-y divide-neutral-200">
                                                <c:choose>
                                                    <c:when test="${not empty accessLogs}">
                                                        <c:forEach var="log" items="${accessLogs}">
                                                            <tr class="hover:bg-neutral-50 transition-colors">
                                                                <td
                                                                    class="px-6 py-4 whitespace-nowrap text-sm text-neutral-900">
                                                                    <c:out value="${log.id}" />
                                                                </td>
                                                                <td
                                                                    class="px-6 py-4 whitespace-nowrap text-sm text-neutral-900">
                                                                    <c:out
                                                                        value="${log.userId > 0 ? log.userId : 'N/A'}" />
                                                                </td>
                                                                <td class="px-6 py-4 whitespace-nowrap">
                                                                    <span
                                                                        class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-800">
                                                                        <c:out
                                                                            value="${log.action != null ? log.action : 'N/A'}" />
                                                                    </span>
                                                                </td>
                                                                <td
                                                                    class="px-6 py-4 whitespace-nowrap text-sm text-neutral-600">
                                                                    <c:out
                                                                        value="${log.ipAddress != null && !empty log.ipAddress ? log.ipAddress : 'N/A'}" />
                                                                </td>
                                                                <td
                                                                    class="px-6 py-4 whitespace-nowrap text-sm text-neutral-600">
                                                                    <c:choose>
                                                                        <c:when
                                                                            test="${log.userAgent != null && !empty log.userAgent}">
                                                                            <span
                                                                                title="${fn:escapeXml(log.userAgent)}">
                                                                                <c:out
                                                                                    value="${fn:substring(log.userAgent, 0, 30)}" />
                                                                                <c:if
                                                                                    test="${fn:length(log.userAgent) > 30}">
                                                                                    ...</c:if>
                                                                            </span>
                                                                        </c:when>
                                                                        <c:otherwise>N/A</c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                                <td
                                                                    class="px-6 py-4 whitespace-nowrap text-sm text-neutral-600">
                                                                    <c:choose>
                                                                        <c:when test="${log.timestamp != null}">
                                                                            <c:out value="${log.formattedTimestamp}" />
                                                                        </c:when>
                                                                        <c:otherwise>N/A</c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <tr>
                                                            <td colspan="6"
                                                                class="px-6 py-12 text-center text-sm text-neutral-500">
                                                                No access logs available.
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