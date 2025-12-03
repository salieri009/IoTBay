<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"staff".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    String contextPath = request.getContextPath();
    
    // Mock supplier data
    List<Object> suppliers = new ArrayList<>();
    suppliers.add(new Object[]{"IoT Solutions Inc.", "contact@iotsolutions.com", "+1-555-0123", "Active", "50 products"});
    suppliers.add(new Object[]{"SmartTech Co.", "info@smarttech.com", "+1-555-0124", "Active", "25 products"});
    suppliers.add(new Object[]{"Global Connect", "sales@globalconnect.com", "+1-555-0125", "Inactive", "15 products"});
%>

<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Suppliers | IoT Bay - Staff Portal</title>
    <link rel="stylesheet" href="<%= contextPath %>/css/modern-theme.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="antialiased bg-neutral-50 text-neutral-900 min-h-screen flex flex-col">
    
    <c:import url="/components/organisms/header/header.jsp" />
    
    <main class="flex-1">
        <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
            <div class="container">
                <div class="max-w-6xl mx-auto">
                    <div class="flex items-center justify-between">
                        <div>
                            <h1 class="text-display-lg text-neutral-900 mb-2">
                                Manage <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Suppliers</span>
                            </h1>
                            <p class="text-lg text-neutral-600">Manage supplier relationships and contacts</p>
                        </div>
                        <div class="flex items-center gap-3">
                            <button class="btn btn--secondary">Export Suppliers</button>
                            <button class="btn btn--primary">Add Supplier</button>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="py-12">
            <div class="container">
                <div class="max-w-6xl mx-auto">
                    <div class="card p-6 mb-8">
                        <div class="flex flex-col md:flex-row gap-4 items-center">
                            <div class="flex-1">
                                <input type="text" placeholder="Search suppliers..." class="form-input">
                            </div>
                            <div class="flex items-center gap-3">
                                <select class="form-select">
                                    <option>All Status</option>
                                    <option>Active</option>
                                    <option>Inactive</option>
                                </select>
                                <button class="btn btn--outline">Filter</button>
                            </div>
                        </div>
                    </div>

                    <div class="card overflow-hidden">
                        <div class="overflow-x-auto">
                            <table class="w-full">
                                <thead class="bg-neutral-50">
                                    <tr>
                                        <th class="text-left py-4 px-6 font-medium text-neutral-700">Supplier</th>
                                        <th class="text-left py-4 px-6 font-medium text-neutral-700">Contact</th>
                                        <th class="text-left py-4 px-6 font-medium text-neutral-700">Phone</th>
                                        <th class="text-left py-4 px-6 font-medium text-neutral-700">Status</th>
                                        <th class="text-left py-4 px-6 font-medium text-neutral-700">Products</th>
                                        <th class="text-left py-4 px-6 font-medium text-neutral-700">Actions</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-neutral-200">
                                    <c:forEach var="supplier" items="<%= suppliers %>" varStatus="status">
                                        <tr class="hover:bg-neutral-50">
                                            <td class="py-4 px-6">
                                                <div class="flex items-center gap-3">
                                                    <div class="w-10 h-10 bg-gradient-to-br from-blue-500 to-purple-500 rounded-full flex items-center justify-center text-white font-semibold text-sm">
                                                        ${fn:substring(supplier[0], 0, 2)}
                                                    </div>
                                                    <div>
                                                        <p class="font-medium text-neutral-900">${supplier[0]}</p>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="py-4 px-6">
                                                <p class="text-neutral-900">${supplier[1]}</p>
                                            </td>
                                            <td class="py-4 px-6">
                                                <p class="text-neutral-900">${supplier[2]}</p>
                                            </td>
                                            <td class="py-4 px-6">
                                                <span class="badge ${supplier[3] == 'Active' ? 'badge--success' : 'badge--warning'}">
                                                    ${supplier[3]}
                                                </span>
                                            </td>
                                            <td class="py-4 px-6">
                                                <p class="text-neutral-900">${supplier[4]}</p>
                                            </td>
                                            <td class="py-4 px-6">
                                                <div class="flex items-center gap-2">
                                                    <button class="btn btn--ghost btn--sm">Edit</button>
                                                    <button class="btn btn--ghost btn--sm">View</button>
                                                    <button class="btn btn--ghost btn--sm text-red-600">Delete</button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
    
    <c:import url="/components/organisms/footer/footer.jsp" />
    <script src="<%= contextPath %>/js/main.js"></script>
</body>
</html>
