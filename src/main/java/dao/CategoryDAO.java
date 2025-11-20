package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Category;

public class CategoryDAO {
    private final Connection connection;

    public CategoryDAO(Connection connection) {
        this.connection = connection;
    }

    // CREATE
    public void createCategory(Category category) throws SQLException {
        String query = "INSERT INTO categories (name, description) VALUES (?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, category.getName());
            statement.setString(2, category.getDescription());
            statement.executeUpdate();
        }
    }

    // READ: Get category by ID
    public Category getCategoryById(int id) throws SQLException {
        String query = "SELECT id, name, description FROM categories WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return new Category(
                        resultSet.getInt("id"),
                        resultSet.getString("name"),
                        resultSet.getString("description")
                    );
                }
            }
        }
        return null;
    }

    // READ: Get all categories
    public List<Category> getAllCategories() throws SQLException {
        String query = "SELECT id, name, description FROM categories ORDER BY sort_order, name";
        List<Category> categories = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                categories.add(new Category(
                    resultSet.getInt("id"),
                    resultSet.getString("name"),
                    resultSet.getString("description")
                ));
            }
        }
        return categories;
    }

    // UPDATE
    public void updateCategory(Category category) throws SQLException {
        String query = "UPDATE categories SET name = ?, description = ? WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, category.getName());
            statement.setString(2, category.getDescription());
            statement.setInt(3, category.getId());
            statement.executeUpdate();
        }
    }

    // DELETE
    public void deleteCategory(int id) throws SQLException {
        String query = "DELETE FROM categories WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, id);
            statement.executeUpdate();
        }
    }
    
    // Get product count by category ID
    public int getProductCountByCategoryId(int categoryId) throws SQLException {
        String query = "SELECT COUNT(*) FROM products WHERE category_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, categoryId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt(1);
                }
            }
        }
        return 0;
    }
    
    // Get category by name (case-insensitive)
    public Category getCategoryByName(String name) throws SQLException {
        String query = "SELECT id, name, description FROM categories WHERE LOWER(name) = LOWER(?) OR LOWER(slug) = LOWER(?)";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, name);
            statement.setString(2, name);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return new Category(
                        resultSet.getInt("id"),
                        resultSet.getString("name"),
                        resultSet.getString("description")
                    );
                }
            }
        }
        return null;
    }
    
    // Get all active categories
    public List<Category> getActiveCategories() throws SQLException {
        String query = "SELECT id, name, description FROM categories WHERE is_active = 1 ORDER BY sort_order, name";
        List<Category> categories = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                categories.add(new Category(
                    resultSet.getInt("id"),
                    resultSet.getString("name"),
                    resultSet.getString("description")
                ));
            }
        }
        return categories;
    }
}