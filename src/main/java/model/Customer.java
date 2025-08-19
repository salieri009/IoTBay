package model;

import java.sql.Timestamp;

public class Customer extends User {
    private String loyaltyPoints;
    private String preferredCategory;
    private String shippingAddress;
    private String billingAddress;
    
    // Default constructor
    public Customer() {
        super();
        setRole("CUSTOMER");
    }
    
    // Constructor with all fields
    public Customer(int id, String email, String passwordHash, String firstName, 
                   String lastName, String phone, String dob, boolean isActive,
                   Timestamp createdAt, Timestamp updatedAt, String loyaltyPoints,
                   String preferredCategory, String shippingAddress, String billingAddress) {
        super(id, email, passwordHash, firstName, lastName, phone, dob, 
              isActive, createdAt, updatedAt, "CUSTOMER");
        this.loyaltyPoints = loyaltyPoints;
        this.preferredCategory = preferredCategory;
        this.shippingAddress = shippingAddress;
        this.billingAddress = billingAddress;
    }
    
    // Constructor without ID (for new customers)
    public Customer(String email, String passwordHash, String firstName, 
                   String lastName, String phone, String dob, String loyaltyPoints,
                   String preferredCategory, String shippingAddress, String billingAddress) {
        super(email, passwordHash, firstName, lastName, phone, dob, "CUSTOMER");
        this.loyaltyPoints = loyaltyPoints;
        this.preferredCategory = preferredCategory;
        this.shippingAddress = shippingAddress;
        this.billingAddress = billingAddress;
    }
    
    // Getters and Setters
    public String getLoyaltyPoints() {
        return loyaltyPoints;
    }
    
    public void setLoyaltyPoints(String loyaltyPoints) {
        this.loyaltyPoints = loyaltyPoints;
    }
    
    public String getPreferredCategory() {
        return preferredCategory;
    }
    
    public void setPreferredCategory(String preferredCategory) {
        this.preferredCategory = preferredCategory;
    }
    
    public String getShippingAddress() {
        return shippingAddress;
    }
    
    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }
    
    public String getBillingAddress() {
        return billingAddress;
    }
    
    public void setBillingAddress(String billingAddress) {
        this.billingAddress = billingAddress;
    }
    
    @Override
    public String toString() {
        return "Customer{" +
               "id=" + getId() +
               ", email='" + getEmail() + '\'' +
               ", firstName='" + getFirstName() + '\'' +
               ", lastName='" + getLastName() + '\'' +
               ", phone='" + getPhone() + '\'' +
               ", dob='" + getDob() + '\'' +
               ", isActive=" + isActive() +
               ", loyaltyPoints='" + loyaltyPoints + '\'' +
               ", preferredCategory='" + preferredCategory + '\'' +
               ", shippingAddress='" + shippingAddress + '\'' +
               ", billingAddress='" + billingAddress + '\'' +
               ", createdAt=" + getCreatedAt() +
               ", updatedAt=" + getUpdatedAt() +
               '}';
    }
}
