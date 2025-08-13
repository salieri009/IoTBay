package dao.interfaces;

import java.sql.SQLException;
import java.util.ArrayList;
import model.Product;

/**
 * Simple ProductDAO interface for basic operations
 */
public interface ProductDAO {
    
    // Basic CRUD operations
    void createProduct(Product product) throws SQLException;
    ArrayList<Product> getAllProducts() throws SQLException;
    Product getProductById(int id) throws SQLException;
    ArrayList<Product> getProductsByName(String name) throws SQLException;
    ArrayList<Product> getProductsByCategoryId(int categoryId) throws SQLException;
    void updateProduct(int id, Product product) throws SQLException;
    void deleteProduct(int id) throws SQLException;
}