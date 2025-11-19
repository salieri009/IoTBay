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

  <title><c:choose><c:when test="${title != null}">${title} | IoT Bay</c:when><c:otherwise>IoT Bay - Smart Technology Store</c:otherwise></c:choose></title>

  <!-- Favicons -->
  <link rel="icon" type="image/svg+xml" href="<c:url value='/images/favicon.svg' />">
  <link rel="icon" type="image/x-icon" href="<c:url value='/favicon.ico' />">
  
  <!-- Stylesheets -->
  <link rel="stylesheet" href="<c:url value='/css/style.css' />">
  
  <c:if test="${customCSS != null}">
    <link rel="stylesheet" href="<c:url value='/css/${customCSS}' />">
  </c:if>

  <!-- Resource Hints -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

  <!-- Theme Script -->
  <script>
    (function() {
      const theme = localStorage.getItem('theme') ||
                   (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
      document.documentElement.setAttribute('data-theme', theme);
    })();
  </script>
</head>
<body class="antialiased bg-neutral-50 text-neutral-900 min-h-screen flex flex-col">
  <!-- Skip Links -->
  <div class="skip-links" role="navigation" aria-label="Skip navigation">
    <a href="#main-content" class="skip-link">Skip to main content</a>
    <a href="#site-navigation" class="skip-link">Skip to navigation</a>
    <a href="#site-search" class="skip-link">Skip to search</a>
  </div>

  <!-- ARIA Live Regions -->
  <div id="aria-live-announcements" class="sr-only" aria-live="polite" aria-atomic="true" role="status"></div>
  <div id="aria-live-errors" class="sr-only" aria-live="assertive" aria-atomic="true" role="alert"></div>

  <!-- Header Organism -->
  <c:import url="/components/organisms/header/header.jsp" />

  <!-- Main Content -->
  <main id="main-content" class="flex-1" role="main" aria-label="Main content">
    <jsp:doBody/>
  </main>

  <!-- Footer Organism -->
  <c:import url="/components/organisms/footer/footer.jsp" />

  <!-- Toast Notifications Container -->
  <div id="toast-container" class="fixed top-4 right-4 z-50 space-y-2" role="region" aria-label="Notifications"></div>

  <!-- Loading Overlay -->
  <div id="loading-overlay" class="fixed inset-0 bg-black bg-opacity-50 hidden z-50 flex items-center justify-center">
    <div class="loading-spinner bg-white p-6 rounded-lg shadow-lg">
      <div class="animate-spin rounded-full h-8 w-8 border-b-2 border-color-cta mx-auto"></div>
      <p class="mt-2 text-sm text-neutral-600">Loading...</p>
    </div>
  </div>

  <!-- Core JavaScript -->
  <script src="${pageContext.request.contextPath}/js/core.js"></script>

  <c:if test="${customJS != null}">
    <script src="${pageContext.request.contextPath}/js/${customJS}"></script>
  </c:if>

  <!-- Performance Monitoring -->
  <script>
    window.addEventListener('load', function() {
      const loadTime = performance.now();
      console.log('Page loaded in:', Math.round(loadTime), 'ms');
    });
  </script>
</body>
</html>

