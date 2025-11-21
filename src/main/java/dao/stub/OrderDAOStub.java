package dao.stub;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

import dao.interfaces.OrderDAO;
import model.Order;

public class OrderDAOStub implements OrderDAO {
    private final List<Order> orders = new ArrayList<>();

    public OrderDAOStub() {
        // Comprehensive test data with 20+ test cases covering various scenarios
        // Test case 1-3: Basic orders for user 1
        orders.add(new Order(1, 1, LocalDateTime.now().minusDays(10), "Pending", BigDecimal.valueOf(199.99), "123 Main St, Sydney NSW 2000", "Credit Card"));
        orders.add(new Order(2, 1, LocalDateTime.now().minusDays(8), "Processing", BigDecimal.valueOf(299.50), "123 Main St, Sydney NSW 2000", "PayPal"));
        orders.add(new Order(3, 1, LocalDateTime.now().minusDays(5), "Shipped", BigDecimal.valueOf(149.99), "123 Main St, Sydney NSW 2000", "Credit Card"));

        // Test case 4-6: Orders for user 2
        orders.add(new Order(4, 2, LocalDateTime.now().minusDays(15), "Delivered", BigDecimal.valueOf(449.99), "456 Pitt St, Sydney NSW 2001", "Debit Card"));
        orders.add(new Order(5, 2, LocalDateTime.now().minusDays(12), "Processing", BigDecimal.valueOf(89.99), "456 Pitt St, Sydney NSW 2001", "PayPal"));
        orders.add(new Order(6, 2, LocalDateTime.now().minusDays(6), "Shipped", BigDecimal.valueOf(199.50), "456 Pitt St, Sydney NSW 2001", "Credit Card"));

        // Test case 7-9: Orders for user 3
        orders.add(new Order(7, 3, LocalDateTime.now().minusDays(20), "Delivered", BigDecimal.valueOf(799.99), "789 King St, Sydney NSW 2000", "Credit Card"));
        orders.add(new Order(8, 3, LocalDateTime.now().minusDays(14), "Delivered", BigDecimal.valueOf(249.75), "789 King St, Sydney NSW 2000", "PayPal"));
        orders.add(new Order(9, 3, LocalDateTime.now().minusDays(3), "Processing", BigDecimal.valueOf(349.99), "789 King St, Sydney NSW 2000", "Credit Card"));

        // Test case 10-12: Large orders
        orders.add(new Order(10, 1, LocalDateTime.now().minusDays(25), "Delivered", BigDecimal.valueOf(1999.99), "123 Main St, Sydney NSW 2000", "Credit Card"));
        orders.add(new Order(11, 2, LocalDateTime.now().minusDays(22), "Delivered", BigDecimal.valueOf(1499.50), "456 Pitt St, Sydney NSW 2001", "Credit Card"));
        orders.add(new Order(12, 3, LocalDateTime.now().minusDays(18), "Delivered", BigDecimal.valueOf(2499.75), "789 King St, Sydney NSW 2000", "PayPal"));

        // Test case 13-15: Small orders
        orders.add(new Order(13, 1, LocalDateTime.now().minusDays(7), "Shipped", BigDecimal.valueOf(19.99), "123 Main St, Sydney NSW 2000", "Credit Card"));
        orders.add(new Order(14, 2, LocalDateTime.now().minusDays(4), "Processing", BigDecimal.valueOf(29.99), "456 Pitt St, Sydney NSW 2001", "PayPal"));
        orders.add(new Order(15, 3, LocalDateTime.now().minusDays(2), "Pending", BigDecimal.valueOf(39.99), "789 King St, Sydney NSW 2000", "Debit Card"));

        // Test case 16-18: Different statuses - Pending
        orders.add(new Order(16, 1, LocalDateTime.now().minusDays(1), "Pending", BigDecimal.valueOf(599.99), "123 Main St, Sydney NSW 2000", "Credit Card"));
        orders.add(new Order(17, 2, LocalDateTime.now().minusHours(12), "Pending", BigDecimal.valueOf(699.50), "456 Pitt St, Sydney NSW 2001", "PayPal"));
        orders.add(new Order(18, 3, LocalDateTime.now().minusHours(2), "Pending", BigDecimal.valueOf(549.99), "789 King St, Sydney NSW 2000", "Credit Card"));

        // Test case 19-21: Cancelled orders
        orders.add(new Order(19, 1, LocalDateTime.now().minusDays(30), "Cancelled", BigDecimal.valueOf(399.99), "123 Main St, Sydney NSW 2000", "Credit Card"));
        orders.add(new Order(20, 2, LocalDateTime.now().minusDays(28), "Cancelled", BigDecimal.valueOf(349.99), "456 Pitt St, Sydney NSW 2001", "PayPal"));
        orders.add(new Order(21, 3, LocalDateTime.now().minusDays(26), "Cancelled", BigDecimal.valueOf(499.99), "789 King St, Sydney NSW 2000", "Credit Card"));

        // Test case 22-24: Refunded orders
        orders.add(new Order(22, 1, LocalDateTime.now().minusDays(35), "Refunded", BigDecimal.valueOf(279.99), "123 Main St, Sydney NSW 2000", "Credit Card"));
        orders.add(new Order(23, 2, LocalDateTime.now().minusDays(32), "Refunded", BigDecimal.valueOf(189.99), "456 Pitt St, Sydney NSW 2001", "PayPal"));
        orders.add(new Order(24, 3, LocalDateTime.now().minusDays(29), "Refunded", BigDecimal.valueOf(219.99), "789 King St, Sydney NSW 2000", "Debit Card"));

        // Test case 25-27: Orders with different addresses
        orders.add(new Order(25, 1, LocalDateTime.now().minusDays(11), "Shipped", BigDecimal.valueOf(879.99), "100 Elizabeth St, Sydney NSW 2000", "Credit Card"));
        orders.add(new Order(26, 2, LocalDateTime.now().minusDays(9), "Processing", BigDecimal.valueOf(679.50), "200 Oxford St, Paddington NSW 2021", "PayPal"));
        orders.add(new Order(27, 3, LocalDateTime.now().minusDays(7), "Delivered", BigDecimal.valueOf(759.99), "300 Crown St, Surry Hills NSW 2010", "Credit Card"));

        // Test case 28-30: Multiple payment methods
        orders.add(new Order(28, 1, LocalDateTime.now().minusDays(13), "Delivered", BigDecimal.valueOf(959.99), "123 Main St, Sydney NSW 2000", "Apple Pay"));
        orders.add(new Order(29, 2, LocalDateTime.now().minusDays(10), "Shipped", BigDecimal.valueOf(1099.99), "456 Pitt St, Sydney NSW 2001", "Google Pay"));
        orders.add(new Order(30, 3, LocalDateTime.now().minusDays(5), "Processing", BigDecimal.valueOf(1199.99), "789 King St, Sydney NSW 2000", "Bank Transfer"));
    }

    private int getNextId() {
        return orders.isEmpty() ? 1 : orders.get(orders.size() - 1).getId() + 1;
    }

    @Override
    public void createOrder(Order order) throws SQLException {
        Order newOrder = new Order(
            getNextId(),
            order.getUserId(),
            order.getOrderDateTime(),
            order.getStatus(),
            order.getTotalAmount(),
            order.getShippingAddress(),
            order.getPaymentMethod()
        );
        orders.add(newOrder);
    }

    @Override
    public Order getOrderById(int id) throws SQLException {
        return orders.stream()
                .filter(order -> order.getId() == id)
                .findFirst()
                .orElse(null);
    }

    @Override
    public List<Order> getAllOrders() throws SQLException {
        return new ArrayList<>(orders);
    }

    @Override
    public List<Order> getOrdersByUserId(int userId) throws SQLException {
        List<Order> result = new ArrayList<>();
        for (Order order : orders) {
            if (order.getUserId() == userId) {
                result.add(order);
            }
        }
        return result;
    }

    @Override
    public void updateOrder(int id, Order updatedOrder) throws SQLException {
        for (int i = 0; i < orders.size(); i++) {
            if (orders.get(i).getId() == id) {
                Order oldOrder = orders.get(i);
                Order newOrder = new Order(
                    id,
                    updatedOrder.getUserId(),
                    updatedOrder.getOrderDateTime(),
                    updatedOrder.getStatus(),
                    updatedOrder.getTotalAmount(),
                    updatedOrder.getShippingAddress(),
                    updatedOrder.getPaymentMethod()
                );
                orders.set(i, newOrder);
                return;
            }
        }
    }

    @Override
    public void deleteOrder(int id) throws SQLException {
        orders.removeIf(order -> order.getId() == id);
    }

    @Override
    public int getTotalOrderCount() throws SQLException {
        return orders.size();
    }

    @Override
    public Order findById(int id) throws SQLException {
        return getOrderById(id);
    }
}
