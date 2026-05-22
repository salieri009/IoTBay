<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
<%@ page import="java.util.List" %>

<%
    List<String[]> importRows = (List<String[]>) request.getAttribute("importRows");
    String[] importHeaders  = (String[]) request.getAttribute("importHeaders");
    String entityType       = (String) request.getAttribute("importEntityType");
%>

<t:base title="Import Preview | IoT Bay">
    <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
        <div class="container mx-auto px-4 sm:px-6 lg:px-8">
            <div class="max-w-6xl mx-auto">
                <h1 class="text-3xl font-bold text-neutral-900 mb-2">
                    Import <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Preview</span>
                </h1>
                <p class="text-lg text-neutral-600">
                    Review the data below before confirming the import.
                    Entity type: <strong><%= entityType != null ? entityType : "—" %></strong>
                </p>
            </div>
        </div>
    </section>

    <section class="py-8">
        <div class="container mx-auto px-4 sm:px-6 lg:px-8">
            <div class="max-w-6xl mx-auto space-y-6">

                <div class="bg-white shadow rounded-lg overflow-hidden">
                    <div class="px-6 py-4 border-b border-neutral-200 flex items-center justify-between">
                        <span class="text-sm text-neutral-500">
                            <% if (importRows != null) { %>
                                <%= importRows.size() %> row(s) ready to import
                            <% } else { %>
                                No data
                            <% } %>
                        </span>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-neutral-200 text-sm">
                            <thead class="bg-neutral-50">
                                <tr>
                                    <th class="px-4 py-3 text-left font-semibold text-neutral-600 uppercase tracking-wider text-xs">#</th>
                                    <%
                                        if (importHeaders != null) {
                                            for (String h : importHeaders) {
                                    %>
                                    <th class="px-4 py-3 text-left font-semibold text-neutral-600 uppercase tracking-wider text-xs"><%= h %></th>
                                    <%      }
                                        }
                                    %>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-neutral-200">
                                <%
                                    if (importRows != null && !importRows.isEmpty()) {
                                        int rowNum = 1;
                                        for (String[] row : importRows) {
                                            boolean hasError = (row.length < (importHeaders != null ? importHeaders.length : 0));
                                %>
                                <tr class="<%= hasError ? "bg-red-50" : "hover:bg-neutral-50" %>">
                                    <td class="px-4 py-2 text-neutral-500"><%= rowNum++ %></td>
                                    <%
                                        for (String cell : row) {
                                    %>
                                    <td class="px-4 py-2 text-neutral-900"><%= cell != null ? cell : "" %></td>
                                    <%
                                        }
                                        if (hasError) {
                                    %>
                                    <td colspan="10" class="px-4 py-2 text-red-700 text-xs font-medium">⚠ Incomplete row — will be skipped</td>
                                    <%
                                        }
                                    %>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="10" class="px-6 py-8 text-center text-neutral-500">No data rows to preview.</td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="flex gap-4">
                    <form method="post" action="${pageContext.request.contextPath}/api/dataManagement/confirmImport">
                        <button type="submit"
                            class="inline-flex items-center px-6 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500">
                            Confirm Import
                        </button>
                    </form>
                    <a href="${pageContext.request.contextPath}/WEB-INF/views/data-management.jsp"
                        class="inline-flex items-center px-6 py-2 border border-neutral-300 text-sm font-medium rounded-md text-neutral-700 bg-white hover:bg-neutral-50">
                        Cancel
                    </a>
                </div>

            </div>
        </div>
    </section>
</t:base>
