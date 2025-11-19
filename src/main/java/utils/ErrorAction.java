package utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Enterprise-grade error handling utility
 * Provides consistent error response patterns while preventing information disclosure
 * 
 * Security Best Practices:
 * - Generic error messages to prevent information leakage
 * - Detailed logging for administrators
 * - Proper HTTP status codes
 * - No stack traces exposed to clients
 * 
 * @author IoTBay Security Team
 * @version 1.0
 */
public final class ErrorAction {
    
    private static final Logger logger = Logger.getLogger(ErrorAction.class.getName());
    private static final String GENERIC_ERROR_MESSAGE = "An error occurred while processing your request. Please try again.";
    private static final String GENERIC_AUTH_ERROR = "Authentication failed. Please check your credentials.";
    private static final String GENERIC_VALIDATION_ERROR = "Invalid input provided. Please check your input and try again.";
    
    private ErrorAction() {
        // Utility class - prevent instantiation
    }
    
    /**
     * Handle validation errors securely
     * Logs detailed information but returns generic message to client
     */
    public static void handleValidationError(
            HttpServletRequest request, 
            HttpServletResponse response, 
            String validationError,
            String logContext) throws IOException {
        
        // Log detailed error for administrators
        logger.warning(String.format("[VALIDATION_ERROR] Context: %s, Error: %s, IP: %s, User-Agent: %s",
                logContext,
                validationError,
                getClientIP(request),
                request.getHeader("User-Agent")));
        
        // Return generic message to prevent information disclosure
        request.setAttribute("errorMessage", GENERIC_VALIDATION_ERROR);
        try {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error forwarding to error page", e);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, GENERIC_VALIDATION_ERROR);
        }
    }
    
    /**
     * Handle authentication errors securely
     * Prevents user enumeration attacks
     */
    public static void handleAuthenticationError(
            HttpServletRequest request,
            HttpServletResponse response,
            String logContext) throws IOException {
        
        // Log detailed error for administrators
        logger.warning(String.format("[AUTH_ERROR] Context: %s, IP: %s, User-Agent: %s",
                logContext,
                getClientIP(request),
                request.getHeader("User-Agent")));
        
        // Generic error message to prevent user enumeration
        request.setAttribute("errorMessage", GENERIC_AUTH_ERROR);
        try {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error forwarding to login page", e);
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, GENERIC_AUTH_ERROR);
        }
    }
    
    /**
     * Handle authorization errors (403 Forbidden)
     */
    public static void handleAuthorizationError(
            HttpServletRequest request,
            HttpServletResponse response,
            String logContext) throws IOException {
        
        logger.warning(String.format("[AUTHORIZATION_ERROR] Context: %s, IP: %s, User: %s",
                logContext,
                getClientIP(request),
                getCurrentUser(request)));
        
        request.setAttribute("errorMessage", "You do not have permission to access this resource.");
        try {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error forwarding to error page", e);
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied.");
        }
    }
    
    /**
     * Handle database errors securely
     * Never expose database structure or SQL errors to clients
     */
    public static void handleDatabaseError(
            HttpServletRequest request,
            HttpServletResponse response,
            Exception e,
            String logContext) throws IOException {
        
        // Log full error details for administrators
        logger.log(Level.SEVERE, 
                String.format("[DATABASE_ERROR] Context: %s, IP: %s", logContext, getClientIP(request)), 
                e);
        
        // Return generic message to client
        request.setAttribute("errorMessage", GENERIC_ERROR_MESSAGE);
        try {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (Exception ex) {
            logger.log(Level.SEVERE, "Error forwarding to error page", ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, GENERIC_ERROR_MESSAGE);
        }
    }
    
    /**
     * Handle general server errors
     */
    public static void handleServerError(
            HttpServletRequest request,
            HttpServletResponse response,
            Exception e,
            String logContext) throws IOException {
        
        // Log full error details
        logger.log(Level.SEVERE,
                String.format("[SERVER_ERROR] Context: %s, IP: %s, User-Agent: %s",
                        logContext,
                        getClientIP(request),
                        request.getHeader("User-Agent")),
                e);
        
        // Return generic message
        request.setAttribute("errorMessage", GENERIC_ERROR_MESSAGE);
        try {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (Exception ex) {
            logger.log(Level.SEVERE, "Error forwarding to error page", ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, GENERIC_ERROR_MESSAGE);
        }
    }
    
    /**
     * Handle invalid input format errors
     */
    public static void handleInvalidInputError(
            HttpServletRequest request,
            HttpServletResponse response,
            String fieldName,
            String logContext) throws IOException {
        
        logger.warning(String.format("[INVALID_INPUT] Field: %s, Context: %s, IP: %s",
                fieldName,
                logContext,
                getClientIP(request)));
        
        request.setAttribute("errorMessage", GENERIC_VALIDATION_ERROR);
        try {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error forwarding to error page", e);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, GENERIC_VALIDATION_ERROR);
        }
    }
    
    /**
     * Handle missing required parameter errors
     */
    public static void handleMissingParameterError(
            HttpServletRequest request,
            HttpServletResponse response,
            String parameterName,
            String logContext) throws IOException {
        
        logger.warning(String.format("[MISSING_PARAMETER] Parameter: %s, Context: %s, IP: %s",
                parameterName,
                logContext,
                getClientIP(request)));
        
        request.setAttribute("errorMessage", GENERIC_VALIDATION_ERROR);
        try {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error forwarding to error page", e);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, GENERIC_VALIDATION_ERROR);
        }
    }
    
    /**
     * Handle rate limiting errors
     */
    public static void handleRateLimitError(
            HttpServletRequest request,
            HttpServletResponse response,
            String logContext) throws IOException {
        
        logger.warning(String.format("[RATE_LIMIT] Context: %s, IP: %s, User-Agent: %s",
                logContext,
                getClientIP(request),
                request.getHeader("User-Agent")));
        
        response.setStatus(429); // 429 Too Many Requests
        response.setHeader("Retry-After", "60"); // Retry after 60 seconds
        response.getWriter().write("{\"error\":\"Too many requests. Please try again later.\"}");
    }
    
    /**
     * Get client IP address (handles proxies)
     */
    private static String getClientIP(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("X-Real-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }
    
    /**
     * Get current user identifier for logging
     */
    private static String getCurrentUser(HttpServletRequest request) {
        Object user = request.getSession(false) != null ? 
                request.getSession(false).getAttribute("user") : null;
        if (user != null) {
            try {
                return user.getClass().getMethod("getEmail").invoke(user).toString();
            } catch (Exception e) {
                return "unknown";
            }
        }
        return "anonymous";
    }
    
    /**
     * Log security event for audit trail
     */
    public static void logSecurityEvent(
            String eventType,
            HttpServletRequest request,
            String details) {
        
        logger.info(String.format("[SECURITY_EVENT] Type: %s, IP: %s, User: %s, Details: %s",
                eventType,
                getClientIP(request),
                getCurrentUser(request),
                details));
    }
}

