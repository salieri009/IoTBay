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
    private static volatile boolean schemaEnsured = false;

    public PaymentDAO(Connection connection) {
        this.connection = connection;
        try {
            ensureSchema(connection);
        } catch (SQLException e) {
            // Non-fatal: log and continue; queries will surface a clearer error if needed.
            System.err.println("[PaymentDAO] Could not ensure payment schema: " + e.getMessage());
        }
    }

    /**
     * The frozen DatabaseInitializer seeds (but never creates) the singular {@code payment}
     * and {@code payment_detail} tables, so they are absent at runtime. Create them here
     * (idempotently) and seed a small sample so payment list/search has data. This runs once
     * per JVM.
     */
    private static synchronized void ensureSchema(Connection conn) throws SQLException {
        if (schemaEnsured) {
            return;
        }
        try (Statement st = conn.createStatement()) {
            st.execute("CREATE TABLE IF NOT EXISTS payment (" +
                    "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                    "user_id INTEGER NOT NULL, " +
                    "order_id INTEGER NOT NULL, " +
                    "payment_date TEXT, " +
                    "amount REAL NOT NULL DEFAULT 0, " +
                    "payment_method TEXT, " +
                    "status TEXT DEFAULT 'PENDING', " +
                    "created_at TEXT DEFAULT (datetime('now')), " +
                    "updated_at TEXT DEFAULT (datetime('now'))" +
                    ")");
            st.execute("CREATE TABLE IF NOT EXISTS payment_detail (" +
                    "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                    "payment_id INTEGER, " +
                    "user_id INTEGER NOT NULL, " +
                    "card_holder_name TEXT, " +
                    "card_number TEXT, " +
                    "expiry_date TEXT, " +
                    "card_type TEXT, " +
                    "is_default INTEGER DEFAULT 0, " +
                    "created_at TEXT DEFAULT (datetime('now')), " +
                    "updated_at TEXT DEFAULT (datetime('now'))" +
                    ")");
        }
        seedSamplePayments(conn);
        schemaEnsured = true;
    }

    private static void seedSamplePayments(Connection conn) throws SQLException {
        try (Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM payment")) {
            if (rs.next() && rs.getInt(1) > 0) {
                return; // already populated
            }
        }
        // user_id, order_id, amount, payment_method, status, payment_date
        String[][] rows = {
            {"1", "1", "299.99", "Credit Card", "COMPLETED", "2025-01-10 09:05:00"},
            {"1", "2", "149.99", "PayPal",      "COMPLETED", "2025-01-15 10:35:00"},
            {"1", "3", "529.98", "Credit Card", "COMPLETED", "2025-02-01 14:05:00"},
            {"1", "4", "29.99",  "Debit Card",  "COMPLETED", "2025-02-14 16:05:00"},
            {"1", "6", "899.99", "Credit Card", "PENDING",   "2025-03-15 11:05:00"},
            {"1", "7", "199.99", "PayPal",      "PENDING",   "2025-04-01 13:05:00"},
            {"1", "8", "399.99", "Credit Card", "COMPLETED", "2025-04-20 09:35:00"},
            {"1", "9", "249.99", "Debit Card",  "PENDING",   "2025-05-01 15:05:00"},
            {"1", "10","4999.99","Credit Card", "PENDING",   "2025-05-10 10:05:00"},
            {"2", "12","179.99", "PayPal",      "PENDING",   "2025-02-05 11:05:00"},
        };
        String sql = "INSERT INTO payment (user_id, order_id, amount, payment_method, status, payment_date, created_at, updated_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, datetime('now'), datetime('now'))";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            for (String[] r : rows) {
                try {
                    ps.setInt(1, Integer.parseInt(r[0]));
                    ps.setInt(2, Integer.parseInt(r[1]));
                    ps.setDouble(3, Double.parseDouble(r[2]));
                    ps.setString(4, r[3]);
                    ps.setString(5, r[4]);
                    ps.setString(6, r[5]);
                    ps.executeUpdate();
                } catch (SQLException ignored) {
                    // skip bad row
                }
            }
        }
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
                    payment.setPaymentDate(parsePaymentDT(rs.getString("payment_date")));
                    payment.setAmount(rs.getBigDecimal("amount"));
                    payment.setPaymentMethod(rs.getString("payment_method"));
                    payment.setStatus(rs.getString("status"));
                    payment.setCreatedAt(parsePaymentDT(rs.getString("created_at")));
                    payment.setUpdatedAt(parsePaymentDT(rs.getString("updated_at")));
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
                    payment.setPaymentDate(parsePaymentDT(rs.getString("payment_date")));
                    payment.setAmount(rs.getBigDecimal("amount"));
                    payment.setPaymentMethod(rs.getString("payment_method"));
                    payment.setStatus(rs.getString("status"));
                    payment.setCreatedAt(parsePaymentDT(rs.getString("created_at")));
                    payment.setUpdatedAt(parsePaymentDT(rs.getString("updated_at")));
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
                    payment.setPaymentDate(parsePaymentDT(rs.getString("payment_date")));
                    payment.setAmount(rs.getBigDecimal("amount"));
                    payment.setPaymentMethod(rs.getString("payment_method"));
                    payment.setStatus(rs.getString("status"));
                    payment.setCreatedAt(parsePaymentDT(rs.getString("created_at")));
                    payment.setUpdatedAt(parsePaymentDT(rs.getString("updated_at")));
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
                    payment.setPaymentDate(parsePaymentDT(rs.getString("payment_date")));
                    payment.setAmount(rs.getBigDecimal("amount"));
                    payment.setPaymentMethod(rs.getString("payment_method"));
                    payment.setStatus(rs.getString("status"));
                    payment.setCreatedAt(parsePaymentDT(rs.getString("created_at")));
                    payment.setUpdatedAt(parsePaymentDT(rs.getString("updated_at")));
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
                    payment.setPaymentDate(parsePaymentDT(rs.getString("payment_date")));
                    payment.setAmount(rs.getBigDecimal("amount"));
                    payment.setPaymentMethod(rs.getString("payment_method"));
                    payment.setStatus(rs.getString("status"));
                    payment.setCreatedAt(parsePaymentDT(rs.getString("created_at")));
                    payment.setUpdatedAt(parsePaymentDT(rs.getString("updated_at")));
                    payments.add(payment);
                }
            }
        }
        return payments;
    }

    /** Flexible date/datetime parse: handles date-only, space- or T-separated,
        ISO nanoseconds, and null. getObject(LocalDateTime.class) threw on some values. */
    private static java.time.LocalDateTime parsePaymentDT(String value) {
        if (value == null || value.trim().isEmpty()) return null;
        String v = value.trim();
        try {
            if (v.length() <= 10) return java.time.LocalDate.parse(v).atStartOfDay();
            return utils.DateTimeParser.parseLocalDateTime(v);
        } catch (Exception e) { return null; }
    }

}