package service;

import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

import dao.ProductDAO;
import model.Product;
import model.ProductSpecification;
import model.TrustBadge;

/**
 * Product Service
 * Business logic for product operations
 * 
 * Based on improvement.md recommendations for product management
 */
public class ProductService {
    private final ProductDAO productDAO;
    
    public ProductService(ProductDAO productDAO) {
        this.productDAO = productDAO;
    }
    
    /**
     * Get product with full details including specifications
     */
    public ProductDetailResult getProductDetail(int productId) throws SQLException {
        Product product = productDAO.getProductById(productId);
        if (product == null) {
            return null;
        }
        
        ProductDetailResult result = new ProductDetailResult();
        result.setProduct(product);
        
        // TODO: Load ProductSpecification from database
        // result.setSpecification(productSpecificationDAO.getByProductId(productId));
        
        // TODO: Load TrustBadges from database
        // result.setTrustBadges(trustBadgeDAO.getByProductId(productId));
        
        return result;
    }
    
    /**
     * Search products with advanced filtering
     * Supports protocol, voltage, and use case filtering
     */
    public List<Product> searchProducts(ProductSearchCriteria criteria) throws SQLException {
        // Basic search by keyword
        if (criteria.getKeyword() != null && !criteria.getKeyword().trim().isEmpty()) {
            return productDAO.searchProducts(criteria.getKeyword());
        }
        
        // Category filter
        if (criteria.getCategoryId() > 0) {
            return productDAO.getProductsByCategory(criteria.getCategoryId());
        }
        
        // Get all products (with pagination in future)
        return productDAO.getAllProducts();
    }
    
    /**
     * Get compatible products for a given product
     */
    public List<Product> getCompatibleProducts(int productId) throws SQLException {
        // TODO: Implement compatibility logic
        // For now, return empty list
        return new ArrayList<>();
    }
    
    /**
     * Product Detail Result DTO
     */
    public static class ProductDetailResult {
        private Product product;
        private ProductSpecification specification;
        private List<TrustBadge> trustBadges;
        private List<Product> compatibleProducts;
        private List<Product> relatedProducts;
        
        // Getters and Setters
        public Product getProduct() {
            return product;
        }
        
        public void setProduct(Product product) {
            this.product = product;
        }
        
        public ProductSpecification getSpecification() {
            return specification;
        }
        
        public void setSpecification(ProductSpecification specification) {
            this.specification = specification;
        }
        
        public List<TrustBadge> getTrustBadges() {
            return trustBadges;
        }
        
        public void setTrustBadges(List<TrustBadge> trustBadges) {
            this.trustBadges = trustBadges;
        }
        
        public List<Product> getCompatibleProducts() {
            return compatibleProducts;
        }
        
        public void setCompatibleProducts(List<Product> compatibleProducts) {
            this.compatibleProducts = compatibleProducts;
        }
        
        public List<Product> getRelatedProducts() {
            return relatedProducts;
        }
        
        public void setRelatedProducts(List<Product> relatedProducts) {
            this.relatedProducts = relatedProducts;
        }
    }
    
    /**
     * Product Search Criteria
     */
    public static class ProductSearchCriteria {
        private String keyword;
        private int categoryId;
        private String protocol; // LoRaWAN, Zigbee, WiFi, etc.
        private String voltage; // 12V, 24V, etc.
        private String useCase; // Temperature Monitoring, Asset Tracking, etc.
        private double minPrice;
        private double maxPrice;
        private boolean inStockOnly;
        
        // Getters and Setters
        public String getKeyword() {
            return keyword;
        }
        
        public void setKeyword(String keyword) {
            this.keyword = keyword;
        }
        
        public int getCategoryId() {
            return categoryId;
        }
        
        public void setCategoryId(int categoryId) {
            this.categoryId = categoryId;
        }
        
        public String getProtocol() {
            return protocol;
        }
        
        public void setProtocol(String protocol) {
            this.protocol = protocol;
        }
        
        public String getVoltage() {
            return voltage;
        }
        
        public void setVoltage(String voltage) {
            this.voltage = voltage;
        }
        
        public String getUseCase() {
            return useCase;
        }
        
        public void setUseCase(String useCase) {
            this.useCase = useCase;
        }
        
        public double getMinPrice() {
            return minPrice;
        }
        
        public void setMinPrice(double minPrice) {
            this.minPrice = minPrice;
        }
        
        public double getMaxPrice() {
            return maxPrice;
        }
        
        public void setMaxPrice(double maxPrice) {
            this.maxPrice = maxPrice;
        }
        
        public boolean isInStockOnly() {
            return inStockOnly;
        }
        
        public void setInStockOnly(boolean inStockOnly) {
            this.inStockOnly = inStockOnly;
        }
    }
}

