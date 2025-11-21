<%@ page contentType="text/html; charset=UTF-8" language="java" isErrorPage="true" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - IoT Bay</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h1 {
            color: #d32f2f;
            margin-top: 0;
        }
        .error-info {
            background: #f5f5f5;
            padding: 20px;
            border-radius: 4px;
            margin: 20px 0;
        }
        .error-info div {
            margin: 10px 0;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            margin: 10px 10px 10px 0;
            background: #1976d2;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            border: none;
            cursor: pointer;
        }
        .btn:hover {
            background: #1565c0;
        }
    </style>
</head>
<body>
<%
    Throwable ex = exception;
    String exceptionClassName = ex != null ? ex.getClass().getName() : null;
    String exceptionMessage = ex != null ? ex.getMessage() : null;
    String topStackTrace = null;
    if (ex != null && ex.getStackTrace() != null && ex.getStackTrace().length > 0) {
        topStackTrace = ex.getStackTrace()[0].toString();
    }

    Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
    String requestUri = (String) request.getAttribute("javax.servlet.error.request_uri");
    Throwable forwardedException = (Throwable) request.getAttribute("javax.servlet.error.exception");
    String forwardedClassName = forwardedException != null ? forwardedException.getClass().getName() : null;
    String forwardedMessage = forwardedException != null ? forwardedException.getMessage() : null;

    String serverName = request.getServerName();
    boolean isLocal = "localhost".equalsIgnoreCase(serverName) || "127.0.0.1".equals(serverName);
%>
    <div class="container">
        <h1>Oops! Something went wrong</h1>
        <p>We're experiencing some technical difficulties. Please try again later.</p>

        <% 
            // Only show detailed error information in development/localhost
            // Never expose stack traces in production
            String environment = application.getInitParameter("app.environment");
            boolean isDevelopment = isLocal || (environment != null && "development".equalsIgnoreCase(environment));
        %>
        <% if (isDevelopment) { %>
            <div class="error-info">
                <h3>Development Error Information:</h3>
                <% if (exceptionClassName != null) { %>
                    <div><strong>Exception:</strong> <%= exceptionClassName %></div>
                <% } %>
                <% if (exceptionMessage != null) { %>
                    <div><strong>Message:</strong> <%= exceptionMessage %></div>
                <% } %>
                <% if (topStackTrace != null) { %>
                    <div><strong>Stack Trace (First Line):</strong>
                        <pre style="overflow-x: auto; font-size: 12px;"><%= topStackTrace %></pre>
                    </div>
                <% } %>
                <% if (ex != null) { %>
                    <div><strong>Full Stack Trace:</strong>
                        <pre style="overflow-x: auto; font-size: 10px; max-height: 400px; overflow-y: auto;"><%
                            java.io.StringWriter sw = new java.io.StringWriter();
                            java.io.PrintWriter pw = new java.io.PrintWriter(sw);
                            ex.printStackTrace(pw);
                            out.print(sw.toString());
                        %></pre>
                    </div>
                <% } %>
                <% if (statusCode != null) { %>
                    <div><strong>Status Code:</strong> <%= statusCode %></div>
                <% } %>
                <% if (requestUri != null) { %>
                    <div><strong>Request URI:</strong> <%= requestUri %></div>
                <% } %>
                <% if (forwardedClassName != null) { %>
                    <div><strong>Forwarded Exception Type:</strong> <%= forwardedClassName %></div>
                <% } %>
                <% if (forwardedMessage != null) { %>
                    <div><strong>Forwarded Exception Message:</strong> <%= forwardedMessage %></div>
                <% } %>
            </div>
        <% } %>

        <div>
            <a href="<%= request.getContextPath() %>/" class="btn">Go Home</a>
            <button onclick="history.back()" class="btn">Go Back</button>
            <button onclick="location.reload()" class="btn">Try Again</button>
        </div>
    </div>
</body>
</html>
