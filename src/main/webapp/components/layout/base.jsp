<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="${param.description != null ? param.description : 'IoT Bay - Your Premier IoT Device Store'}">
    <meta name="keywords" content="IoT devices, smart home, sensors, electronics, technology">
    <meta name="author" content="IoT Bay">
    
    <!-- Page Title -->
    <title>${param.title != null ? param.title.concat(' | IoT Bay') : 'IoT Bay - Smart Technology Store'}</title>
    
    <!-- Modern Favicons -->
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/images/favicon.svg">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/favicon.ico">
    
    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/modern-theme.css?v=3">
    
    <!-- Custom CSS if needed -->
    <c:if test="${param.customCSS != null}">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/${param.customCSS}">
    </c:if>
    
    <!-- Preload critical fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Theme detection script -->
    <script>
        (function() {
            const theme = localStorage.getItem('theme') || 
                         (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
            document.documentElement.setAttribute('data-theme', theme);
        })();
    </script>
</head>
<body class="antialiased bg-neutral-50 text-neutral-900 min-h-screen flex flex-col">
    <!-- Skip to main content for accessibility -->
    <a href="#main-content" class="sr-only focus:not-sr-only focus:absolute focus:top-4 focus:left-4 bg-brand-primary text-white px-4 py-2 rounded-md z-50">
        Skip to main content
    </a>
    
    <%-- Use new Atomic Design components --%>
    <!-- Header -->
    <c:import url="/components/organisms/header/header.jsp" />
    
    <!-- Main Content -->
    <main id="main-content" class="flex-1">
        <!-- Page-specific content will be inserted here -->
        <jsp:doBody/>
    </main>
    
    <!-- Footer -->
    <c:import url="/components/organisms/footer/footer.jsp" />
    
    <!-- Toast Notifications Container -->
    <div id="toast-container" class="fixed top-4 right-4 z-50 space-y-2" role="region" aria-label="Notifications"></div>
    
    <!-- Loading Overlay -->
    <div id="loading-overlay" class="fixed inset-0 bg-black bg-opacity-50 hidden z-50 flex items-center justify-center">
        <div class="loading-spinner bg-white p-6 rounded-lg shadow-lg">
            <div class="animate-spin rounded-full h-8 w-8 border-b-2 border-brand-primary mx-auto"></div>
            <p class="mt-2 text-sm text-neutral-600">Loading...</p>
        </div>
    </div>
    
    <!-- Core JavaScript -->
    <script src="${pageContext.request.contextPath}/js/core.js"></script>
    
    <!-- Page-specific JavaScript -->
    <c:if test="${param.customJS != null}">
        <script src="${pageContext.request.contextPath}/js/${param.customJS}"></script>
    </c:if>
    
    <!-- Performance monitoring -->
    <script>
        // Simple performance monitoring
        window.addEventListener('load', function() {
            const loadTime = performance.now();
            console.log('Page loaded in:', Math.round(loadTime), 'ms');
        });
    </script>
</body>
</html>
