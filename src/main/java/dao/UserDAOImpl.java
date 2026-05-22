package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.interfaces.UserDAO;
import model.User;
import utils.DateTimeParser;
import config.DIContainer;

public class UserDAOImpl implements UserDAO {

    public UserDAOImpl() {
        // No-args constructor
    }

    @Override
    public void createUser(User user) throws SQLException {
        String query = "INSERT INTO Users (email, password, firstName, lastName, phoneNumber, postalCode, addressLine1, addressLine2, dateOfBirth, paymentMethod, createdAt, updatedAt, role, isActive) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            setUserParams(statement, user);
            statement.executeUpdate();
        }
    }

    @Override
    public List<User> getAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM Users";
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query);
                ResultSet rs = statement.executeQuery()) {
            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }
        }
        return users;
    }

    @Override
    public User getUserById(int id) throws SQLException {
        String query = "SELECT * FROM Users WHERE id = ?";
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, id);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        }
        return null;
    }

    @Override
    public List<User> getUsersByEmail(String email) throws SQLException {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM Users WHERE email LIKE ?";
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, email);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    users.add(mapResultSetToUser(rs));
                }
            }
        }
        return users;
    }

    @Override
    public User getUserByEmail(String email) throws SQLException {
        String query = "SELECT * FROM Users WHERE email = ?";
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, email);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        }
        return null;
    }

    @Override
    public boolean isEmailExists(String email) throws SQLException {
        String query = "SELECT COUNT(*) FROM Users WHERE email = ?";
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, email);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    @Override
    public void updateUser(int id, User user) throws SQLException {
        String query = "UPDATE Users SET email = ?, password = ?, firstName = ?, lastName = ?, phoneNumber = ?, postalCode = ?, addressLine1 = ?, addressLine2 = ?, dateOfBirth = ?, paymentMethod = ?, createdAt = ?, updatedAt = ?, role = ?, isActive = ? WHERE id = ?";
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            setUserParams(statement, user);
            statement.setInt(15, id); // 14개 필드 + id
            statement.executeUpdate();
        }
    }

    @Override
    public void deleteUser(int id) throws SQLException {
        Connection connection = DIContainer.getConnection();
        boolean autoCommit = connection.getAutoCommit();
        connection.setAutoCommit(false);
        try {
            // Step 1: Restore stock for all active (non-cancelled) orders
            String findActiveOrdersSql = "SELECT order_id FROM \"order\" WHERE user_id = ? AND status != 'cancelled'";
            try (PreparedStatement findOrdersStmt = connection.prepareStatement(findActiveOrdersSql)) {
                findOrdersStmt.setInt(1, id);
                try (ResultSet orderRs = findOrdersStmt.executeQuery()) {
                    while (orderRs.next()) {
                        int orderId = orderRs.getInt("order_id");
                        String findItemsSql = "SELECT productID, quantity FROM order_product WHERE orderID = ?";
                        try (PreparedStatement findItemsStmt = connection.prepareStatement(findItemsSql)) {
                            findItemsStmt.setInt(1, orderId);
                            try (ResultSet itemRs = findItemsStmt.executeQuery()) {
                                while (itemRs.next()) {
                                    int productId = itemRs.getInt("productID");
                                    int quantity = itemRs.getInt("quantity");
                                    String restoreStockSql = "UPDATE products SET stock_quantity = stock_quantity + ? WHERE id = ?";
                                    try (PreparedStatement restoreStmt = connection.prepareStatement(restoreStockSql)) {
                                        restoreStmt.setInt(1, quantity);
                                        restoreStmt.setInt(2, productId);
                                        restoreStmt.executeUpdate();
                                    }
                                }
                            }
                        }
                    }
                }
            }
            // Step 2: Cancel all user's orders
            String cancelOrdersSql = "UPDATE \"order\" SET status = 'cancelled' WHERE user_id = ?";
            try (PreparedStatement cancelStmt = connection.prepareStatement(cancelOrdersSql)) {
                cancelStmt.setInt(1, id);
                cancelStmt.executeUpdate();
            }
            // Step 3: Delete the user
            String deleteUserSql = "DELETE FROM Users WHERE id = ?";
            try (PreparedStatement deleteStmt = connection.prepareStatement(deleteUserSql)) {
                deleteStmt.setInt(1, id);
                deleteStmt.executeUpdate();
            }
            connection.commit();
        } catch (SQLException e) {
            connection.rollback();
            throw e;
        } finally {
            connection.setAutoCommit(autoCommit);
        }
    }

    // ResultSet에서 User 객체로 매핑
    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        java.time.LocalDate dob = null;
        try {
            String dobStr = rs.getString("dateOfBirth");
            if (dobStr != null && !dobStr.isEmpty()) {
                dob = java.time.LocalDate.parse(dobStr);
            }
        } catch (Exception e) {
            System.err.println("[UserDAOImpl] Warning: Failed to parse dateOfBirth for user ID " + rs.getInt("id")
                    + ": " + e.getMessage());
        }

        java.time.LocalDateTime createdAt = null;
        try {
            createdAt = DateTimeParser.parseLocalDateTime(rs.getString("createdAt"));
        } catch (Exception e) {
            System.err.println("[UserDAOImpl] Warning: Failed to parse createdAt for user ID " + rs.getInt("id") + ": "
                    + e.getMessage());
            createdAt = java.time.LocalDateTime.now(); // Fallback to now
        }

        java.time.LocalDateTime updatedAt = null;
        try {
            updatedAt = DateTimeParser.parseLocalDateTime(rs.getString("updatedAt"));
        } catch (Exception e) {
            System.err.println("[UserDAOImpl] Warning: Failed to parse updatedAt for user ID " + rs.getInt("id") + ": "
                    + e.getMessage());
            updatedAt = java.time.LocalDateTime.now(); // Fallback to now
        }

        return new User(
                rs.getInt("id"),
                rs.getString("email"),
                rs.getString("password"),
                rs.getString("firstName"),
                rs.getString("lastName"),
                rs.getString("phoneNumber"),
                rs.getString("postalCode"),
                rs.getString("addressLine1"),
                rs.getString("addressLine2"),
                dob,
                rs.getString("paymentMethod"),
                createdAt,
                updatedAt,
                rs.getString("role"),
                rs.getBoolean("isActive"));
    }

    // User 객체의 값을 PreparedStatement에 세팅
    private void setUserParams(PreparedStatement statement, User user) throws SQLException {
        statement.setString(1, user.getEmail());
        statement.setString(2, user.getPassword());
        statement.setString(3, user.getFirstName());
        statement.setString(4, user.getLastName());
        statement.setString(5, user.getPhone());
        statement.setString(6, user.getPostalCode());
        statement.setString(7, user.getAddressLine1());
        statement.setString(8, user.getAddressLine2());
        statement.setString(9, user.getDateOfBirth() != null ? user.getDateOfBirth().toString() : null);
        statement.setString(10, user.getPaymentMethod());
        statement.setString(11, user.getCreatedAt() != null ? user.getCreatedAt().toString() : null);
        statement.setString(12, user.getUpdatedAt() != null ? user.getUpdatedAt().toString() : null);
        statement.setString(13, user.getRole());
        statement.setBoolean(14, user.isActive());
    }

    @Override
    public int getTotalUserCount() throws SQLException {
        String query = "SELECT COUNT(*) FROM Users";
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query);
                ResultSet rs = statement.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0;
        }
    }
}
