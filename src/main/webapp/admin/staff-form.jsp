<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.User" %>

<% User sessionUser=(User) session.getAttribute("user");
   if (sessionUser==null || (!"staff".equalsIgnoreCase(sessionUser.getRole()) && !"admin".equalsIgnoreCase(sessionUser.getRole()))) {
       response.sendRedirect(request.getContextPath() + "/login.jsp"); return;
   }
   String csrfToken = utils.SecurityUtil.generateCSRFToken(request);
   User editStaff = (User) request.getAttribute("editStaff");
   boolean isEdit = editStaff != null;
%>

<t:base title="${isEdit ? 'Edit' : 'Add'} Staff | IoT Bay">
    <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
        <div class="container">
            <div class="max-w-3xl mx-auto">
                <a href="<c:url value='/admin/staff/'/>" class="text-neutral-500 hover:text-neutral-900 flex items-center gap-2 mb-4 text-sm">
                    &larr; Back to Staff
                </a>
                <h1 class="text-display-md text-neutral-900 mb-6">
                    <% if (isEdit) { %>
                        Edit <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Staff Member</span>
                    <% } else { %>
                        Add New <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Staff Member</span>
                    <% } %>
                </h1>

                <% if (request.getAttribute("error") != null) { %>
                <div class="mb-6 rounded-lg border border-red-200 bg-red-50 p-4 text-sm text-red-800">
                    <strong>Error:</strong> <%= request.getAttribute("error") %>
                </div>
                <% } %>

                <div class="bg-white p-8 rounded-xl shadow-sm border border-neutral-200">
                    <form action="<c:url value='/admin/staff/${isEdit ? "update" : "create"}'/>" method="post" class="space-y-6">
                        <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                        <% if (isEdit) { %>
                            <input type="hidden" name="user_id" value="<%= editStaff.getId() %>">
                        <% } %>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label class="block text-sm font-medium text-neutral-700 mb-1">First Name *</label>
                                <input type="text" name="firstName" required class="form-input w-full"
                                       value="<%= isEdit ? editStaff.getFirstName() : "" %>">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-neutral-700 mb-1">Last Name *</label>
                                <input type="text" name="lastName" required class="form-input w-full"
                                       value="<%= isEdit ? editStaff.getLastName() : "" %>">
                            </div>
                            <div class="col-span-2">
                                <label class="block text-sm font-medium text-neutral-700 mb-1">Email *</label>
                                <input type="email" name="email" required class="form-input w-full"
                                       value="<%= isEdit ? editStaff.getEmail() : "" %>">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-neutral-700 mb-1">Password <%= isEdit ? "(leave blank to keep)" : "*" %></label>
                                <input type="password" name="password" <%= isEdit ? "" : "required" %> class="form-input w-full" placeholder="••••••••">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-neutral-700 mb-1">Phone</label>
                                <input type="tel" name="phone" class="form-input w-full"
                                       value="<%= isEdit && editStaff.getPhone() != null ? editStaff.getPhone() : "" %>">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-neutral-700 mb-1">Position *</label>
                                <select name="position" required class="form-input w-full">
                                    <% String pos = isEdit && editStaff.getPosition() != null ? editStaff.getPosition() : ""; %>
                                    <option value="">Select position...</option>
                                    <option value="salesperson" <%= "salesperson".equals(pos) ? "selected" : "" %>>Salesperson</option>
                                    <option value="manager" <%= "manager".equals(pos) ? "selected" : "" %>>Manager</option>
                                    <option value="support" <%= "support".equals(pos) ? "selected" : "" %>>Support</option>
                                    <option value="technician" <%= "technician".equals(pos) ? "selected" : "" %>>Technician</option>
                                </select>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-neutral-700 mb-1">Date of Birth</label>
                                <input type="date" name="dateOfBirth" class="form-input w-full"
                                       value="<%= isEdit && editStaff.getDateOfBirth() != null ? editStaff.getDateOfBirth().toString() : "" %>">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-neutral-700 mb-1">Status</label>
                                <select name="isActive" class="form-input w-full">
                                    <option value="true" <%= !isEdit || editStaff.isActive() ? "selected" : "" %>>Active</option>
                                    <option value="false" <%= isEdit && !editStaff.isActive() ? "selected" : "" %>>Inactive</option>
                                </select>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-neutral-700 mb-1">Postal Code</label>
                                <input type="text" name="postalCode" class="form-input w-full"
                                       value="<%= isEdit && editStaff.getPostalCode() != null ? editStaff.getPostalCode() : "" %>">
                            </div>
                            <div class="col-span-2">
                                <label class="block text-sm font-medium text-neutral-700 mb-1">Address</label>
                                <input type="text" name="addressLine1" class="form-input w-full mb-2"
                                       placeholder="Address line 1"
                                       value="<%= isEdit && editStaff.getAddressLine1() != null ? editStaff.getAddressLine1() : "" %>">
                                <input type="text" name="addressLine2" class="form-input w-full"
                                       placeholder="Address line 2"
                                       value="<%= isEdit && editStaff.getAddressLine2() != null ? editStaff.getAddressLine2() : "" %>">
                            </div>
                        </div>

                        <div class="flex justify-end gap-4 pt-6 border-t border-neutral-100">
                            <a href="<c:url value='/admin/staff/'/>" class="btn btn--outline">Cancel</a>
                            <button type="submit" class="btn btn--primary">
                                <%= isEdit ? "Update Staff" : "Create Staff" %>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>
</t:base>
