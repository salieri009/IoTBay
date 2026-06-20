<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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

    <title><c:choose><c:when test="${title != null}">${title} | IoT Bay</c:when><c:otherwise>IoT Bay - Smart Technology Store</c:otherwise></c:choose></title>

    <!-- Modern Favicons -->
    <link rel="icon" type="image/svg+xml" href="<c:url value='/images/favicon.svg' />">
    <link rel="icon" type="image/x-icon" href="<c:url value='/favicon.ico' />">
    
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        brand: {
                            // primary/secondary are objects with DEFAULT + numbered scale so both
                            // `brand-primary` and `brand-primary-100` etc. resolve correctly.
                            primary: {
                                DEFAULT: '#0a95ff',
                                50: '#eff8ff', 100: '#dbeefe', 200: '#bfe3ff', 300: '#93d2ff',
                                400: '#60b8ff', 500: '#0a95ff', 600: '#0077e6', 700: '#005fc0',
                                800: '#064f9b', 900: '#0a437d',
                            },
                            secondary: {
                                DEFAULT: '#64748b',
                                50: '#f8fafc', 100: '#f1f5f9', 200: '#e2e8f0', 300: '#cbd5e1',
                                400: '#94a3b8', 500: '#64748b', 600: '#475569', 700: '#334155',
                                800: '#1e293b', 900: '#0f172a',
                            },
                        },
                        neutral: {
                            50: '#f9fafb',
                            100: '#f3f4f6',
                            200: '#e5e7eb',
                            300: '#d1d5db',
                            400: '#9ca3af',
                            500: '#6b7280',
                            600: '#4b5563',
                            700: '#374151',
                            800: '#1f2937',
                            900: '#111827',
                            950: '#030712',
                        },
                        success: {
                            DEFAULT: '#22c55e',
                            50: '#f0fdf4', 100: '#dcfce7', 200: '#bbf7d0', 400: '#4ade80',
                            500: '#22c55e', 600: '#16a34a', 700: '#15803d', 800: '#166534',
                        },
                        error: {
                            DEFAULT: '#ef4444',
                            50: '#fef2f2', 100: '#fee2e2', 200: '#fecaca', 400: '#f87171',
                            500: '#ef4444', 600: '#dc2626', 700: '#b91c1c', 800: '#991b1b',
                        },
                        warning: {
                            DEFAULT: '#f59e0b',
                            50: '#fffbeb', 100: '#fef3c7', 200: '#fde68a', 400: '#fbbf24',
                            500: '#f59e0b', 600: '#d97706', 700: '#b45309', 800: '#92400e',
                        },
                        accent: {
                            DEFAULT: '#f97316',
                            50: '#fff7ed', 100: '#ffedd5', 200: '#fed7aa', 400: '#fb923c',
                            500: '#f97316', 600: '#ea580c', 700: '#c2410c',
                        },
                        info: {
                            DEFAULT: '#0ea5e9',
                            50: '#f0f9ff', 100: '#e0f2fe', 400: '#38bdf8',
                            500: '#0ea5e9', 600: '#0284c7', 700: '#0369a1',
                        },
                    }
                }
            }
        }
    </script>
    
    <link rel="stylesheet" href="<c:url value='/css/style.css?v=20251120' />">

    <c:if test="${customCSS != null}">
        <link rel="stylesheet" href="<c:url value='/css/${customCSS}' />">
    </c:if>

    <!-- Resource Hints for Performance (Section 3.4) -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="dns-prefetch" href="https://fonts.googleapis.com">
    
    <!-- Preload Critical Resources -->
    <link rel="preload" href="<c:url value='/css/style.css?v=20251120' />" as="style">
    <link rel="preload" href="<c:url value='/js/main.js' />" as="script">
    
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:ital,opsz,wght@0,9..40,300;0,9..40,400;0,9..40,500;0,9..40,600;1,9..40,400&display=swap" rel="stylesheet">

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

    <%-- Use new Atomic Design components --%>
    <c:import url="/components/organisms/header/header.jsp" />

    <main id="main-content" class="flex-1" role="main" aria-label="Main content">
        <jsp:doBody/>
    </main>

    <c:import url="/components/organisms/footer/footer.jsp" />

    <!-- Toast Notifications Container (Enhanced ARIA) -->
    <div 
        id="toast-container" 
        class="fixed top-4 right-4 z-toast space-y-2" 
        role="region" 
        aria-label="Notifications"
        aria-live="polite"
        aria-atomic="false"
    ></div>
    
    <!-- Loading Overlay (Enhanced ARIA) -->
    <div 
        id="loading-overlay" 
        class="fixed inset-0 bg-black bg-opacity-50 hidden z-modal-backdrop flex items-center justify-center"
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


