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
    <title>Admin Dashboard - IoT Bay Management</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;900&display=swap" rel="stylesheet">
    <style>
        /* Admin Layout: Sidebar 256px + Main calc(100vw - 256px) */
        .admin-layout {
            display: flex;
            min-height: 100vh;
            background: linear-gradient(135deg, var(--neutral-50) 0%, var(--neutral-100) 100%);
        }
        
        /* Admin Sidebar: 256px fixed (skeleton-refactor) */
        .admin-sidebar {
            width: 256px;
            min-height: 100vh;
            background: #1F2937;
            position: fixed;
            left: 0;
            top: 0;
            z-index: 300;
            padding: 24px;
            overflow-y: auto;
            transition: transform 0.3s ease;
        }
        
        /* Admin Main Content: calc(100vw - 256px) */
        .admin-main {
            width: calc(100vw - 256px);
            margin-left: 256px;
            padding: 32px;
            transition: margin-left 0.3s ease;
        }
        
        /* Mobile: Sidebar Overlay */
        @media (max-width: 768px) {
            .admin-sidebar {
                width: 0;
                transform: translateX(-100%);
            }
            
            .admin-sidebar--open {
                width: 100%;
                transform: translateX(0);
            }
            
            .admin-main {
                width: 100vw;
                margin-left: 0;
            }
        }
        
        .admin-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        .admin-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 3rem;
            padding: 2rem;
            background: var(--neutral-0);
            border-radius: var(--border-radius-xl);
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--neutral-200);
        }
        
        .admin-title {
            font-size: 2.5rem;
            font-weight: 900;
            background: var(--brand-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .admin-subtitle {
            color: var(--neutral-600);
            font-size: 1.125rem;
            margin-top: 0.5rem;
        }
        
        .admin-user-info {
            text-align: right;
        }
        
        .user-name {
            font-weight: 600;
            color: var(--neutral-800);
            font-size: 1.125rem;
        }
        
        .user-role {
            color: var(--brand-primary);
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-bottom: 3rem;
        }
        
        .stat-card {
            background: var(--neutral-0);
            padding: 2rem;
            border-radius: var(--border-radius-xl);
            border: 1px solid var(--neutral-200);
            box-shadow: var(--shadow-md);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-xl);
        }
        
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--brand-gradient);
        }
        
        .stat-icon {
            width: 3rem;
            height: 3rem;
            background: var(--brand-gradient);
            border-radius: var(--border-radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
        }
        
        .stat-icon svg {
            width: 1.5rem;
            height: 1.5rem;
            color: var(--neutral-0);
        }
        
        .stat-number {
            font-size: 2.5rem;
            font-weight: 900;
            color: var(--neutral-800);
            margin-bottom: 0.5rem;
        }
        
        .stat-label {
            color: var(--neutral-600);
            font-size: 1rem;
            font-weight: 500;
        }
        
        .stat-change {
            font-size: 0.875rem;
            margin-top: 0.5rem;
        }
        
        .stat-change.positive {
            color: var(--success);
        }
        
        .stat-change.negative {
            color: var(--error);
        }
        
        .management-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
        }
        
        .management-card {
            background: var(--neutral-0);
            border-radius: var(--border-radius-xl);
            border: 1px solid var(--neutral-200);
            box-shadow: var(--shadow-md);
            overflow: hidden;
            transition: all 0.3s ease;
        }
        
        .management-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-xl);
        }
        
        .card-header {
            padding: 2rem 2rem 1rem;
            background: linear-gradient(135deg, var(--brand-primary-50) 0%, var(--brand-secondary-50) 100%);
        }
        
        .card-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--neutral-800);
            margin-bottom: 0.5rem;
        }
        
        .card-description {
            color: var(--neutral-600);
            line-height: 1.6;
        }
        
        .card-body {
            padding: 2rem;
        }
        
        .feature-list {
            list-style: none;
            padding: 0;
            margin: 0 0 2rem 0;
        }
        
        .feature-item {
            display: flex;
            align-items: center;
            padding: 0.75rem 0;
            border-bottom: 1px solid var(--neutral-100);
        }
        
        .feature-item:last-child {
            border-bottom: none;
        }
        
        .feature-icon {
            width: 1.25rem;
            height: 1.25rem;
            color: var(--success);
            margin-right: 1rem;
        }
        
        .action-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }
        
        .action-btn {
            flex: 1;
            min-width: 120px;
        }
        
        .quick-actions {
            background: var(--neutral-0);
            border-radius: var(--border-radius-xl);
            border: 1px solid var(--neutral-200);
            box-shadow: var(--shadow-md);
            padding: 2rem;
        }
        
        .quick-actions-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--neutral-800);
            margin-bottom: 1.5rem;
        }
        
        .quick-action-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }
        
        .quick-action-btn {
            display: flex;
            align-items: center;
            padding: 1rem;
            background: var(--neutral-50);
            border: 1px solid var(--neutral-200);
            border-radius: var(--border-radius-lg);
            text-decoration: none;
            color: var(--neutral-700);
            transition: all 0.3s ease;
        }
        
        .quick-action-btn:hover {
            background: var(--brand-primary-50);
            border-color: var(--brand-primary-200);
            color: var(--brand-primary-700);
        }
        
        .quick-action-icon {
            width: 1.5rem;
            height: 1.5rem;
            margin-right: 0.75rem;
        }
        
        @media (max-width: 768px) {
            .admin-container {
                padding: 1rem;
            }
            
            .admin-header {
                flex-direction: column;
                text-align: center;
                gap: 1rem;
            }
            
            .admin-user-info {
                text-align: center;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .management-grid {
                grid-template-columns: 1fr;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .action-btn {
                min-width: auto;
            }
        }
    </style>
</head>
<body>
    <c:import url="/components/organisms/header/header.jsp" />
    
    <main class="admin-layout">
        <!-- Admin Sidebar: 256px fixed -->
        <aside class="admin-sidebar" id="adminSidebar">
            <div style="color: #FFFFFF; margin-bottom: 24px;">
                <h2 style="font-size: 1.25rem; font-weight: 700; margin-bottom: 8px;">Admin Panel</h2>
                <p style="font-size: 0.875rem; color: rgba(255,255,255,0.7);">IoT Bay Management</p>
            </div>
            <nav style="display: flex; flex-direction: column; gap: 8px;">
                <a href="admin-dashboard.jsp" style="color: #FFFFFF; padding: 12px; border-radius: 8px; text-decoration: none; background: rgba(255,255,255,0.1);">Dashboard</a>
                <a href="<%=request.getContextPath()%>/manage-users.jsp" style="color: rgba(255,255,255,0.8); padding: 12px; border-radius: 8px; text-decoration: none;">User Management</a>
                <a href="<%=request.getContextPath()%>/manage-products.jsp" style="color: rgba(255,255,255,0.8); padding: 12px; border-radius: 8px; text-decoration: none;">Product Management</a>
                <a href="<%=request.getContextPath()%>/manage-suppliers.jsp" style="color: rgba(255,255,255,0.8); padding: 12px; border-radius: 8px; text-decoration: none;">Supplier Management</a>
                <a href="<%=request.getContextPath()%>/manage-access-logs.jsp" style="color: rgba(255,255,255,0.8); padding: 12px; border-radius: 8px; text-decoration: none;">Access Logs</a>
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
                    <div class="user-name">Welcome, <%= currentUser.getFirstName() %> <%= currentUser.getLastName() %></div>
                    <div class="user-role">System Administrator</div>
                </div>
            </header>
            
            <!-- Statistics Overview -->
            <section class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon">
                        <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"/>
                        </svg>
                    </div>
                    <div class="stat-number" id="totalUsers">1,234</div>
                    <div class="stat-label">Total Users</div>
                    <div class="stat-change positive">??+12% this month</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon">
                        <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"/>
                        </svg>
                    </div>
                    <div class="stat-number" id="totalProducts">856</div>
                    <div class="stat-label">IoT Products</div>
                    <div class="stat-change positive">??+8% this week</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon">
                        <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"/>
                        </svg>
                    </div>
                    <div class="stat-number" id="totalOrders">2,468</div>
                    <div class="stat-label">Total Orders</div>
                    <div class="stat-change positive">??+15% this month</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon">
                        <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"/>
                        </svg>
                    </div>
                    <div class="stat-number" id="totalSuppliers">95</div>
                    <div class="stat-label">Active Suppliers</div>
                    <div class="stat-change positive">??+3% this month</div>
                </div>
            </section>
            
            <!-- Management Features -->
            <section class="management-grid">
                <!-- Supplier Information Management -->
                <div class="management-card">
                    <div class="card-header">
                        <h3 class="card-title">?�� Supplier Management</h3>
                        <p class="card-description">Manage supplier information, contracts, and relationships</p>
                    </div>
                    <div class="card-body">
                        <ul class="feature-list">
                            <li class="feature-item">
                                <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                </svg>
                                Add & manage supplier profiles
                            </li>
                            <li class="feature-item">
                                <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                </svg>
                                Track supplier performance
                            </li>
                            <li class="feature-item">
                                <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                </svg>
                                Contract & compliance management
                            </li>
                        </ul>
                        <div class="action-buttons">
                            <a href="<%=request.getContextPath()%>/supplier-management.jsp" class="btn btn--primary action-btn">
                                Manage Suppliers
                            </a>
                            <a href="<%=request.getContextPath()%>/supplier-management.jsp#add-new" class="btn btn--outline action-btn">
                                Add Supplier
                            </a>
                        </div>
                    </div>
                </div>
                
                <!-- Data Management -->
                <div class="management-card">
                    <div class="card-header">
                        <h3 class="card-title">?�� Data Management</h3>
                        <p class="card-description">Bulk import/export operations and data analytics</p>
                    </div>
                    <div class="card-body">
                        <ul class="feature-list">
                            <li class="feature-item">
                                <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                </svg>
                                CSV import & export
                            </li>
                            <li class="feature-item">
                                <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                </svg>
                                Bulk data operations
                            </li>
                            <li class="feature-item">
                                <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                </svg>
                                Data validation & cleanup
                            </li>
                        </ul>
                        <div class="action-buttons">
                            <a href="<%=request.getContextPath()%>/data-management.jsp" class="btn btn--primary action-btn">
                                Data Tools
                            </a>
                            <a href="<%=request.getContextPath()%>/data-management.jsp#import" class="btn btn--outline action-btn">
                                Import Data
                            </a>
                        </div>
                    </div>
                </div>
                
                <!-- BI & Reporting -->
                <div class="management-card">
                    <div class="card-header">
                        <h3 class="card-title">?�� BI & Reporting</h3>
                        <p class="card-description">Business intelligence and advanced analytics</p>
                    </div>
                    <div class="card-body">
                        <ul class="feature-list">
                            <li class="feature-item">
                                <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                </svg>
                                Interactive dashboards
                            </li>
                            <li class="feature-item">
                                <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                </svg>
                                Sales & revenue analytics
                            </li>
                            <li class="feature-item">
                                <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                </svg>
                                Performance metrics
                            </li>
                        </ul>
                        <div class="action-buttons">
                            <a href="<%=request.getContextPath()%>/reports-dashboard.jsp" class="btn btn--primary action-btn">
                                View Reports
                            </a>
                            <a href="<%=request.getContextPath()%>/admin-statistics.jsp" class="btn btn--secondary action-btn">
                                Statistics & Analytics
                            </a>
                            <a href="<%=request.getContextPath()%>/reports-dashboard.jsp#create" class="btn btn--outline action-btn">
                                Create Report
                            </a>
                        </div>
                    </div>
                </div>
                
                <!-- Inventory Management -->
                <div class="management-card">
                    <div class="card-header">
                        <h3 class="card-title">?�� Inventory Control</h3>
                        <p class="card-description">Real-time inventory tracking and management</p>
                    </div>
                    <div class="card-body">
                        <ul class="feature-list">
                            <li class="feature-item">
                                <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                </svg>
                                Stock level monitoring
                            </li>
                            <li class="feature-item">
                                <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                </svg>
                                Low stock alerts
                            </li>
                            <li class="feature-item">
                                <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                </svg>
                                Automated reordering
                            </li>
                        </ul>
                        <div class="action-buttons">
                            <a href="<%=request.getContextPath()%>/inventory-management.jsp" class="btn btn--primary action-btn">
                                Manage Inventory
                            </a>
                            <a href="<%=request.getContextPath()%>/api/manage/products" class="btn btn--outline action-btn">
                                Product Admin
                            </a>
                        </div>
                    </div>
                </div>
                
                <!-- Order Management -->
                <div class="management-card">
                    <div class="card-header">
                        <h3 class="card-title">?���?Order Management</h3>
                        <p class="card-description">Comprehensive order processing and fulfillment</p>
                    </div>
                    <div class="card-body">
                        <ul class="feature-list">
                            <li class="feature-item">
                                <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                </svg>
                                Order status tracking
                            </li>
                            <li class="feature-item">
                                <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                </svg>
                                Fulfillment management
                            </li>
                            <li class="feature-item">
                                <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                </svg>
                                Customer communications
                            </li>
                        </ul>
                        <div class="action-buttons">
                            <a href="<%=request.getContextPath()%>/order-management.jsp" class="btn btn--primary action-btn">
                                Manage Orders
                            </a>
                            <a href="<%=request.getContextPath()%>/order-management.jsp#pending" class="btn btn--outline action-btn">
                                Pending Orders
                            </a>
                        </div>
                    </div>
                </div>
                
                <!-- User Management -->
                <div class="management-card">
                    <div class="card-header">
                        <h3 class="card-title">?�� User Administration</h3>
                        <p class="card-description">User accounts, roles, and access control</p>
                    </div>
                    <div class="card-body">
                        <ul class="feature-list">
                            <li class="feature-item">
                                <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                </svg>
                                User role management
                            </li>
                            <li class="feature-item">
                                <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                </svg>
                                Access control policies
                            </li>
                            <li class="feature-item">
                                <svg class="feature-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                </svg>
                                Security audit logs
                            </li>
                        </ul>
                        <div class="action-buttons">
                            <a href="<%=request.getContextPath()%>/api/manage/users" class="btn btn--primary action-btn">
                                Manage Users
                            </a>
                            <a href="<%=request.getContextPath()%>/api/manage/access-logs" class="btn btn--outline action-btn">
                                Access Logs
                            </a>
                        </div>
                    </div>
                </div>
            </section>
            
            <!-- Quick Actions -->
            <section class="quick-actions">
                <h3 class="quick-actions-title">Quick Actions</h3>
                <div class="quick-action-grid">
                    <a href="<%=request.getContextPath()%>/browse.jsp" class="quick-action-btn">
                        <svg class="quick-action-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                        </svg>
                        Browse Products
                    </a>
                    <a href="<%=request.getContextPath()%>/api/manage/products" class="quick-action-btn">
                        <svg class="quick-action-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"/>
                        </svg>
                        Add Product
                    </a>
                    <a href="<%=request.getContextPath()%>/orderhistory" class="quick-action-btn">
                        <svg class="quick-action-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
                        </svg>
                        View Orders
                    </a>
                    <a href="<%=request.getContextPath()%>/data-management.jsp#backup" class="quick-action-btn">
                        <svg class="quick-action-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-3m-1 4l-3-3m0 0l-3 3m3-3v12"/>
                        </svg>
                        Backup Data
                    </a>
                    <a href="<%=request.getContextPath()%>/reports-dashboard.jsp#analytics" class="quick-action-btn">
                        <svg class="quick-action-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                        </svg>
                        Analytics
                    </a>
                    <a href="<%=request.getContextPath()%>/index.jsp" class="quick-action-btn">
                        <svg class="quick-action-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
                        </svg>
                        Back to Store
                    </a>
                </div>
            </section>
            </div>
        </div>
    </main>
    
    <!-- Mobile Sidebar Toggle -->
    <button class="admin-sidebar-toggle" id="sidebarToggle" style="display: none; position: fixed; top: 16px; left: 16px; z-index: 301; background: #1F2937; color: #FFFFFF; border: none; padding: 12px; border-radius: 8px; cursor: pointer;">
        <svg width="24" height="24" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/>
        </svg>
    </button>
    
    <script>
        // Mobile sidebar toggle
        if (window.innerWidth <= 768) {
            document.getElementById('sidebarToggle').style.display = 'block';
            document.getElementById('sidebarToggle').addEventListener('click', function() {
                document.getElementById('adminSidebar').classList.toggle('admin-sidebar--open');
            });
        }
    </script>
    
    <c:import url="/components/organisms/footer/footer.jsp" />
    
    <script>
        // Simple data fetching simulation
        document.addEventListener('DOMContentLoaded', function() {
            // Simulate real-time statistics updates
            function updateStats() {
                // These would typically come from AJAX calls to backend APIs
                const stats = {
                    users: Math.floor(Math.random() * 100) + 1200,
                    products: Math.floor(Math.random() * 50) + 850,
                    orders: Math.floor(Math.random() * 200) + 2400,
                    suppliers: Math.floor(Math.random() * 10) + 90
                };
                
                // Update numbers with smooth animation
                animateNumber('totalUsers', stats.users);
                animateNumber('totalProducts', stats.products);
                animateNumber('totalOrders', stats.orders);
                animateNumber('totalSuppliers', stats.suppliers);
            }
            
            function animateNumber(elementId, targetValue) {
                const element = document.getElementById(elementId);
                if (!element) return;
                
                const currentValue = parseInt(element.textContent.replace(/,/g, ''));
                const increment = (targetValue - currentValue) / 20;
                let current = currentValue;
                
                const timer = setInterval(() => {
                    current += increment;
                    if ((increment > 0 && current >= targetValue) || (increment < 0 && current <= targetValue)) {
                        current = targetValue;
                        clearInterval(timer);
                    }
                    element.textContent = Math.round(current).toLocaleString();
                }, 50);
            }
            
            // Update stats every 30 seconds
            updateStats();
            setInterval(updateStats, 30000);
        });
    </script>
</body>
</html>
