package utils;

import java.util.regex.Pattern;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.math.BigDecimal;

public class InputValidator {
    
    // Email validation pattern
    private static final Pattern EMAIL_PATTERN = Pattern.compile(
        "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$"
    );
    
    // Phone validation pattern (allows various formats)
    private static final Pattern PHONE_PATTERN = Pattern.compile(
        "^[\\+]?[1-9]?[0-9]{7,15}$"
    );
    
    // Name validation pattern (allows letters, spaces, hyphens, apostrophes)
    private static final Pattern NAME_PATTERN = Pattern.compile(
        "^[a-zA-Z\\s\\-']{2,50}$"
    );
    
    // Password validation (at least 8 characters, 1 uppercase, 1 lowercase, 1 digit)
    private static final Pattern PASSWORD_PATTERN = Pattern.compile(
        "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d@$!%*?&]{8,}$"
    );
    
    // Address validation
    private static final Pattern ADDRESS_PATTERN = Pattern.compile(
        "^[a-zA-Z0-9\\s\\-',./]{5,200}$"
    );
    
    // Date formatter
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    
    /**
     * Validate email address
     */
    public static boolean isValidEmail(String email) {
        return email != null && !email.trim().isEmpty() && EMAIL_PATTERN.matcher(email).matches();
    }
    
    /**
     * Validate phone number
     */
    public static boolean isValidPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return false;
        }
        // Remove spaces and dashes for validation
        String cleanPhone = phone.replaceAll("[\\s\\-()]", "");
        return PHONE_PATTERN.matcher(cleanPhone).matches();
    }
    
    /**
     * Validate name (first name, last name)
     */
    public static boolean isValidName(String name) {
        return name != null && !name.trim().isEmpty() && NAME_PATTERN.matcher(name.trim()).matches();
    }
    
    /**
     * Validate password
     */
    public static boolean isValidPassword(String password) {
        return password != null && PASSWORD_PATTERN.matcher(password).matches();
    }
    
    /**
     * Validate address
     */
    public static boolean isValidAddress(String address) {
        return address != null && !address.trim().isEmpty() && ADDRESS_PATTERN.matcher(address.trim()).matches();
    }
    
    /**
     * Validate date of birth
     */
    public static boolean isValidDateOfBirth(String dob) {
        if (dob == null || dob.trim().isEmpty()) {
            return false;
        }
        
        try {
            LocalDate birthDate = LocalDate.parse(dob, DATE_FORMATTER);
            LocalDate now = LocalDate.now();
            
            // Check if date is in the future
            if (birthDate.isAfter(now)) {
                return false;
            }
            
            // Check if age is reasonable (between 13 and 120 years)
            LocalDate minDate = now.minusYears(120);
            LocalDate maxDate = now.minusYears(13);
            
            return !birthDate.isBefore(minDate) && !birthDate.isAfter(maxDate);
        } catch (DateTimeParseException e) {
            return false;
        }
    }
    
    /**
     * Validate price (must be positive)
     */
    public static boolean isValidPrice(BigDecimal price) {
        return price != null && price.compareTo(BigDecimal.ZERO) > 0;
    }
    
    /**
     * Validate quantity (must be non-negative integer)
     */
    public static boolean isValidQuantity(Integer quantity) {
        return quantity != null && quantity >= 0;
    }
    
    /**
     * Validate stock quantity (must be non-negative integer)
     */
    public static boolean isValidStockQuantity(Integer stockQuantity) {
        return stockQuantity != null && stockQuantity >= 0;
    }
    
    /**
     * Validate product name
     */
    public static boolean isValidProductName(String productName) {
        return productName != null && !productName.trim().isEmpty() && 
               productName.trim().length() >= 2 && productName.trim().length() <= 100;
    }
    
    /**
     * Validate product description
     */
    public static boolean isValidProductDescription(String description) {
        return description != null && !description.trim().isEmpty() && 
               description.trim().length() >= 10 && description.trim().length() <= 1000;
    }
    
    /**
     * Validate category
     */
    public static boolean isValidCategory(String category) {
        return category != null && !category.trim().isEmpty() && 
               category.trim().length() >= 2 && category.trim().length() <= 50;
    }
    
    /**
     * Validate user ID (must be positive integer)
     */
    public static boolean isValidUserId(Integer userId) {
        return userId != null && userId > 0;
    }
    
    /**
     * Validate product ID (must be positive integer)
     */
    public static boolean isValidProductId(Integer productId) {
        return productId != null && productId > 0;
    }
    
    /**
     * Validate order ID (must be positive integer)
     */
    public static boolean isValidOrderId(Integer orderId) {
        return orderId != null && orderId > 0;
    }
    
    /**
     * Validate date range
     */
    public static boolean isValidDateRange(LocalDate startDate, LocalDate endDate) {
        if (startDate == null || endDate == null) {
            return false;
        }
        return !endDate.isBefore(startDate);
    }
    
    /**
     * Validate order status
     */
    public static boolean isValidOrderStatus(String status) {
        if (status == null || status.trim().isEmpty()) {
            return false;
        }
        String[] validStatuses = {"PENDING", "CONFIRMED", "SHIPPED", "DELIVERED", "CANCELLED"};
        for (String validStatus : validStatuses) {
            if (validStatus.equalsIgnoreCase(status.trim())) {
                return true;
            }
        }
        return false;
    }
    
    /**
     * Validate payment method
     */
    public static boolean isValidPaymentMethod(String paymentMethod) {
        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            return false;
        }
        String[] validMethods = {"CREDIT_CARD", "DEBIT_CARD", "PAYPAL", "BANK_TRANSFER"};
        for (String validMethod : validMethods) {
            if (validMethod.equalsIgnoreCase(paymentMethod.trim())) {
                return true;
            }
        }
        return false;
    }
    
    /**
     * Sanitize string input (remove HTML tags and trim)
     */
    public static String sanitizeString(String input) {
        if (input == null) {
            return null;
        }
        // Remove HTML tags and trim whitespace
        return input.replaceAll("<[^>]*>", "").trim();
    }
    
    /**
     * Parse integer safely
     */
    public static Integer parseInteger(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return null;
        }
    }
    
    /**
     * Parse BigDecimal safely
     */
    public static BigDecimal parseBigDecimal(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        try {
            return new BigDecimal(value.trim());
        } catch (NumberFormatException e) {
            return null;
        }
    }
    
    /**
     * Parse LocalDate safely
     */
    public static LocalDate parseLocalDate(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        try {
            return LocalDate.parse(value.trim(), DATE_FORMATTER);
        } catch (DateTimeParseException e) {
            return null;
        }
    }
    
    /**
     * Validate and sanitize string input with field name
     */
    public static String validateAndSanitize(String input, String fieldName) {
        if (input == null || input.trim().isEmpty()) {
            return null;
        }
        return sanitizeString(input);
    }
}
