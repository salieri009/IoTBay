package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import model.Order;

public class OrderDAO {
    private final Connection connection;

    public OrderDAO(Connection connection) {
        this.connection = connection;
    }

    // CREATE
    public int createOrder(Order order) throws SQLException {
        String query = "INSERT INTO \"order\" (user_id, order_date, status, total_amount, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            statement.setInt(1, order.getUserId());
            statement.setObject(2, order.getOrderDate());
            statement.setString(3, order.getStatus());
            statement.setBigDecimal(4, order.getTotalAmount());
            statement.setObject(5, LocalDateTime.now());
            statement.setObject(6, LocalDateTime.now());
            
            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
            throw new SQLException("Creating order failed, no ID obtained.");
        }
    }

    // READ: Get order by ID
    public Order getOrderById(int orderId) throws SQLException {
        String query = "SELECT order_id, user_id, order_date, status, total_amount, created_at, updated_at FROM \"order\" WHERE order_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, orderId);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("order_id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setOrderDate(rs.getObject("order_date", LocalDateTime.class));
                    order.setStatus(rs.getString("status"));
                    order.setTotalAmount(rs.getBigDecimal("total_amount"));
                    order.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                    order.setUpdatedAt(rs.getObject("updated_at", LocalDateTime.class));
                    return order;
                }
            }
        }
        return null;
    }

    // READ: Get all orders by user ID
    public List<Order> getOrdersByUserId(int userId) throws SQLException {
        String query = "SELECT order_id, user_id, order_date, status, total_amount, created_at, updated_at FROM \"order\" WHERE user_id = ? ORDER BY order_date DESC";
        List<Order> orders = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("order_id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setOrderDate(rs.getObject("order_date", LocalDateTime.class));
                    order.setStatus(rs.getString("status"));
                    order.setTotalAmount(rs.getBigDecimal("total_amount"));
                    order.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                    order.setUpdatedAt(rs.getObject("updated_at", LocalDateTime.class));
                    orders.add(order);
                }
            }
        }
        return orders;
    }

    // UPDATE: Update order status and total amount
    public void updateOrder(Order order) throws SQLException {
        String query = "UPDATE \"order\" SET order_date = ?, status = ?, total_amount = ?, updated_at = ? WHERE order_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setObject(1, order.getOrderDate());
            statement.setString(2, order.getStatus());
            statement.setBigDecimal(3, order.getTotalAmount());
            statement.setObject(4, LocalDateTime.now());
            statement.setInt(5, order.getId());
            statement.executeUpdate();
        }
    }

    // DELETE: Delete order by ID
    public void deleteOrder(int orderId) throws SQLException {
        String query = "DELETE FROM \"order\" WHERE order_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, orderId);
            statement.executeUpdate();
        }
    }

    public List<Order> searchOrders(int userId, Integer orderId, String orderDate) throws SQLException {
        String query = "SELECT order_id, user_id, order_date, status, total_amount, created_at, updated_at FROM \"order\" "
                    + "WHERE user_id = ? "
                    + "AND (? IS NULL OR order_id = ?) "
                    + "AND (? IS NULL OR date(replace(order_date, 'T', ' ')) = ?) "
                    + "ORDER BY order_date DESC";

        List<Order> orders = new ArrayList<>();

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);

            if (orderId == null) {
                statement.setNull(2, Types.INTEGER);
                statement.setNull(3, Types.INTEGER);
            } else {
                statement.setInt(2, orderId);
                statement.setInt(3, orderId);
            }

            if (orderDate == null || orderDate.isEmpty()) {
                statement.setNull(4, Types.VARCHAR);
                statement.setNull(5, Types.VARCHAR);
            } else {
                statement.setString(4, orderDate);
                statement.setString(5, orderDate);
            }

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("order_id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setOrderDate(rs.getObject("order_date", LocalDateTime.class));
                    order.setStatus(rs.getString("status"));
                    order.setTotalAmount(rs.getBigDecimal("total_amount"));
                    order.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                    order.setUpdatedAt(rs.getObject("updated_at", LocalDateTime.class));
                    orders.add(order);
                }
            }
        }

        return orders;
    }

    // GET orders by status
    public List<Order> getOrdersByStatus(String status) throws SQLException {
        String query = "SELECT order_id, user_id, order_date, status, total_amount, created_at, updated_at FROM \"order\" WHERE status = ? ORDER BY order_date DESC";
        List<Order> orders = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, status);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("order_id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setOrderDate(rs.getObject("order_date", LocalDateTime.class));
                    order.setStatus(rs.getString("status"));
                    order.setTotalAmount(rs.getBigDecimal("total_amount"));
                    order.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                    order.setUpdatedAt(rs.getObject("updated_at", LocalDateTime.class));
                    orders.add(order);
                }
            }
        }
        return orders;
    }

    // GET all orders (admin function)
    public List<Order> getAllOrders() throws SQLException {
        String query = "SELECT order_id, user_id, order_date, status, total_amount, created_at, updated_at FROM \"order\" ORDER BY order_date DESC";
        List<Order> orders = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("order_id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setOrderDate(rs.getObject("order_date", LocalDateTime.class));
                    order.setStatus(rs.getString("status"));
                    order.setTotalAmount(rs.getBigDecimal("total_amount"));
                    order.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                    order.setUpdatedAt(rs.getObject("updated_at", LocalDateTime.class));
                    orders.add(order);
                }
            }
        }
        return orders;
    }
}