package service;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

import dao.CartItemDAO;
import dao.ProductDAO;
import model.CartItem;
import model.Product;

/**
 * Cart Service
 * Business logic for shopping cart operations with compatibility checking
 * 
 * Based on improvement.md recommendations for:
 * - Optimistic UI updates (Section 3.1)
 * - Compatibility checking (Section 4.1)
 * - Error recovery (Section 4.3)
 */
public class CartService {
    private final CartItemDAO cartItemDAO;
    private final ProductDAO productDAO;
    private final CompatibilityEngine compatibilityEngine;
    
    public CartService(CartItemDAO cartItemDAO, ProductDAO productDAO) {
        this.cartItemDAO = cartItemDAO;
        this.productDAO = productDAO;
        this.compatibilityEngine = new CompatibilityEngine(productDAO, cartItemDAO);
    }
    
    /**
     * Add product to cart with validation and compatibility checking
     * 
     * @param userId User ID
     * @param productId Product ID
     * @param quantity Quantity to add
     * @return CartOperationResult with success status and any compatibility warnings
     */
    public CartOperationResult addToCart(int userId, int productId, int quantity) throws SQLException {
        CartOperationResult result = new CartOperationResult();
        
        // 1. Validate product exists
        Product product = productDAO.getProductById(productId);
        if (product == null) {
            result.setSuccess(false);
            result.setErrorMessage("Product not found");
            return result;
        }
        
        // 2. Validate stock availability
        if (product.getStockQuantity() < quantity) {
            result.setSuccess(false);
            result.setErrorMessage("Insufficient stock available");
            return result;
        }
        
        // 3. Check if item already in cart
        CartItem existingItem = cartItemDAO.getCartItem(userId, productId);
        
        if (existingItem != null) {
            int updatedQuantity = existingItem.getQuantity() + quantity;
            if (product.getStockQuantity() < updatedQuantity) {
                result.setSuccess(false);
                result.setErrorMessage("Insufficient stock for updated quantity");
                return result;
            }
            cartItemDAO.updateCartItemQuantity(userId, productId, updatedQuantity);
        } else {
            CartItem newItem = new CartItem();
            newItem.setUserId(userId);
            newItem.setProductId(productId);
            newItem.setQuantity(quantity);
            newItem.setPrice(BigDecimal.valueOf(product.getPrice()));
            newItem.setAddedAt(LocalDateTime.now());
            
            cartItemDAO.addCartItem(newItem);
        }
        
        // 4. Check compatibility after adding
        List<CompatibilityEngine.CompatibilityIssue> issues = 
            compatibilityEngine.checkCartCompatibility(userId);
        result.setCompatibilityIssues(issues);
        
        result.setSuccess(true);
        result.setMessage("Product added to cart successfully");
        
        return result;
    }
    
    /**
     * Update cart item quantity
     */
    public CartOperationResult updateCartItem(int userId, int productId, int quantity) throws SQLException {
        CartOperationResult result = new CartOperationResult();
        
        if (quantity < 0) {
            result.setSuccess(false);
            result.setErrorMessage("Quantity cannot be negative");
            return result;
        }
        
        if (!cartItemDAO.isProductInCart(userId, productId)) {
            result.setSuccess(false);
            result.setErrorMessage("Item not found in cart");
            return result;
        }
        
        if (quantity == 0) {
            cartItemDAO.deleteCartItem(userId, productId);
            result.setSuccess(true);
            result.setMessage("Item removed from cart");
            return result;
        }
        
        // Validate stock
        Product product = productDAO.getProductById(productId);
        if (product != null && product.getStockQuantity() < quantity) {
            result.setSuccess(false);
            result.setErrorMessage("Insufficient stock available");
            return result;
        }
        
        cartItemDAO.updateCartItemQuantity(userId, productId, quantity);
        
        // Re-check compatibility
        List<CompatibilityEngine.CompatibilityIssue> issues = 
            compatibilityEngine.checkCartCompatibility(userId);
        result.setCompatibilityIssues(issues);
        
        result.setSuccess(true);
        result.setMessage("Cart updated successfully");
        
        return result;
    }
    
    /**
     * Remove item from cart
     */
    public CartOperationResult removeFromCart(int userId, int productId) throws SQLException {
        CartOperationResult result = new CartOperationResult();
        
        if (!cartItemDAO.isProductInCart(userId, productId)) {
            result.setSuccess(false);
            result.setErrorMessage("Item not found in cart");
            return result;
        }
        
        cartItemDAO.deleteCartItem(userId, productId);
        
        result.setSuccess(true);
        result.setMessage("Item removed from cart");
        
        return result;
    }
    
    /**
     * Get cart summary with compatibility check
     */
    public CartSummary getCartSummary(int userId) throws SQLException {
        CartSummary summary = new CartSummary();
        
        List<CartItem> items = cartItemDAO.getCartItemsByUserId(userId);
        BigDecimal total = cartItemDAO.getCartTotal(userId);
        int itemCount = cartItemDAO.getCartItemCount(userId);
        
        summary.setItems(items);
        summary.setTotal(total);
        summary.setItemCount(itemCount);
        
        // Check compatibility
        List<CompatibilityEngine.CompatibilityIssue> issues = 
            compatibilityEngine.checkCartCompatibility(userId);
        summary.setCompatibilityIssues(issues);
        
        return summary;
    }
    
    /**
     * Cart Operation Result DTO
     */
    public static class CartOperationResult {
        private boolean success;
        private String message;
        private String errorMessage;
        private List<CompatibilityEngine.CompatibilityIssue> compatibilityIssues;
        
        // Getters and Setters
        public boolean isSuccess() {
            return success;
        }
        
        public void setSuccess(boolean success) {
            this.success = success;
        }
        
        public String getMessage() {
            return message;
        }
        
        public void setMessage(String message) {
            this.message = message;
        }
        
        public String getErrorMessage() {
            return errorMessage;
        }
        
        public void setErrorMessage(String errorMessage) {
            this.errorMessage = errorMessage;
        }
        
        public List<CompatibilityEngine.CompatibilityIssue> getCompatibilityIssues() {
            return compatibilityIssues;
        }
        
        public void setCompatibilityIssues(List<CompatibilityEngine.CompatibilityIssue> compatibilityIssues) {
            this.compatibilityIssues = compatibilityIssues;
        }
    }
    
    /**
     * Cart Summary DTO
     */
    public static class CartSummary {
        private List<CartItem> items;
        private BigDecimal total;
        private int itemCount;
        private List<CompatibilityEngine.CompatibilityIssue> compatibilityIssues;
        
        // Getters and Setters
        public List<CartItem> getItems() {
            return items;
        }
        
        public void setItems(List<CartItem> items) {
            this.items = items;
        }
        
        public BigDecimal getTotal() {
            return total;
        }
        
        public void setTotal(BigDecimal total) {
            this.total = total;
        }
        
        public int getItemCount() {
            return itemCount;
        }
        
        public void setItemCount(int itemCount) {
            this.itemCount = itemCount;
        }
        
        public List<CompatibilityEngine.CompatibilityIssue> getCompatibilityIssues() {
            return compatibilityIssues;
        }
        
        public void setCompatibilityIssues(List<CompatibilityEngine.CompatibilityIssue> compatibilityIssues) {
            this.compatibilityIssues = compatibilityIssues;
        }
    }
}

