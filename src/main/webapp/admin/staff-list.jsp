<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="model.User" %>

<% User sessionUser=(User) session.getAttribute("user");
   if (sessionUser==null || (!"staff".equalsIgnoreCase(sessionUser.getRole()) && !"admin".equalsIgnoreCase(sessionUser.getRole()))) {
       response.sendRedirect(request.getContextPath() + "/login.jsp"); return;
   }
%>

<t:base title="Manage Staff" customCSS="modern-theme.css">
    <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
        <div class="l-container">
            <div class="max-w-6xl mx-auto">
                <div class="flex items-center justify-between mb-8">
                    <div>
                        <h1 class="text-display-lg text-neutral-900 mb-2">
                            Manage <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Staff</span>
                        </h1>
                        <p class="text-lg text-neutral-600">Manage staff accounts and positions</p>
                    </div>
                    <a href="<c:url value='/admin/staff/form'/>" class="btn btn--primary">Add Staff</a>
                </div>

                <!-- Search Filters -->
                <div class="bg-white p-4 rounded-xl shadow-sm border border-neutral-200 mb-6">
                    <form action="<c:url value='/admin/staff/search'/>" method="get" class="flex gap-4 items-end flex-wrap">
                        <div>
                            <label class="block text-xs font-medium text-neutral-600 mb-1">Name</label>
                            <input type="text" name="name" value="${searchName}" placeholder="Search name..." class="form-input">
                        </div>
                        <div>
                            <label class="block text-xs font-medium text-neutral-600 mb-1">Position</label>
                            <select name="position" class="form-input">
                                <option value="all" ${searchPosition=='all'||empty searchPosition?'selected':''}>All Positions</option>
                                <option value="salesperson" ${searchPosition=='salesperson'?'selected':''}>Salesperson</option>
                                <option value="manager" ${searchPosition=='manager'?'selected':''}>Manager</option>
                                <option value="support" ${searchPosition=='support'?'selected':''}>Support</option>
                                <option value="technician" ${searchPosition=='technician'?'selected':''}>Technician</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn--primary btn--sm">Search</button>
                        <a href="<c:url value='/admin/staff/'/>" class="btn btn--outline btn--sm">Reset</a>
                    </form>
                </div>

                <!-- Staff Table -->
                <div class="bg-white rounded-xl shadow-sm border border-neutral-200 overflow-hidden">
                    <div class="p-4 border-b border-neutral-200">
                        <span class="text-sm text-neutral-500">
                            <c:choose>
                                <c:when test="${not empty staffList}">${fn:length(staffList)} staff member(s)</c:when>
                                <c:otherwise>No staff found</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="w-full text-left border-collapse">
                            <thead>
                                <tr class="bg-neutral-50 border-b border-neutral-200">
                                    <th class="p-4 font-semibold text-neutral-700 text-sm">ID</th>
                                    <th class="p-4 font-semibold text-neutral-700 text-sm">Name</th>
                                    <th class="p-4 font-semibold text-neutral-700 text-sm">Email</th>
                                    <th class="p-4 font-semibold text-neutral-700 text-sm">Phone</th>
                                    <th class="p-4 font-semibold text-neutral-700 text-sm">Position</th>
                                    <th class="p-4 font-semibold text-neutral-700 text-sm">Status</th>
                                    <th class="p-4 font-semibold text-neutral-700 text-sm">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-neutral-200">
                                <c:forEach var="s" items="${staffList}">
                                    <tr class="hover:bg-neutral-50 transition-colors">
                                        <td class="p-4 text-sm text-neutral-600">#${s.id}</td>
                                        <td class="p-4 font-medium text-neutral-900">${s.firstName} ${s.lastName}</td>
                                        <td class="p-4 text-sm text-neutral-600">${s.email}</td>
                                        <td class="p-4 text-sm text-neutral-600">${not empty s.phone ? s.phone : '—'}</td>
                                        <td class="p-4 text-sm">
                                            <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-purple-100 text-purple-800">
                                                ${not empty s.position ? s.position : 'staff'}
                                            </span>
                                        </td>
                                        <td class="p-4 text-sm">
                                            <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium ${s.active ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}">
                                                ${s.active ? 'Active' : 'Inactive'}
                                            </span>
                                        </td>
                                        <td class="p-4">
                                            <div class="flex items-center gap-2">
                                                <a href="<c:url value='/admin/staff/view/${s.id}'/>" class="text-brand-primary hover:text-brand-secondary font-medium text-sm">View</a>
                                                <a href="<c:url value='/admin/staff/edit/${s.id}'/>" class="text-neutral-600 hover:text-neutral-900 font-medium text-sm">Edit</a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty staffList}">
                                    <tr><td colspan="7" class="p-8 text-center text-neutral-500">No staff found.</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="mt-6">
                    <a href="<c:url value='/admin-dashboard'/>" class="btn btn--outline">&larr; Back to Dashboard</a>
                </div>
            </div>
        </div>
    </section>
</t:base>
