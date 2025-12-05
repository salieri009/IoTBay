package dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import model.Product;

public class ProductDAO implements dao.interfaces.ProductDAO {
    private final Connection connection;

    public ProductDAO(Connection connection) {
        this.connection = connection;
    }

    @Override
    public void createProduct(Product product) throws SQLException {
        String query = "INSERT INTO product (category_id, name, description, price, stock_quantity, image_url, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            statement.setInt(1, product.getCategoryId());
            statement.setString(2, product.getName());
            statement.setString(3, product.getDescription());
            statement.setBigDecimal(4, BigDecimal.valueOf(product.getPrice()));
            statement.setInt(5, product.getStockQuantity());
            statement.setString(6, product.getImageUrl());
            statement.setObject(7, LocalDateTime.now());
            statement.setObject(8, LocalDateTime.now());

            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        product.setId(generatedKeys.getInt(1));
                    }
                }
            }
        }
    }

    @Override
    public ArrayList<Product> getAllProducts() throws SQLException {
        String query = "SELECT * FROM product ORDER BY created_at DESC";
        ArrayList<Product> products = new ArrayList<>();

        try (PreparedStatement statement = connection.prepareStatement(query);
                ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getBigDecimal("price").doubleValue());
                product.setStockQuantity(rs.getInt("stock_quantity"));
                product.setImageUrl(rs.getString("image_url"));
                product.setCreatedAt(rs.getObject("created_at", LocalDate.class));
                products.add(product);
            }
        }

        return products;
    }

    @Override
    public Product getProductById(int id) throws SQLException {
        String query = "SELECT * FROM product WHERE id = ?";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, id);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    Product product = new Product();
                    product.setId(rs.getInt("id"));
                    product.setCategoryId(rs.getInt("category_id"));
                    product.setName(rs.getString("name"));
                    product.setDescription(rs.getString("description"));
                    product.setPrice(rs.getBigDecimal("price").doubleValue());
                    product.setStockQuantity(rs.getInt("stock_quantity"));
                    product.setImageUrl(rs.getString("image_url"));
                    product.setCreatedAt(rs.getObject("created_at", LocalDate.class));
                    return product;
                }
            }
        }

        return null;
    }

    @Override
    public ArrayList<Product> getProductsByName(String name) throws SQLException {
        String query = "SELECT * FROM product WHERE name ILIKE ? ORDER BY name";
        ArrayList<Product> products = new ArrayList<>();

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, "%" + name + "%");

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setId(rs.getInt("id"));
                    product.setCategoryId(rs.getInt("category_id"));
                    product.setName(rs.getString("name"));
                    product.setDescription(rs.getString("description"));
                    product.setPrice(rs.getBigDecimal("price").doubleValue());
                    product.setStockQuantity(rs.getInt("stock_quantity"));
                    product.setImageUrl(rs.getString("image_url"));
                    product.setCreatedAt(rs.getObject("created_at", LocalDate.class));
                    products.add(product);
                }
            }
        }

        return products;
    }

    @Override
    public ArrayList<Product> getProductsByCategoryId(int categoryId) throws SQLException {
        String query = "SELECT * FROM product WHERE category_id = ? ORDER BY name";
        ArrayList<Product> products = new ArrayList<>();

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, categoryId);

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setId(rs.getInt("id"));
                    product.setCategoryId(rs.getInt("category_id"));
                    product.setName(rs.getString("name"));
                    product.setDescription(rs.getString("description"));
                    product.setPrice(rs.getBigDecimal("price").doubleValue());
                    product.setStockQuantity(rs.getInt("stock_quantity"));
                    product.setImageUrl(rs.getString("image_url"));
                    product.setCreatedAt(rs.getObject("created_at", LocalDate.class));
                    products.add(product);
                }
            }
        }

        return products;
    }

    @Override
    public void updateProduct(int id, Product product) throws SQLException {
        String query = "UPDATE product SET category_id = ?, name = ?, description = ?, price = ?, stock_quantity = ?, image_url = ?, updated_at = ? WHERE id = ?";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, product.getCategoryId());
            statement.setString(2, product.getName());
            statement.setString(3, product.getDescription());
            statement.setBigDecimal(4, BigDecimal.valueOf(product.getPrice()));
            statement.setInt(5, product.getStockQuantity());
            statement.setString(6, product.getImageUrl());
            statement.setObject(7, LocalDateTime.now());
            statement.setInt(8, id);

            statement.executeUpdate();
        }
    }

    @Override
    public void deleteProduct(int id) throws SQLException {
        String query = "DELETE FROM product WHERE id = ?";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, id);
            statement.executeUpdate();
        }
    }

    // Additional useful methods
    public ArrayList<Product> getAvailableProducts() throws SQLException {
        String query = "SELECT * FROM product WHERE stock_quantity > 0 ORDER BY name";
        ArrayList<Product> products = new ArrayList<>();

        try (PreparedStatement statement = connection.prepareStatement(query);
                ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getBigDecimal("price").doubleValue());
                product.setStockQuantity(rs.getInt("stock_quantity"));
                product.setImageUrl(rs.getString("image_url"));
                product.setCreatedAt(rs.getObject("created_at", LocalDate.class));
                products.add(product);
            }
        }

        return products;
    }

    public void updateStockQuantity(int productId, int newQuantity) throws SQLException {
        String query = "UPDATE product SET stock_quantity = ?, updated_at = ? WHERE id = ?";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, newQuantity);
            statement.setObject(2, LocalDateTime.now());
            statement.setInt(3, productId);
            statement.executeUpdate();
        }
    }

    public void decreaseStock(int productId, int quantity) throws SQLException {
        String query = "UPDATE product SET stock_quantity = stock_quantity - ?, updated_at = ? WHERE id = ? AND stock_quantity >= ?";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, quantity);
            statement.setObject(2, LocalDateTime.now());
            statement.setInt(3, productId);
            statement.setInt(4, quantity);

            int rowsAffected = statement.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("Insufficient stock for product ID: " + productId);
            }
        }
    }

    public void increaseStock(int productId, int quantity) throws SQLException {
        String query = "UPDATE product SET stock_quantity = stock_quantity + ?, updated_at = ? WHERE id = ?";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, quantity);
            statement.setObject(2, LocalDateTime.now());
            statement.setInt(3, productId);
            statement.executeUpdate();
        }
    }

    /**
     * Search products by keyword
     * Used by ProductService
     */
    public List<Product> searchProducts(String keyword) throws SQLException {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllProducts();
        }
        return searchProducts(keyword, null, null, null);
    }

    /**
     * Get products by category ID
     * Used by ProductService
     */
    public List<Product> getProductsByCategory(int categoryId) throws SQLException {
        return getProductsByCategoryId(categoryId);
    }

    public List<Product> searchProducts(String searchTerm, Integer categoryId, Double minPrice, Double maxPrice)
            throws SQLException {
        StringBuilder query = new StringBuilder("SELECT * FROM product WHERE 1=1");
        ArrayList<Object> parameters = new ArrayList<>();

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            query.append(" AND (name ILIKE ? OR description ILIKE ?)");
            String searchPattern = "%" + searchTerm + "%";
            parameters.add(searchPattern);
            parameters.add(searchPattern);
        }

        if (categoryId != null) {
            query.append(" AND category_id = ?");
            parameters.add(categoryId);
        }

        if (minPrice != null) {
            query.append(" AND price >= ?");
            parameters.add(BigDecimal.valueOf(minPrice));
        }

        if (maxPrice != null) {
            query.append(" AND price <= ?");
            parameters.add(BigDecimal.valueOf(maxPrice));
        }

        query.append(" ORDER BY name");

        ArrayList<Product> products = new ArrayList<>();

        try (PreparedStatement statement = connection.prepareStatement(query.toString())) {
            for (int i = 0; i < parameters.size(); i++) {
                statement.setObject(i + 1, parameters.get(i));
            }

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setId(rs.getInt("id"));
                    product.setCategoryId(rs.getInt("category_id"));
                    product.setName(rs.getString("name"));
                    product.setDescription(rs.getString("description"));
                    product.setPrice(rs.getBigDecimal("price").doubleValue());
                    product.setStockQuantity(rs.getInt("stock_quantity"));
                    product.setImageUrl(rs.getString("image_url"));
                    product.setCreatedAt(rs.getObject("created_at", LocalDate.class));
                    products.add(product);
                }
            }
        }

        return products;
    }

    // Additional methods for ProductController
    public List<Product> searchProducts(String query, int limit, int offset) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM product WHERE name ILIKE ? OR description ILIKE ? ORDER BY name LIMIT ? OFFSET ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            String searchTerm = "%" + query + "%";
            stmt.setString(1, searchTerm);
            stmt.setString(2, searchTerm);
            stmt.setInt(3, limit);
            stmt.setInt(4, offset);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    products.add(mapResultSetToProduct(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error searching products: " + e.getMessage());
        }

        return products;
    }

    public int getSearchResultCount(String query) {
        String sql = "SELECT COUNT(*) FROM product WHERE name ILIKE ? OR description ILIKE ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            String searchTerm = "%" + query + "%";
            stmt.setString(1, searchTerm);
            stmt.setString(2, searchTerm);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error counting search results: " + e.getMessage());
        }

        return 0;
    }

    public List<Product> getAllProducts(int limit, int offset) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM product ORDER BY name LIMIT ? OFFSET ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            stmt.setInt(2, offset);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    products.add(mapResultSetToProduct(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting all products: " + e.getMessage());
        }

        return products;
    }

    public int getTotalProductCount() {
        String sql = "SELECT COUNT(*) FROM product";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error counting products: " + e.getMessage());
        }

        return 0;
    }

    public List<Product> getProductsByCategory(String category, int limit, int offset) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM product WHERE category_id = (SELECT id FROM category WHERE name = ?) ORDER BY name LIMIT ? OFFSET ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, category);
            stmt.setInt(2, limit);
            stmt.setInt(3, offset);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    products.add(mapResultSetToProduct(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting products by category: " + e.getMessage());
        }

        return products;
    }

    public int getProductCountByCategory(String category) {
        String sql = "SELECT COUNT(*) FROM product WHERE category_id = (SELECT id FROM category WHERE name = ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, category);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error counting products by category: " + e.getMessage());
        }

        return 0;
    }

    public List<Product> getProductsByPriceRange(BigDecimal minPrice, BigDecimal maxPrice, int limit, int offset) {
        List<Product> products = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM product WHERE 1=1");

        List<Object> params = new ArrayList<>();

        if (minPrice != null) {
            sql.append(" AND price >= ?");
            params.add(minPrice);
        }

        if (maxPrice != null) {
            sql.append(" AND price <= ?");
            params.add(maxPrice);
        }

        sql.append(" ORDER BY price LIMIT ? OFFSET ?");
        params.add(limit);
        params.add(offset);

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    products.add(mapResultSetToProduct(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting products by price range: " + e.getMessage());
        }

        return products;
    }

    public int getProductCountByPriceRange(BigDecimal minPrice, BigDecimal maxPrice) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM product WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (minPrice != null) {
            sql.append(" AND price >= ?");
            params.add(minPrice);
        }

        if (maxPrice != null) {
            sql.append(" AND price <= ?");
            params.add(maxPrice);
        }

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error counting products by price range: " + e.getMessage());
        }

        return 0;
    }

    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        String sql = "SELECT name FROM category ORDER BY name";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    categories.add(rs.getString("name"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting categories: " + e.getMessage());
        }

        return categories;
    }

    public List<Product> getFeaturedProducts(int limit) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM product WHERE stock_quantity > 0 ORDER BY created_at DESC LIMIT ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, limit);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    products.add(mapResultSetToProduct(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting featured products: " + e.getMessage());
        }

        return products;
    }

    @Override
    public Product findById(Integer id) throws SQLException {
        if (id == null) {
            return null;
        }
        return getProductById(id);
    }

    @Override
    public Product findById(int id) throws SQLException {
        return getProductById(id);
    }

    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setId(rs.getInt("id"));
        product.setCategoryId(rs.getInt("category_id"));
        product.setName(rs.getString("name"));
        product.setDescription(rs.getString("description"));
        product.setPrice(rs.getBigDecimal("price").doubleValue());
        product.setStockQuantity(rs.getInt("stock_quantity"));
        product.setImageUrl(rs.getString("image_url"));
        product.setCreatedAt(rs.getObject("created_at", LocalDate.class));
        return product;
    }
}
