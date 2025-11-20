<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || (!"staff".equalsIgnoreCase(user.getRole()) && !"admin".equalsIgnoreCase(user.getRole()))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    String contextPath = request.getContextPath();
    boolean isEdit = request.getAttribute("supplier") != null;
%>

<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Edit' : 'Add'} Supplier | IoT Bay - Admin Portal</title>
    <link rel="stylesheet" href="<%= contextPath %>/css/modern-theme.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="antialiased bg-neutral-50 text-neutral-900 min-h-screen flex flex-col">
    
    <c:import url="/components/organisms/header/header.jsp" />
    
    <main class="flex-1">
        <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
            <div class="container">
                <div class="max-w-3xl mx-auto">
                    <div class="mb-8">
                        <a href="<%= contextPath %>/admin/supplier/" class="text-neutral-500 hover:text-neutral-900 flex items-center gap-2 mb-4">
                            &larr; Back to Suppliers
                        </a>
                        <h1 class="text-display-md text-neutral-900">
                            ${isEdit ? 'Edit' : 'Add New'} <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Supplier</span>
                        </h1>
                    </div>

                    <div class="bg-white p-8 rounded-xl shadow-sm border border-neutral-200">
                        <form action="<%= contextPath %>/admin/supplier/${isEdit ? 'update' : 'create'}" method="post">
                            <c:if test="${not empty supplier}">
                                <input type="hidden" name="id" value="${supplier.id}">
                            </c:if>
                            <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                                <div class="col-span-2">
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Company Name *</label>
                                    <input type="text" name="companyName" value="${supplier.companyName}" required class="form-input w-full" placeholder="e.g. IoT Solutions Inc.">
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Contact Name *</label>
                                    <input type="text" name="contactName" value="${supplier.contactName}" required class="form-input w-full" placeholder="e.g. John Doe">
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Email *</label>
                                    <input type="email" name="email" value="${supplier.email}" required class="form-input w-full" placeholder="contact@company.com">
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Phone *</label>
                                    <input type="tel" name="phone" value="${supplier.phoneNumber}" required class="form-input w-full" placeholder="+1-555-0123">
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Website</label>
                                    <input type="url" name="website" value="${supplier.website}" class="form-input w-full" placeholder="https://example.com">
                                </div>

                                <div class="col-span-2">
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Address Line 1 *</label>
                                    <input type="text" name="address" value="${supplier.addressLine1}" required class="form-input w-full" placeholder="123 Tech Park">
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">City *</label>
                                    <input type="text" name="city" value="${supplier.city}" required class="form-input w-full">
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">State *</label>
                                    <input type="text" name="state" value="${supplier.state}" required class="form-input w-full">
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Zip Code *</label>
                                    <input type="text" name="zipCode" value="${supplier.postalCode}" required class="form-input w-full">
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Country *</label>
                                    <input type="text" name="country" value="${supplier.country}" required class="form-input w-full">
                                </div>
                            </div>

                            <div class="flex justify-end gap-4 pt-6 border-t border-neutral-100">
                                <a href="<%= contextPath %>/admin/supplier/" class="btn btn--outline">Cancel</a>
                                <button type="submit" class="btn btn--primary">
                                    ${isEdit ? 'Update Supplier' : 'Create Supplier'}
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <c:import url="/components/organisms/footer/footer.jsp" />
</body>
</html>