package utils;

import java.io.*;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.ArrayList;
import java.util.Arrays;

import model.User;
import model.AccessLog;
import model.Order;
import model.Product;

public class CSVUtil {
    private static final String CSV_SEPARATOR = ",";
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    
    // Generate CSV content for users
    public static String generateUserCSV(List<User> users) {
        StringBuilder csvContent = new StringBuilder();
        // Header
        csvContent.append("ID,Email,First Name,Last Name,Phone,DOB,Is Active,Created At,Updated At\n");
        
        for (User user : users) {
            csvContent.append(user.getId()).append(CSV_SEPARATOR)
                     .append(escapeCSV(user.getEmail())).append(CSV_SEPARATOR)
                     .append(escapeCSV(user.getFirstName())).append(CSV_SEPARATOR)
                     .append(escapeCSV(user.getLastName())).append(CSV_SEPARATOR)
                     .append(escapeCSV(user.getPhone())).append(CSV_SEPARATOR)
                     .append(user.getDob() != null ? user.getDob().toString() : "").append(CSV_SEPARATOR)
                     .append(user.isActive()).append(CSV_SEPARATOR)
                     .append(formatTimestamp(user.getCreatedAt())).append(CSV_SEPARATOR)
                     .append(formatTimestamp(user.getUpdatedAt())).append("\n");
        }
        
        return csvContent.toString();
    }
    
    // Generate CSV content for access logs
    public static String generateAccessLogCSV(List<AccessLog> accessLogs) {
        StringBuilder csvContent = new StringBuilder();
        // Header
        csvContent.append("ID,User ID,Action,IP Address,User Agent,Timestamp\n");
        
        for (AccessLog log : accessLogs) {
            csvContent.append(log.getId()).append(CSV_SEPARATOR)
                     .append(log.getUserId()).append(CSV_SEPARATOR)
                     .append(escapeCSV(log.getAction())).append(CSV_SEPARATOR)
                     .append(escapeCSV(log.getIpAddress())).append(CSV_SEPARATOR)
                     .append(escapeCSV(log.getUserAgent())).append(CSV_SEPARATOR)
                     .append(formatLocalDateTime(log.getTimestamp())).append("\n");
        }
        
        return csvContent.toString();
    }
    
    // Generate CSV content for orders
    public static String generateOrderCSV(List<Order> orders) {
        StringBuilder csvContent = new StringBuilder();
        // Header
        csvContent.append("ID,User ID,Total Amount,Order Date,Status,Shipping Address,Payment Method\n");
        
        for (Order order : orders) {
            csvContent.append(order.getId()).append(CSV_SEPARATOR)
                     .append(order.getUserId()).append(CSV_SEPARATOR)
                     .append(order.getTotalAmount()).append(CSV_SEPARATOR)
                     .append(formatLocalDateTime(order.getOrderDateTime())).append(CSV_SEPARATOR)
                     .append(escapeCSV(order.getStatus())).append(CSV_SEPARATOR)
                     .append(escapeCSV(order.getShippingAddress())).append(CSV_SEPARATOR)
                     .append(escapeCSV(order.getPaymentMethod())).append("\n");
        }
        
        return csvContent.toString();
    }
    
    // Generate CSV content for products
    public static String generateProductCSV(List<Product> products) {
        StringBuilder csvContent = new StringBuilder();
        // Header
        csvContent.append("ID,Name,Category,Price,Stock Quantity,Description\n");
        
        for (Product product : products) {
            csvContent.append(product.getId()).append(CSV_SEPARATOR)
                     .append(escapeCSV(product.getName())).append(CSV_SEPARATOR)
                     .append(escapeCSV(product.getCategory())).append(CSV_SEPARATOR)
                     .append(product.getPrice()).append(CSV_SEPARATOR)
                     .append(product.getStockQuantity()).append(CSV_SEPARATOR)
                     .append(escapeCSV(product.getDescription())).append("\n");
        }
        
        return csvContent.toString();
    }
    
    // Parse CSV content and return list of string arrays
    public static List<String[]> parseCSV(String csvContent) {
        List<String[]> records = new ArrayList<>();
        
        if (csvContent == null || csvContent.trim().isEmpty()) {
            return records;
        }
        
        String[] lines = csvContent.split("\n");
        for (String line : lines) {
            if (line.trim().isEmpty()) {
                continue;
            }
            records.add(parseCSVLine(line));
        }
        
        return records;
    }
    
    // Parse a single CSV line
    private static String[] parseCSVLine(String csvLine) {
        List<String> fields = new ArrayList<>();
        boolean inQuotes = false;
        StringBuilder currentField = new StringBuilder();
        
        for (int i = 0; i < csvLine.length(); i++) {
            char c = csvLine.charAt(i);
            
            if (c == '"') {
                inQuotes = !inQuotes;
            } else if (c == ',' && !inQuotes) {
                fields.add(currentField.toString());
                currentField = new StringBuilder();
            } else {
                currentField.append(c);
            }
        }
        
        fields.add(currentField.toString());
        return fields.toArray(new String[0]);
    }
    
    // Escape CSV field
    private static String escapeCSV(String value) {
        if (value == null) {
            return "";
        }
        
        if (value.contains(",") || value.contains("\"") || value.contains("\n")) {
            return "\"" + value.replace("\"", "\"\"") + "\"";
        }
        
        return value;
    }
    
    // Format timestamp for CSV
    private static String formatTimestamp(Timestamp timestamp) {
        if (timestamp == null) {
            return "";
        }
        return timestamp.toLocalDateTime().format(DATE_FORMATTER);
    }
    
    // Validate CSV headers
    public static boolean validateCSVHeaders(String[] actualHeaders, String[] expectedHeaders) {
        if (actualHeaders.length != expectedHeaders.length) {
            return false;
        }
        
        for (int i = 0; i < actualHeaders.length; i++) {
            if (!actualHeaders[i].trim().equalsIgnoreCase(expectedHeaders[i])) {
                return false;
            }
        }
        
        return true;
    }

    // Helper method to format LocalDateTime
    private static String formatLocalDateTime(LocalDateTime dateTime) {
        if (dateTime == null) {
            return "";
        }
        return dateTime.toString();
    }
}
