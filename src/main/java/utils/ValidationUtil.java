package utils;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.regex.Pattern;

public class ValidationUtil {

    // String validation method
    public static boolean isValidString(String str) {
        return str != null && !str.trim().isEmpty();
    }

    // Name validation (English, Korean, spaces, hyphens allowed)
    public static String validateName(String name, String fieldName) {
        if (name == null || name.trim().isEmpty()) {
            return fieldName + " cannot be empty.";
        }
        if (name.length() > 30) {
            return fieldName + " must be under 30 characters.";
        }
        if (!name.matches("^[a-zA-Z가-힣\\s'-]{2,30}$")) {
            return fieldName + " contains invalid characters.";
        }
        return null;
    }

    // Australian phone number validation
    public static String validateAustralianPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return "Phone number cannot be empty.";
        }
        if (!phone.matches("^(\\+614|04)\\d{8}$")) {
            return "Phone number must be in valid Australian format (e.g., 04XXXXXXXX or +614XXXXXXXX).";
        }
        return null;
    }

    // Email validation
    public static String validateEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return "Email cannot be empty.";
        }
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        if (!email.matches(emailRegex)) {
            return "Invalid email format.";
        }
        return null;
    }

    // Password validation
    public static String validatePasswordChange(String newPassword, String confirmPassword) {
        if (newPassword == null || newPassword.trim().isEmpty()) {
            return "New password cannot be empty.";
        }
        if (!newPassword.equals(confirmPassword)) {
            return "New password and confirm password do not match.";
        }
        if (newPassword.length() < 8) {
            return "Password should be at least 8 characters long.";
        }
        if (!newPassword.matches(".*[A-Z].*")) {
            return "Password must contain at least one uppercase letter.";
        }
        if (!newPassword.matches(".*[a-z].*")) {
            return "Password must contain at least one lowercase letter.";
        }
        if (!newPassword.matches(".*\\d.*")) {
            return "Password must contain at least one digit.";
        }
        if (!newPassword.matches(".*[!@#$%^&*(),.?\":{}|<>].*")) {
            return "Password must include at least one special character.";
        }
        return null;
    }

    // Australian postal code validation (4 digits)
    public static String validateAustralianPostalCode(String postalCode) {
        if (postalCode == null || postalCode.trim().isEmpty()) {
            return "Postal code cannot be empty.";
        }
        if (!postalCode.matches("^\\d{4}$")) {
            return "Postal code must be a 4-digit number.";
        }
        return null;
    }

    // Address line 1 validation
    public static String validateAddress(String address) {
        if (address == null || address.trim().isEmpty()) {
            return "Address cannot be empty.";
        }
        if (address.length() > 100) {
            return "Address must be under 100 characters.";
        }
        return null;
    }

    // Date of birth validation
    public static String validateBirthDate(String birthDate) {
        if (birthDate == null || birthDate.trim().isEmpty()) {
            return "Birth date cannot be empty.";
        }
        try {
            LocalDate parsed = LocalDate.parse(birthDate);
            if (parsed.isAfter(LocalDate.now())) {
                return "Birth date cannot be in the future.";
            }
        } catch (DateTimeParseException e) {
            return "Invalid date format. Use YYYY-MM-DD.";
        }
        return null;
    }

    // User registration profile validation
    public static String validateRegisterUserProfile(
        String firstName, String lastName, String phone, String postalCode, String addressLine1
    ) {
        String firstError = validateName(firstName, "First name");
        if (firstError != null) return firstError;

        String lastError = validateName(lastName, "Last name");
        if (lastError != null) return lastError;

        String phoneError = validateAustralianPhone(phone);
        if (phoneError != null) return phoneError;

        String postalError = validateAustralianPostalCode(postalCode);
        if (postalError != null) return postalError;

        String addressError = validateAddress(addressLine1);
        if (addressError != null) return addressError;

        return null;
    }

    // Payment amount validation
    public static String validatePaymentAmount(String amountStr) {
        if (amountStr == null || amountStr.trim().isEmpty()) {
            return "Amount cannot be empty.";
        }
        try {
            double amount = Double.parseDouble(amountStr);
            if (amount <= 0) {
                return "Amount must be greater than zero.";
            }
        } catch (NumberFormatException e) {
            return "Amount must be a valid number.";
        }
        return null;
    }

    // Payment method validation (e.g., Credit Card, PayPal, Bank Transfer)
    public static String validatePaymentMethod(String method) {
        if (method == null || method.trim().isEmpty()) {
            return "Payment method cannot be empty.";
        }
        String[] validMethods = {"Credit Card", "PayPal", "Bank Transfer"};
        for (String valid : validMethods) {
            if (valid.equalsIgnoreCase(method.trim())) {
                return null;
            }
        }
        return "Invalid payment method. Valid methods: Credit Card, PayPal, Bank Transfer.";
    }

    // Payment status validation (e.g., Pending, Completed, Failed)
    public static String validatePaymentStatus(String status) {
        if (status == null || status.trim().isEmpty()) {
            return "Payment status cannot be empty.";
        }
        String[] validStatuses = {"Pending", "Completed", "Failed"};
        for (String valid : validStatuses) {
            if (valid.equalsIgnoreCase(status.trim())) {
                return null;
            }
        }
        return "Invalid payment status. Valid statuses: Pending, Completed, Failed.";
    }

    // Complete payment validation
    public static String validatePayment(String amountStr, String method, String status) {
        String amountError = validatePaymentAmount(amountStr);
        if (amountError != null) return amountError;

        String methodError = validatePaymentMethod(method);
        if (methodError != null) return methodError;

        String statusError = validatePaymentStatus(status);
        if (statusError != null) return statusError;

        return null;
    }

    // Payment validation
    public static String validatePayment(String amount, String paymentMethod,
                                       String cardNumber, String expiryDate, String cvv) {
        if (!isValidAmount(amount)) {
            return "Invalid payment amount";
        }

        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            return "Payment method is required";
        }

        if ("CREDIT_CARD".equals(paymentMethod) || "DEBIT_CARD".equals(paymentMethod)) {
            if (!isValidCardNumber(cardNumber)) {
                return "Invalid card number";
            }
            if (!isValidExpiryDate(expiryDate)) {
                return "Invalid expiry date";
            }
            if (!isValidCVV(cvv)) {
                return "Invalid CVV";
            }
        }

        return null; // Valid
    }

    // Shipment validation
    public static String validateShipment(String shipmentMethod, String address, String shipmentDate) {
        if (shipmentMethod == null || shipmentMethod.trim().isEmpty()) {
            return "Shipment method is required";
        }

        if (address == null || address.trim().length() < 10) {
            return "Valid address is required (minimum 10 characters)";
        }

        if (shipmentDate != null && !shipmentDate.trim().isEmpty()) {
            try {
                LocalDate.parse(shipmentDate);
            } catch (DateTimeParseException e) {
                return "Invalid shipment date format";
            }
        }

        return null; // Valid
    }

    // Review validation
    public static String validateReview(String rating, String comment, String title) {
        if (rating == null || rating.trim().isEmpty()) {
            return "Rating is required";
        }

        try {
            int ratingValue = Integer.parseInt(rating);
            if (ratingValue < 1 || ratingValue > 5) {
                return "Rating must be between 1 and 5";
            }
        } catch (NumberFormatException e) {
            return "Invalid rating format";
        }

        if (comment != null && comment.trim().length() > 1000) {
            return "Comment must be less than 1000 characters";
        }

        if (title != null && title.trim().length() > 100) {
            return "Title must be less than 100 characters";
        }

        return null; // Valid
    }

    // Utility validation methods
    public static boolean isValidAmount(String amount) {
        if (amount == null || amount.trim().isEmpty()) {
            return false;
        }

        try {
            BigDecimal value = new BigDecimal(amount);
            return value.compareTo(BigDecimal.ZERO) > 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    public static boolean isValidCardNumber(String cardNumber) {
        if (cardNumber == null) return false;

        // Remove spaces and dashes
        String cleaned = cardNumber.replaceAll("[\\s-]", "");

        // Check if it's all digits and appropriate length
        return cleaned.matches("\\d{13,19}");
    }

    public static boolean isValidExpiryDate(String expiryDate) {
        if (expiryDate == null) return false;

        // Expect MM/YY or MM/YYYY format
        Pattern pattern = Pattern.compile("^(0[1-9]|1[0-2])/([0-9]{2}|[0-9]{4})$");
        return pattern.matcher(expiryDate).matches();
    }

    public static boolean isValidCVV(String cvv) {
        if (cvv == null) return false;

        // CVV should be 3 or 4 digits
        return cvv.matches("\\d{3,4}");
    }
}
