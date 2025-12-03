<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
                <%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
                    <%@ page import="java.util.List" %>
                        <%@ page import="model.AccessLog" %>
                            <%@ page import="model.User" %>

                                <% // Staff authorization check User currentUser=(User) session.getAttribute("user"); if
                                    (currentUser==null || (!"staff".equalsIgnoreCase(currentUser.getRole()) &&
                                    !"admin".equalsIgnoreCase(currentUser.getRole()))) {
                                    response.sendRedirect(request.getContextPath() + "/login.jsp" ); return; } // Get
                                    logs from request attribute List<AccessLog> logs = (List<AccessLog>)
                                        request.getAttribute("accessLogs");
                                        if (logs == null) {
                                        logs = new java.util.ArrayList<>();
                                            }
                                            request.setAttribute("logs", logs);
                                            %>

                                            <t:base>
                                                <jsp:attribute name="title">Access Logs | IoT Bay - Staff Portal
                                                </jsp:attribute>
                                                <jsp:attribute name="customCSS">admin.css</jsp:attribute>

                                                <jsp:body>
                                                    <!-- Page Header -->
                                                    <section
                                                        class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
                                                        <div class="container">
                                                            <div class="max-w-6xl mx-auto">
                                                                <div class="flex items-center justify-between mb-8">
                                                                    <div>
                                                                        <h1
                                                                            class="text-display-lg text-neutral-900 mb-2">
                                                                            Access <span
                                                                                class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Logs</span>
                                                                        </h1>
                                                                        <p class="text-lg text-neutral-600">
                                                                            Monitor system access and user activities
                                                                        </p>
                                                                    </div>
                                                                    <div class="flex items-center gap-3">
                                                                        <jsp:include
                                                                            page="/components/atoms/button/button.jsp">
                                                                            <jsp:param name="text"
                                                                                value="Export Logs" />
                                                                            <jsp:param name="type" value="secondary" />
                                                                        </jsp:include>

                                                                        <jsp:include
                                                                            page="/components/atoms/button/button.jsp">
                                                                            <jsp:param name="text" value="Refresh" />
                                                                            <jsp:param name="type" value="outline" />
                                                                            <jsp:param name="onclick"
                                                                                value="location.reload()" />
                                                                        </jsp:include>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </section>

                                                    <!-- Logs Table -->
                                                    <section class="py-12">
                                                        <div class="container">
                                                            <div class="max-w-6xl mx-auto">
                                                                <div class="card overflow-hidden">
                                                                    <div class="overflow-x-auto">
                                                                        <table class="w-full">
                                                                            <thead class="bg-neutral-50">
                                                                                <tr>
                                                                                    <th
                                                                                        class="text-left py-4 px-6 font-medium text-neutral-700">
                                                                                        ID</th>
                                                                                    <th
                                                                                        class="text-left py-4 px-6 font-medium text-neutral-700">
                                                                                        User ID</th>
                                                                                    <th
                                                                                        class="text-left py-4 px-6 font-medium text-neutral-700">
                                                                                        Action</th>
                                                                                    <th
                                                                                        class="text-left py-4 px-6 font-medium text-neutral-700">
                                                                                        IP Address</th>
                                                                                    <th
                                                                                        class="text-left py-4 px-6 font-medium text-neutral-700">
                                                                                        User Agent</th>
                                                                                    <th
                                                                                        class="text-left py-4 px-6 font-medium text-neutral-700">
                                                                                        Timestamp</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody class="divide-y divide-neutral-200">
                                                                                <c:choose>
                                                                                    <c:when test="${not empty logs}">
                                                                                        <c:forEach var="log"
                                                                                            items="${logs}">
                                                                                            <tr
                                                                                                class="hover:bg-neutral-50">
                                                                                                <td
                                                                                                    class="py-4 px-6 text-neutral-900">
                                                                                                    ${log.id}</td>
                                                                                                <td
                                                                                                    class="py-4 px-6 text-neutral-900">
                                                                                                    ${log.userId > 0 ?
                                                                                                    log.userId : 'N/A'}
                                                                                                </td>
                                                                                                <td class="py-4 px-6">
                                                                                                    <jsp:include
                                                                                                        page="/components/atoms/badge/badge.jsp">
                                                                                                        <jsp:param
                                                                                                            name="text"
                                                                                                            value="${log.action != null ? log.action : 'N/A'}" />
                                                                                                        <jsp:param
                                                                                                            name="type"
                                                                                                            value="neutral" />
                                                                                                    </jsp:include>
                                                                                                </td>
                                                                                                <td
                                                                                                    class="py-4 px-6 text-neutral-600">
                                                                                                    ${log.ipAddress !=
                                                                                                    null && !empty
                                                                                                    log.ipAddress ?
                                                                                                    log.ipAddress :
                                                                                                    'N/A'}
                                                                                                </td>
                                                                                                <td
                                                                                                    class="py-4 px-6 text-neutral-600 text-sm">
                                                                                                    <c:choose>
                                                                                                        <c:when
                                                                                                            test="${log.userAgent != null && !empty log.userAgent}">
                                                                                                            <span
                                                                                                                title="${log.userAgent}">
                                                                                                                ${fn:substring(log.userAgent,
                                                                                                                0,
                                                                                                                50)}${fn:length(log.userAgent)
                                                                                                                > 50 ?
                                                                                                                '...' :
                                                                                                                ''}
                                                                                                            </span>
                                                                                                        </c:when>
                                                                                                        <c:otherwise>N/A
                                                                                                        </c:otherwise>
                                                                                                    </c:choose>
                                                                                                </td>
                                                                                                <td
                                                                                                    class="py-4 px-6 text-neutral-600">
                                                                                                    <c:choose>
                                                                                                        <c:when
                                                                                                            test="${log.timestamp != null}">
                                                                                                            ${log.timestamp}
                                                                                                        </c:when>
                                                                                                        <c:otherwise>N/A
                                                                                                        </c:otherwise>
                                                                                                    </c:choose>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </c:forEach>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <tr>
                                                                                            <td colspan="6"
                                                                                                class="py-8 px-6 text-center text-neutral-600">
                                                                                                No access logs
                                                                                                available.
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
                                                </jsp:body>
                                            </t:base>