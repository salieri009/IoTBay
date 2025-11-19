<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ page import="model.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"staff".equalsIgnoreCase(user.getRole())) {
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
    <title>Data Management | IoT Bay - Staff Portal</title>
    <link rel="stylesheet" href="<%= contextPath %>/css/modern-theme.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="antialiased bg-neutral-50 text-neutral-900 min-h-screen flex flex-col">
    
    <c:import url="/components/organisms/header/header.jsp" />
    
    <main class="flex-1">
        <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
            <div class="container">
                <div class="max-w-6xl mx-auto">
                    <div>
                        <h1 class="text-display-lg text-neutral-900 mb-2">
                            Data <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Management</span>
                        </h1>
                        <p class="text-lg text-neutral-600">Manage system data and backups</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="py-12">
            <div class="container">
                <div class="max-w-6xl mx-auto">
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                        <div class="card p-6">
                            <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center mb-4">
                                <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-8l-4-4m0 0L8 8m4-4v12"></path>
                                </svg>
                            </div>
                            <h3 class="text-lg font-semibold text-neutral-900 mb-2">Backup Data</h3>
                            <p class="text-neutral-600 mb-4">Create system backups and restore data</p>
                            <button class="btn btn--primary">Create Backup</button>
                        </div>

                        <div class="card p-6">
                            <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center mb-4">
                                <svg class="w-6 h-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                </svg>
                            </div>
                            <h3 class="text-lg font-semibold text-neutral-900 mb-2">Data Integrity</h3>
                            <p class="text-neutral-600 mb-4">Check and repair data consistency</p>
                            <button class="btn btn--secondary">Run Check</button>
                        </div>

                        <div class="card p-6">
                            <div class="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center mb-4">
                                <svg class="w-6 h-6 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                                </svg>
                            </div>
                            <h3 class="text-lg font-semibold text-neutral-900 mb-2">Export Data</h3>
                            <p class="text-neutral-600 mb-4">Export data in various formats</p>
                            <button class="btn btn--outline">Export</button>
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