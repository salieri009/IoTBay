<%@ page contentType="text/html; charset=UTF-8" language="java" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Oops! Something went wrong - IoT Bay</title>
    <meta name="description" content="Error page for IoT Bay - Smart Technology Store">
    
    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/modern-theme.css">
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="antialiased bg-neutral-50 text-neutral-900 min-h-screen flex flex-col">
    
    <!-- Header -->
    <jsp:include page="components/header.jsp" />
    
    <!-- Error Page Content -->
    <main class="flex-1 flex items-center justify-center py-20">
        <div class="container">
            <div class="max-w-2xl mx-auto text-center">
                <!-- Error Icon -->
                <div class="w-20 h-20 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-6">
                    <svg class="w-10 h-10 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                              d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.964-.833-2.732 0L4.732 18.5c-.77.833.192 2.5 1.732 2.5z"></path>
                    </svg>
                </div>
                
                <!-- Error Title -->
                <h1 class="text-4xl md:text-5xl font-bold text-neutral-900 mb-4">
                    Oops! Something went wrong
                </h1>
                
                <!-- Error Message -->
                <p class="text-lg md:text-xl text-neutral-600 mb-8 max-w-lg mx-auto">
                    We're experiencing some technical difficulties. Don't worry, our team has been notified and is working to fix this issue.
                </p>
                
                                
                <!-- Error Details (for development) -->
                <c:if test="${pageContext.request.serverName == 'localhost'}">
                    <div class="bg-neutral-100 rounded-lg p-6 mb-8 text-left">
                        <h3 class="font-semibold text-neutral-900 mb-3">Development Info:</h3>
                        <div class="text-sm text-neutral-700 space-y-2">
                            <c:if test="${not empty pageContext.exception}">
                                <div>
                                    <strong>Exception:</strong> ${pageContext.exception.class.simpleName}
                                </div>
                                <div>
                                    <strong>Message:</strong> ${pageContext.exception.message}
                                </div>
                            </c:if>
                            <c:if test="${not empty requestScope['javax.servlet.error.status_code']}">
                                <div>
                                    <strong>Status Code:</strong> ${requestScope['javax.servlet.error.status_code']}
                                </div>
                            </c:if>
                            <c:if test="${not empty requestScope['javax.servlet.error.request_uri']}">
                                <div>
                                    <strong>Request URI:</strong> ${requestScope['javax.servlet.error.request_uri']}
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:if>
                
                <!-- Action Buttons -->
                <div class="flex flex-wrap gap-4 justify-center">
                    <button onclick="history.back()" class="btn btn--outline btn--lg">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path>
                        </svg>
                        Go Back
                    </button>
                    <a href="${pageContext.request.contextPath}/" class="btn btn--primary btn--lg">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path>
                        </svg>
                        Go Home
                    </a>
                    <button onclick="location.reload()" class="btn btn--ghost btn--lg">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"></path>
                        </svg>
                        Try Again
                    </button>
                </div>
                
                <!-- Help Section -->
                <div class="mt-12 pt-8 border-t border-neutral-200">
                    <h3 class="font-semibold text-neutral-900 mb-4">Need Help?</h3>
                    <div class="flex flex-wrap gap-6 justify-center text-sm">
                        <a href="${pageContext.request.contextPath}/contact" class="flex items-center gap-2 text-brand-primary hover:text-brand-primary-700 transition-colors">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 4.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path>
                            </svg>
                            Contact Support
                        </a>
                        <a href="${pageContext.request.contextPath}/browse" class="flex items-center gap-2 text-brand-primary hover:text-brand-primary-700 transition-colors">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                            </svg>
                            Browse Products
                        </a>
                        <a href="${pageContext.request.contextPath}/about" class="flex items-center gap-2 text-brand-primary hover:text-brand-primary-700 transition-colors">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                            About Us
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </main>
    
    <!-- Footer -->
    <jsp:include page="components/footer.jsp" />
    
    <!-- JavaScript -->
    <script src="${pageContext.request.contextPath}/js/core.js"></script>
    
    <script>
        // Analytics tracking for error pages
        if (typeof gtag !== 'undefined') {
            gtag('event', 'exception', {
                'description': 'Error page viewed',
                'fatal': false
            });
        }
        
        // Auto-refresh for 5xx errors (optional)
        const statusCode = '${requestScope["javax.servlet.error.status_code"]}';
        if (statusCode && statusCode.startsWith('5')) {
            console.log('Server error detected. Page will auto-refresh in 30 seconds.');
            setTimeout(() => {
                if (confirm('Would you like to try loading the page again?')) {
                    location.reload();
                }
            }, 30000);
        }
    </script>
</body>
</html>
                
                <div class="error-actions">
                    <a href="javascript:history.back()" class="btn btn--outline">
                        <svg class="btn__icon" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M9.707 16.707a1 1 0 01-1.414 0l-6-6a1 1 0 010-1.414l6-6a1 1 0 011.414 1.414L4.414 9H17a1 1 0 110 2H4.414l5.293 5.293a1 1 0 010 1.414z" clip-rule="evenodd"></path>
                        </svg>
                        Go Back
                    </a>
                    <a href="index.jsp" class="btn btn--primary">
                        <svg class="btn__icon" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z"></path>
                        </svg>
                        Home Page
                    </a>
                </div>
                
                <div class="error-help">
                    <h3 class="error-help__title">Need help?</h3>
                    <p class="error-help__description">
                        If this problem persists, please contact our support team at 
                        <a href="mailto:support@iotbay.com" class="link">support@iotbay.com</a>
                    </p>
                </div>
            </div>
        </div>
    </main>
    
    <jsp:include page="components/footer.jsp" />
    <script src="js/main.js"></script>
</body>
</html>
