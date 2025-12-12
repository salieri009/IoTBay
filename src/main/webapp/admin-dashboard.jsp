<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.User" %>

<%
    // Admin authorization check
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || 
        (!"staff".equalsIgnoreCase(currentUser.getRole()) && 
         !"admin".equalsIgnoreCase(currentUser.getRole()))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<t:admin-base title="Admin Dashboard" activeNav="dashboard">
    <div class="admin-container">
        <!-- Admin Header -->
        <header class="admin-header">
            <div>
                <h1 class="admin-title">Admin Dashboard</h1>
                <p class="admin-subtitle">IoT Bay Management Console</p>
            </div>
            <div class="admin-user-info">
                <div class="user-name">Welcome, 
                    <c:out value="${sessionScope.user.firstName}" /> 
                    <c:out value="${sessionScope.user.lastName}" />
                </div>
                <div class="user-role">System Administrator</div>
            </div>
        </header>

        <!-- Statistics Overview -->
        <section class="stats-grid" aria-label="Statistics Overview">
            <div class="stat-card">
                <div class="stat-icon">
                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z" />
                    </svg>
                </div>
                <div class="stat-number" id="totalUsers">${totalUsers != null ? totalUsers : 0}</div>
                <div class="stat-label">Total Users</div>
                <div class="stat-change positive">Active users</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">
                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
                    </svg>
                </div>
                <div class="stat-number" id="totalProducts">${totalProducts != null ? totalProducts : 0}</div>
                <div class="stat-label">IoT Products</div>
                <div class="stat-change positive">In catalog</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">
                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z" />
                    </svg>
                </div>
                <div class="stat-number" id="totalOrders">${totalOrders != null ? totalOrders : 0}</div>
                <div class="stat-label">Total Orders</div>
                <div class="stat-change positive">All time</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">
                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
                    </svg>
                </div>
                <div class="stat-number" id="totalSuppliers">${totalSuppliers != null ? totalSuppliers : 0}</div>
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
                    <p class="card-description">Manage supplier information, contracts, and relationships</p>
                </div>
                <div class="card-body">
                    <ul class="feature-list">
                        <li class="feature-item">
                            <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                            </svg>
                            Add & manage supplier profiles
                        </li>
                        <li class="feature-item">
                            <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                            </svg>
                            Track supplier performance
                        </li>
                        <li class="feature-item">
                            <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                            </svg>
                            Contract & compliance management
                        </li>
                    </ul>
                    <div class="action-buttons">
                        <a href="<c:url value='/admin/supplier/'/>" class="btn btn--primary action-btn">Manage Suppliers</a>
                        <a href="<c:url value='/admin/supplier/form'/>" class="btn btn--outline action-btn">Add Supplier</a>
                    </div>
                </div>
            </div>

            <!-- Data Management -->
            <div class="management-card">
                <div class="card-header">
                    <h3 class="card-title">💾 Data Management</h3>
                    <p class="card-description">Bulk import/export operations and data analytics</p>
                </div>
                <div class="card-body">
                    <ul class="feature-list">
                        <li class="feature-item">
                            <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                            </svg>
                            CSV import & export
                        </li>
                        <li class="feature-item">
                            <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                            </svg>
                            Bulk data operations
                        </li>
                        <li class="feature-item">
                            <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                            </svg>
                            Data validation & cleanup
                        </li>
                    </ul>
                    <div class="action-buttons">
                        <a href="<c:url value='/data-management'/>" class="btn btn--primary action-btn">Data Tools</a>
                        <a href="<c:url value='/data-management'/>" class="btn btn--outline action-btn">Import Data</a>
                    </div>
                </div>
            </div>

            <!-- BI & Reporting -->
            <div class="management-card">
                <div class="card-header">
                    <h3 class="card-title">📊 BI & Reporting</h3>
                    <p class="card-description">Business intelligence and advanced analytics</p>
                </div>
                <div class="card-body">
                    <ul class="feature-list">
                        <li class="feature-item">
                            <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                            </svg>
                            Interactive dashboards
                        </li>
                        <li class="feature-item">
                            <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                            </svg>
                            Sales & revenue analytics
                        </li>
                        <li class="feature-item">
                            <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                            </svg>
                            Performance metrics
                        </li>
                    </ul>
                    <div class="action-buttons">
                        <a href="<c:url value='/reports-dashboard'/>" class="btn btn--primary action-btn">View Reports</a>
                        <a href="<c:url value='/admin-statistics'/>" class="btn btn--secondary action-btn">Statistics & Analytics</a>
                        <a href="<c:url value='/reports-dashboard#create'/>" class="btn btn--outline action-btn">Create Report</a>
                    </div>
                </div>
            </div>

            <!-- Inventory Management -->
            <div class="management-card">
                <div class="card-header">
                    <h3 class="card-title">📦 Inventory Control</h3>
                    <p class="card-description">Real-time inventory tracking and management</p>
                </div>
                <div class="card-body">
                    <ul class="feature-list">
                        <li class="feature-item">
                            <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                            </svg>
                            Stock level monitoring
                        </li>
                        <li class="feature-item">
                            <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                            </svg>
                            Low stock alerts
                        </li>
                        <li class="feature-item">
                            <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                            </svg>
                            Automated reordering
                        </li>
                    </ul>
                    <div class="action-buttons">
                        <a href="<c:url value='/api/manage/products'/>" class="btn btn--primary action-btn">Manage Inventory</a>
                        <a href="<c:url value='/api/manage/products'/>" class="btn btn--outline action-btn">Product Admin</a>
                    </div>
                </div>
            </div>

            <!-- Order Management -->
            <div class="management-card">
                <div class="card-header">
                    <h3 class="card-title">🛒 Order Management</h3>
                    <p class="card-description">Comprehensive order processing and fulfillment</p>
                </div>
                <div class="card-body">
                    <ul class="feature-list">
                        <li class="feature-item">
                            <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                            </svg>
                            Order status tracking
                        </li>
                        <li class="feature-item">
                            <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                            </svg>
                            Fulfillment management
                        </li>
                        <li class="feature-item">
                            <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                            </svg>
                            Customer communications
                        </li>
                    </ul>
                    <div class="action-buttons">
                        <a href="<c:url value='/manage/orders'/>" class="btn btn--primary action-btn">Manage Orders</a>
                        <a href="<c:url value='/manage/orders'/>" class="btn btn--outline action-btn">Pending Orders</a>
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
                            <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                            </svg>
                            User role management
                        </li>
                        <li class="feature-item">
                            <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                            </svg>
                            Access control policies
                        </li>
                        <li class="feature-item">
                            <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                            </svg>
                            Security audit logs
                        </li>
                    </ul>
                    <div class="action-buttons">
                        <a href="<c:url value='/api/manage/users'/>" class="btn btn--primary action-btn">Manage Users</a>
                        <a href="<c:url value='/api/manage/access-logs'/>" class="btn btn--outline action-btn">Access Logs</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- Quick Actions -->
        <section class="quick-actions" aria-label="Quick Actions">
            <h3 class="quick-actions-title">Quick Actions</h3>
            <div class="quick-action-grid">
                <a href="<c:url value='/browse.jsp'/>" class="quick-action-btn">
                    <svg class="quick-action-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                    </svg>
                    Browse Products
                </a>
                <a href="<c:url value='/api/manage/products'/>" class="quick-action-btn">
                    <svg class="quick-action-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6" />
                    </svg>
                    Manage Products
                </a>
                <a href="<c:url value='/manage/orders'/>" class="quick-action-btn">
                    <svg class="quick-action-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                    </svg>
                    View Orders
                </a>
                <a href="<c:url value='/data-management'/>" class="quick-action-btn">
                    <svg class="quick-action-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-3m-1 4l-3-3m0 0l-3 3m3-3v12" />
                    </svg>
                    Backup Data
                </a>
                <a href="<c:url value='/reports-dashboard#analytics'/>" class="quick-action-btn">
                    <svg class="quick-action-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
                    </svg>
                    Analytics
                </a>
                <a href="<c:url value='/index.jsp'/>" class="quick-action-btn">
                    <svg class="quick-action-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
                    </svg>
                    Back to Store
                </a>
            </div>
        </section>
    </div>
</t:admin-base>