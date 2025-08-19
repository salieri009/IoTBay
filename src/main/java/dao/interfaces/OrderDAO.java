package dao.interfaces;

import java.sql.SQLException;
import java.util.List;

import model.Order;

public interface OrderDAO {
    void createOrder(Order order) throws SQLException;
    Order getOrderById(int id) throws SQLException;
    List<Order> getAllOrders() throws SQLException;
    List<Order> getOrdersByUserId(int userId) throws SQLException;
    void updateOrder(int id, Order order) throws SQLException;
    void deleteOrder(int id) throws SQLException;
    int getTotalOrderCount() throws SQLException;
    
    // Additional methods for controller compatibility
    Order findById(int id) throws SQLException;
}
