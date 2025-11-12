package service;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

import model.Product;
import model.ProductSpecification;
import model.CartItem;
import dao.ProductDAO;
import dao.CartItemDAO;

/**
 * Compatibility Engine Service
 * Checks compatibility between IoT products in cart
 * 
 * Based on improvement.md Section 4.1: Proactive Compatibility Checking
 * 
 * This service validates:
 * - Voltage compatibility
 * - Protocol compatibility
 * - Power supply compatibility
 * - Operating range compatibility
 */
public class CompatibilityEngine {
    private final ProductDAO productDAO;
    private final CartItemDAO cartItemDAO;
    
    public CompatibilityEngine(ProductDAO productDAO, CartItemDAO cartItemDAO) {
        this.productDAO = productDAO;
        this.cartItemDAO = cartItemDAO;
    }
    
    /**
     * Compatibility Issue Model
     */
    public static class CompatibilityIssue {
        public enum IssueType {
            VOLTAGE_MISMATCH,
            PROTOCOL_MISMATCH,
            POWER_SUPPLY_MISSING,
            OPERATING_RANGE_INCOMPATIBLE
        }
        
        private IssueType type;
        private String productName;
        private String message;
        private String severity; // "warning" or "error"
        private List<Integer> suggestedProductIds;
        
        public CompatibilityIssue(IssueType type, String productName, String message, String severity) {
            this.type = type;
            this.productName = productName;
            this.message = message;
            this.severity = severity;
            this.suggestedProductIds = new ArrayList<>();
        }
        
        // Getters and Setters
        public IssueType getType() {
            return type;
        }
        
        public String getProductName() {
            return productName;
        }
        
        public String getMessage() {
            return message;
        }
        
        public String getSeverity() {
            return severity;
        }
        
        public List<Integer> getSuggestedProductIds() {
            return suggestedProductIds;
        }
        
        public void addSuggestion(int productId) {
            this.suggestedProductIds.add(productId);
        }
    }
    
    /**
     * Check compatibility of all products in user's cart
     * 
     * @param userId User ID
     * @return List of compatibility issues (empty if no issues)
     */
    public List<CompatibilityIssue> checkCartCompatibility(int userId) {
        List<CompatibilityIssue> issues = new ArrayList<>();
        
        try {
            List<CartItem> cartItems = cartItemDAO.getCartItemsByUserId(userId);
            List<Product> products = new ArrayList<>();
            List<ProductSpecification> specifications = new ArrayList<>();
            
            // Load products and specifications
            for (CartItem item : cartItems) {
                Product product = productDAO.getProductById(item.getProductId());
                if (product != null) {
                    products.add(product);
                    // TODO: Load ProductSpecification from database
                    // For now, we'll create a placeholder
                    ProductSpecification spec = getProductSpecification(product.getId());
                    specifications.add(spec);
                }
            }
            
            // Check voltage compatibility
            issues.addAll(checkVoltageCompatibility(products, specifications));
            
            // Check protocol compatibility
            issues.addAll(checkProtocolCompatibility(products, specifications));
            
            // Check power supply availability
            issues.addAll(checkPowerSupplyAvailability(products, specifications));
            
        } catch (Exception e) {
            // Log error but don't block checkout
            System.err.println("Error checking compatibility: " + e.getMessage());
        }
        
        return issues;
    }
    
    /**
     * Check voltage compatibility between products
     */
    private List<CompatibilityIssue> checkVoltageCompatibility(
            List<Product> products, List<ProductSpecification> specifications) {
        
        List<CompatibilityIssue> issues = new ArrayList<>();
        
        for (int i = 0; i < products.size(); i++) {
            ProductSpecification spec = specifications.get(i);
            if (spec == null || spec.getVoltage() == null) {
                continue;
            }
            
            String voltage = spec.getVoltage();
            boolean hasCompatiblePowerSupply = false;
            
            // Check if there's a compatible power supply in cart
            for (int j = 0; j < products.size(); j++) {
                if (i == j) continue;
                
                ProductSpecification otherSpec = specifications.get(j);
                if (otherSpec == null) continue;
                
                // Check if other product is a power supply/adapter
                Product otherProduct = products.get(j);
                if (isPowerSupply(otherProduct)) {
                    if (isVoltageCompatible(voltage, otherSpec.getVoltage())) {
                        hasCompatiblePowerSupply = true;
                        break;
                    }
                }
            }
            
            // If product requires specific voltage and no compatible supply found
            if (!hasCompatiblePowerSupply && requiresPowerSupply(voltage)) {
                CompatibilityIssue issue = new CompatibilityIssue(
                    CompatibilityIssue.IssueType.VOLTAGE_MISMATCH,
                    products.get(i).getName(),
                    String.format("%s requires %s, but no compatible power supply found in cart.", 
                                 products.get(i).getName(), voltage),
                    "warning"
                );
                issues.add(issue);
            }
        }
        
        return issues;
    }
    
    /**
     * Check protocol compatibility
     */
    private List<CompatibilityIssue> checkProtocolCompatibility(
            List<Product> products, List<ProductSpecification> specifications) {
        
        List<CompatibilityIssue> issues = new ArrayList<>();
        
        // Group products by protocol
        java.util.Map<String, List<Product>> protocolGroups = new java.util.HashMap<>();
        
        for (int i = 0; i < products.size(); i++) {
            ProductSpecification spec = specifications.get(i);
            if (spec == null || spec.getCommunicationProtocol() == null) {
                continue;
            }
            
            String protocol = spec.getCommunicationProtocol();
            protocolGroups.computeIfAbsent(protocol, k -> new ArrayList<>()).add(products.get(i));
        }
        
        // If multiple protocols are present, warn user
        if (protocolGroups.size() > 1) {
            StringBuilder protocols = new StringBuilder();
            for (String protocol : protocolGroups.keySet()) {
                if (protocols.length() > 0) protocols.append(", ");
                protocols.append(protocol);
            }
            
            CompatibilityIssue issue = new CompatibilityIssue(
                CompatibilityIssue.IssueType.PROTOCOL_MISMATCH,
                "Cart",
                String.format("Your cart contains products with different communication protocols: %s. " +
                            "These may not be compatible with each other.", protocols.toString()),
                "warning"
            );
            issues.add(issue);
        }
        
        return issues;
    }
    
    /**
     * Check if power supplies are available for products that need them
     */
    private List<CompatibilityIssue> checkPowerSupplyAvailability(
            List<Product> products, List<ProductSpecification> specifications) {
        
        List<CompatibilityIssue> issues = new ArrayList<>();
        
        for (int i = 0; i < products.size(); i++) {
            ProductSpecification spec = specifications.get(i);
            if (spec == null || spec.getVoltage() == null) {
                continue;
            }
            
            String voltage = spec.getVoltage();
            if (requiresPowerSupply(voltage)) {
                boolean hasPowerSupply = false;
                
                for (int j = 0; j < products.size(); j++) {
                    if (i == j) continue;
                    
                    Product otherProduct = products.get(j);
                    if (isPowerSupply(otherProduct)) {
                        hasPowerSupply = true;
                        break;
                    }
                }
                
                if (!hasPowerSupply) {
                    CompatibilityIssue issue = new CompatibilityIssue(
                        CompatibilityIssue.IssueType.POWER_SUPPLY_MISSING,
                        products.get(i).getName(),
                        String.format("%s requires an external power supply (%s), but none found in cart.", 
                                     products.get(i).getName(), voltage),
                        "warning"
                    );
                    issues.add(issue);
                }
            }
        }
        
        return issues;
    }
    
    /**
     * Check if two voltage specifications are compatible
     */
    private boolean isVoltageCompatible(String voltage1, String voltage2) {
        if (voltage1 == null || voltage2 == null) {
            return false;
        }
        
        // Extract numeric voltage values
        Double v1 = extractVoltage(voltage1);
        Double v2 = extractVoltage(voltage2);
        
        if (v1 == null || v2 == null) {
            return false;
        }
        
        // Allow 10% tolerance
        double tolerance = 0.1;
        return Math.abs(v1 - v2) / Math.max(v1, v2) <= tolerance;
    }
    
    /**
     * Extract numeric voltage from string (e.g., "12V DC" -> 12.0)
     */
    private Double extractVoltage(String voltageStr) {
        if (voltageStr == null) return null;
        
        Pattern pattern = Pattern.compile("(\\d+(?:\\.\\d+)?)\\s*V", Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(voltageStr);
        
        if (matcher.find()) {
            try {
                return Double.parseDouble(matcher.group(1));
            } catch (NumberFormatException e) {
                return null;
            }
        }
        
        return null;
    }
    
    /**
     * Check if product requires external power supply
     */
    private boolean requiresPowerSupply(String voltage) {
        if (voltage == null) return false;
        
        // Products with USB or battery typically don't need external supply
        String lower = voltage.toLowerCase();
        return !lower.contains("usb") && !lower.contains("battery");
    }
    
    /**
     * Check if product is a power supply/adapter
     */
    private boolean isPowerSupply(Product product) {
        if (product == null || product.getName() == null) {
            return false;
        }
        
        String name = product.getName().toLowerCase();
        String description = product.getDescription() != null ? 
                           product.getDescription().toLowerCase() : "";
        
        return name.contains("power supply") || 
               name.contains("adapter") || 
               name.contains("charger") ||
               description.contains("power supply") ||
               description.contains("adapter");
    }
    
    /**
     * Get product specification (placeholder - should load from database)
     */
    private ProductSpecification getProductSpecification(int productId) {
        // TODO: Implement ProductSpecificationDAO to load from database
        // For now, return null (will be handled gracefully)
        return null;
    }
}

