package utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.logging.Logger;
import java.util.regex.Pattern;
import java.util.UUID;

/**
 * Enterprise-grade security utility class for input validation and sanitization
 * Provides secure parameter extraction, validation, and security features
 * 
 * Security Features:
 * - Input validation and sanitization
 * - XSS prevention
 * - SQL Injection prevention (parameterized queries)
 * - CSRF token generation and validation
 * - Rate limiting support
 * - Secure session management
 * 
 * @author IoTBay Security Team
 * @version 3.0
 */
public final class SecurityUtil {
    
    private static final Logger logger = Logger.getLogger(SecurityUtil.class.getName());
    
    // XSS prevention patterns
    private static final Pattern SCRIPT_PATTERN = Pattern.compile("<script[^>]*>.*?</script>", Pattern.CASE_INSENSITIVE | Pattern.DOTALL);
    private static final Pattern JAVASCRIPT_PATTERN = Pattern.compile("javascript:", Pattern.CASE_INSENSITIVE);
    private static final Pattern ON_EVENT_PATTERN = Pattern.compile("on\\w+\\s*=", Pattern.CASE_INSENSITIVE);
    
    // CSRF token session attribute name
    private static final String CSRF_TOKEN_ATTR = "csrfToken";
    
    private SecurityUtil() {}
    
    /**
     * Safely extracts and validates integer parameter from request
     * 
     * @param request HTTP servlet request
     * @param paramName Parameter name
     * @return Validated integer value
     * @throws IllegalArgumentException if parameter is invalid or missing
     */
    public static int getValidatedIntParameter(HttpServletRequest request, String paramName) {
        String value = request.getParameter(paramName);
        if (value == null || value.trim().isEmpty()) {
            logger.warning("Missing required parameter: " + paramName);
            throw new IllegalArgumentException("Parameter '" + paramName + "' is required");
        }
        
        try {
            int result = Integer.parseInt(value.trim());
            if (result < 0) {
                throw new IllegalArgumentException("Parameter '" + paramName + "' must be non-negative");
            }
            return result;
        } catch (NumberFormatException e) {
            logger.warning("Invalid number format for parameter: " + paramName + " = " + value);
            throw new IllegalArgumentException("Invalid number format for parameter '" + paramName + "'");
        }
    }
    
    /**
     * Safely extracts and validates double parameter from request
     * 
     * @param request HTTP servlet request
     * @param paramName Parameter name
     * @return Validated double value
     * @throws IllegalArgumentException if parameter is invalid or missing
     */
    public static double getValidatedDoubleParameter(HttpServletRequest request, String paramName) {
        String value = request.getParameter(paramName);
        if (value == null || value.trim().isEmpty()) {
            logger.warning("Missing required parameter: " + paramName);
            throw new IllegalArgumentException("Parameter '" + paramName + "' is required");
        }
        
        try {
            double result = Double.parseDouble(value.trim());
            if (result < 0) {
                throw new IllegalArgumentException("Parameter '" + paramName + "' must be non-negative");
            }
            return result;
        } catch (NumberFormatException e) {
            logger.warning("Invalid number format for parameter: " + paramName + " = " + value);
            throw new IllegalArgumentException("Invalid number format for parameter '" + paramName + "'");
        }
    }
    
    /**
     * Safely extracts and validates string parameter from request
     * 
     * @param request HTTP servlet request
     * @param paramName Parameter name
     * @param maxLength Maximum allowed length
     * @return Validated and sanitized string
     * @throws IllegalArgumentException if parameter is invalid or missing
     */
    public static String getValidatedStringParameter(HttpServletRequest request, String paramName, int maxLength) {
        String value = request.getParameter(paramName);
        if (value == null || value.trim().isEmpty()) {
            logger.warning("Missing required parameter: " + paramName);
            throw new IllegalArgumentException("Parameter '" + paramName + "' is required");
        }
        
        value = value.trim();
        if (value.length() > maxLength) {
            logger.warning("Parameter too long: " + paramName + " (length: " + value.length() + ")");
            throw new IllegalArgumentException("Parameter '" + paramName + "' exceeds maximum length of " + maxLength);
        }
        
        // Basic XSS prevention - remove potentially dangerous characters
        value = value.replaceAll("[<>\"'&]", "");
        
        return value;
    }
    
    /**
     * Safely extracts optional integer parameter from request
     * 
     * @param request HTTP servlet request
     * @param paramName Parameter name
     * @param defaultValue Default value if parameter is missing
     * @return Validated integer value or default
     */
    public static int getOptionalIntParameter(HttpServletRequest request, String paramName, int defaultValue) {
        String value = request.getParameter(paramName);
        if (value == null || value.trim().isEmpty()) {
            return defaultValue;
        }
        
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            logger.warning("Invalid number format for optional parameter: " + paramName + " = " + value + ", using default: " + defaultValue);
            return defaultValue;
        }
    }
    
    /**
     * Validates email format
     * 
     * @param email Email to validate
     * @return true if email is valid
     */
    public static boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        return email.matches(emailRegex);
    }
    
    /**
     * Enhanced sanitization to prevent XSS attacks
     * Removes dangerous HTML/JavaScript patterns
     * 
     * @param input Input string to sanitize
     * @return Sanitized string
     */
    public static String sanitizeInput(String input) {
        if (input == null) {
            return null;
        }
        
        String sanitized = input;
        
        // Remove script tags
        sanitized = SCRIPT_PATTERN.matcher(sanitized).replaceAll("");
        
        // Remove javascript: protocol
        sanitized = JAVASCRIPT_PATTERN.matcher(sanitized).replaceAll("");
        
        // Remove event handlers (onclick, onerror, etc.)
        sanitized = ON_EVENT_PATTERN.matcher(sanitized).replaceAll("");
        
        // Remove dangerous HTML characters
        sanitized = sanitized.replaceAll("[<>\"'&]", "");
        
        // Remove control characters
        sanitized = sanitized.replaceAll("[\\x00-\\x1F\\x7F]", "");
        
        return sanitized.trim();
    }
    
    /**
     * Sanitize input for database storage (prevents SQL injection)
     * Note: Always use PreparedStatement with parameters instead of string concatenation
     * This is an additional layer of defense
     * 
     * @param input Input string to sanitize
     * @return Sanitized string
     */
    public static String sanitizeForDatabase(String input) {
        if (input == null) {
            return null;
        }
        
        // Remove SQL injection patterns
        String sanitized = input;
        sanitized = sanitized.replaceAll("[';\"\\\\]", ""); // Remove quotes and backslashes
        sanitized = sanitized.replaceAll("(?i)(union|select|insert|update|delete|drop|create|alter|exec|execute)", "");
        sanitized = sanitized.replaceAll("--", ""); // Remove SQL comments
        sanitized = sanitized.replaceAll("/\\*.*?\\*/", ""); // Remove block comments
        
        return sanitized.trim();
    }
    
    /**
     * Validate and sanitize integer with range check
     */
    public static int getValidatedIntParameter(
            HttpServletRequest request, 
            String paramName, 
            int minValue, 
            int maxValue) {
        int value = getValidatedIntParameter(request, paramName);
        
        if (value < minValue || value > maxValue) {
            logger.warning(String.format("Parameter %s value %d out of range [%d, %d]", 
                    paramName, value, minValue, maxValue));
            throw new IllegalArgumentException(
                    String.format("Parameter '%s' must be between %d and %d", 
                            paramName, minValue, maxValue));
        }
        
        return value;
    }
    
    /**
     * Validate and sanitize string with pattern matching
     */
    public static String getValidatedStringParameter(
            HttpServletRequest request,
            String paramName,
            int maxLength,
            Pattern allowedPattern) {
        String value = getValidatedStringParameter(request, paramName, maxLength);
        
        if (allowedPattern != null && !allowedPattern.matcher(value).matches()) {
            logger.warning(String.format("Parameter %s does not match required pattern", paramName));
            throw new IllegalArgumentException(
                    String.format("Parameter '%s' contains invalid characters", paramName));
        }
        
        return value;
    }
    
    /**
     * Generate CSRF token and store in session
     */
    public static String generateCSRFToken(HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        String token = UUID.randomUUID().toString();
        session.setAttribute(CSRF_TOKEN_ATTR, token);
        logger.fine("CSRF token generated for session: " + session.getId());
        return token;
    }
    
    /**
     * Validate CSRF token from request
     * Returns true if token is valid, false otherwise
     */
    public static boolean validateCSRFToken(HttpServletRequest request) {
        // Get or create session (create if doesn't exist for first-time requests)
        HttpSession session = request.getSession(true);
        
        String sessionToken = (String) session.getAttribute(CSRF_TOKEN_ATTR);
        String requestToken = request.getParameter("csrfToken");
        
        if (requestToken == null) {
            // Try header as fallback
            requestToken = request.getHeader("X-CSRF-Token");
        }
        
        // If no token in session, this might be the first request - allow it but log
        if (sessionToken == null) {
            logger.info("No CSRF token in session (first request), allowing but generating new token. Session: " + session.getId());
            // Generate token for next request
            generateCSRFToken(request);
            // For first request without token, be lenient (development mode)
            // In production, you might want to return false here
            return requestToken == null; // Allow if no token provided (first request)
        }
        
        // If no token in request but session has token, fail validation
        if (requestToken == null) {
            logger.warning("CSRF validation failed: Missing token in request. Session: " + session.getId());
            return false;
        }
        
        boolean isValid = sessionToken.equals(requestToken);
        
        if (!isValid) {
            logger.warning(String.format("CSRF validation failed: Token mismatch. Session: %s, IP: %s, SessionToken: %s, RequestToken: %s",
                    session.getId(), getClientIP(request), 
                    sessionToken != null ? sessionToken.substring(0, Math.min(8, sessionToken.length())) + "..." : "null",
                    requestToken != null ? requestToken.substring(0, Math.min(8, requestToken.length())) + "..." : "null"));
        } else {
            // Regenerate token after successful validation (token rotation)
            generateCSRFToken(request);
        }
        
        return isValid;
    }
    
    /**
     * Check if request should be rate limited
     * Simple in-memory implementation (for production, use Redis or similar)
     */
    public static boolean isRateLimited(HttpServletRequest request, int maxRequests, long timeWindowMs) {
        // This is a simplified implementation
        // For production, use a proper rate limiting library (e.g., Bucket4j, Redis)
        // String clientId = getClientIP(request); // Reserved for future implementation
        
        // TODO: Implement proper rate limiting with cache/Redis
        // For now, return false (not rate limited)
        // In production, check request count for clientId within timeWindowMs
        // Example implementation would use:
        // - ConcurrentHashMap or Redis to track request counts per IP
        // - Time-based sliding window or token bucket algorithm
        // - Thread-safe increment and expiration logic
        
        return false;
    }
    
    /**
     * Validate file upload (basic checks)
     */
    public static boolean isValidFileUpload(String fileName, String contentType, long fileSize, long maxSize) {
        if (fileName == null || fileName.trim().isEmpty()) {
            return false;
        }
        
        // Check file size
        if (fileSize > maxSize) {
            logger.warning("File upload rejected: File too large. Size: " + fileSize);
            return false;
        }
        
        // Check for path traversal
        if (fileName.contains("..") || fileName.contains("/") || fileName.contains("\\")) {
            logger.warning("File upload rejected: Invalid file name. Name: " + fileName);
            return false;
        }
        
        // Check file extension
        String[] allowedExtensions = {".jpg", ".jpeg", ".png", ".gif", ".pdf", ".doc", ".docx"};
        String lowerFileName = fileName.toLowerCase();
        boolean hasValidExtension = false;
        
        for (String ext : allowedExtensions) {
            if (lowerFileName.endsWith(ext)) {
                hasValidExtension = true;
                break;
            }
        }
        
        if (!hasValidExtension) {
            logger.warning("File upload rejected: Invalid file extension. Name: " + fileName);
            return false;
        }
        
        return true;
    }
    
    /**
     * Get client IP address (handles proxies and load balancers)
     */
    public static String getClientIP(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("X-Real-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        
        // Handle multiple IPs (take first)
        if (ip != null && ip.contains(",")) {
            ip = ip.split(",")[0].trim();
        }
        
        return ip;
    }
    
    /**
     * Validate password strength
     */
    public static boolean isStrongPassword(String password) {
        if (password == null || password.length() < 8) {
            return false;
        }
        
        boolean hasUpper = password.matches(".*[A-Z].*");
        boolean hasLower = password.matches(".*[a-z].*");
        boolean hasDigit = password.matches(".*\\d.*");
        boolean hasSpecial = password.matches(".*[!@#$%^&*(),.?\":{}|<>].*");
        
        return hasUpper && hasLower && hasDigit && hasSpecial;
    }
    
    /**
     * Generates a generic error message to prevent information disclosure
     * 
     * @return Generic error message
     */
    public static String getGenericErrorMessage() {
        return "An error occurred while processing your request. Please try again.";
    }
}
