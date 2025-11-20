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
%>

<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add User | IoT Bay - Admin Portal</title>
    <link rel="stylesheet" href="<%= contextPath %>/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="antialiased bg-neutral-50 text-neutral-900 min-h-screen flex flex-col">
    
    <c:import url="/components/organisms/header/header.jsp" />
    
    <main class="flex-1">
        <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
            <div class="container">
                <div class="max-w-3xl mx-auto">
                    <div class="mb-8">
                        <a href="<%= contextPath %>/manage/users" class="text-neutral-500 hover:text-neutral-900 flex items-center gap-2 mb-4">
                            &larr; Back to Users
                        </a>
                        <h1 class="text-display-md text-neutral-900">
                            Add New <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">User</span>
                        </h1>
                    </div>

                    <div class="bg-white p-8 rounded-xl shadow-sm border border-neutral-200">
                        <form action="<%= contextPath %>/manage/users" method="post">
                            <%
                                String csrfToken = utils.SecurityUtil.generateCSRFToken(request);
                            %>
                            <input type="hidden" name="csrfToken" value="<%= csrfToken %>">

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">First Name *</label>
                                    <input type="text" name="firstName" required class="form-input w-full" placeholder="John">
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Last Name *</label>
                                    <input type="text" name="lastName" required class="form-input w-full" placeholder="Doe">
                                </div>

                                <div class="col-span-2">
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Email *</label>
                                    <input type="email" name="email" required class="form-input w-full" placeholder="john.doe@example.com">
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Password *</label>
                                    <input type="password" name="password" required class="form-input w-full" placeholder="••••••••">
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Phone Number</label>
                                    <input type="tel" name="phoneNumber" class="form-input w-full" placeholder="+1-555-0123">
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Role *</label>
                                    <select name="role" required class="form-input w-full">
                                        <option value="customer">Customer</option>
                                        <option value="staff">Staff</option>
                                        <option value="admin">Admin</option>
                                    </select>
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-neutral-700 mb-1">Active Status</label>
                                    <select name="isActive" class="form-input w-full">
                                        <option value="true" selected>Active</option>
                                        <option value="false">Inactive</option>
                                    </select>
                                </div>
                            </div>

                            <div class="flex justify-end gap-4 pt-6 border-t border-neutral-100">
                                <a href="<%= contextPath %>/manage/users" class="btn btn--outline">Cancel</a>
                                <button type="submit" class="btn btn--primary">
                                    Create User
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

