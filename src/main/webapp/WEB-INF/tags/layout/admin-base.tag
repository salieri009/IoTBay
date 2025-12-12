<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ attribute name="title" required="false" rtexprvalue="true" %>
<%@ attribute name="description" required="false" rtexprvalue="true" %>
<%@ attribute name="customCSS" required="false" rtexprvalue="true" %>
<%@ attribute name="customJS" required="false" rtexprvalue="true" %>
<%@ attribute name="activeNav" required="false" rtexprvalue="true" %>

<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="${description != null ? description : 'IoT Bay Admin - Management Console'}">
    <meta name="robots" content="noindex, nofollow">
    <meta name="author" content="IoT Bay">

    <title><c:choose><c:when test="${title != null}">${title} | IoT Bay Admin</c:when><c:otherwise>Admin Dashboard | IoT Bay</c:otherwise></c:choose></title>

    <!-- Favicons -->
    <link rel="icon" type="image/svg+xml" href="<c:url value='/images/favicon.svg' />">
    <link rel="icon" type="image/x-icon" href="<c:url value='/favicon.ico' />">
    
    <!-- Stylesheets -->
    <link rel="stylesheet" href="<c:url value='/css/style.css?v=20251212' />">
    <link rel="stylesheet" href="<c:url value='/css/admin.css?v=20251212' />">

    <c:if test="${customCSS != null}">
        <link rel="stylesheet" href="<c:url value='/css/${customCSS}' />">
    </c:if>

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;900&display=swap" rel="stylesheet">

    <!-- Theme Script -->
    <script>
        (function() {
            const theme = localStorage.getItem('theme') ||
                         (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
            document.documentElement.setAttribute('data-theme', theme);
        })();
    </script>
</head>
<body class="antialiased">
    <!-- Skip Links -->
    <div class="skip-links" role="navigation" aria-label="Skip navigation">
        <a href="#main-content" class="skip-link">Skip to main content</a>
        <a href="#admin-nav" class="skip-link">Skip to admin navigation</a>
    </div>

    <!-- ARIA Live Regions -->
    <div id="aria-live-announcements" class="sr-only" aria-live="polite" aria-atomic="true" role="status"></div>
    <div id="aria-live-errors" class="sr-only" aria-live="assertive" aria-atomic="true" role="alert"></div>

    <!-- Header Organism -->
    <c:import url="/components/organisms/header/header.jsp" />

    <!-- Admin Layout Container -->
    <main class="admin-layout" id="main-content" role="main">
        
        <!-- Admin Sidebar -->
        <aside class="admin-sidebar" id="adminSidebar" aria-label="Admin Navigation">
            <div class="sidebar-header">
                <h2 class="sidebar-title">Admin Panel</h2>
                <p class="sidebar-subtitle">IoT Bay Management</p>
            </div>
            <nav class="sidebar-nav" id="admin-nav">
                <a href="<c:url value='/admin-dashboard'/>" 
                   class="admin-nav-link ${activeNav == 'dashboard' ? 'active' : ''}"
                   ${activeNav == 'dashboard' ? 'aria-current="page"' : ''}>
                    Dashboard
                </a>
                <a href="<c:url value='/api/manage/users'/>" 
                   class="admin-nav-link ${activeNav == 'users' ? 'active' : ''}">
                    User Management
                </a>
                <a href="<c:url value='/api/manage/products'/>" 
                   class="admin-nav-link ${activeNav == 'products' ? 'active' : ''}">
                    Product Management
                </a>
                <a href="<c:url value='/admin/supplier/'/>" 
                   class="admin-nav-link ${activeNav == 'suppliers' ? 'active' : ''}">
                    Supplier Management
                </a>
                <a href="<c:url value='/api/manage/access-logs'/>" 
                   class="admin-nav-link ${activeNav == 'logs' ? 'active' : ''}">
                    Access Logs
                </a>
                <a href="<c:url value='/data-management'/>" 
                   class="admin-nav-link ${activeNav == 'data' ? 'active' : ''}">
                    Data Management
                </a>
                <a href="<c:url value='/reports-dashboard'/>" 
                   class="admin-nav-link ${activeNav == 'reports' ? 'active' : ''}">
                    Reports
                </a>
                <a href="<c:url value='/help.jsp'/>" 
                   class="admin-nav-link ${activeNav == 'help' ? 'active' : ''}">
                    Help & Documentation
                </a>
            </nav>
        </aside>

        <!-- Admin Main Content -->
        <div class="admin-main">
            <jsp:doBody/>
        </div>
    </main>

    <!-- Mobile Sidebar Toggle -->
    <button class="admin-sidebar-toggle" id="sidebarToggle" aria-label="Toggle Navigation Menu" aria-expanded="false">
        <svg width="24" height="24" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
        </svg>
    </button>

    <!-- Footer -->
    <c:import url="/components/organisms/footer/footer.jsp" />

    <!-- Toast Notifications Container -->
    <div id="toast-container" class="fixed top-4 right-4 z-50 space-y-2" role="region" aria-label="Notifications"></div>

    <!-- Loading Overlay -->
    <div id="loading-overlay" class="fixed inset-0 bg-black bg-opacity-50 hidden z-50 flex items-center justify-center">
        <div class="loading-spinner bg-white p-6 rounded-lg shadow-lg">
            <div class="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mx-auto"></div>
            <p class="mt-2 text-sm text-gray-600">Loading...</p>
        </div>
    </div>

    <!-- Core JavaScript -->
    <script src="<c:url value='/js/main.js'/>"></script>
    
    <c:if test="${customJS != null}">
        <script src="<c:url value='/js/${customJS}'/>"></script>
    </c:if>

    <!-- Admin Sidebar Toggle Script -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const toggle = document.getElementById('sidebarToggle');
            const sidebar = document.getElementById('adminSidebar');
            
            if (toggle && sidebar) {
                toggle.addEventListener('click', function() {
                    sidebar.classList.toggle('admin-sidebar--open');
                    const isOpen = sidebar.classList.contains('admin-sidebar--open');
                    toggle.setAttribute('aria-expanded', isOpen);
                });
            }
            
            // Format numbers with commas
            const formatNumber = (num) => num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            document.querySelectorAll('.stat-number').forEach(el => {
                const num = parseInt(el.textContent) || 0;
                el.textContent = formatNumber(num);
            });
        });
    </script>
</body>
</html>
