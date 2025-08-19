package model;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

public class CartItem implements Serializable {
    private int id;
    private int userId;
    private int productId;
    private int quantity;
    private BigDecimal price; 
    private LocalDateTime addedAt;
    private LocalDateTime updatedAt;

    // Default constructor
    public CartItem() {
        this.addedAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
        this.price = BigDecimal.ZERO;
    }

    // Constructor with BigDecimal
    public CartItem(int userId, int productId, int quantity, BigDecimal price, LocalDateTime addedAt) {
        this.userId = userId;
        this.productId = productId;
        this.quantity = quantity;
        this.price = price; 
        this.addedAt = addedAt;
        this.updatedAt = LocalDateTime.now();
    }

    // Legacy constructor for backward compatibility
    public CartItem(int userId, int productId, int quantity, double price, LocalDateTime addedAt) {
        this.userId = userId;
        this.productId = productId;
        this.quantity = quantity;
        this.price = BigDecimal.valueOf(price); 
        this.addedAt = addedAt;
        this.updatedAt = LocalDateTime.now();
    }

    // Constructor with all fields
    public CartItem(int id, int userId, int productId, int quantity, BigDecimal price, 
                   LocalDateTime addedAt, LocalDateTime updatedAt) {
        this.id = id;
        this.userId = userId;
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
        this.addedAt = addedAt;
        this.updatedAt = updatedAt;
    }

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
        this.updatedAt = LocalDateTime.now();
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
        this.updatedAt = LocalDateTime.now();
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
        this.updatedAt = LocalDateTime.now();
    }

    public BigDecimal getPrice() {
        return price; 
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
        this.updatedAt = LocalDateTime.now();
    }

    // Legacy setter for backward compatibility
    public void setPrice(double price) {
        this.price = BigDecimal.valueOf(price);
        this.updatedAt = LocalDateTime.now();
    }

    public LocalDateTime getAddedAt() {
        return addedAt;
    }

    public void setAddedAt(LocalDateTime addedAt) {
        this.addedAt = addedAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    // Method to calculate subtotal
    public BigDecimal getSubtotal() {
        return price.multiply(BigDecimal.valueOf(quantity));
    }

    // Legacy method for backward compatibility
    public double getSubtotal(double price) {
        return price * quantity;
    }

    @Override
    public String toString() {
        return "CartItem{" +
                "id=" + id +
                ", userId=" + userId +
                ", productId=" + productId +
                ", quantity=" + quantity +
                ", price=" + price +
                ", addedAt=" + addedAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}
