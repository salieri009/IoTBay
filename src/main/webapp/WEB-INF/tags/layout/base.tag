<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="title" required="false" rtexprvalue="true" %>
<%@ attribute name="description" required="false" rtexprvalue="true" %>
<%@ attribute name="customCSS" required="false" rtexprvalue="true" %>
<%@ attribute name="customJS" required="false" rtexprvalue="true" %>

<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="${description != null ? description : 'IoT Bay - Your Premier IoT Device Store'}">
    <meta name="keywords" content="IoT devices, smart home, sensors, electronics, technology">
    <meta name="author" content="IoT Bay">

    <title>${title != null ? title.concat(' | IoT Bay') : 'IoT Bay - Smart Technology Store'}</title>

    <link rel="icon" type="image/x-icon" href="<c:url value='/images/favicon.ico' />">
    <link rel="stylesheet" href="<c:url value='/css/modern-theme.css' />">

    <c:if test="${customCSS != null}">
        <link rel="stylesheet" href="<c:url value='/css/${customCSS}' />">
    </c:if>

    <!-- Resource Hints for Performance (Section 3.4) -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="dns-prefetch" href="https://fonts.googleapis.com">
    
    <!-- Preload Critical Resources -->
    <link rel="preload" href="<c:url value='/css/modern-theme.css' />" as="style">
    <link rel="preload" href="<c:url value='/js/main.js' />" as="script">
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <script>
        (function() {
            const theme = localStorage.getItem('theme') ||
                         (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
            document.documentElement.setAttribute('data-theme', theme);
        })();
    </script>
</head>
<body class="antialiased bg-neutral-50 text-neutral-900 min-h-screen flex flex-col">
    <!-- Enhanced Skip Links (Section 8.1 - Enhanced Keyboard Navigation) -->
    <div class="skip-links" role="navigation" aria-label="Skip navigation">
        <a href="#main-content" class="skip-link">
            Skip to main content
        </a>
        <a href="#site-navigation" class="skip-link">
            Skip to navigation
        </a>
        <a href="#site-search" class="skip-link">
            Skip to search
        </a>
    </div>

    <!-- ARIA Live Region for Dynamic Announcements (Section 8.2 - Screen Reader Optimization) -->
    <div 
        id="aria-live-announcements" 
        class="sr-only" 
        aria-live="polite" 
        aria-atomic="true"
        role="status"
        aria-relevant="additions text"
    >
        <!-- Dynamically updated content for screen readers -->
    </div>

    <!-- ARIA Live Region for Urgent Announcements (Errors) -->
    <div 
        id="aria-live-errors" 
        class="sr-only" 
        aria-live="assertive" 
        aria-atomic="true"
        role="alert"
        aria-relevant="additions text"
    >
        <!-- Urgent error messages for screen readers -->
    </div>

    <jsp:include page="/components/header.jsp" />

    <main id="main-content" class="flex-1" role="main" aria-label="Main content">
        <jsp:doBody/>
    </main>

    <jsp:include page="/components/footer.jsp" />

    <!-- Toast Notifications Container (Enhanced ARIA) -->
    <div 
        id="toast-container" 
        class="fixed top-4 right-4 z-50 space-y-2" 
        role="region" 
        aria-label="Notifications"
        aria-live="polite"
        aria-atomic="false"
    ></div>
    
    <!-- Loading Overlay (Enhanced ARIA) -->
    <div 
        id="loading-overlay" 
        class="fixed inset-0 bg-black bg-opacity-50 hidden z-50 flex items-center justify-center"
        role="status"
        aria-live="polite"
        aria-busy="true"
        aria-label="Loading content"
    >
        <div class="loading-spinner bg-white p-6 rounded-lg shadow-lg">
            <div class="animate-spin rounded-full h-8 w-8 border-b-2 border-brand-primary mx-auto" aria-hidden="true"></div>
            <p class="mt-2 text-sm text-neutral-600">Loading...</p>
        </div>
    </div>

    <script src="<c:url value='/js/main.js' />"></script>
    <c:if test="${customJS != null}">
        <script src="<c:url value='/js/${customJS}' />"></script>
    </c:if>
    <script>
        window.addEventListener('load', function() {
            const loadTime = performance.now();
            console.log('Page loaded in:', Math.round(loadTime), 'ms');
        });
    </script>
</body>
</html>


