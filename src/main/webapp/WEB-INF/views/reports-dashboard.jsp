<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="service.ReportingService.DashboardReport" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports & Analytics Dashboard - IoT Bay Admin</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/modern-theme.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;900&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .dashboard-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--color-border);
        }
        
        .dashboard-grid {
            display: grid;
            gap: 2rem;
            margin-bottom: 2rem;
        }
        
        .metrics-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .metric-card {
            background: var(--color-surface);
            padding: 2rem;
            border-radius: var(--border-radius-lg);
            border: 1px solid var(--color-border);
            text-align: center;
            transition: all 0.3s ease;
        }
        
        .metric-card:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }
        
        .metric-icon {
            width: 3rem;
            height: 3rem;
            margin: 0 auto 1rem;
            background: var(--color-primary-light);
            border-radius: var(--border-radius-full);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--color-primary);
        }
        
        .metric-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--color-text-primary);
            margin-bottom: 0.5rem;
        }
        
        .metric-label {
            font-size: 0.875rem;
            color: var(--color-text-secondary);
            margin-bottom: 0.5rem;
        }
        
        .metric-change {
            font-size: 0.75rem;
            padding: 0.25rem 0.5rem;
            border-radius: var(--border-radius-full);
        }
        
        .metric-change.positive {
            background: var(--color-success-light);
            color: var(--color-success-dark);
        }
        
        .metric-change.negative {
            background: var(--color-error-light);
            color: var(--color-error-dark);
        }
        
        .reports-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .report-card {
            background: var(--color-surface);
            padding: 2rem;
            border-radius: var(--border-radius-lg);
            border: 1px solid var(--color-border);
            transition: all 0.3s ease;
        }
        
        .report-card:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }
        
        .report-header {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
        }
        
        .report-icon {
            width: 2.5rem;
            height: 2.5rem;
            margin-right: 1rem;
            background: var(--color-primary-light);
            border-radius: var(--border-radius);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--color-primary);
        }
        
        .report-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--color-text-primary);
        }
        
        .report-description {
            color: var(--color-text-secondary);
            margin-bottom: 1.5rem;
            line-height: 1.5;
        }
        
        .report-actions {
            display: flex;
            gap: 0.5rem;
        }
        
        .chart-container {
            background: var(--color-surface);
            padding: 2rem;
            border-radius: var(--border-radius-lg);
            border: 1px solid var(--color-border);
            margin-bottom: 2rem;
        }
        
        .chart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }
        
        .chart-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--color-text-primary);
        }
        
        .chart-canvas {
            max-height: 400px;
        }
        
        .alert {
            padding: 1rem;
            border-radius: var(--border-radius);
            margin-bottom: 1rem;
        }
        
        .alert-error {
            background: var(--color-error-light);
            color: var(--color-error-dark);
            border: 1px solid var(--color-error);
        }
        
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }
        
        .quick-action {
            background: var(--color-surface);
            padding: 1.5rem;
            border-radius: var(--border-radius-lg);
            border: 1px solid var(--color-border);
            text-align: center;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .quick-action:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
            text-decoration: none;
        }
        
        .quick-action-icon {
            width: 2rem;
            height: 2rem;
            margin: 0 auto 0.5rem;
            color: var(--color-primary);
        }
        
        .quick-action-title {
            font-weight: 600;
            color: var(--color-text-primary);
            margin-bottom: 0.25rem;
        }
        
        .quick-action-desc {
            font-size: 0.875rem;
            color: var(--color-text-secondary);
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <c:import url="/components/organisms/header/header.jsp" />
    
    <main class="dashboard-container">
        <!-- Dashboard Header -->
        <div class="dashboard-header">
            <div>
                <h1 class="text-3xl font-bold text-primary">Reports & Analytics Dashboard</h1>
                <p class="text-secondary">Business Intelligence and system insights</p>
            </div>
            <div class="flex gap-2">
                <button onclick="refreshDashboard()" class="btn btn--outline">
                    <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"></path>
                    </svg>
                    Refresh
                </button>
                <button onclick="exportDashboard()" class="btn btn--primary">
                    <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                    </svg>
                    Export Report
                </button>
            </div>
        </div>
        
        <!-- Error Messages -->
        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <div class="alert alert-error">
                <strong>Error!</strong> <%= error %>
            </div>
        <% } %>
        
        <!-- Dashboard Metrics -->
        <%
            DashboardReport dashboardReport = (DashboardReport) request.getAttribute("dashboardReport");
            if (dashboardReport != null) {
        %>
            <div class="metrics-grid">
                <!-- Total Users -->
                <div class="metric-card">
                    <div class="metric-icon">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"></path>
                        </svg>
                    </div>
                    <div class="metric-number"><%= dashboardReport.getTotalUsers() %></div>
                    <div class="metric-label">Total Users</div>
                    <div class="metric-change positive">
                        <%= dashboardReport.getActiveUsers() %> active
                    </div>
                </div>
                
                <!-- Total Products -->
                <div class="metric-card">
                    <div class="metric-icon">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"></path>
                        </svg>
                    </div>
                    <div class="metric-number"><%= dashboardReport.getTotalProducts() %></div>
                    <div class="metric-label">Total Products</div>
                    <% if (dashboardReport.getLowStockProducts() > 0) { %>
                        <div class="metric-change negative">
                            <%= dashboardReport.getLowStockProducts() %> low stock
                        </div>
                    <% } else { %>
                        <div class="metric-change positive">All stocked well</div>
                    <% } %>
                </div>
                
                <!-- Total Suppliers -->
                <div class="metric-card">
                    <div class="metric-icon">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path>
                        </svg>
                    </div>
                    <div class="metric-number"><%= dashboardReport.getTotalSuppliers() %></div>
                    <div class="metric-label">Total Suppliers</div>
                    <div class="metric-change positive">
                        <%= dashboardReport.getActiveSuppliers() %> active
                    </div>
                </div>
                
                <!-- Inventory Value -->
                <div class="metric-card">
                    <div class="metric-icon">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                        </svg>
                    </div>
                    <div class="metric-number">$<%= String.format("%.0f", dashboardReport.getTotalInventoryValue()) %></div>
                    <div class="metric-label">Inventory Value</div>
                    <% if (dashboardReport.getOutOfStockProducts() > 0) { %>
                        <div class="metric-change negative">
                            <%= dashboardReport.getOutOfStockProducts() %> out of stock
                        </div>
                    <% } else { %>
                        <div class="metric-change positive">All in stock</div>
                    <% } %>
                </div>
            </div>
        <% } %>
        
        <!-- Quick Actions -->
        <div class="quick-actions">
            <a href="<%= request.getContextPath() %>/manage/users" class="quick-action">
                <svg class="quick-action-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"></path>
                </svg>
                <div class="quick-action-title">Manage Users</div>
                <div class="quick-action-desc">User administration</div>
            </a>
            
            <a href="<%= request.getContextPath() %>/manage/products" class="quick-action">
                <svg class="quick-action-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"></path>
                </svg>
                <div class="quick-action-title">Manage Products</div>
                <div class="quick-action-desc">Product catalog</div>
            </a>
            
            <a href="<%= request.getContextPath() %>/manage/suppliers" class="quick-action">
                <svg class="quick-action-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path>
                </svg>
                <div class="quick-action-title">Manage Suppliers</div>
                <div class="quick-action-desc">Supplier network</div>
            </a>
            
            <a href="<%= request.getContextPath() %>/manage/data" class="quick-action">
                <svg class="quick-action-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M9 19l3 3m0 0l3-3m-3 3V10"></path>
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
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>
                        </svg>
                    </div>
                    <div class="report-title">Sales Report</div>
                </div>
                <div class="report-description">
                    Analyze sales performance, revenue trends, and top-selling products over custom date ranges.
                </div>
                <div class="report-actions">
                    <a href="<%= request.getContextPath() %>/reports/sales" class="btn btn--primary btn-sm">View Report</a>
                    <button onclick="generateSalesChart()" class="btn btn--outline btn-sm">Quick View</button>
                </div>
            </div>
            
            <!-- Inventory Report -->
            <div class="report-card">
                <div class="report-header">
                    <div class="report-icon">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"></path>
                        </svg>
                    </div>
                    <div class="report-title">Inventory Report</div>
                </div>
                <div class="report-description">
                    Monitor stock levels, identify low inventory items, and analyze inventory value distribution.
                </div>
                <div class="report-actions">
                    <a href="<%= request.getContextPath() %>/reports/inventory" class="btn btn--primary btn-sm">View Report</a>
                    <button onclick="generateInventoryChart()" class="btn btn--outline btn-sm">Quick View</button>
                </div>
            </div>
            
            <!-- User Analytics -->
            <div class="report-card">
                <div class="report-header">
                    <div class="report-icon">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"></path>
                        </svg>
                    </div>
                    <div class="report-title">User Analytics</div>
                </div>
                <div class="report-description">
                    Track user registrations, analyze user behavior patterns, and monitor user engagement metrics.
                </div>
                <div class="report-actions">
                    <a href="<%= request.getContextPath() %>/reports/users" class="btn btn--primary btn-sm">View Report</a>
                    <button onclick="generateUserChart()" class="btn btn--outline btn-sm">Quick View</button>
                </div>
            </div>
            
            <!-- Supplier Analytics -->
            <div class="report-card">
                <div class="report-header">
                    <div class="report-icon">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path>
                        </svg>
                    </div>
                    <div class="report-title">Supplier Analytics</div>
                </div>
                <div class="report-description">
                    Analyze supplier performance, geographic distribution, and supplier type breakdown.
                </div>
                <div class="report-actions">
                    <a href="<%= request.getContextPath() %>/reports/suppliers" class="btn btn--primary btn-sm">View Report</a>
                    <button onclick="generateSupplierChart()" class="btn btn--outline btn-sm">Quick View</button>
                </div>
            </div>
        </div>
        
        <!-- Chart Container for Quick Views -->
        <div id="chartContainer" class="chart-container" style="display: none;">
            <div class="chart-header">
                <h3 id="chartTitle" class="chart-title">Chart</h3>
                <button onclick="closeChart()" class="btn btn--ghost">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                </button>
            </div>
            <canvas id="quickChart" class="chart-canvas"></canvas>
        </div>
    </main>

    <c:import url="/components/organisms/footer/footer.jsp" />
    <script src="<%=request.getContextPath()%>/js/main.js"></script>
    
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
                                callback: function(value) {
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
        setInterval(function() {
            // In a real implementation, this would use AJAX to refresh data
            console.log('Dashboard auto-refresh triggered');
        }, 300000);
    </script>
</body>
</html>
