<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"staff".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("../../login.jsp");
        return;
    }
    String contextPath = request.getContextPath();
    
    // Mock user data
    List<User> users = new ArrayList<>();
    users.add(new User(1, "john.doe@example.com", "password123", "John", "Doe", "+61 400 000 001", "2000", "1 George St", "Sydney NSW", null, "Card", null, null, "customer", true));
    users.add(new User(2, "jane.smith@example.com", "password456", "Jane", "Smith", "+61 400 000 002", "2001", "2 Pitt St", "Sydney NSW", null, "PayPal", null, null, "customer", true));
    users.add(new User(3, "admin@iotbay.com", "admin123", "Admin", "User", "+61 400 000 003", "2002", "3 Admin St", "Sydney NSW", null, "Card", null, null, "staff", true));
%>

<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Manage users and customer accounts">
    <title>Manage Users | IoT Bay - Staff Portal</title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="<%= contextPath %>/css/modern-theme.css">
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="antialiased bg-neutral-50 text-neutral-900 min-h-screen flex flex-col">
    
    <!-- Header -->
    <jsp:include page="../components/header.jsp" />
    
    <main class="flex-1">
        <!-- Page Header -->
        <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
            <div class="container">
                <div class="max-w-6xl mx-auto">
                    <div class="flex items-center justify-between">
                        <div>
                            <h1 class="text-display-lg text-neutral-900 mb-2">
                                Manage <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Users</span>
                            </h1>
                            <p class="text-lg text-neutral-600">
                                Manage customer accounts and user permissions
                            </p>
                        </div>
                        <div class="flex items-center gap-3">
                            <button class="btn btn--secondary">
                                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                                </svg>
                                Export Users
                            </button>
                            <button class="btn btn--primary">
                                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
                                </svg>
                                Add User
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Users Management -->
        <section class="py-12">
            <div class="container">
                <div class="max-w-6xl mx-auto">
                    <!-- Filters and Search -->
                    <div class="card p-6 mb-8">
                        <div class="flex flex-col md:flex-row gap-4 items-center">
                            <div class="flex-1">
                                <div class="relative">
                                    <input type="text" placeholder="Search users..." class="form-input pr-10">
                                    <svg class="absolute right-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-neutral-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                                    </svg>
                                </div>
                            </div>
                            <div class="flex items-center gap-3">
                                <select class="form-select">
                                    <option>All Roles</option>
                                    <option>Customer</option>
                                    <option>Staff</option>
                                </select>
                                <select class="form-select">
                                    <option>All Status</option>
                                    <option>Active</option>
                                    <option>Inactive</option>
                                </select>
                                <button class="btn btn--outline">Filter</button>
                            </div>
                        </div>
                    </div>

                    <!-- Users Table -->
                    <div class="card overflow-hidden">
                        <div class="overflow-x-auto">
                            <table class="w-full">
                                <thead class="bg-neutral-50">
                                    <tr>
                                        <th class="text-left py-4 px-6 font-medium text-neutral-700">
                                            <input type="checkbox" class="rounded border-neutral-300">
                                        </th>
                                        <th class="text-left py-4 px-6 font-medium text-neutral-700">User</th>
                                        <th class="text-left py-4 px-6 font-medium text-neutral-700">Email</th>
                                        <th class="text-left py-4 px-6 font-medium text-neutral-700">Role</th>
                                        <th class="text-left py-4 px-6 font-medium text-neutral-700">Status</th>
                                        <th class="text-left py-4 px-6 font-medium text-neutral-700">Joined</th>
                                        <th class="text-left py-4 px-6 font-medium text-neutral-700">Actions</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-neutral-200">
                                    <c:forEach var="userItem" items="<%= users %>">
                                        <tr class="hover:bg-neutral-50">
                                            <td class="py-4 px-6">
                                                <input type="checkbox" class="rounded border-neutral-300">
                                            </td>
                                            <td class="py-4 px-6">
                                                <div class="flex items-center gap-3">
                                                    <div class="w-10 h-10 bg-gradient-to-br from-blue-500 to-purple-500 rounded-full flex items-center justify-center text-white font-semibold text-sm">
                                                        ${fn:toUpperCase(userItem.firstName.substring(0,1))}${fn:toUpperCase(userItem.lastName.substring(0,1))}
                                                    </div>
                                                    <div>
                                                        <p class="font-medium text-neutral-900">${userItem.firstName} ${userItem.lastName}</p>
                                                        <p class="text-sm text-neutral-600">ID: ${userItem.id}</p>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="py-4 px-6">
                                                <p class="text-neutral-900">${userItem.email}</p>
                                                <p class="text-sm text-neutral-600">${userItem.phone}</p>
                                            </td>
                                            <td class="py-4 px-6">
                                                <span class="badge ${userItem.role == 'staff' ? 'badge--info' : 'badge--secondary'}">
                                                    ${userItem.role}
                                                </span>
                                            </td>
                                            <td class="py-4 px-6">
                                                <span class="badge badge--success">Active</span>
                                            </td>
                                            <td class="py-4 px-6">
                                                <p class="text-neutral-900">Mar 15, 2024</p>
                                            </td>
                                            <td class="py-4 px-6">
                                                <div class="flex items-center gap-2">
                                                    <button class="btn btn--ghost btn--sm" onclick="editUser(${userItem.id})">
                                                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path>
                                                        </svg>
                                                    </button>
                                                    <button class="btn btn--ghost btn--sm" onclick="viewUser(${userItem.id})">
                                                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                                                        </svg>
                                                    </button>
                                                    <button class="btn btn--ghost btn--sm text-red-600" onclick="deleteUser(${userItem.id})">
                                                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                                                        </svg>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        
                        <!-- Pagination -->
                        <div class="px-6 py-4 border-t border-neutral-200">
                            <div class="flex items-center justify-between">
                                <p class="text-sm text-neutral-600">
                                    Showing <span class="font-medium">1</span> to <span class="font-medium">3</span> of <span class="font-medium">3</span> results
                                </p>
                                <div class="flex items-center gap-2">
                                    <button class="btn btn--ghost btn--sm" disabled>Previous</button>
                                    <button class="btn btn--primary btn--sm">1</button>
                                    <button class="btn btn--ghost btn--sm" disabled>Next</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
    
    <!-- Footer -->
    <jsp:include page="../components/footer.jsp" />
    
    <!-- JavaScript -->
    <script src="<%= contextPath %>/js/main.js"></script>
    
    <script>
        function editUser(userId) {
            // Implement edit user functionality
            console.log('Edit user:', userId);
        }
        
        function viewUser(userId) {
            // Implement view user functionality
            console.log('View user:', userId);
        }
        
        function deleteUser(userId) {
            if (confirm('Are you sure you want to delete this user?')) {
                // Implement delete user functionality
                console.log('Delete user:', userId);
            }
        }
    </script>
</body>
</html>