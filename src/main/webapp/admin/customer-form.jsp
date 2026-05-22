<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.User" %>

<%
    User sessionUser = (User) session.getAttribute("user");
    if (sessionUser == null || (!"staff".equalsIgnoreCase(sessionUser.getRole()) &&
            !"admin".equalsIgnoreCase(sessionUser.getRole()))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    // Generate CSRF token and expose to EL scope
    String csrfToken = utils.SecurityUtil.generateCSRFToken(request);
    User editCustomer = (User) request.getAttribute("editCustomer");
    boolean isEdit = editCustomer != null;
    // Set all values in page scope for EL access inside scriptless body
    pageContext.setAttribute("csrfToken", csrfToken);
    pageContext.setAttribute("editCustomer", editCustomer);
    pageContext.setAttribute("isEdit", isEdit);
    pageContext.setAttribute("customerFormAction", isEdit ? "/admin/customer/update" : "/admin/customer/create");
    pageContext.setAttribute("errorMsg", request.getAttribute("error"));
    // Pre-compute customer type for select
    if (isEdit && editCustomer.getCustomerType() != null) {
        pageContext.setAttribute("ctype", editCustomer.getCustomerType());
    } else {
        pageContext.setAttribute("ctype", "individual");
    }
%>

<t:base title="${isEdit ? 'Edit' : 'Add'} Customer | IoT Bay">
    <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
        <div class="container">
            <div class="max-w-3xl mx-auto">
                <a href="<c:url value='/admin/customer/'/>" class="text-neutral-500 hover:text-neutral-900 flex items-center gap-2 mb-4 text-sm">
                    &larr; Back to Customers
                </a>
                <h1 class="text-display-md text-neutral-900 mb-6">
                    <c:choose>
                        <c:when test="${isEdit}">
                            Edit <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Customer</span>
                        </c:when>
                        <c:otherwise>
                            Add New <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Customer</span>
                        </c:otherwise>
                    </c:choose>
                </h1>

                <c:if test="${not empty errorMsg}">
                <div class="mb-6 rounded-lg border border-red-200 bg-red-50 p-4 text-sm text-red-800">
                    <strong>Error:</strong> <c:out value="${errorMsg}"/>
                </div>
                </c:if>

                <div class="bg-white p-8 rounded-xl shadow-sm border border-neutral-200">
                    <form action="<c:url value='${customerFormAction}'/>" method="post" class="space-y-6">
                        <input type="hidden" name="csrfToken" value="${csrfToken}">
                        <c:if test="${isEdit}">
                            <input type="hidden" name="user_id" value="${editCustomer.id}">
                        </c:if>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label class="block text-sm font-medium text-neutral-700 mb-1">First Name *</label>
                                <input type="text" name="firstName" required class="form-input w-full"
                                       value="${isEdit ? editCustomer.firstName : ''}">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-neutral-700 mb-1">Last Name *</label>
                                <input type="text" name="lastName" required class="form-input w-full"
                                       value="${isEdit ? editCustomer.lastName : ''}">
                            </div>
                            <div class="col-span-2">
                                <label class="block text-sm font-medium text-neutral-700 mb-1">Email *</label>
                                <input type="email" name="email" required class="form-input w-full"
                                       value="${isEdit ? editCustomer.email : ''}">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-neutral-700 mb-1">
                                    Password <c:choose><c:when test="${isEdit}">(leave blank to keep)</c:when><c:otherwise>*</c:otherwise></c:choose>
                                </label>
                                <input type="password" name="password" class="form-input w-full" placeholder="••••••••"
                                       <c:if test="${not isEdit}">required</c:if>>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-neutral-700 mb-1">Phone</label>
                                <input type="tel" name="phone" class="form-input w-full"
                                       value="${isEdit ? editCustomer.phone : ''}">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-neutral-700 mb-1">Customer Type *</label>
                                <select name="customerType" required class="form-input w-full">
                                    <option value="individual" <c:if test="${ctype == 'individual'}">selected</c:if>>Individual</option>
                                    <option value="company" <c:if test="${ctype == 'company'}">selected</c:if>>Company</option>
                                </select>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-neutral-700 mb-1">Date of Birth</label>
                                <input type="date" name="dateOfBirth" class="form-input w-full"
                                       value="${isEdit ? editCustomer.dateOfBirthAsString : ''}">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-neutral-700 mb-1">Status</label>
                                <select name="isActive" class="form-input w-full">
                                    <option value="true" <c:if test="${not isEdit or editCustomer.active}">selected</c:if>>Active</option>
                                    <option value="false" <c:if test="${isEdit and not editCustomer.active}">selected</c:if>>Inactive</option>
                                </select>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-neutral-700 mb-1">Postal Code</label>
                                <input type="text" name="postalCode" class="form-input w-full"
                                       value="${isEdit ? editCustomer.postalCode : ''}">
                            </div>
                            <div class="col-span-2">
                                <label class="block text-sm font-medium text-neutral-700 mb-1">Address Line 1</label>
                                <input type="text" name="addressLine1" class="form-input w-full"
                                       value="${isEdit ? editCustomer.addressLine1 : ''}">
                            </div>
                            <div class="col-span-2">
                                <label class="block text-sm font-medium text-neutral-700 mb-1">Address Line 2</label>
                                <input type="text" name="addressLine2" class="form-input w-full"
                                       value="${isEdit ? editCustomer.addressLine2 : ''}">
                            </div>
                        </div>

                        <div class="flex justify-end gap-4 pt-6 border-t border-neutral-100">
                            <a href="<c:url value='/admin/customer/'/>" class="btn btn--outline">Cancel</a>
                            <button type="submit" class="btn btn--primary">
                                ${isEdit ? 'Update Customer' : 'Create Customer'}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>
</t:base>
