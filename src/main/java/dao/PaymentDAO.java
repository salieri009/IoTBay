package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import model.Payment;

public class PaymentDAO {
    private final Connection connection;

    public PaymentDAO(Connection connection) {
        this.connection = connection;
    }

    // CREATE
    public int createPayment(Payment payment) throws SQLException {
        String query = "INSERT INTO payment (user_id, order_id, payment_date, amount, payment_method, status, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            statement.setInt(1, payment.getUserId());
            statement.setInt(2, payment.getOrderId());
            statement.setObject(3, payment.getPaymentDate());
            statement.setBigDecimal(4, payment.getAmount());
            statement.setString(5, payment.getPaymentMethod());
            statement.setString(6, payment.getStatus());
            statement.setObject(7, payment.getCreatedAt());
            statement.setObject(8, payment.getUpdatedAt());
            
            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
            throw new SQLException("Creating payment failed, no ID obtained.");
        }
    }

    // READ: Get payment by ID
    public Payment getPaymentById(int id) throws SQLException {
        String query = "SELECT * FROM payment WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, id);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    Payment payment = new Payment();
                    payment.setId(rs.getInt("id"));
                    payment.setUserId(rs.getInt("user_id"));
                    payment.setOrderId(rs.getInt("order_id"));
                    payment.setPaymentDate(rs.getObject("payment_date", LocalDateTime.class));
                    payment.setAmount(rs.getBigDecimal("amount"));
                    payment.setPaymentMethod(rs.getString("payment_method"));
                    payment.setStatus(rs.getString("status"));
                    payment.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                    payment.setUpdatedAt(rs.getObject("updated_at", LocalDateTime.class));
                    return payment;
                }
            }
        }
        return null;
    }

    // UPDATE
    public void updatePayment(Payment payment) throws SQLException {
        String query = "UPDATE payment SET payment_date = ?, amount = ?, payment_method = ?, status = ?, updated_at = ? WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setObject(1, payment.getPaymentDate());
            statement.setBigDecimal(2, payment.getAmount());
            statement.setString(3, payment.getPaymentMethod());
            statement.setString(4, payment.getStatus());
            statement.setObject(5, LocalDateTime.now());
            statement.setInt(6, payment.getId());
            statement.executeUpdate();
        }
    }

    // DELETE
    public void deletePayment(int id) throws SQLException {
        String query = "DELETE FROM payment WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, id);
            statement.executeUpdate();
        }
    }

    // GET all payments by user
    public List<Payment> getPaymentsByUserId(int userId) throws SQLException {
        String query = "SELECT * FROM payment WHERE user_id = ? ORDER BY payment_date DESC";
        List<Payment> payments = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    Payment payment = new Payment();
                    payment.setId(rs.getInt("id"));
                    payment.setUserId(rs.getInt("user_id"));
                    payment.setOrderId(rs.getInt("order_id"));
                    payment.setPaymentDate(rs.getObject("payment_date", LocalDateTime.class));
                    payment.setAmount(rs.getBigDecimal("amount"));
                    payment.setPaymentMethod(rs.getString("payment_method"));
                    payment.setStatus(rs.getString("status"));
                    payment.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                    payment.setUpdatedAt(rs.getObject("updated_at", LocalDateTime.class));
                    payments.add(payment);
                }
            }
        }
        return payments;
    }

    // GET payments by user ID and date range
    public List<Payment> getPaymentsByUserIdAndDateRange(int userId, String dateFrom, String dateTo) throws SQLException {
        String query = "SELECT * FROM payment WHERE user_id = ? AND payment_date BETWEEN ? AND ? ORDER BY payment_date DESC";
        List<Payment> payments = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);
            statement.setString(2, dateFrom);
            statement.setString(3, dateTo);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    Payment payment = new Payment();
                    payment.setId(rs.getInt("id"));
                    payment.setUserId(rs.getInt("user_id"));
                    payment.setOrderId(rs.getInt("order_id"));
                    payment.setPaymentDate(rs.getObject("payment_date", LocalDateTime.class));
                    payment.setAmount(rs.getBigDecimal("amount"));
                    payment.setPaymentMethod(rs.getString("payment_method"));
                    payment.setStatus(rs.getString("status"));
                    payment.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                    payment.setUpdatedAt(rs.getObject("updated_at", LocalDateTime.class));
                    payments.add(payment);
                }
            }
        }
        return payments;
    }

    // GET payments by order ID
    public List<Payment> getPaymentsByOrderId(int orderId) throws SQLException {
        String query = "SELECT * FROM payment WHERE order_id = ? ORDER BY payment_date DESC";
        List<Payment> payments = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, orderId);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    Payment payment = new Payment();
                    payment.setId(rs.getInt("id"));
                    payment.setUserId(rs.getInt("user_id"));
                    payment.setOrderId(rs.getInt("order_id"));
                    payment.setPaymentDate(rs.getObject("payment_date", LocalDateTime.class));
                    payment.setAmount(rs.getBigDecimal("amount"));
                    payment.setPaymentMethod(rs.getString("payment_method"));
                    payment.setStatus(rs.getString("status"));
                    payment.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                    payment.setUpdatedAt(rs.getObject("updated_at", LocalDateTime.class));
                    payments.add(payment);
                }
            }
        }
        return payments;
    }

    // GET payments by status
    public List<Payment> getPaymentsByStatus(String status) throws SQLException {
        String query = "SELECT * FROM payment WHERE status = ? ORDER BY payment_date DESC";
        List<Payment> payments = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, status);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    Payment payment = new Payment();
                    payment.setId(rs.getInt("id"));
                    payment.setUserId(rs.getInt("user_id"));
                    payment.setOrderId(rs.getInt("order_id"));
                    payment.setPaymentDate(rs.getObject("payment_date", LocalDateTime.class));
                    payment.setAmount(rs.getBigDecimal("amount"));
                    payment.setPaymentMethod(rs.getString("payment_method"));
                    payment.setStatus(rs.getString("status"));
                    payment.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                    payment.setUpdatedAt(rs.getObject("updated_at", LocalDateTime.class));
                    payments.add(payment);
                }
            }
        }
        return payments;
    }
}