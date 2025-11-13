package utils;

import javax.servlet.http.HttpServletRequest;
import java.util.logging.Logger;

/**
 * Security utility class for input validation and sanitization
 * Provides secure parameter extraction and validation methods
 * 
 * @author IoTBay Security Team
 * @version 2.0
 */
public final class SecurityUtil {
    
    private static final Logger logger = Logger.getLogger(SecurityUtil.class.getName());
    
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
     * Sanitizes string input to prevent XSS attacks
     * 
     * @param input Input string to sanitize
     * @return Sanitized string
     */
    public static String sanitizeInput(String input) {
        if (input == null) {
            return null;
        }
        
        return input.replaceAll("[<>\"'&]", "")
                   .replaceAll("script", "")
                   .replaceAll("javascript:", "")
                   .trim();
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
