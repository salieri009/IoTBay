<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="model.User" %>

<%
    // Admin authorization check
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"staff".equalsIgnoreCase(currentUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BI & Analytics Dashboard - IoT Bay Admin</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/modern-theme.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;900&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .admin-layout {
            min-height: 100vh;
            background: linear-gradient(135deg, var(--neutral-50) 0%, var(--neutral-100) 100%);
        }
        
        .dashboard-container {
            max-width: 1600px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding: 2rem;
            background: var(--neutral-0);
            border-radius: var(--border-radius-xl);
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--neutral-200);
        }
        
        .dashboard-title {
            font-size: 2rem;
            font-weight: 900;
            background: var(--brand-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .dashboard-subtitle {
            color: var(--neutral-600);
            font-size: 1rem;
            margin-top: 0.5rem;
        }
        
        .dashboard-controls {
            display: flex;
            gap: 1rem;
            align-items: center;
        }
        
        .date-filter {
            display: flex;
            gap: 0.5rem;
            align-items: center;
        }
        
        .date-filter label {
            font-weight: 500;
            color: var(--neutral-700);
        }
        
        .date-filter select,
        .date-filter input {
            padding: 0.5rem;
            border: 1px solid var(--neutral-300);
            border-radius: var(--border-radius-md);
            font-size: 0.875rem;
        }
        
        .kpi-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .kpi-card {
            background: var(--neutral-0);
            border-radius: var(--border-radius-xl);
            border: 1px solid var(--neutral-200);
            box-shadow: var(--shadow-md);
            padding: 2rem;
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
        }
        
        .kpi-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-lg);
        }
        
        .kpi-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--brand-gradient);
        }
        
        .kpi-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }
        
        .kpi-title {
            font-size: 0.875rem;
            font-weight: 500;
            color: var(--neutral-600);
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        
        .kpi-icon {
            width: 2rem;
            height: 2rem;
            padding: 0.5rem;
            background: var(--brand-primary-100);
            border-radius: var(--border-radius-lg);
            color: var(--brand-primary-700);
        }
        
        .kpi-value {
            font-size: 2.5rem;
            font-weight: 900;
            color: var(--neutral-800);
            margin-bottom: 0.5rem;
        }
        
        .kpi-change {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.875rem;
        }
        
        .kpi-change.positive {
            color: var(--success);
        }
        
        .kpi-change.negative {
            color: var(--error);
        }
        
        .kpi-change.neutral {
            color: var(--neutral-500);
        }
        
        .charts-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
            margin-bottom: 2rem;
        }
        
        .chart-card {
            background: var(--neutral-0);
            border-radius: var(--border-radius-xl);
            border: 1px solid var(--neutral-200);
            box-shadow: var(--shadow-md);
            overflow: hidden;
        }
        
        .chart-header {
            padding: 1.5rem;
            background: var(--neutral-50);
            border-bottom: 1px solid var(--neutral-200);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .chart-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--neutral-800);
        }
        
        .chart-actions {
            display: flex;
            gap: 0.5rem;
        }
        
        .chart-body {
            padding: 2rem;
        }
        
        .chart-container {
            position: relative;
            height: 300px;
        }
        
        .chart-container.large {
            height: 400px;
        }
        
        .analytics-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }
        
        .analytics-card {
            background: var(--neutral-0);
            border-radius: var(--border-radius-xl);
            border: 1px solid var(--neutral-200);
            box-shadow: var(--shadow-md);
            overflow: hidden;
        }
        
        .analytics-header {
            padding: 1.5rem;
            background: var(--neutral-50);
            border-bottom: 1px solid var(--neutral-200);
        }
        
        .analytics-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--neutral-800);
        }
        
        .analytics-body {
            padding: 2rem;
        }
        
        .metric-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .metric-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 0;
            border-bottom: 1px solid var(--neutral-100);
        }
        
        .metric-item:last-child {
            border-bottom: none;
        }
        
        .metric-label {
            font-weight: 500;
            color: var(--neutral-700);
        }
        
        .metric-value {
            font-weight: 700;
            color: var(--neutral-800);
        }
        
        .metric-bar {
            width: 100%;
            height: 0.5rem;
            background: var(--neutral-200);
            border-radius: var(--border-radius-full);
            overflow: hidden;
            margin-top: 0.5rem;
        }
        
        .metric-fill {
            height: 100%;
            background: var(--brand-gradient);
            transition: width 0.3s ease;
        }
        
        .reports-section {
            background: var(--neutral-0);
            border-radius: var(--border-radius-xl);
            border: 1px solid var(--neutral-200);
            box-shadow: var(--shadow-md);
            padding: 2rem;
            margin-bottom: 2rem;
        }
        
        .reports-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }
        
        .reports-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--neutral-800);
        }
        
        .report-templates {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
        }
        
        .report-template {
            background: var(--neutral-50);
            border: 1px solid var(--neutral-200);
            border-radius: var(--border-radius-lg);
            padding: 1.5rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .report-template:hover {
            background: var(--brand-primary-50);
            border-color: var(--brand-primary-200);
        }
        
        .template-icon {
            width: 2.5rem;
            height: 2.5rem;
            background: var(--brand-gradient);
            border-radius: var(--border-radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
        }
        
        .template-icon svg {
            width: 1.5rem;
            height: 1.5rem;
            color: var(--neutral-0);
        }
        
        .template-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--neutral-800);
            margin-bottom: 0.5rem;
        }
        
        .template-description {
            font-size: 0.875rem;
            color: var(--neutral-600);
            margin-bottom: 1rem;
        }
        
        .template-actions {
            display: flex;
            gap: 0.5rem;
        }
        
        .real-time-section {
            background: var(--neutral-0);
            border-radius: var(--border-radius-xl);
            border: 1px solid var(--neutral-200);
            box-shadow: var(--shadow-md);
            padding: 2rem;
        }
        
        .real-time-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }
        
        .real-time-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--neutral-800);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .live-indicator {
            width: 0.5rem;
            height: 0.5rem;
            background: var(--success);
            border-radius: 50%;
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
        }
        
        .real-time-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
        }
        
        .real-time-metric {
            background: var(--neutral-50);
            border-radius: var(--border-radius-lg);
            padding: 1.5rem;
            text-align: center;
        }
        
        .real-time-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--brand-primary);
            margin-bottom: 0.5rem;
        }
        
        .real-time-label {
            font-size: 0.875rem;
            color: var(--neutral-600);
        }
        
        @media (max-width: 1200px) {
            .charts-grid {
                grid-template-columns: 1fr;
            }
        }
        
        @media (max-width: 768px) {
            .dashboard-container {
                padding: 1rem;
            }
            
            .dashboard-header {
                flex-direction: column;
                text-align: center;
                gap: 1rem;
            }
            
            .dashboard-controls {
                flex-direction: column;
                width: 100%;
            }
            
            .date-filter {
                flex-direction: column;
                width: 100%;
            }
            
            .kpi-grid {
                grid-template-columns: 1fr;
            }
            
            .analytics-grid {
                grid-template-columns: 1fr;
            }
            
            .report-templates {
                grid-template-columns: 1fr;
            }
            
            .real-time-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
    </style>
</head>
<body>
    <jsp:include page="components/header.jsp" />
    
    <main class="admin-layout">
        <div class="dashboard-container">
            <!-- Dashboard Header -->
            <header class="dashboard-header">
                <div>
                    <h1 class="dashboard-title">BI & Analytics Dashboard</h1>
                    <p class="dashboard-subtitle">Business Intelligence and Performance Analytics</p>
                </div>
                <div class="dashboard-controls">
                    <div class="date-filter">
                        <label for="dateRange">Time Period:</label>
                        <select id="dateRange" onchange="updateDashboard()">
                            <option value="7">Last 7 days</option>
                            <option value="30" selected>Last 30 days</option>
                            <option value="90">Last 3 months</option>
                            <option value="365">Last year</option>
                            <option value="custom">Custom range</option>
                        </select>
                    </div>
                    <button class="btn btn--outline" onclick="refreshDashboard()">
                        <svg style="width: 1rem; height: 1rem; margin-right: 0.5rem;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/>
                        </svg>
                        Refresh
                    </button>
                </div>
            </header>
            
            <!-- Key Performance Indicators -->
            <section class="kpi-grid">
                <div class="kpi-card">
                    <div class="kpi-header">
                        <span class="kpi-title">Total Revenue</span>
                        <div class="kpi-icon">
                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1"/>
                            </svg>
                        </div>
                    </div>
                    <div class="kpi-value" id="totalRevenue">$245,890</div>
                    <div class="kpi-change positive">
                        <svg style="width: 1rem; height: 1rem;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"/>
                        </svg>
                        <span>+12.5% from last month</span>
                    </div>
                </div>
                
                <div class="kpi-card">
                    <div class="kpi-header">
                        <span class="kpi-title">Total Orders</span>
                        <div class="kpi-icon">
                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"/>
                            </svg>
                        </div>
                    </div>
                    <div class="kpi-value" id="totalOrders">2,468</div>
                    <div class="kpi-change positive">
                        <svg style="width: 1rem; height: 1rem;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"/>
                        </svg>
                        <span>+8.3% from last month</span>
                    </div>
                </div>
                
                <div class="kpi-card">
                    <div class="kpi-header">
                        <span class="kpi-title">Active Users</span>
                        <div class="kpi-icon">
                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"/>
                            </svg>
                        </div>
                    </div>
                    <div class="kpi-value" id="activeUsers">1,234</div>
                    <div class="kpi-change positive">
                        <svg style="width: 1rem; height: 1rem;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"/>
                        </svg>
                        <span>+5.2% from last month</span>
                    </div>
                </div>
                
                <div class="kpi-card">
                    <div class="kpi-header">
                        <span class="kpi-title">Conversion Rate</span>
                        <div class="kpi-icon">
                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                            </svg>
                        </div>
                    </div>
                    <div class="kpi-value" id="conversionRate">3.2%</div>
                    <div class="kpi-change negative">
                        <svg style="width: 1rem; height: 1rem;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 17h8m0 0V9m0 8l-8-8-4 4-6-6"/>
                        </svg>
                        <span>-0.3% from last month</span>
                    </div>
                </div>
            </section>
            
            <!-- Charts Section -->
            <section class="charts-grid">
                <div class="chart-card">
                    <div class="chart-header">
                        <h3 class="chart-title">Revenue Trends</h3>
                        <div class="chart-actions">
                            <button class="btn btn--sm btn--outline" onclick="exportChart('revenue')">Export</button>
                        </div>
                    </div>
                    <div class="chart-body">
                        <div class="chart-container large">
                            <canvas id="revenueChart"></canvas>
                        </div>
                    </div>
                </div>
                
                <div class="chart-card">
                    <div class="chart-header">
                        <h3 class="chart-title">Product Categories</h3>
                        <div class="chart-actions">
                            <button class="btn btn--sm btn--outline" onclick="exportChart('categories')">Export</button>
                        </div>
                    </div>
                    <div class="chart-body">
                        <div class="chart-container">
                            <canvas id="categoriesChart"></canvas>
                        </div>
                    </div>
                </div>
            </section>
            
            <!-- Analytics Grid -->
            <section class="analytics-grid">
                <div class="analytics-card">
                    <div class="analytics-header">
                        <h3 class="analytics-title">Top Products</h3>
                    </div>
                    <div class="analytics-body">
                        <ul class="metric-list">
                            <li class="metric-item">
                                <div>
                                    <div class="metric-label">Industrial IoT Sensor Kit</div>
                                    <div class="metric-bar">
                                        <div class="metric-fill" style="width: 85%"></div>
                                    </div>
                                </div>
                                <div class="metric-value">$45,230</div>
                            </li>
                            <li class="metric-item">
                                <div>
                                    <div class="metric-label">Smart Home Hub Pro</div>
                                    <div class="metric-bar">
                                        <div class="metric-fill" style="width: 72%"></div>
                                    </div>
                                </div>
                                <div class="metric-value">$38,450</div>
                            </li>
                            <li class="metric-item">
                                <div>
                                    <div class="metric-label">Agriculture Monitor System</div>
                                    <div class="metric-bar">
                                        <div class="metric-fill" style="width: 64%"></div>
                                    </div>
                                </div>
                                <div class="metric-value">$34,120</div>
                            </li>
                            <li class="metric-item">
                                <div>
                                    <div class="metric-label">Warehouse Automation Kit</div>
                                    <div class="metric-bar">
                                        <div class="metric-fill" style="width: 58%"></div>
                                    </div>
                                </div>
                                <div class="metric-value">$31,890</div>
                            </li>
                        </ul>
                    </div>
                </div>
                
                <div class="analytics-card">
                    <div class="analytics-header">
                        <h3 class="analytics-title">User Engagement</h3>
                    </div>
                    <div class="analytics-body">
                        <div class="chart-container">
                            <canvas id="engagementChart"></canvas>
                        </div>
                    </div>
                </div>
            </section>
            
            <!-- Report Templates -->
            <section class="reports-section" id="create">
                <div class="reports-header">
                    <h3 class="reports-title">Generate Reports</h3>
                    <button class="btn btn--primary" onclick="openCustomReportModal()">
                        <svg style="width: 1rem; height: 1rem; margin-right: 0.5rem;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"/>
                        </svg>
                        Custom Report
                    </button>
                </div>
                
                <div class="report-templates">
                    <div class="report-template" onclick="generateReport('sales')">
                        <div class="template-icon">
                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"/>
                            </svg>
                        </div>
                        <div class="template-title">Sales Report</div>
                        <div class="template-description">Comprehensive sales analysis with revenue trends, top products, and customer insights</div>
                        <div class="template-actions">
                            <button class="btn btn--sm btn--primary">Generate</button>
                            <button class="btn btn--sm btn--outline">Preview</button>
                        </div>
                    </div>
                    
                    <div class="report-template" onclick="generateReport('inventory')">
                        <div class="template-icon">
                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"/>
                            </svg>
                        </div>
                        <div class="template-title">Inventory Report</div>
                        <div class="template-description">Stock levels, low inventory alerts, and product performance analysis</div>
                        <div class="template-actions">
                            <button class="btn btn--sm btn--primary">Generate</button>
                            <button class="btn btn--sm btn--outline">Preview</button>
                        </div>
                    </div>
                    
                    <div class="report-template" onclick="generateReport('users')">
                        <div class="template-icon">
                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"/>
                            </svg>
                        </div>
                        <div class="template-title">User Analytics</div>
                        <div class="template-description">User behavior, engagement metrics, and customer segmentation analysis</div>
                        <div class="template-actions">
                            <button class="btn btn--sm btn--primary">Generate</button>
                            <button class="btn btn--sm btn--outline">Preview</button>
                        </div>
                    </div>
                    
                    <div class="report-template" onclick="generateReport('suppliers')">
                        <div class="template-icon">
                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"/>
                            </svg>
                        </div>
                        <div class="template-title">Supplier Performance</div>
                        <div class="template-description">Supplier metrics, delivery performance, and relationship analysis</div>
                        <div class="template-actions">
                            <button class="btn btn--sm btn--primary">Generate</button>
                            <button class="btn btn--sm btn--outline">Preview</button>
                        </div>
                    </div>
                </div>
            </section>
            
            <!-- Real-time Analytics -->
            <section class="real-time-section" id="analytics">
                <div class="real-time-header">
                    <h3 class="real-time-title">
                        <span class="live-indicator"></span>
                        Real-time Analytics
                    </h3>
                    <span class="text-sm text-neutral-600">Updated every 30 seconds</span>
                </div>
                
                <div class="real-time-grid">
                    <div class="real-time-metric">
                        <div class="real-time-value" id="liveVisitors">342</div>
                        <div class="real-time-label">Active Visitors</div>
                    </div>
                    <div class="real-time-metric">
                        <div class="real-time-value" id="liveOrders">23</div>
                        <div class="real-time-label">Orders Today</div>
                    </div>
                    <div class="real-time-metric">
                        <div class="real-time-value" id="liveRevenue">$12,450</div>
                        <div class="real-time-label">Revenue Today</div>
                    </div>
                    <div class="real-time-metric">
                        <div class="real-time-value" id="liveConversion">4.2%</div>
                        <div class="real-time-label">Conversion Rate</div>
                    </div>
                </div>
            </section>
        </div>
    </main>
    
    <jsp:include page="components/footer.jsp" />
    
    <script>
        // Chart configurations and data
        let charts = {};
        
        // Initialize Dashboard
        document.addEventListener('DOMContentLoaded', function() {
            initializeCharts();
            startRealTimeUpdates();
        });
        
        function initializeCharts() {
            // Revenue Chart
            const revenueCtx = document.getElementById('revenueChart').getContext('2d');
            charts.revenue = new Chart(revenueCtx, {
                type: 'line',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    datasets: [{
                        label: 'Revenue',
                        data: [12000, 15000, 18000, 22000, 19000, 25000, 28000, 32000, 29000, 35000, 38000, 42000],
                        borderColor: 'rgb(37, 99, 235)',
                        backgroundColor: 'rgba(37, 99, 235, 0.1)',
                        tension: 0.4,
                        fill: true
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
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
            });
            
            // Categories Chart
            const categoriesCtx = document.getElementById('categoriesChart').getContext('2d');
            charts.categories = new Chart(categoriesCtx, {
                type: 'doughnut',
                data: {
                    labels: ['Industrial IoT', 'Smart Home', 'Agriculture', 'Warehouse'],
                    datasets: [{
                        data: [35, 25, 20, 20],
                        backgroundColor: [
                            'rgb(37, 99, 235)',
                            'rgb(124, 58, 237)',
                            'rgb(6, 182, 212)',
                            'rgb(16, 185, 129)'
                        ]
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom'
                        }
                    }
                }
            });
            
            // Engagement Chart
            const engagementCtx = document.getElementById('engagementChart').getContext('2d');
            charts.engagement = new Chart(engagementCtx, {
                type: 'bar',
                data: {
                    labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                    datasets: [{
                        label: 'Page Views',
                        data: [1200, 1900, 3000, 5000, 2000, 3000, 2500],
                        backgroundColor: 'rgba(37, 99, 235, 0.8)'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        }
        
        function updateDashboard() {
            const dateRange = document.getElementById('dateRange').value;
            
            // Simulate data update based on date range
            const multiplier = dateRange === '7' ? 0.3 : dateRange === '30' ? 1 : dateRange === '90' ? 2.5 : 4;
            
            // Update KPIs
            document.getElementById('totalRevenue').textContent = '$' + Math.round(245890 * multiplier).toLocaleString();
            document.getElementById('totalOrders').textContent = Math.round(2468 * multiplier).toLocaleString();
            document.getElementById('activeUsers').textContent = Math.round(1234 * multiplier).toLocaleString();
            
            // Update charts with new data (simulation)
            if (charts.revenue) {
                const newData = charts.revenue.data.datasets[0].data.map(value => Math.round(value * multiplier));
                charts.revenue.data.datasets[0].data = newData;
                charts.revenue.update();
            }
            
            showNotification(`Dashboard updated for ${dateRange === 'custom' ? 'custom' : dateRange + ' days'} period`, 'success');
        }
        
        function refreshDashboard() {
            showNotification('Refreshing dashboard data...', 'info');
            
            // Simulate refresh
            setTimeout(() => {
                // Update real-time metrics
                updateRealTimeMetrics();
                showNotification('Dashboard refreshed successfully!', 'success');
            }, 1000);
        }
        
        function startRealTimeUpdates() {
            // Update real-time metrics every 30 seconds
            setInterval(updateRealTimeMetrics, 30000);
        }
        
        function updateRealTimeMetrics() {
            // Simulate real-time data updates
            const visitors = Math.floor(Math.random() * 100) + 300;
            const orders = Math.floor(Math.random() * 10) + 20;
            const revenue = Math.floor(Math.random() * 5000) + 10000;
            const conversion = (Math.random() * 2 + 3).toFixed(1);
            
            document.getElementById('liveVisitors').textContent = visitors;
            document.getElementById('liveOrders').textContent = orders;
            document.getElementById('liveRevenue').textContent = '$' + revenue.toLocaleString();
            document.getElementById('liveConversion').textContent = conversion + '%';
        }
        
        function generateReport(type) {
            showNotification(`Generating ${type} report...`, 'info');
            
            // Simulate report generation
            setTimeout(() => {
                showNotification(`${type.charAt(0).toUpperCase() + type.slice(1)} report generated successfully!`, 'success');
                
                // In a real implementation, this would trigger a download or open a new window
                console.log(`Generated ${type} report`);
            }, 2000);
        }
        
        function exportChart(chartType) {
            if (charts[chartType]) {
                const url = charts[chartType].toBase64Image();
                const link = document.createElement('a');
                link.download = `${chartType}_chart.png`;
                link.href = url;
                link.click();
                
                showNotification(`${chartType} chart exported successfully!`, 'success');
            }
        }
        
        function openCustomReportModal() {
            // This would open a modal for custom report configuration
            alert('Custom report builder would open here with options for:\n\n• Date range selection\n• Metric selection\n• Chart type selection\n• Export format options\n• Scheduling options');
        }
        
        function showNotification(message, type = 'info') {
            const notification = document.createElement('div');
            notification.className = `notification notification--${type}`;
            notification.textContent = message;
            notification.style.cssText = `
                position: fixed;
                top: 2rem;
                right: 2rem;
                padding: 1rem 1.5rem;
                background: ${type === 'success' ? 'var(--success)' : type === 'warning' ? 'var(--warning)' : 'var(--brand-primary)'};
                color: var(--neutral-0);
                border-radius: var(--border-radius-lg);
                box-shadow: var(--shadow-lg);
                z-index: 2000;
                animation: slideIn 0.3s ease;
            `;
            
            document.body.appendChild(notification);
            
            setTimeout(() => {
                notification.remove();
            }, 3000);
        }
        
        // Add CSS animation for notifications
        const style = document.createElement('style');
        style.textContent = `
            @keyframes slideIn {
                from {
                    transform: translateX(100%);
                    opacity: 0;
                }
                to {
                    transform: translateX(0);
                    opacity: 1;
                }
            }
            
            .btn--sm {
                padding: 0.5rem 1rem;
                font-size: 0.875rem;
            }
            
            .text-sm {
                font-size: 0.875rem;
            }
            
            .text-neutral-600 {
                color: var(--neutral-600);
            }
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>
