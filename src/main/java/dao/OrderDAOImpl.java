package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

import dao.interfaces.OrderDAO;
import model.Order;

public class OrderDAOImpl implements OrderDAO {
    private final Connection connection;

    public OrderDAOImpl(Connection connection) {
        this.connection = connection;
    }

    @Override
    public void createOrder(Order order) throws SQLException {
        String query = "INSERT INTO orders (user_id, total_amount, order_date, status, shipping_address, payment_method) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, order.getUserId());
            pstmt.setBigDecimal(2, order.getTotalAmount());
            pstmt.setTimestamp(3, order.getOrderDateAsTimestamp());
            pstmt.setString(4, order.getStatus());
            pstmt.setString(5, order.getShippingAddress());
            pstmt.setString(6, order.getPaymentMethod());
            pstmt.executeUpdate();
        }
    }

    @Override
    public Order getOrderById(int id) throws SQLException {
        String query = "SELECT id, user_id, total_amount, order_date, status, shipping_address, payment_method FROM orders WHERE id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return createOrderFromResultSet(rs);
                }
            }
        }
        return null;
    }

    @Override
    public List<Order> getAllOrders() throws SQLException {
        String query = "SELECT id, user_id, total_amount, order_date, status, shipping_address, payment_method FROM orders ORDER BY order_date DESC";
        List<Order> orders = new ArrayList<>();
        
        try (PreparedStatement pstmt = connection.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                orders.add(createOrderFromResultSet(rs));
            }
        }
        
        return orders;
    }

    @Override
    public List<Order> getOrdersByUserId(int userId) throws SQLException {
        String query = "SELECT id, user_id, total_amount, order_date, status, shipping_address, payment_method FROM orders WHERE user_id = ? ORDER BY order_date DESC";
        List<Order> orders = new ArrayList<>();
        
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    orders.add(createOrderFromResultSet(rs));
                }
            }
        }
        
        return orders;
    }

    @Override
    public void updateOrder(int id, Order order) throws SQLException {
        String query = "UPDATE orders SET user_id = ?, total_amount = ?, order_date = ?, status = ?, shipping_address = ?, payment_method = ? WHERE id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, order.getUserId());
            pstmt.setBigDecimal(2, order.getTotalAmount());
            pstmt.setTimestamp(3, order.getOrderDateAsTimestamp());
            pstmt.setString(4, order.getStatus());
            pstmt.setString(5, order.getShippingAddress());
            pstmt.setString(6, order.getPaymentMethod());
            pstmt.setInt(7, id);
            pstmt.executeUpdate();
        }
    }

    @Override
    public void deleteOrder(int id) throws SQLException {
        String query = "DELETE FROM orders WHERE id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        }
    }

    @Override
    public int getTotalOrderCount() throws SQLException {
        String query = "SELECT COUNT(*) FROM orders";
        try (PreparedStatement pstmt = connection.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0;
        }
    }

    private Order createOrderFromResultSet(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setId(rs.getInt("id"));
        order.setUserId(rs.getInt("user_id"));
        order.setTotalAmount(rs.getBigDecimal("total_amount"));
        order.setOrderDate(rs.getTimestamp("order_date"));
        order.setStatus(rs.getString("status"));
        order.setShippingAddress(rs.getString("shipping_address"));
        order.setPaymentMethod(rs.getString("payment_method"));
        return order;
    }

    @Override
    public Order findById(int id) throws SQLException {
        return getOrderById(id);
    }
}
