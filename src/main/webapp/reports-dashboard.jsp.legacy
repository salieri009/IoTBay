<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"staff".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Staff reports and analytics dashboard">
    <title>Reports Dashboard | IoT Bay - Staff Portal</title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="<%= contextPath %>/css/modern-theme.css">
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="antialiased bg-neutral-50 text-neutral-900 min-h-screen flex flex-col">
    
    <!-- Header -->
    <c:import url="/components/organisms/header/header.jsp" />
    
    <main class="flex-1">
        <!-- Page Header -->
        <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
            <div class="container">
                <div class="max-w-6xl mx-auto">
                    <div class="flex items-center justify-between">
                        <div>
                            <h1 class="text-display-lg text-neutral-900 mb-2">
                                Reports & <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Analytics</span>
                            </h1>
                            <p class="text-lg text-neutral-600">
                                Monitor business performance and key metrics
                            </p>
                        </div>
                        <div class="flex items-center gap-3">
                            <select class="form-select">
                                <option>Last 30 days</option>
                                <option>Last 7 days</option>
                                <option>Last 90 days</option>
                                <option>This year</option>
                            </select>
                            <button class="btn btn--primary">
                                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                                </svg>
                                Export Report
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Dashboard Content -->
        <section class="py-12">
            <div class="container">
                <div class="max-w-6xl mx-auto">
                    <!-- Key Metrics -->
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                        <div class="card p-6 text-center">
                            <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center mx-auto mb-4">
                                <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1"></path>
                                </svg>
                            </div>
                            <h3 class="text-2xl font-bold text-neutral-900 mb-1">
                                <fmt:formatNumber value="${totalRevenue != null ? totalRevenue : 0}" type="currency" currencySymbol="$" maxFractionDigits="0"/>
                            </h3>
                            <p class="text-sm text-neutral-600">Total Revenue</p>
                            <span class="inline-block mt-2 px-2 py-1 bg-green-100 text-green-800 text-xs rounded-full">Live Data</span>
                        </div>
                        
                        <div class="card p-6 text-center">
                            <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center mx-auto mb-4">
                                <svg class="w-6 h-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"></path>
                                </svg>
                            </div>
                            <h3 class="text-2xl font-bold text-neutral-900 mb-1">${totalOrders != null ? totalOrders : 0}</h3>
                            <p class="text-sm text-neutral-600">Total Orders</p>
                            <span class="inline-block mt-2 px-2 py-1 bg-green-100 text-green-800 text-xs rounded-full">Live Data</span>
                        </div>
                        
                        <div class="card p-6 text-center">
                            <div class="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center mx-auto mb-4">
                                <svg class="w-6 h-6 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"></path>
                                </svg>
                            </div>
                            <h3 class="text-2xl font-bold text-neutral-900 mb-1">${totalUsers != null ? totalUsers : 0}</h3>
                            <p class="text-sm text-neutral-600">Total Users</p>
                            <span class="inline-block mt-2 px-2 py-1 bg-green-100 text-green-800 text-xs rounded-full">Live Data</span>
                        </div>
                        
                        <div class="card p-6 text-center">
                            <div class="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center mx-auto mb-4">
                                <svg class="w-6 h-6 text-orange-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>
                                </svg>
                            </div>
                            <h3 class="text-2xl font-bold text-neutral-900 mb-1">${totalProducts != null ? totalProducts : 0}</h3>
                            <p class="text-sm text-neutral-600">Total Products</p>
                            <span class="inline-block mt-2 px-2 py-1 bg-red-100 text-red-800 text-xs rounded-full">-2.1%</span>
                        </div>
                    </div>

                    <!-- Charts and Reports -->
                    <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-8">
                        <!-- Revenue Chart -->
                        <div class="card p-6">
                            <h3 class="text-lg font-semibold text-neutral-900 mb-4">Revenue Trend</h3>
                            <div class="h-64 bg-neutral-100 rounded-lg flex items-center justify-center">
                                <p class="text-neutral-500">Chart placeholder - Revenue over time</p>
                            </div>
                        </div>
                        
                        <!-- Top Products -->
                        <div class="card p-6">
                            <h3 class="text-lg font-semibold text-neutral-900 mb-4">Top Products</h3>
                            <div class="space-y-4">
                                <div class="flex items-center justify-between">
                                    <div class="flex items-center gap-3">
                                        <img src="<%= contextPath %>/images/sample1.png" alt="Product" class="w-10 h-10 rounded-lg object-cover">
                                        <div>
                                            <p class="font-medium text-neutral-900">Smart Home Hub Pro</p>
                                            <p class="text-sm text-neutral-600">127 sold</p>
                                        </div>
                                    </div>
                                    <span class="font-semibold text-neutral-900">$38,073</span>
                                </div>
                                
                                <div class="flex items-center justify-between">
                                    <div class="flex items-center gap-3">
                                        <img src="<%= contextPath %>/images/sample2.png" alt="Product" class="w-10 h-10 rounded-lg object-cover">
                                        <div>
                                            <p class="font-medium text-neutral-900">IoT Sensor Pack</p>
                                            <p class="text-sm text-neutral-600">89 sold</p>
                                        </div>
                                    </div>
                                    <span class="font-semibold text-neutral-900">$12,450</span>
                                </div>
                                
                                <div class="flex items-center justify-between">
                                    <div class="flex items-center gap-3">
                                        <img src="<%= contextPath %>/images/sample3.png" alt="Product" class="w-10 h-10 rounded-lg object-cover">
                                        <div>
                                            <p class="font-medium text-neutral-900">Smart Thermostat</p>
                                            <p class="text-sm text-neutral-600">76 sold</p>
                                        </div>
                                    </div>
                                    <span class="font-semibold text-neutral-900">$9,120</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Recent Orders -->
                    <div class="card p-6">
                        <div class="flex items-center justify-between mb-6">
                            <h3 class="text-lg font-semibold text-neutral-900">Recent Orders</h3>
                            <a href="<%= contextPath %>/orderhistory" class="btn btn--outline btn--sm">View All</a>
                        </div>
                        
                        <div class="overflow-x-auto">
                            <table class="w-full">
                                <thead>
                                    <tr class="border-b border-neutral-200">
                                        <th class="text-left py-3 px-4 font-medium text-neutral-700">Order ID</th>
                                        <th class="text-left py-3 px-4 font-medium text-neutral-700">Customer</th>
                                        <th class="text-left py-3 px-4 font-medium text-neutral-700">Status</th>
                                        <th class="text-left py-3 px-4 font-medium text-neutral-700">Total</th>
                                        <th class="text-left py-3 px-4 font-medium text-neutral-700">Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr class="border-b border-neutral-100">
                                        <td class="py-3 px-4 text-sm text-neutral-900">#ORD-2024-001</td>
                                        <td class="py-3 px-4 text-sm text-neutral-900">John Doe</td>
                                        <td class="py-3 px-4"><span class="badge badge--success">Delivered</span></td>
                                        <td class="py-3 px-4 text-sm text-neutral-900">$299.99</td>
                                        <td class="py-3 px-4 text-sm text-neutral-600">Mar 15, 2024</td>
                                    </tr>
                                    <tr class="border-b border-neutral-100">
                                        <td class="py-3 px-4 text-sm text-neutral-900">#ORD-2024-002</td>
                                        <td class="py-3 px-4 text-sm text-neutral-900">Jane Smith</td>
                                        <td class="py-3 px-4"><span class="badge badge--warning">Processing</span></td>
                                        <td class="py-3 px-4 text-sm text-neutral-900">$156.78</td>
                                        <td class="py-3 px-4 text-sm text-neutral-600">Mar 14, 2024</td>
                                    </tr>
                                    <tr class="border-b border-neutral-100">
                                        <td class="py-3 px-4 text-sm text-neutral-900">#ORD-2024-003</td>
                                        <td class="py-3 px-4 text-sm text-neutral-900">Bob Johnson</td>
                                        <td class="py-3 px-4"><span class="badge badge--info">Shipped</span></td>
                                        <td class="py-3 px-4 text-sm text-neutral-900">$89.99</td>
                                        <td class="py-3 px-4 text-sm text-neutral-600">Mar 13, 2024</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
    
    <!-- Footer -->
    <c:import url="/components/organisms/footer/footer.jsp" />
    
    <!-- JavaScript -->
    <script src="<%= contextPath %>/js/main.js"></script>
</body>
</html>
