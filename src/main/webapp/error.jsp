<%@ page contentType="text/html; charset=UTF-8" language="java" isErrorPage="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="css/modern-theme.css" />
    <title>Error - IoT Bay</title>
</head>
<body>
    <jsp:include page="components/header.jsp" />
    
    <main class="error-page">
        <div class="container">
            <div class="error-content">
                <div class="error-icon">
                    <svg fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd"></path>
                    </svg>
                </div>
                
                <h1 class="error-title">Oops! Something went wrong</h1>
                <p class="error-description">
                    We encountered an unexpected error while processing your request.
                    Don't worry, our team has been notified and is working to fix this issue.
                </p>
                
                <% 
                String errorMessage = (String) request.getAttribute("errorMessage");
                String errorCode = (String) request.getAttribute("errorCode");
                if (errorMessage != null || exception != null) { 
                %>
                <div class="error-details">
                    <h3 class="error-details__title">Error Details</h3>
                    <% if (errorCode != null) { %>
                    <p class="error-details__code">Error Code: <span><%= errorCode %></span></p>
                    <% } %>
                    <% if (errorMessage != null) { %>
                    <p class="error-details__message"><%= errorMessage %></p>
                    <% } else if (exception != null) { %>
                    <p class="error-details__message"><%= exception.getMessage() %></p>
                    <% } %>
                </div>
                <% } %>
                
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
