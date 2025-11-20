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
        orders.add(new Order(1, 1, BigDecimal.valueOf(199.99), LocalDateTime.now().minusDays(10), "Pending", "123 Main St, Sydney NSW 2000", "Credit Card"));
        orders.add(new Order(2, 1, BigDecimal.valueOf(299.50), LocalDateTime.now().minusDays(8), "Processing", "123 Main St, Sydney NSW 2000", "PayPal"));
        orders.add(new Order(3, 1, BigDecimal.valueOf(149.99), LocalDateTime.now().minusDays(5), "Shipped", "123 Main St, Sydney NSW 2000", "Credit Card"));

        // Test case 4-6: Orders for user 2
        orders.add(new Order(4, 2, BigDecimal.valueOf(449.99), LocalDateTime.now().minusDays(15), "Delivered", "456 Pitt St, Sydney NSW 2001", "Debit Card"));
        orders.add(new Order(5, 2, BigDecimal.valueOf(89.99), LocalDateTime.now().minusDays(12), "Processing", "456 Pitt St, Sydney NSW 2001", "PayPal"));
        orders.add(new Order(6, 2, BigDecimal.valueOf(199.50), LocalDateTime.now().minusDays(6), "Shipped", "456 Pitt St, Sydney NSW 2001", "Credit Card"));

        // Test case 7-9: Orders for user 3
        orders.add(new Order(7, 3, BigDecimal.valueOf(799.99), LocalDateTime.now().minusDays(20), "Delivered", "789 King St, Sydney NSW 2000", "Credit Card"));
        orders.add(new Order(8, 3, BigDecimal.valueOf(249.75), LocalDateTime.now().minusDays(14), "Delivered", "789 King St, Sydney NSW 2000", "PayPal"));
        orders.add(new Order(9, 3, BigDecimal.valueOf(349.99), LocalDateTime.now().minusDays(3), "Processing", "789 King St, Sydney NSW 2000", "Credit Card"));

        // Test case 10-12: Large orders
        orders.add(new Order(10, 1, BigDecimal.valueOf(1999.99), LocalDateTime.now().minusDays(25), "Delivered", "123 Main St, Sydney NSW 2000", "Credit Card"));
        orders.add(new Order(11, 2, BigDecimal.valueOf(1499.50), LocalDateTime.now().minusDays(22), "Delivered", "456 Pitt St, Sydney NSW 2001", "Credit Card"));
        orders.add(new Order(12, 3, BigDecimal.valueOf(2499.75), LocalDateTime.now().minusDays(18), "Delivered", "789 King St, Sydney NSW 2000", "PayPal"));

        // Test case 13-15: Small orders
        orders.add(new Order(13, 1, BigDecimal.valueOf(19.99), LocalDateTime.now().minusDays(7), "Shipped", "123 Main St, Sydney NSW 2000", "Credit Card"));
        orders.add(new Order(14, 2, BigDecimal.valueOf(29.99), LocalDateTime.now().minusDays(4), "Processing", "456 Pitt St, Sydney NSW 2001", "PayPal"));
        orders.add(new Order(15, 3, BigDecimal.valueOf(39.99), LocalDateTime.now().minusDays(2), "Pending", "789 King St, Sydney NSW 2000", "Debit Card"));

        // Test case 16-18: Different statuses - Pending
        orders.add(new Order(16, 1, BigDecimal.valueOf(599.99), LocalDateTime.now().minusDays(1), "Pending", "123 Main St, Sydney NSW 2000", "Credit Card"));
        orders.add(new Order(17, 2, BigDecimal.valueOf(699.50), LocalDateTime.now().minusHours(12), "Pending", "456 Pitt St, Sydney NSW 2001", "PayPal"));
        orders.add(new Order(18, 3, BigDecimal.valueOf(549.99), LocalDateTime.now().minusHours(2), "Pending", "789 King St, Sydney NSW 2000", "Credit Card"));

        // Test case 19-21: Cancelled orders
        orders.add(new Order(19, 1, BigDecimal.valueOf(399.99), LocalDateTime.now().minusDays(30), "Cancelled", "123 Main St, Sydney NSW 2000", "Credit Card"));
        orders.add(new Order(20, 2, BigDecimal.valueOf(349.99), LocalDateTime.now().minusDays(28), "Cancelled", "456 Pitt St, Sydney NSW 2001", "PayPal"));
        orders.add(new Order(21, 3, BigDecimal.valueOf(499.99), LocalDateTime.now().minusDays(26), "Cancelled", "789 King St, Sydney NSW 2000", "Credit Card"));

        // Test case 22-24: Refunded orders
        orders.add(new Order(22, 1, BigDecimal.valueOf(279.99), LocalDateTime.now().minusDays(35), "Refunded", "123 Main St, Sydney NSW 2000", "Credit Card"));
        orders.add(new Order(23, 2, BigDecimal.valueOf(189.99), LocalDateTime.now().minusDays(32), "Refunded", "456 Pitt St, Sydney NSW 2001", "PayPal"));
        orders.add(new Order(24, 3, BigDecimal.valueOf(219.99), LocalDateTime.now().minusDays(29), "Refunded", "789 King St, Sydney NSW 2000", "Debit Card"));

        // Test case 25-27: Orders with different addresses
        orders.add(new Order(25, 1, BigDecimal.valueOf(879.99), LocalDateTime.now().minusDays(11), "Shipped", "100 Elizabeth St, Sydney NSW 2000", "Credit Card"));
        orders.add(new Order(26, 2, BigDecimal.valueOf(679.50), LocalDateTime.now().minusDays(9), "Processing", "200 Oxford St, Paddington NSW 2021", "PayPal"));
        orders.add(new Order(27, 3, BigDecimal.valueOf(759.99), LocalDateTime.now().minusDays(7), "Delivered", "300 Crown St, Surry Hills NSW 2010", "Credit Card"));

        // Test case 28-30: Multiple payment methods
        orders.add(new Order(28, 1, BigDecimal.valueOf(959.99), LocalDateTime.now().minusDays(13), "Delivered", "123 Main St, Sydney NSW 2000", "Apple Pay"));
        orders.add(new Order(29, 2, BigDecimal.valueOf(1099.99), LocalDateTime.now().minusDays(10), "Shipped", "456 Pitt St, Sydney NSW 2001", "Google Pay"));
        orders.add(new Order(30, 3, BigDecimal.valueOf(1199.99), LocalDateTime.now().minusDays(5), "Processing", "789 King St, Sydney NSW 2000", "Bank Transfer"));
    }

    private int getNextId() {
        return orders.isEmpty() ? 1 : orders.get(orders.size() - 1).getId() + 1;
    }

    @Override
    public void createOrder(Order order) throws SQLException {
        Order newOrder = new Order(
            getNextId(),
            order.getUserId(),
            order.getTotalAmount(),
            order.getOrderDateTime(),
            order.getStatus(),
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
                    updatedOrder.getTotalAmount(),
                    updatedOrder.getOrderDateTime(),
                    updatedOrder.getStatus(),
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
