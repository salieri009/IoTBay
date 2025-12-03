<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.Map" %>
        <%@ page import="java.time.format.DateTimeFormatter" %>
            <%@ page import="service.ReportingService.DashboardReport" %>
                <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
                    <%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

                        <t:base>
                            <jsp:attribute name="title">Reports & Analytics Dashboard | IoT Bay Admin</jsp:attribute>
                            <jsp:attribute name="customCSS">modern-theme.css</jsp:attribute>

                            <jsp:body>
                                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
                                <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

                                <main class="dashboard-container">
                                    <!-- Dashboard Header -->
                                    <div class="dashboard-header">
                                        <div>
                                            <h1 class="text-3xl font-bold text-primary">Reports & Analytics Dashboard
                                            </h1>
                                            <p class="text-secondary">Business Intelligence and system insights</p>
                                        </div>
                                        <div class="flex gap-2">
                                            <button onclick="refreshDashboard()" class="btn btn--outline">
                                                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor"
                                                    viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15">
                                                    </path>
                                                </svg>
                                                Refresh
                                            </button>
                                            <button onclick="exportDashboard()" class="btn btn--primary">
                                                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor"
                                                    viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z">
                                                    </path>
                                                </svg>
                                                Export Report
                                            </button>
                                        </div>
                                    </div>

                                    <!-- Error Messages -->
                                    <% String error=(String) request.getAttribute("error"); if (error !=null) { %>
                                        <div class="alert alert-error">
                                            <strong>Error!</strong>
                                            <%= error %>
                                        </div>
                                        <% } %>

                                            <!-- Dashboard Metrics -->
                                            <% DashboardReport dashboardReport=(DashboardReport)
                                                request.getAttribute("dashboardReport"); if (dashboardReport !=null) {
                                                %>
                                                <div class="metrics-grid">
                                                    <!-- Total Users -->
                                                    <div class="metric-card">
                                                        <div class="metric-icon">
                                                            <svg class="w-6 h-6" fill="none" stroke="currentColor"
                                                                viewBox="0 0 24 24">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    stroke-width="2"
                                                                    d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z">
                                                                </path>
                                                            </svg>
                                                        </div>
                                                        <div class="metric-number">
                                                            <%= dashboardReport.getTotalUsers() %>
                                                        </div>
                                                        <div class="metric-label">Total Users</div>
                                                        <div class="metric-change positive">
                                                            <%= dashboardReport.getActiveUsers() %> active
                                                        </div>
                                                    </div>

                                                    <!-- Total Products -->
                                                    <div class="metric-card">
                                                        <div class="metric-icon">
                                                            <svg class="w-6 h-6" fill="none" stroke="currentColor"
                                                                viewBox="0 0 24 24">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    stroke-width="2"
                                                                    d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4">
                                                                </path>
                                                            </svg>
                                                        </div>
                                                        <div class="metric-number">
                                                            <%= dashboardReport.getTotalProducts() %>
                                                        </div>
                                                        <div class="metric-label">Total Products</div>
                                                        <% if (dashboardReport.getLowStockProducts()> 0) { %>
                                                            <div class="metric-change negative">
                                                                <%= dashboardReport.getLowStockProducts() %> low stock
                                                            </div>
                                                            <% } else { %>
                                                                <div class="metric-change positive">All stocked well
                                                                </div>
                                                                <% } %>
                                                    </div>

                                                    <!-- Total Suppliers -->
                                                    <div class="metric-card">
                                                        <div class="metric-icon">
                                                            <svg class="w-6 h-6" fill="none" stroke="currentColor"
                                                                viewBox="0 0 24 24">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    stroke-width="2"
                                                                    d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4">
                                                                </path>
                                                            </svg>
                                                        </div>
                                                        <div class="metric-number">
                                                            <%= dashboardReport.getTotalSuppliers() %>
                                                        </div>
                                                        <div class="metric-label">Total Suppliers</div>
                                                        <div class="metric-change positive">
                                                            <%= dashboardReport.getActiveSuppliers() %> active
                                                        </div>
                                                    </div>

                                                    <!-- Inventory Value -->
                                                    <div class="metric-card">
                                                        <div class="metric-icon">
                                                            <svg class="w-6 h-6" fill="none" stroke="currentColor"
                                                                viewBox="0 0 24 24">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    stroke-width="2"
                                                                    d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z">
                                                                </path>
                                                            </svg>
                                                        </div>
                                                        <div class="metric-number">$<%= String.format("%.0f",
                                                                dashboardReport.getTotalInventoryValue()) %>
                                                        </div>
                                                        <div class="metric-label">Inventory Value</div>
                                                        <% if (dashboardReport.getOutOfStockProducts()> 0) { %>
                                                            <div class="metric-change negative">
                                                                <%= dashboardReport.getOutOfStockProducts() %> out of
                                                                    stock
                                                            </div>
                                                            <% } else { %>
                                                                <div class="metric-change positive">All in stock</div>
                                                                <% } %>
                                                    </div>
                                                </div>
                                                <% } %>

                                                    <!-- Quick Actions -->
                                                    <div class="quick-actions">
                                                        <a href="<%= request.getContextPath() %>/manage-users.jsp"
                                                            class="quick-action">
                                                            <svg class="quick-action-icon" fill="none"
                                                                stroke="currentColor" viewBox="0 0 24 24">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    stroke-width="2"
                                                                    d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z">
                                                                </path>
                                                            </svg>
                                                            <div class="quick-action-title">Manage Users</div>
                                                            <div class="quick-action-desc">User administration</div>
                                                        </a>

                                                        <a href="<%= request.getContextPath() %>/manage-products.jsp"
                                                            class="quick-action">
                                                            <svg class="quick-action-icon" fill="none"
                                                                stroke="currentColor" viewBox="0 0 24 24">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    stroke-width="2"
                                                                    d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4">
                                                                </path>
                                                            </svg>
                                                            <div class="quick-action-title">Manage Products</div>
                                                            <div class="quick-action-desc">Product catalog</div>
                                                        </a>

                                                        <a href="<%= request.getContextPath() %>/manage-suppliers.jsp"
                                                            class="quick-action">
                                                            <svg class="quick-action-icon" fill="none"
                                                                stroke="currentColor" viewBox="0 0 24 24">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    stroke-width="2"
                                                                    d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4">
                                                                </path>
                                                            </svg>
                                                            <div class="quick-action-title">Manage Suppliers</div>
                                                            <div class="quick-action-desc">Supplier network</div>
                                                        </a>

                                                        <a href="<%= request.getContextPath() %>/manage-data.jsp"
                                                            class="quick-action">
                                                            <svg class="quick-action-icon" fill="none"
                                                                stroke="currentColor" viewBox="0 0 24 24">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    stroke-width="2"
                                                                    d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M9 19l3 3m0 0l3-3m-3 3V10">
                                                                </path>
                                                            </svg>
                                                            <div class="quick-action-title">Data Management</div>
                                                            <div class="quick-action-desc">Import/Export data</div>
                                                        </a>
                                                    </div>

                                                    <!-- Available Reports -->
                                                    <div class="reports-grid">
                                                        <!-- Sales Report -->
                                                        <div class="report-card">
                                                            <div class="report-header">
                                                                <div class="report-icon">
                                                                    <svg class="w-5 h-5" fill="none"
                                                                        stroke="currentColor" viewBox="0 0 24 24">
                                                                        <path stroke-linecap="round"
                                                                            stroke-linejoin="round" stroke-width="2"
                                                                            d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z">
                                                                        </path>
                                                                    </svg>
                                                                </div>
                                                                <div class="report-title">Sales Report</div>
                                                            </div>
                                                            <div class="report-description">
                                                                Analyze sales performance, revenue trends, and
                                                                top-selling products over custom date ranges.
                                                            </div>
                                                            <div class="report-actions">
                                                                <a href="<%= request.getContextPath() %>/reports/sales"
                                                                    class="btn btn--primary btn-sm">View Report</a>
                                                                <button onclick="generateSalesChart()"
                                                                    class="btn btn--outline btn-sm">Quick View</button>
                                                            </div>
                                                        </div>

                                                        <!-- Inventory Report -->
                                                        <div class="report-card">
                                                            <div class="report-header">
                                                                <div class="report-icon">
                                                                    <svg class="w-5 h-5" fill="none"
                                                                        stroke="currentColor" viewBox="0 0 24 24">
                                                                        <path stroke-linecap="round"
                                                                            stroke-linejoin="round" stroke-width="2"
                                                                            d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4">
                                                                        </path>
                                                                    </svg>
                                                                </div>
                                                                <div class="report-title">Inventory Report</div>
                                                            </div>
                                                            <div class="report-description">
                                                                Monitor stock levels, identify low inventory items, and
                                                                analyze inventory value distribution.
                                                            </div>
                                                            <div class="report-actions">
                                                                <a href="<%= request.getContextPath() %>/reports/inventory"
                                                                    class="btn btn--primary btn-sm">View Report</a>
                                                                <button onclick="generateInventoryChart()"
                                                                    class="btn btn--outline btn-sm">Quick View</button>
                                                            </div>
                                                        </div>

                                                        <!-- User Analytics -->
                                                        <div class="report-card">
                                                            <div class="report-header">
                                                                <div class="report-icon">
                                                                    <svg class="w-5 h-5" fill="none"
                                                                        stroke="currentColor" viewBox="0 0 24 24">
                                                                        <path stroke-linecap="round"
                                                                            stroke-linejoin="round" stroke-width="2"
                                                                            d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z">
                                                                        </path>
                                                                    </svg>
                                                                </div>
                                                                <div class="report-title">User Analytics</div>
                                                            </div>
                                                            <div class="report-description">
                                                                Track user registrations, analyze user behavior
                                                                patterns, and monitor user engagement metrics.
                                                            </div>
                                                            <div class="report-actions">
                                                                <a href="<%= request.getContextPath() %>/reports/users"
                                                                    class="btn btn--primary btn-sm">View Report</a>
                                                                <button onclick="generateUserChart()"
                                                                    class="btn btn--outline btn-sm">Quick View</button>
                                                            </div>
                                                        </div>

                                                        <!-- Supplier Analytics -->
                                                        <div class="report-card">
                                                            <div class="report-header">
                                                                <div class="report-icon">
                                                                    <svg class="w-5 h-5" fill="none"
                                                                        stroke="currentColor" viewBox="0 0 24 24">
                                                                        <path stroke-linecap="round"
                                                                            stroke-linejoin="round" stroke-width="2"
                                                                            d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4">
                                                                        </path>
                                                                    </svg>
                                                                </div>
                                                                <div class="report-title">Supplier Analytics</div>
                                                            </div>
                                                            <div class="report-description">
                                                                Analyze supplier performance, geographic distribution,
                                                                and supplier type breakdown.
                                                            </div>
                                                            <div class="report-actions">
                                                                <a href="<%= request.getContextPath() %>/reports/suppliers"
                                                                    class="btn btn--primary btn-sm">View Report</a>
                                                                <button onclick="generateSupplierChart()"
                                                                    class="btn btn--outline btn-sm">Quick View</button>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Chart Container for Quick Views -->
                                                    <div id="chartContainer" class="chart-container"
                                                        style="display: none;">
                                                        <div class="chart-header">
                                                            <h3 id="chartTitle" class="chart-title">Chart</h3>
                                                            <button onclick="closeChart()" class="btn btn--ghost">
                                                                <svg class="w-4 h-4" fill="none" stroke="currentColor"
                                                                    viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                                        stroke-width="2" d="M6 18L18 6M6 6l12 12">
                                                                    </path>
                                                                </svg>
                                                            </button>
                                                        </div>
                                                        <canvas id="quickChart" class="chart-canvas"></canvas>
                                                    </div>
                                </main>

                                <script>
                                    let currentChart = null;

                                    function refreshDashboard() {
                                        location.reload();
                                    }

                                    function exportDashboard() {
                                        // In a real implementation, this would generate and download a PDF report
                                        alert('Dashboard export functionality would be implemented here.');
                                    }

                                    function closeChart() {
                                        document.getElementById('chartContainer').style.display = 'none';
                                        if (currentChart) {
                                            currentChart.destroy();
                                            currentChart = null;
                                        }
                                    }

                                    function showChart(title, chartConfig) {
                                        document.getElementById('chartTitle').textContent = title;
                                        document.getElementById('chartContainer').style.display = 'block';

                                        if (currentChart) {
                                            currentChart.destroy();
                                        }

                                        const ctx = document.getElementById('quickChart').getContext('2d');
                                        currentChart = new Chart(ctx, chartConfig);
                                    }

                                    function generateSalesChart() {
                                        const config = {
                                            type: 'line',
                                            data: {
                                                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                                                datasets: [{
                                                    label: 'Revenue ($)',
                                                    data: [12000, 15000, 8000, 18000, 22000, 25000],
                                                    borderColor: 'var(--color-primary)',
                                                    backgroundColor: 'var(--color-primary-light)',
                                                    tension: 0.4
                                                }]
                                            },
                                            options: {
                                                responsive: true,
                                                maintainAspectRatio: false,
                                                plugins: {
                                                    title: {
                                                        display: true,
                                                        text: 'Sales Trend (Last 6 Months)'
                                                    }
                                                },
                                                scales: {
                                                    y: {
                                                        beginAtZero: true,
                                                        ticks: {
                                                            callback: function (value) {
                                                                return '$' + value.toLocaleString();
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        };
                                        showChart('Sales Report - Quick View', config);
                                    }

                                    function generateInventoryChart() {
                                        const config = {
                                            type: 'doughnut',
                                            data: {
                                                labels: ['In Stock', 'Low Stock', 'Out of Stock'],
                                                datasets: [{
                                                    data: [<%= dashboardReport != null ? dashboardReport.getTotalProducts() - dashboardReport.getLowStockProducts() - dashboardReport.getOutOfStockProducts() : 0 %>, 
                                   <%= dashboardReport != null ? dashboardReport.getLowStockProducts() : 0 %>, 
                                   <%= dashboardReport != null ? dashboardReport.getOutOfStockProducts() : 0 %>],
                                                    backgroundColor: [
                                                        'var(--color-success)',
                                                        'var(--color-warning)',
                                                        'var(--color-error)'
                                                    ]
                                                }]
                                            },
                                            options: {
                                                responsive: true,
                                                maintainAspectRatio: false,
                                                plugins: {
                                                    title: {
                                                        display: true,
                                                        text: 'Inventory Status Distribution'
                                                    },
                                                    legend: {
                                                        position: 'bottom'
                                                    }
                                                }
                                            }
                                        };
                                        showChart('Inventory Report - Quick View', config);
                                    }

                                    function generateUserChart() {
                                        const config = {
                                            type: 'bar',
                                            data: {
                                                labels: ['Active Users', 'Total Users'],
                                                datasets: [{
                                                    label: 'User Count',
                                                    data: [<%= dashboardReport != null ? dashboardReport.getActiveUsers() : 0 %>, 
                                   <%= dashboardReport != null ? dashboardReport.getTotalUsers() : 0 %>],
                                                    backgroundColor: [
                                                        'var(--color-success)',
                                                        'var(--color-primary)'
                                                    ]
                                                }]
                                            },
                                            options: {
                                                responsive: true,
                                                maintainAspectRatio: false,
                                                plugins: {
                                                    title: {
                                                        display: true,
                                                        text: 'User Statistics'
                                                    }
                                                },
                                                scales: {
                                                    y: {
                                                        beginAtZero: true
                                                    }
                                                }
                                            }
                                        };
                                        showChart('User Analytics - Quick View', config);
                                    }

                                    function generateSupplierChart() {
                                        const config = {
                                            type: 'pie',
                                            data: {
                                                labels: ['Active Suppliers', 'Inactive Suppliers'],
                                                datasets: [{
                                                    data: [<%= dashboardReport != null ? dashboardReport.getActiveSuppliers() : 0 %>, 
                                   <%= dashboardReport != null ? dashboardReport.getTotalSuppliers() - dashboardReport.getActiveSuppliers() : 0 %>],
                                                    backgroundColor: [
                                                        'var(--color-success)',
                                                        'var(--color-error)'
                                                    ]
                                                }]
                                            },
                                            options: {
                                                responsive: true,
                                                maintainAspectRatio: false,
                                                plugins: {
                                                    title: {
                                                        display: true,
                                                        text: 'Supplier Status Distribution'
                                                    },
                                                    legend: {
                                                        position: 'bottom'
                                                    }
                                                }
                                            }
                                        };
                                        showChart('Supplier Analytics - Quick View', config);
                                    }

                                    // Auto-refresh dashboard every 5 minutes
                                    setInterval(function () {
                                        // In a real implementation, this would use AJAX to refresh data
                                        console.log('Dashboard auto-refresh triggered');
                                    }, 300000);
                                </script>
                            </jsp:body>
                        </t:base>