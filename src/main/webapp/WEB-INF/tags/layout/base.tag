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

    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/modern-theme.css">

    <c:if test="${customCSS != null}">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/${customCSS}">
    </c:if>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
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
    <a href="#main-content" class="sr-only focus:not-sr-only focus:absolute focus:top-4 focus:left-4 bg-brand-primary text-white px-4 py-2 rounded-md z-50">
        Skip to main content
    </a>

    <jsp:include page="/components/header.jsp" />

    <main id="main-content" class="flex-1">
        <jsp:doBody/>
    </main>

    <jsp:include page="/components/footer.jsp" />

    <div id="toast-container" class="fixed top-4 right-4 z-50 space-y-2" role="region" aria-label="Notifications"></div>
    <div id="loading-overlay" class="fixed inset-0 bg-black bg-opacity-50 hidden z-50 flex items-center justify-center">
        <div class="loading-spinner bg-white p-6 rounded-lg shadow-lg">
            <div class="animate-spin rounded-full h-8 w-8 border-b-2 border-brand-primary mx-auto"></div>
            <p class="mt-2 text-sm text-neutral-600">Loading...</p>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/core.js"></script>
    <c:if test="${customJS != null}">
        <script src="${pageContext.request.contextPath}/js/${customJS}"></script>
    </c:if>
    <script>
        window.addEventListener('load', function() {
            const loadTime = performance.now();
            console.log('Page loaded in:', Math.round(loadTime), 'ms');
        });
    </script>
</body>
</html>


