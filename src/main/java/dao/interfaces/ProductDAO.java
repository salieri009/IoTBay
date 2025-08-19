package dao.interfaces;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;

/**
 * Simple ProductDAO interface for basic operations
 */
public interface ProductDAO {
    
    // Basic CRUD operations
    void createProduct(Product product) throws SQLException;
    List<Product> getAllProducts() throws SQLException;
    Product getProductById(int id) throws SQLException;
    ArrayList<Product> getProductsByName(String name) throws SQLException;
    ArrayList<Product> getProductsByCategoryId(int categoryId) throws SQLException;
    void updateProduct(int id, Product product) throws SQLException;
    void deleteProduct(int id) throws SQLException;
    int getTotalProductCount() throws SQLException;
    
    // Additional methods for controller compatibility
    Product findById(int id) throws SQLException;
    Product findById(Integer id) throws SQLException;
}