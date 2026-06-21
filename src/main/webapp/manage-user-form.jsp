<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.User" %>

<% User sessionUser=(User) session.getAttribute("user");
   if (sessionUser==null ||
       (!"staff".equalsIgnoreCase(sessionUser.getRole()) && !"admin".equalsIgnoreCase(sessionUser.getRole()))) {
       response.sendRedirect(request.getContextPath() + "/login.jsp" ); return;
   }
   String csrfToken=utils.SecurityUtil.generateCSRFToken(request);
   User editUser = (User) request.getAttribute("editUser");
   boolean isEdit = editUser != null;
   pageContext.setAttribute("csrfToken", csrfToken);
   pageContext.setAttribute("isEdit", isEdit);
%>

<t:base title="${isEdit ? 'Edit' : 'Add'} User | IoT Bay">
    <main class="flex-1">
        <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
            <div class="container">
                <div class="max-w-3xl mx-auto">
                    <div class="mb-8">
                        <a href="${pageContext.request.contextPath}/api/manage/users"
                            class="text-neutral-500 hover:text-neutral-900 flex items-center gap-2 mb-4">
                            &larr; Back to Users
                        </a>
                        <h1 class="text-display-md text-neutral-900">
                            ${isEdit ? 'Edit' : 'Add New'}
                            <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">User</span>
                        </h1>
                    </div>

                    <div class="bg-white p-8 rounded-xl shadow-sm border border-neutral-200">
                        <c:if test="${not empty error}">
                            <div class="mb-6 rounded-lg border border-red-200 bg-red-50 p-4 text-sm text-red-800" role="alert">
                                <strong>Error:</strong> <c:out value="${error}"/>
                            </div>
                        </c:if>
                        <form action="${pageContext.request.contextPath}${isEdit ? '/manage/users/update' : '/api/manage/users'}"
                            method="post">
                            <input type="hidden" name="csrfToken" value="${csrfToken}">
                            <c:if test="${isEdit}">
                                <input type="hidden" name="user_id" value="${editUser.id}">
                            </c:if>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">First Name *</label>
                                    <input type="text" name="firstName" required
                                        class="form-input w-full" placeholder="John"
                                        value="<c:out value='${editUser.firstName}'/>">
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Last Name *</label>
                                    <input type="text" name="lastName" required
                                        class="form-input w-full" placeholder="Doe"
                                        value="<c:out value='${editUser.lastName}'/>">
                                </div>

                                <div class="col-span-2">
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Email *</label>
                                    <input type="email" name="email" required
                                        class="form-input w-full"
                                        placeholder="john.doe@example.com"
                                        value="<c:out value='${editUser.email}'/>">
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Password ${isEdit ? '(leave blank to keep current)' : '*'}</label>
                                    <input type="password" name="password" ${isEdit ? '' : 'required'}
                                        class="form-input w-full" placeholder="••••••••">
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Phone Number</label>
                                    <input type="tel" name="phone" class="form-input w-full"
                                        placeholder="+61 400 000 000"
                                        value="<c:out value='${editUser.phone}'/>">
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Date of Birth</label>
                                    <input type="date" name="dateOfBirth" class="form-input w-full"
                                        value="<c:out value='${editUser.dateOfBirth}'/>">
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Role *</label>
                                    <select name="role" required class="form-input w-full">
                                        <option value="customer" ${editUser.role == 'customer' ? 'selected' : ''}>Customer</option>
                                        <option value="staff" ${editUser.role == 'staff' ? 'selected' : ''}>Staff</option>
                                    </select>
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Active Status</label>
                                    <select name="isActive" class="form-input w-full">
                                        <option value="true" ${!isEdit || editUser.active ? 'selected' : ''}>Active</option>
                                        <option value="false" ${isEdit && !editUser.active ? 'selected' : ''}>Inactive</option>
                                    </select>
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Postal Code</label>
                                    <input type="text" name="postalCode" class="form-input w-full"
                                        value="<c:out value='${editUser.postalCode}'/>">
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Address Line 1</label>
                                    <input type="text" name="addressLine1" class="form-input w-full"
                                        value="<c:out value='${editUser.addressLine1}'/>">
                                </div>

                                <div class="col-span-2">
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Address Line 2</label>
                                    <input type="text" name="addressLine2" class="form-input w-full"
                                        value="<c:out value='${editUser.addressLine2}'/>">
                                </div>
                            </div>

                            <div class="flex justify-end gap-4 pt-6 border-t border-neutral-100">
                                <a href="${pageContext.request.contextPath}/api/manage/users"
                                    class="btn btn--outline">Cancel</a>
                                <button type="submit" class="btn btn--primary">
                                    ${isEdit ? 'Update User' : 'Create User'}
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>
    </main>
</t:base>
