<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || (!"staff".equalsIgnoreCase(user.getRole()) && !"admin".equalsIgnoreCase(user.getRole()))) {
        response.sendRedirect("../../login.jsp");
        return;
    }
    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Data Management | IoT Bay - Admin Portal</title>
    <link rel="stylesheet" href="<%= contextPath %>/css/modern-theme.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="antialiased bg-neutral-50 text-neutral-900 min-h-screen flex flex-col">
    
    <c:import url="/components/organisms/header/header.jsp" />
    
    <main class="flex-1">
        <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
            <div class="container">
                <div class="max-w-4xl mx-auto text-center">
                    <h1 class="text-display-lg text-neutral-900 mb-4">
                        Data <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Management</span>
                    </h1>
                    <p class="text-lg text-neutral-600 max-w-2xl mx-auto">
                        Export system data and view database statistics
                    </p>
                </div>
            </div>
        </section>

        <section class="py-12">
            <div class="container">
                <div class="max-w-6xl mx-auto">
                    <!-- Statistics Cards -->
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12">
                        <div class="bg-white p-6 rounded-xl shadow-sm border border-neutral-200">
                            <div class="text-sm text-neutral-500 font-medium mb-1">Total Users</div>
                            <div class="text-3xl font-bold text-neutral-900">${totalUsers}</div>
                        </div>
                        <div class="bg-white p-6 rounded-xl shadow-sm border border-neutral-200">
                            <div class="text-sm text-neutral-500 font-medium mb-1">Total Products</div>
                            <div class="text-3xl font-bold text-neutral-900">${totalProducts}</div>
                        </div>
                        <div class="bg-white p-6 rounded-xl shadow-sm border border-neutral-200">
                            <div class="text-sm text-neutral-500 font-medium mb-1">Total Orders</div>
                            <div class="text-3xl font-bold text-neutral-900">${totalOrders}</div>
                        </div>
                    </div>

                    <!-- Export Actions -->
                    <div class="bg-white rounded-xl shadow-sm border border-neutral-200 overflow-hidden">
                        <div class="p-6 border-b border-neutral-200">
                            <h2 class="text-xl font-semibold text-neutral-900">Data Export</h2>
                            <p class="text-neutral-600 mt-1">Download system data in CSV format</p>
                        </div>
                        <div class="p-6 grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div class="p-4 border border-neutral-200 rounded-lg hover:border-brand-primary transition-colors">
                                <h3 class="font-semibold text-neutral-900 mb-2">User Data</h3>
                                <p class="text-sm text-neutral-600 mb-4">Export all registered user accounts and details.</p>
                                <a href="<%= contextPath %>/api/dataManagement/exportUsers" class="btn btn--secondary w-full justify-center">Export Users</a>
                            </div>
                            <div class="p-4 border border-neutral-200 rounded-lg hover:border-brand-primary transition-colors">
                                <h3 class="font-semibold text-neutral-900 mb-2">Product Catalog</h3>
                                <p class="text-sm text-neutral-600 mb-4">Export full product inventory and details.</p>
                                <a href="<%= contextPath %>/api/dataManagement/exportProducts" class="btn btn--secondary w-full justify-center">Export Products</a>
                            </div>
                            <div class="p-4 border border-neutral-200 rounded-lg hover:border-brand-primary transition-colors">
                                <h3 class="font-semibold text-neutral-900 mb-2">Order History</h3>
                                <p class="text-sm text-neutral-600 mb-4">Export all customer orders and transactions.</p>
                                <a href="<%= contextPath %>/api/dataManagement/exportOrders" class="btn btn--secondary w-full justify-center">Export Orders</a>
                            </div>
                            <div class="p-4 border border-neutral-200 rounded-lg hover:border-brand-primary transition-colors">
                                <h3 class="font-semibold text-neutral-900 mb-2">Access Logs</h3>
                                <p class="text-sm text-neutral-600 mb-4">Export system access and security logs.</p>
                                <a href="<%= contextPath %>/api/dataManagement/exportAccessLogs" class="btn btn--secondary w-full justify-center">Export Logs</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <c:import url="/components/organisms/footer/footer.jsp" />

</body>
</html>
