package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import model.PaymentDetail;

public class PaymentDetailDAO {
    private final Connection connection;

    public PaymentDetailDAO(Connection connection) {
        this.connection = connection;
    }

    // CREATE
    public int createPaymentDetail(PaymentDetail detail) throws SQLException {
        String query = "INSERT INTO payment_detail (payment_id, user_id, card_holder_name, card_number, expiry_date, card_type, is_default, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            statement.setObject(1, detail.getPaymentId());
            statement.setInt(2, detail.getUserId());
            statement.setString(3, detail.getCardHolderName());
            statement.setString(4, detail.getCardNumber());
            statement.setString(5, detail.getExpiryDate());
            statement.setString(6, detail.getCardType());
            statement.setBoolean(7, detail.isDefault());
            statement.setObject(8, detail.getCreatedAt());
            statement.setObject(9, detail.getUpdatedAt());
            
            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
            throw new SQLException("Creating payment detail failed, no ID obtained.");
        }
    }

    // READ: Get payment detail by ID
    public PaymentDetail getPaymentDetailById(int id) throws SQLException {
        String query = "SELECT * FROM payment_detail WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, id);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    PaymentDetail detail = new PaymentDetail();
                    detail.setId(rs.getInt("id"));
                    detail.setPaymentId(rs.getObject("payment_id", Integer.class));
                    detail.setUserId(rs.getInt("user_id"));
                    detail.setCardHolderName(rs.getString("card_holder_name"));
                    detail.setCardNumber(rs.getString("card_number"));
                    detail.setExpiryDate(rs.getString("expiry_date"));
                    detail.setCardType(rs.getString("card_type"));
                    detail.setDefault(rs.getBoolean("is_default"));
                    detail.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                    detail.setUpdatedAt(rs.getObject("updated_at", LocalDateTime.class));
                    return detail;
                }
            }
        }
        return null;
    }

    // READ: Get payment detail by payment ID
    public PaymentDetail getByPaymentId(int paymentId) throws SQLException {
        String query = "SELECT * FROM payment_detail WHERE payment_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, paymentId);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    PaymentDetail detail = new PaymentDetail();
                    detail.setId(rs.getInt("id"));
                    detail.setPaymentId(rs.getObject("payment_id", Integer.class));
                    detail.setUserId(rs.getInt("user_id"));
                    detail.setCardHolderName(rs.getString("card_holder_name"));
                    detail.setCardNumber(rs.getString("card_number"));
                    detail.setExpiryDate(rs.getString("expiry_date"));
                    detail.setCardType(rs.getString("card_type"));
                    detail.setDefault(rs.getBoolean("is_default"));
                    detail.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                    detail.setUpdatedAt(rs.getObject("updated_at", LocalDateTime.class));
                    return detail;
                }
            }
        }
        return null;
    }

    // UPDATE
    public void updatePaymentDetail(PaymentDetail detail) throws SQLException {
        String query = "UPDATE payment_detail SET card_holder_name = ?, card_number = ?, expiry_date = ?, card_type = ?, is_default = ?, updated_at = ? WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, detail.getCardHolderName());
            statement.setString(2, detail.getCardNumber());
            statement.setString(3, detail.getExpiryDate());
            statement.setString(4, detail.getCardType());
            statement.setBoolean(5, detail.isDefault());
            statement.setObject(6, LocalDateTime.now());
            statement.setInt(7, detail.getId());
            statement.executeUpdate();
        }
    }

    // DELETE
    public void deletePaymentDetail(int id) throws SQLException {
        String query = "DELETE FROM payment_detail WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, id);
            statement.executeUpdate();
        }
    }

    // DELETE by payment ID
    public void deleteByPaymentId(int paymentId) throws SQLException {
        String query = "DELETE FROM payment_detail WHERE payment_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, paymentId);
            statement.executeUpdate();
        }
    }

    // GET all payment details for a user
    public List<PaymentDetail> getPaymentDetailsByUserId(int userId) throws SQLException {
        String query = "SELECT * FROM payment_detail WHERE user_id = ? ORDER BY created_at DESC";
        List<PaymentDetail> details = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    PaymentDetail detail = new PaymentDetail();
                    detail.setId(rs.getInt("id"));
                    detail.setPaymentId(rs.getObject("payment_id", Integer.class));
                    detail.setUserId(rs.getInt("user_id"));
                    detail.setCardHolderName(rs.getString("card_holder_name"));
                    detail.setCardNumber(rs.getString("card_number"));
                    detail.setExpiryDate(rs.getString("expiry_date"));
                    detail.setCardType(rs.getString("card_type"));
                    detail.setDefault(rs.getBoolean("is_default"));
                    detail.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                    detail.setUpdatedAt(rs.getObject("updated_at", LocalDateTime.class));
                    details.add(detail);
                }
            }
        }
        return details;
    }

    // GET default payment detail for a user
    public PaymentDetail getDefaultPaymentDetailByUserId(int userId) throws SQLException {
        String query = "SELECT * FROM payment_detail WHERE user_id = ? AND is_default = true LIMIT 1";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    PaymentDetail detail = new PaymentDetail();
                    detail.setId(rs.getInt("id"));
                    detail.setPaymentId(rs.getObject("payment_id", Integer.class));
                    detail.setUserId(rs.getInt("user_id"));
                    detail.setCardHolderName(rs.getString("card_holder_name"));
                    detail.setCardNumber(rs.getString("card_number"));
                    detail.setExpiryDate(rs.getString("expiry_date"));
                    detail.setCardType(rs.getString("card_type"));
                    detail.setDefault(rs.getBoolean("is_default"));
                    detail.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                    detail.setUpdatedAt(rs.getObject("updated_at", LocalDateTime.class));
                    return detail;
                }
            }
        }
        return null;
    }

    // Set default payment detail
    public void setDefaultPaymentDetail(int userId, int paymentDetailId) throws SQLException {
        connection.setAutoCommit(false);
        try {
            // First, unset all defaults for the user
            String unsetQuery = "UPDATE payment_detail SET is_default = false WHERE user_id = ?";
            try (PreparedStatement statement = connection.prepareStatement(unsetQuery)) {
                statement.setInt(1, userId);
                statement.executeUpdate();
            }

            // Then set the specified one as default
            String setQuery = "UPDATE payment_detail SET is_default = true, updated_at = ? WHERE id = ? AND user_id = ?";
            try (PreparedStatement statement = connection.prepareStatement(setQuery)) {
                statement.setObject(1, LocalDateTime.now());
                statement.setInt(2, paymentDetailId);
                statement.setInt(3, userId);
                statement.executeUpdate();
            }

            connection.commit();
        } catch (SQLException e) {
            connection.rollback();
            throw e;
        } finally {
            connection.setAutoCommit(true);
        }
    }
}