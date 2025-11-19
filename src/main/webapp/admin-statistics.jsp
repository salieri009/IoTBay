<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.User" %>
<%
    // Admin access check - consistent with admin-dashboard.jsp
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"staff".equalsIgnoreCase(currentUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?error=unauthorized");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IoT Bay Admin - Statistics & Analytics</title>
    <meta name="description" content="IoT Bay administrative statistics and analytics dashboard for authorized personnel only.">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/modern-theme.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;900&display=swap" rel="stylesheet">
</head>
<body>
    <!-- Include Header -->
    <c:import url="/components/organisms/header/header.jsp" />

    <!-- Admin Navigation Breadcrumb -->
    <nav class="py-4 bg-neutral-100">
        <div class="container">
            <div class="flex items-center gap-2 text-sm">
                <a href="<%=request.getContextPath()%>/" class="text-neutral-600 hover:text-brand-primary">Home</a>
                <svg class="w-4 h-4 text-neutral-400" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path>
                </svg>
                <a href="<%=request.getContextPath()%>/admin-dashboard.jsp" class="text-neutral-600 hover:text-brand-primary">Admin Dashboard</a>
                <svg class="w-4 h-4 text-neutral-400" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path>
                </svg>
                <span class="text-neutral-900 font-medium">Statistics & Analytics</span>
            </div>
        </div>
    </nav>

    <!-- Admin Header -->
    <section class="py-8 bg-gradient-to-r from-blue-600 to-blue-800 text-white">
        <div class="container">
            <div class="flex items-center justify-between">
                <div>
                    <h1 class="text-3xl font-bold mb-2">Statistics & Analytics Dashboard</h1>
                    <p class="text-blue-100">
                        Comprehensive insights and performance metrics for IoT Bay platform
                    </p>
                </div>
                <div class="bg-white/10 backdrop-blur-sm rounded-lg px-4 py-2">
                    <div class="flex items-center gap-2">
                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-6-3a2 2 0 11-4 0 2 2 0 014 0zm-2 4a5 5 0 00-4.546 2.916A5.986 5.986 0 0010 16a5.986 5.986 0 004.546-2.084A5 5 0 0010 11z" clip-rule="evenodd"></path>
                        </svg>
                        <span class="text-sm font-medium">Admin Access</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Key Performance Indicators -->
    <section class="py-12">
        <div class="container">
            <div class="mb-8">
                <h2 class="text-2xl font-bold text-neutral-900 mb-2">Key Performance Indicators</h2>
                <p class="text-neutral-600">Real-time business metrics and performance data</p>
            </div>

            <!-- Statistics Grid -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-12">
                <!-- Total Customers -->
                <div class="card bg-gradient-to-br from-blue-50 to-blue-100 border-blue-200">
                    <div class="card__body text-center">
                        <div class="w-12 h-12 bg-blue-500 rounded-full flex items-center justify-center mx-auto mb-4">
                            <svg class="w-6 h-6 text-white" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M13 6a3 3 0 11-6 0 3 3 0 016 0zM18 8a2 2 0 11-4 0 2 2 0 014 0zM14 15a4 4 0 00-8 0v3h8v-3z"></path>
                            </svg>
                        </div>
                        <div class="text-3xl font-bold text-blue-600 mb-2">10,247</div>
                        <div class="text-lg font-semibold text-neutral-900 mb-1">Total Customers</div>
                        <p class="text-sm text-neutral-600">Across 52 countries</p>
                        <div class="mt-3 text-xs text-green-600 font-medium">↗ +12.5% from last month</div>
                    </div>
                </div>

                <!-- Products Sold -->
                <div class="card bg-gradient-to-br from-green-50 to-green-100 border-green-200">
                    <div class="card__body text-center">
                        <div class="w-12 h-12 bg-green-500 rounded-full flex items-center justify-center mx-auto mb-4">
                            <svg class="w-6 h-6 text-white" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M10 2L3 7v11a1 1 0 001 1h12a1 1 0 001-1V7l-7-5zM10 12a2 2 0 100-4 2 2 0 000 4z" clip-rule="evenodd"></path>
                            </svg>
                        </div>
                        <div class="text-3xl font-bold text-green-600 mb-2">547</div>
                        <div class="text-lg font-semibold text-neutral-900 mb-1">IoT Products</div>
                        <p class="text-sm text-neutral-600">Premium quality devices</p>
                        <div class="mt-3 text-xs text-green-600 font-medium">↗ +8.3% from last month</div>
                    </div>
                </div>

                <!-- System Uptime -->
                <div class="card bg-gradient-to-br from-purple-50 to-purple-100 border-purple-200">
                    <div class="card__body text-center">
                        <div class="w-12 h-12 bg-purple-500 rounded-full flex items-center justify-center mx-auto mb-4">
                            <svg class="w-6 h-6 text-white" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M3 4a1 1 0 011-1h12a1 1 0 011 1v2a1 1 0 01-1 1H4a1 1 0 01-1-1V4zm0 4a1 1 0 011-1h6a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h6a1 1 0 110 2H4a1 1 0 01-1-1z" clip-rule="evenodd"></path>
                            </svg>
                        </div>
                        <div class="text-3xl font-bold text-purple-600 mb-2">99.94%</div>
                        <div class="text-lg font-semibold text-neutral-900 mb-1">System Uptime</div>
                        <p class="text-sm text-neutral-600">Last 30 days</p>
                        <div class="mt-3 text-xs text-green-600 font-medium">↗ +0.1% from last month</div>
                    </div>
                </div>

                <!-- Support Tickets -->
                <div class="card bg-gradient-to-br from-orange-50 to-orange-100 border-orange-200">
                    <div class="card__body text-center">
                        <div class="w-12 h-12 bg-orange-500 rounded-full flex items-center justify-center mx-auto mb-4">
                            <svg class="w-6 h-6 text-white" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"></path>
                            </svg>
                        </div>
                        <div class="text-3xl font-bold text-orange-600 mb-2">24/7</div>
                        <div class="text-lg font-semibold text-neutral-900 mb-1">Support Available</div>
                        <p class="text-sm text-neutral-600">Average response: 2.3hrs</p>
                        <div class="mt-3 text-xs text-green-600 font-medium">↗ Response time improved</div>
                    </div>
                </div>
            </div>

            <!-- Detailed Analytics -->
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                <!-- Sales Performance -->
                <div class="card">
                    <div class="card__header">
                        <h3 class="card__title">Sales Performance</h3>
                        <p class="card__subtitle">Revenue and order trends</p>
                    </div>
                    <div class="card__body">
                        <div class="space-y-4">
                            <div class="flex justify-between items-center py-3 border-b border-neutral-200">
                                <span class="text-neutral-600">Monthly Revenue</span>
                                <span class="font-semibold text-green-600">$247,890</span>
                            </div>
                            <div class="flex justify-between items-center py-3 border-b border-neutral-200">
                                <span class="text-neutral-600">Orders Processed</span>
                                <span class="font-semibold">1,432</span>
                            </div>
                            <div class="flex justify-between items-center py-3 border-b border-neutral-200">
                                <span class="text-neutral-600">Average Order Value</span>
                                <span class="font-semibold">$173.12</span>
                            </div>
                            <div class="flex justify-between items-center py-3">
                                <span class="text-neutral-600">Conversion Rate</span>
                                <span class="font-semibold text-blue-600">3.47%</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Customer Analytics -->
                <div class="card">
                    <div class="card__header">
                        <h3 class="card__title">Customer Analytics</h3>
                        <p class="card__subtitle">User engagement and retention</p>
                    </div>
                    <div class="card__body">
                        <div class="space-y-4">
                            <div class="flex justify-between items-center py-3 border-b border-neutral-200">
                                <span class="text-neutral-600">New Registrations</span>
                                <span class="font-semibold text-green-600">+187</span>
                            </div>
                            <div class="flex justify-between items-center py-3 border-b border-neutral-200">
                                <span class="text-neutral-600">Active Users (30d)</span>
                                <span class="font-semibold">8,934</span>
                            </div>
                            <div class="flex justify-between items-center py-3 border-b border-neutral-200">
                                <span class="text-neutral-600">Customer Retention</span>
                                <span class="font-semibold">87.3%</span>
                            </div>
                            <div class="flex justify-between items-center py-3">
                                <span class="text-neutral-600">Support Satisfaction</span>
                                <span class="font-semibold text-blue-600">4.8/5.0</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="flex flex-wrap gap-4 mt-8">
                <a href="<%=request.getContextPath()%>/admin-dashboard.jsp" class="btn btn--outline">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path>
                    </svg>
                    Back to Dashboard
                </a>
                <button class="btn btn--primary" onclick="exportData()">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                    </svg>
                    Export Report
                </button>
                <button class="btn btn--secondary" onclick="refreshData()">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"></path>
                    </svg>
                    Refresh Data
                </button>
            </div>
        </div>
    </section>

    <c:import url="/components/organisms/footer/footer.jsp" />
    
    <script src="js/main.js"></script>
    <script>
        // Admin statistics functions
        function exportData() {
            alert('Export functionality would be implemented here.\nData will be exported as CSV/Excel format.');
        }

        function refreshData() {
            // In a real application, this would fetch fresh data from the server
            alert('Data refreshed successfully!\nShowing latest statistics.');
            location.reload();
        }

        // Auto-refresh data every 5 minutes
        setInterval(function() {
            console.log('Auto-refreshing statistics data...');
            // In production, this would silently update the data
        }, 300000); // 5 minutes
    </script>
</body>
</html>
