package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import dao.interfaces.ProductDAO;
import model.Product;
import utils.DateTimeParser;


public class ProductDAOImpl implements ProductDAO {
    private final Connection connection;

    public ProductDAOImpl(Connection connection) {
        this.connection = connection;
    }

    @Override
    public void createProduct(Product product) throws SQLException {
        String query = "INSERT INTO products (category_id, name, description, price, stock_quantity, image_url, created_at) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            setProductParams(statement, product);
            statement.executeUpdate();
        }
    }

    @Override
    public ArrayList<Product> getAllProducts() throws SQLException {
        String query = "SELECT * FROM products";
        ArrayList<Product> products = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet rs = statement.executeQuery()) {
            while (rs.next()) {
                products.add(mapResultSetToProduct(rs));
            }
        }
        return products;
    }

    @Override
    public Product getProductById(int id) throws SQLException {
        String query = "SELECT * FROM products WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, id);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToProduct(rs);
                }
            }
        }
        return null;
    }

    @Override
    public ArrayList<Product> getProductsByName(String name) throws SQLException {
        String query = "SELECT * FROM products WHERE name LIKE ?";
        ArrayList<Product> products = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, "%" + name + "%");
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    products.add(mapResultSetToProduct(rs));
                }
            }
        }
        return products;
    }

    @Override
    public ArrayList<Product> getProductsByCategoryId(int categoryId) throws SQLException {
        String query = "SELECT * FROM products WHERE category_id = ?";
        ArrayList<Product> products = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, categoryId);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    products.add(mapResultSetToProduct(rs));
                }
            }
        }
        return products;
    }

    @Override
    public void updateProduct(int id, Product product) throws SQLException {
        String query = "UPDATE products SET category_id = ?, name = ?, description = ?, price = ?, stock_quantity = ?, image_url = ?, created_at = ? WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            setProductParams(statement, product);
            statement.setInt(8, id); // Only the last param is different
            statement.executeUpdate();
        }
    }

    @Override
    public void deleteProduct(int id) throws SQLException {
        String query = "DELETE FROM products WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, id);
            statement.executeUpdate();
        }
    }

    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
        return new Product(
            rs.getInt("id"),
            rs.getInt("category_id"),
            rs.getString("name"),
            rs.getString("description"),
            rs.getDouble("price"),
            rs.getInt("stock_quantity"),
            rs.getString("image_url"),
            DateTimeParser.parseLocalDate(rs.getString("created_at"))
        );
    }

    public int countByCategory(int categoryId) throws SQLException {
        String query = "SELECT COUNT(*) FROM Products WHERE categoryId = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, categoryId);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
                return 0;
            }
        }
    }

    public int countByKeyword(String keyword) throws SQLException {
        String query = "SELECT COUNT(*) FROM Products WHERE name LIKE ? OR description LIKE ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            String searchPattern = "%" + keyword + "%";
            statement.setString(1, searchPattern);
            statement.setString(2, searchPattern);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
                return 0;
            }
        }
    }

    public int countAll() throws SQLException {
        String query = "SELECT COUNT(*) FROM Products";
        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet rs = statement.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0;
        }
    }

    public ArrayList<Product> findByCategoryWithPagination(int categoryId, int offset, int limit) throws SQLException {
        String query = "SELECT * FROM Products WHERE categoryId = ? ORDER BY id LIMIT ? OFFSET ?";
        ArrayList<Product> products = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, categoryId);
            statement.setInt(2, limit);
            statement.setInt(3, offset);
            
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    products.add(mapResultSetToProduct(rs));
                }
            }
        }
        return products;
    }

    public ArrayList<Product> searchWithPagination(String keyword, int offset, int limit) throws SQLException {
        String query = "SELECT * FROM Products WHERE name LIKE ? OR description LIKE ? ORDER BY id LIMIT ? OFFSET ?";
        ArrayList<Product> products = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            String searchPattern = "%" + keyword + "%";
            statement.setString(1, searchPattern);
            statement.setString(2, searchPattern);
            statement.setInt(3, limit);
            statement.setInt(4, offset);
            
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    products.add(mapResultSetToProduct(rs));
                }
            }
        }
        return products;
    }

    public ArrayList<Product> findWithPagination(int offset, int limit) throws SQLException {
        String query = "SELECT * FROM Products ORDER BY id LIMIT ? OFFSET ?";
        ArrayList<Product> products = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, limit);
            statement.setInt(2, offset);
            
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    products.add(mapResultSetToProduct(rs));
                }
            }
        }
        return products;
    }

    public ArrayList<Product> findByStockAvailable() throws SQLException {
        String query = "SELECT * FROM Products WHERE stock_quantity > 0 ORDER BY name";
        ArrayList<Product> products = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet rs = statement.executeQuery()) {
            
            while (rs.next()) {
                products.add(mapResultSetToProduct(rs));
            }
        }
        return products;
    }

    private void setProductParams(PreparedStatement statement, Product product) throws SQLException {
        statement.setInt(1, product.getCategoryId());
        statement.setString(2, product.getName());
        statement.setString(3, product.getDescription());
        statement.setDouble(4, product.getPrice());
        statement.setInt(5, product.getStockQuantity());
        statement.setString(6, product.getImageUrl());
        statement.setString(7, DateTimeParser.toText(product.getCreatedAt()));
    }
}