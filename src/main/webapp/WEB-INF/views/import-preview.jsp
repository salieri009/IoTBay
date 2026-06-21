<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

<t:base title="Import Preview | IoT Bay">
    <section class="py-8 bg-white border-b-2 border-brand-primary">
        <div class="l-container">
            <div class="max-w-6xl mx-auto">
                <h1 class="text-3xl font-bold text-neutral-900 mb-2">
                    Import <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Preview</span>
                </h1>
                <p class="text-lg text-neutral-600">
                    Review the data below before confirming the import.
                    Entity type: <strong><c:out value="${empty importEntityType ? '—' : importEntityType}"/></strong>
                </p>
            </div>
        </div>
    </section>

    <section class="py-8">
        <div class="l-container">
            <div class="max-w-6xl mx-auto space-y-6">

                <div class="bg-white shadow rounded-lg overflow-hidden">
                    <div class="px-6 py-4 border-b border-neutral-200 flex items-center justify-between">
                        <span class="text-sm text-neutral-500">
                            <c:choose>
                                <c:when test="${not empty importRows}">
                                    ${fn:length(importRows)} row(s) ready to import
                                </c:when>
                                <c:otherwise>No data</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-neutral-200 text-sm">
                            <thead class="bg-neutral-50">
                                <tr>
                                    <th class="px-4 py-3 text-left font-semibold text-neutral-600 uppercase tracking-wider text-xs">#</th>
                                    <c:forEach var="h" items="${importHeaders}">
                                        <th class="px-4 py-3 text-left font-semibold text-neutral-600 uppercase tracking-wider text-xs">
                                            <c:out value="${h}"/>
                                        </th>
                                    </c:forEach>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-neutral-200">
                                <c:choose>
                                    <c:when test="${not empty importRows}">
                                        <c:forEach var="row" items="${importRows}" varStatus="rs">
                                            <c:set var="hasError" value="${fn:length(row) lt fn:length(importHeaders)}"/>
                                            <tr class="${hasError ? 'bg-red-50' : 'hover:bg-neutral-50'}">
                                                <td class="px-4 py-2 text-neutral-500">${rs.index + 1}</td>
                                                <c:forEach var="cell" items="${row}">
                                                    <td class="px-4 py-2 text-neutral-900"><c:out value="${cell}"/></td>
                                                </c:forEach>
                                                <c:if test="${hasError}">
                                                    <td colspan="10" class="px-4 py-2 text-red-700 text-xs font-medium">Incomplete row &mdash; will be skipped</td>
                                                </c:if>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="10" class="px-6 py-8 text-center text-neutral-500">No data rows to preview.</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
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
                    <a href="${pageContext.request.contextPath}/data-management"
                        class="inline-flex items-center px-6 py-2 border border-neutral-300 text-sm font-medium rounded-md text-neutral-700 bg-white hover:bg-neutral-50">
                        Cancel
                    </a>
                </div>

            </div>
        </div>
    </section>
</t:base>
