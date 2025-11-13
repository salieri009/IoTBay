package model;

import java.io.Serializable;

/**
 * Trust Badge Model
 * Represents trust indicators for products (certifications, compatibility, etc.)
 * 
 * Based on improvement.md recommendations for enhanced trust signals
 */
public class TrustBadge implements Serializable {
    public enum BadgeType {
        CERTIFICATION, // CE, FCC, RoHS, etc.
        COMPATIBILITY, // Works with: Home Assistant, AWS IoT, etc.
        STOCK_RELIABILITY, // In Stock 95% of time
        SUPPORT_LEVEL, // 24/7, Business Hours, Community
        WARRANTY // 2-Year, Lifetime, etc.
    }
    
    private int id;
    private int productId;
    private BadgeType type;
    private String label; // e.g., "CE Certified", "Works with Home Assistant"
    private String description; // Detailed description
    private String iconUrl; // URL to badge icon
    private boolean isActive;
    
    // Default constructor
    public TrustBadge() {
        this.isActive = true;
    }
    
    // Constructor
    public TrustBadge(int productId, BadgeType type, String label, String description) {
        this.productId = productId;
        this.type = type;
        this.label = label;
        this.description = description;
        this.isActive = true;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getProductId() {
        return productId;
    }
    
    public void setProductId(int productId) {
        this.productId = productId;
    }
    
    public BadgeType getType() {
        return type;
    }
    
    public void setType(BadgeType type) {
        this.type = type;
    }
    
    public String getLabel() {
        return label;
    }
    
    public void setLabel(String label) {
        this.label = label;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getIconUrl() {
        return iconUrl;
    }
    
    public void setIconUrl(String iconUrl) {
        this.iconUrl = iconUrl;
    }
    
    public boolean isActive() {
        return isActive;
    }
    
    public void setActive(boolean active) {
        isActive = active;
    }
    
    @Override
    public String toString() {
        return "TrustBadge{" +
                "id=" + id +
                ", productId=" + productId +
                ", type=" + type +
                ", label='" + label + '\'' +
                ", description='" + description + '\'' +
                ", isActive=" + isActive +
                '}';
    }
}

