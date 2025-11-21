<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // Admin authorization check
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || (!"staff".equalsIgnoreCase(currentUser.getRole()) && 
        !"admin".equalsIgnoreCase(currentUser.getRole()))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

                    <!DOCTYPE html>
                    <html lang="en">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Admin Dashboard - IoT Bay Management</title>
                        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
                        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css">
                        <link rel="preconnect" href="https://fonts.googleapis.com">
                        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                        <link
                            href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;900&display=swap"
                            rel="stylesheet">
                    </head>

                    <body>
                        <c:import url="/components/organisms/header/header.jsp" />

                        <main class="admin-layout">
                            <!-- Admin Sidebar: 256px fixed -->
                            <aside class="admin-sidebar" id="adminSidebar" aria-label="Admin Navigation">
                                <div class="sidebar-header">
                                    <h2 class="sidebar-title">Admin Panel</h2>
                                    <p class="sidebar-subtitle">IoT Bay Management</p>
                                </div>
                                <nav class="sidebar-nav">
                                    <a href="<%=request.getContextPath()%>/admin-dashboard"
                                        class="admin-nav-link active" aria-current="page">
                                        Dashboard
                                    </a>
                                    <a href="<%=request.getContextPath()%>/api/manage/users" class="admin-nav-link">
                                        User Management
                                    </a>
                                    <a href="<%=request.getContextPath()%>/api/manage/products" class="admin-nav-link">
                                        Product Management
                                    </a>
                                    <a href="<%=request.getContextPath()%>/admin/supplier/" class="admin-nav-link">
                                        Supplier Management
                                    </a>
                                    <a href="<%=request.getContextPath()%>/api/manage/access-logs"
                                        class="admin-nav-link">
                                        Access Logs
                                    </a>
                                    <a href="<%=request.getContextPath()%>/help.jsp" class="admin-nav-link">
                                        Help & Documentation
                                    </a>
                                </nav>
                            </aside>

                            <!-- Admin Main Content: calc(100vw - 256px) -->
                            <div class="admin-main">
                                <div class="admin-container">
                                    <!-- Admin Header -->
                                    <header class="admin-header">
                                        <div>
                                            <h1 class="admin-title">Admin Dashboard</h1>
                                            <p class="admin-subtitle">IoT Bay Management Console</p>
                                        </div>
                                        <div class="admin-user-info">
                                            <div class="user-name">Welcome, <%= currentUser.getFirstName() %>
                                                    <%= currentUser.getLastName() %>
                                            </div>
                                            <div class="user-role">System Administrator</div>
                                        </div>
                                    </header>

                                    <!-- Statistics Overview -->
                                    <section class="stats-grid" aria-label="Statistics Overview">
                                        <div class="stat-card">
                                            <div class="stat-icon">
                                                <svg fill="none" stroke="currentColor" viewBox="0 0 24 24"
                                                    aria-hidden="true">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z" />
                                                </svg>
                                            </div>
                                            <div class="stat-number" id="totalUsers">${totalUsers != null ? totalUsers :
                                                0}</div>
                                            <div class="stat-label">Total Users</div>
                                            <div class="stat-change positive">Active users</div>
                                        </div>

                                        <div class="stat-card">
                                            <div class="stat-icon">
                                                <svg fill="none" stroke="currentColor" viewBox="0 0 24 24"
                                                    aria-hidden="true">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
                                                </svg>
                                            </div>
                                            <div class="stat-number" id="totalProducts">${totalProducts != null ?
                                                totalProducts : 0}</div>
                                            <div class="stat-label">IoT Products</div>
                                            <div class="stat-change positive">In catalog</div>
                                        </div>

                                        <div class="stat-card">
                                            <div class="stat-icon">
                                                <svg fill="none" stroke="currentColor" viewBox="0 0 24 24"
                                                    aria-hidden="true">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z" />
                                                </svg>
                                            </div>
                                            <div class="stat-number" id="totalOrders">${totalOrders != null ?
                                                totalOrders : 0}</div>
                                            <div class="stat-label">Total Orders</div>
                                            <div class="stat-change positive">All time</div>
                                        </div>

                                        <div class="stat-card">
                                            <div class="stat-icon">
                                                <svg fill="none" stroke="currentColor" viewBox="0 0 24 24"
                                                    aria-hidden="true">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
                                                </svg>
                                            </div>
                                            <div class="stat-number" id="totalSuppliers">${totalSuppliers != null ?
                                                totalSuppliers : 0}</div>
                                            <div class="stat-label">Active Suppliers</div>
                                            <div class="stat-change positive">Registered</div>
                                        </div>
                                    </section>

                                    <!-- Management Features -->
                                    <section class="management-grid" aria-label="Management Features">
                                        <!-- Supplier Information Management -->
                                        <div class="management-card">
                                            <div class="card-header">
                                                <h3 class="card-title">📦 Supplier Management</h3>
                                                <p class="card-description">Manage supplier information, contracts, and
                                                    relationships</p>
                                            </div>
                                            <div class="card-body">
                                                <ul class="feature-list">
                                                    <li class="feature-item">
                                                        <svg class="feature-icon" fill="none" stroke="currentColor"
                                                            viewBox="0 0 24 24" aria-hidden="true">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2" d="M5 13l4 4L19 7" />
                                                        </svg>
                                                        Add & manage supplier profiles
                                                    </li>
                                                    <li class="feature-item">
                                                        <svg class="feature-icon" fill="none" stroke="currentColor"
                                                            viewBox="0 0 24 24" aria-hidden="true">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2" d="M5 13l4 4L19 7" />
                                                        </svg>
                                                        Track supplier performance
                                                    </li>
                                                    <li class="feature-item">
                                                        <svg class="feature-icon" fill="none" stroke="currentColor"
                                                            viewBox="0 0 24 24" aria-hidden="true">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2" d="M5 13l4 4L19 7" />
                                                        </svg>
                                                        Contract & compliance management
                                                    </li>
                                                </ul>
                                                <div class="action-buttons">
                                                    <a href="<%=request.getContextPath()%>/admin/supplier/"
                                                        class="btn btn--primary action-btn">
                                                        Manage Suppliers
                                                    </a>
                                                    <a href="<%=request.getContextPath()%>/admin/supplier/form"
                                                        class="btn btn--outline action-btn">
                                                        Add Supplier
                                                    </a>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Data Management -->
                                        <div class="management-card">
                                            <div class="card-header">
                                                <h3 class="card-title">💾 Data Management</h3>
                                                <p class="card-description">Bulk import/export operations and data
                                                    analytics</p>
                                            </div>
                                            <div class="card-body">
                                                <ul class="feature-list">
                                                    <li class="feature-item">
                                                        <svg class="feature-icon" fill="none" stroke="currentColor"
                                                            viewBox="0 0 24 24" aria-hidden="true">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2" d="M5 13l4 4L19 7" />
                                                        </svg>
                                                        CSV import & export
                                                    </li>
                                                    <li class="feature-item">
                                                        <svg class="feature-icon" fill="none" stroke="currentColor"
                                                            viewBox="0 0 24 24" aria-hidden="true">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2" d="M5 13l4 4L19 7" />
                                                        </svg>
                                                        Bulk data operations
                                                    </li>
                                                    <li class="feature-item">
                                                        <svg class="feature-icon" fill="none" stroke="currentColor"
                                                            viewBox="0 0 24 24" aria-hidden="true">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2" d="M5 13l4 4L19 7" />
                                                        </svg>
                                                        Data validation & cleanup
                                                    </li>
                                                </ul>
                                                <div class="action-buttons">
                                                    <a href="<%=request.getContextPath()%>/data-management"
                                                        class="btn btn--primary action-btn">
                                                        Data Tools
                                                    </a>
                                                    <a href="<%=request.getContextPath()%>/data-management"
                                                        class="btn btn--outline action-btn">
                                                        Import Data
                                                    </a>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- BI & Reporting -->
                                        <div class="management-card">
                                            <div class="card-header">
                                                <h3 class="card-title">📊 BI & Reporting</h3>
                                                <p class="card-description">Business intelligence and advanced analytics
                                                </p>
                                            </div>
                                            <div class="card-body">
                                                <ul class="feature-list">
                                                    <li class="feature-item">
                                                        <svg class="feature-icon" fill="none" stroke="currentColor"
                                                            viewBox="0 0 24 24" aria-hidden="true">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2" d="M5 13l4 4L19 7" />
                                                        </svg>
                                                        Interactive dashboards
                                                    </li>
                                                    <li class="feature-item">
                                                        <svg class="feature-icon" fill="none" stroke="currentColor"
                                                            viewBox="0 0 24 24" aria-hidden="true">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2" d="M5 13l4 4L19 7" />
                                                        </svg>
                                                        Sales & revenue analytics
                                                    </li>
                                                    <li class="feature-item">
                                                        <svg class="feature-icon" fill="none" stroke="currentColor"
                                                            viewBox="0 0 24 24" aria-hidden="true">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2" d="M5 13l4 4L19 7" />
                                                        </svg>
                                                        Performance metrics
                                                    </li>
                                                </ul>
                                                <div class="action-buttons">
                                                    <a href="<%=request.getContextPath()%>/reports-dashboard"
                                                        class="btn btn--primary action-btn">
                                                        View Reports
                                                    </a>
                                                    <a href="<%=request.getContextPath()%>/admin-statistics"
                                                        class="btn btn--secondary action-btn">
                                                        Statistics & Analytics
                                                    </a>
                                                    <a href="<%=request.getContextPath()%>/reports-dashboard#create"
                                                        class="btn btn--outline action-btn">
                                                        Create Report
                                                    </a>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Inventory Management -->
                                        <div class="management-card">
                                            <div class="card-header">
                                                <h3 class="card-title">📦 Inventory Control</h3>
                                                <p class="card-description">Real-time inventory tracking and management
                                                </p>
                                            </div>
                                            <div class="card-body">
                                                <ul class="feature-list">
                                                    <li class="feature-item">
                                                        <svg class="feature-icon" fill="none" stroke="currentColor"
                                                            viewBox="0 0 24 24" aria-hidden="true">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2" d="M5 13l4 4L19 7" />
                                                        </svg>
                                                        Stock level monitoring
                                                    </li>
                                                    <li class="feature-item">
                                                        <svg class="feature-icon" fill="none" stroke="currentColor"
                                                            viewBox="0 0 24 24" aria-hidden="true">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2" d="M5 13l4 4L19 7" />
                                                        </svg>
                                                        Low stock alerts
                                                    </li>
                                                    <li class="feature-item">
                                                        <svg class="feature-icon" fill="none" stroke="currentColor"
                                                            viewBox="0 0 24 24" aria-hidden="true">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2" d="M5 13l4 4L19 7" />
                                                        </svg>
                                                        Automated reordering
                                                    </li>
                                                </ul>
                                                <div class="action-buttons">
                                                    <a href="<%=request.getContextPath()%>/api/manage/products"
                                                        class="btn btn--primary action-btn">
                                                        Manage Inventory
                                                    </a>
                                                    <a href="<%=request.getContextPath()%>/api/manage/products"
                                                        class="btn btn--outline action-btn">
                                                        Product Admin
                                                    </a>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Order Management -->
                                        <div class="management-card">
                                            <div class="card-header">
                                                <h3 class="card-title">🛒 Order Management</h3>
                                                <p class="card-description">Comprehensive order processing and
                                                    fulfillment</p>
                                            </div>
                                            <div class="card-body">
                                                <ul class="feature-list">
                                                    <li class="feature-item">
                                                        <svg class="feature-icon" fill="none" stroke="currentColor"
                                                            viewBox="0 0 24 24" aria-hidden="true">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2" d="M5 13l4 4L19 7" />
                                                        </svg>
                                                        Order status tracking
                                                    </li>
                                                    <li class="feature-item">
                                                        <svg class="feature-icon" fill="none" stroke="currentColor"
                                                            viewBox="0 0 24 24" aria-hidden="true">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2" d="M5 13l4 4L19 7" />
                                                        </svg>
                                                        Fulfillment management
                                                    </li>
                                                    <li class="feature-item">
                                                        <svg class="feature-icon" fill="none" stroke="currentColor"
                                                            viewBox="0 0 24 24" aria-hidden="true">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2" d="M5 13l4 4L19 7" />
                                                        </svg>
                                                        Customer communications
                                                    </li>
                                                </ul>
                                                <div class="action-buttons">
                                                    <a href="<%=request.getContextPath()%>/manage/orders"
                                                        class="btn btn--primary action-btn">
                                                        Manage Orders
                                                    </a>
                                                    <a href="<%=request.getContextPath()%>/manage/orders"
                                                        class="btn btn--outline action-btn">
                                                        Pending Orders
                                                    </a>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- User Management -->
                                        <div class="management-card">
                                            <div class="card-header">
                                                <h3 class="card-title">👥 User Administration</h3>
                                                <p class="card-description">User accounts, roles, and access control</p>
                                            </div>
                                            <div class="card-body">
                                                <ul class="feature-list">
                                                    <li class="feature-item">
                                                        <svg class="feature-icon" fill="none" stroke="currentColor"
                                                            viewBox="0 0 24 24" aria-hidden="true">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2" d="M5 13l4 4L19 7" />
                                                        </svg>
                                                        User role management
                                                    </li>
                                                    <li class="feature-item">
                                                        <svg class="feature-icon" fill="none" stroke="currentColor"
                                                            viewBox="0 0 24 24" aria-hidden="true">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2" d="M5 13l4 4L19 7" />
                                                        </svg>
                                                        Access control policies
                                                    </li>
                                                    <li class="feature-item">
                                                        <svg class="feature-icon" fill="none" stroke="currentColor"
                                                            viewBox="0 0 24 24" aria-hidden="true">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2" d="M5 13l4 4L19 7" />
                                                        </svg>
                                                        Security audit logs
                                                    </li>
                                                </ul>
                                                <div class="action-buttons">
                                                    <a href="<%=request.getContextPath()%>/api/manage/users"
                                                        class="btn btn--primary action-btn">
                                                        Manage Users
                                                    </a>
                                                    <a href="<%=request.getContextPath()%>/api/manage/access-logs"
                                                        class="btn btn--outline action-btn">
                                                        Access Logs
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </section>

                                    <!-- Quick Actions -->
                                    <section class="quick-actions" aria-label="Quick Actions">
                                        <h3 class="quick-actions-title">Quick Actions</h3>
                                        <div class="quick-action-grid">
                                            <a href="<%=request.getContextPath()%>/browse.jsp" class="quick-action-btn">
                                                <svg class="quick-action-icon" fill="none" stroke="currentColor"
                                                    viewBox="0 0 24 24" aria-hidden="true">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                                                </svg>
                                                Browse Products
                                            </a>
                                            <a href="<%=request.getContextPath()%>/api/manage/products"
                                                class="quick-action-btn">
                                                <svg class="quick-action-icon" fill="none" stroke="currentColor"
                                                    viewBox="0 0 24 24" aria-hidden="true">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6" />
                                                </svg>
                                                Manage Products
                                            </a>
                                            <a href="<%=request.getContextPath()%>/manage/orders"
                                                class="quick-action-btn">
                                                <svg class="quick-action-icon" fill="none" stroke="currentColor"
                                                    viewBox="0 0 24 24" aria-hidden="true">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                                                </svg>
                                                View Orders
                                            </a>
                                            <a href="<%=request.getContextPath()%>/data-management"
                                                class="quick-action-btn">
                                                <svg class="quick-action-icon" fill="none" stroke="currentColor"
                                                    viewBox="0 0 24 24" aria-hidden="true">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M8 7H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-3m-1 4l-3-3m0 0l-3 3m3-3v12" />
                                                </svg>
                                                Backup Data
                                            </a>
                                            <a href="<%=request.getContextPath()%>/reports-dashboard#analytics"
                                                class="quick-action-btn">
                                                <svg class="quick-action-icon" fill="none" stroke="currentColor"
                                                    viewBox="0 0 24 24" aria-hidden="true">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
                                                </svg>
                                                Analytics
                                            </a>
                                            <a href="<%=request.getContextPath()%>/index.jsp" class="quick-action-btn">
                                                <svg class="quick-action-icon" fill="none" stroke="currentColor"
                                                    viewBox="0 0 24 24" aria-hidden="true">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
                                                </svg>
                                                Back to Store
                                            </a>
                                        </div>
                                    </section>
                                </div>
                            </div>
                        </main>

                        <!-- Mobile Sidebar Toggle -->
                        <button class="admin-sidebar-toggle" id="sidebarToggle" aria-label="Toggle Navigation Menu">
                            <svg width="24" height="24" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                                aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M4 6h16M4 12h16M4 18h16" />
                            </svg>
                        </button>

                        <script>
                            // Mobile sidebar toggle
                            if (window.innerWidth <= 768) {
                                const toggle = document.getElementById('sidebarToggle');
                                if (toggle) {
                                    toggle.addEventListener('click', function () {
                                        document.getElementById('adminSidebar').classList.toggle('admin-sidebar--open');
                                    });
                                }
                            }
                        </script>

                        <c:import url="/components/organisms/footer/footer.jsp" />

                        <script>
                            // Format numbers with commas
                            document.addEventListener('DOMContentLoaded', function () {
                                const formatNumber = (num) => {
                                    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                                };

                                // Format all stat numbers
                                const statNumbers = document.querySelectorAll('.stat-number');
                                statNumbers.forEach(element => {
                                    const num = parseInt(element.textContent) || 0;
                                    element.textContent = formatNumber(num);
                                });
                            });
                        </script>
                    </body>

                    </html>