package service;

import dao.OrderDAO;
import model.Order;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.stream.Collectors;

/**
 * Order Service
 * Business logic for order management
 * 
 * Based on FEATURES.md Section 3.3: Order Management
 * - Order listing with filtering
 * - Order status management
 * - Order search functionality
 * - Order statistics
 */
public class OrderService {
    private final OrderDAO orderDAO;
    
    public OrderService(OrderDAO orderDAO) {
        this.orderDAO = orderDAO;
    }
    
    /**
     * Get user orders with filtering
     * 
     * @param userId User ID
     * @param statusFilter Order status filter (null for all)
     * @param dateRange Days to look back (null for all time)
     * @param orderNumber Order number search (null for all)
     * @return List of filtered orders
     */
    public List<Order> getUserOrders(int userId, String statusFilter, Integer dateRange, String orderNumber) throws SQLException {
        List<Order> allOrders;
        try {
            allOrders = orderDAO.getOrdersByUserId(userId);
        } catch (SQLException e) {
            throw new SQLException("Failed to retrieve user orders", e);
        }
        
        // Apply filters
        List<Order> filteredOrders = new ArrayList<>(allOrders);
        
        // Filter by status
        if (statusFilter != null && !statusFilter.isEmpty() && !"all".equalsIgnoreCase(statusFilter)) {
            filteredOrders = filteredOrders.stream()
                .filter(order -> statusFilter.equalsIgnoreCase(order.getStatus()))
                .collect(Collectors.toList());
        }
        
        // Filter by date range
        if (dateRange != null && dateRange > 0) {
            LocalDateTime cutoffDate = LocalDateTime.now().minus(dateRange, ChronoUnit.DAYS);
            filteredOrders = filteredOrders.stream()
                .filter(order -> order.getOrderDate() != null && order.getOrderDate().isAfter(cutoffDate))
                .collect(Collectors.toList());
        }
        
        // Filter by order number
        if (orderNumber != null && !orderNumber.trim().isEmpty()) {
            try {
                int orderId = Integer.parseInt(orderNumber.trim());
                filteredOrders = filteredOrders.stream()
                    .filter(order -> order.getId() == orderId)
                    .collect(Collectors.toList());
            } catch (NumberFormatException e) {
                // If not a number, search in order ID string representation
                filteredOrders = filteredOrders.stream()
                    .filter(order -> String.valueOf(order.getId()).contains(orderNumber.trim()))
                    .collect(Collectors.toList());
            }
        }
        
        return filteredOrders;
    }
    
    /**
     * Get order by ID with authorization check
     * 
     * @param orderId Order ID
     * @param userId User ID (for authorization)
     * @param isStaff Whether user is staff/admin
     * @return Order if found and authorized, null otherwise
     */
    public Order getOrderById(int orderId, int userId, boolean isStaff) throws SQLException {
        Order order = orderDAO.getOrderById(orderId);
        
        if (order == null) {
            return null;
        }
        
        // Check authorization
        if (!isStaff && order.getUserId() != userId) {
            return null; // Unauthorized
        }
        
        return order;
    }
    
    /**
     * Update order status
     * 
     * @param orderId Order ID
     * @param newStatus New status
     * @param userId User ID (for authorization)
     * @param isStaff Whether user is staff/admin
     * @return OrderOperationResult
     */
    public OrderOperationResult updateOrderStatus(int orderId, String newStatus, int userId, boolean isStaff) throws SQLException {
        OrderOperationResult result = new OrderOperationResult();
        
        // Only staff/admin can update order status
        if (!isStaff) {
            result.setSuccess(false);
            result.setErrorMessage("Only staff members can update order status");
            return result;
        }
        
        Order order = orderDAO.getOrderById(orderId);
        if (order == null) {
            result.setSuccess(false);
            result.setErrorMessage("Order not found");
            return result;
        }
        
        // Validate status
        if (!isValidStatus(newStatus)) {
            result.setSuccess(false);
            result.setErrorMessage("Invalid order status: " + newStatus);
            return result;
        }
        
        order.setStatus(newStatus);
        order.setUpdatedAt(LocalDateTime.now());
        // OrderDAO.updateOrder takes order as parameter
        orderDAO.updateOrder(order);
        
        result.setSuccess(true);
        result.setOrder(order);
        result.setMessage("Order status updated successfully");
        
        return result;
    }
    
    /**
     * Get order statistics for a user
     * 
     * @param userId User ID
     * @return OrderStatistics
     */
    public OrderStatistics getUserOrderStatistics(int userId) throws SQLException {
        OrderStatistics stats = new OrderStatistics();
        
        List<Order> orders = orderDAO.getOrdersByUserId(userId);
        
        stats.setTotalOrders(orders.size());
        
        // Calculate total spent
        BigDecimal totalSpent = orders.stream()
            .map(Order::getTotalAmount)
            .reduce(BigDecimal.ZERO, BigDecimal::add);
        stats.setTotalSpent(totalSpent);
        
        // Count by status
        Map<String, Integer> statusCounts = new HashMap<>();
        for (Order order : orders) {
            String status = order.getStatus();
            statusCounts.put(status, statusCounts.getOrDefault(status, 0) + 1);
        }
        stats.setStatusCounts(statusCounts);
        
        // Get recent orders (last 5)
        stats.setRecentOrders(orders.stream()
            .limit(5)
            .collect(Collectors.toList()));
        
        return stats;
    }
    
    /**
     * Get all orders with filtering (staff/admin only)
     * 
     * @param statusFilter Status filter
     * @param customerIdFilter Customer ID filter
     * @param dateFrom Start date
     * @param dateTo End date
     * @return List of filtered orders
     */
    public List<Order> getAllOrdersFiltered(String statusFilter, Integer customerIdFilter, 
                                           LocalDateTime dateFrom, LocalDateTime dateTo) throws SQLException {
        List<Order> allOrders;
        try {
            allOrders = orderDAO.getAllOrders();
        } catch (SQLException e) {
            throw new SQLException("Failed to retrieve all orders", e);
        }
        
        // Apply filters
        List<Order> filteredOrders = new ArrayList<>(allOrders);
        
        if (statusFilter != null && !statusFilter.isEmpty() && !"all".equalsIgnoreCase(statusFilter)) {
            filteredOrders = filteredOrders.stream()
                .filter(order -> statusFilter.equalsIgnoreCase(order.getStatus()))
                .collect(Collectors.toList());
        }
        
        if (customerIdFilter != null) {
            filteredOrders = filteredOrders.stream()
                .filter(order -> order.getUserId() == customerIdFilter)
                .collect(Collectors.toList());
        }
        
        if (dateFrom != null) {
            filteredOrders = filteredOrders.stream()
                .filter(order -> order.getOrderDate() != null && 
                        (order.getOrderDate().isAfter(dateFrom) || order.getOrderDate().isEqual(dateFrom)))
                .collect(Collectors.toList());
        }
        
        if (dateTo != null) {
            filteredOrders = filteredOrders.stream()
                .filter(order -> order.getOrderDate() != null && 
                        (order.getOrderDate().isBefore(dateTo) || order.getOrderDate().isEqual(dateTo)))
                .collect(Collectors.toList());
        }
        
        return filteredOrders;
    }
    
    /**
     * Validate order status
     */
    private boolean isValidStatus(String status) {
        if (status == null) {
            return false;
        }
        
        String upperStatus = status.toUpperCase();
        return upperStatus.equals("PENDING") ||
               upperStatus.equals("PROCESSING") ||
               upperStatus.equals("SHIPPED") ||
               upperStatus.equals("DELIVERED") ||
               upperStatus.equals("CANCELLED") ||
               upperStatus.equals("REFUNDED");
    }
    
    /**
     * Inner class for order operation results
     */
    public static class OrderOperationResult {
        private boolean success;
        private String message;
        private String errorMessage;
        private Order order;
        
        public boolean isSuccess() {
            return success;
        }
        
        public void setSuccess(boolean success) {
            this.success = success;
        }
        
        public String getMessage() {
            return message;
        }
        
        public void setMessage(String message) {
            this.message = message;
        }
        
        public String getErrorMessage() {
            return errorMessage;
        }
        
        public void setErrorMessage(String errorMessage) {
            this.errorMessage = errorMessage;
        }
        
        public Order getOrder() {
            return order;
        }
        
        public void setOrder(Order order) {
            this.order = order;
        }
    }
    
    /**
     * Inner class for order statistics
     */
    public static class OrderStatistics {
        private int totalOrders;
        private BigDecimal totalSpent;
        private Map<String, Integer> statusCounts;
        private List<Order> recentOrders;
        
        public int getTotalOrders() {
            return totalOrders;
        }
        
        public void setTotalOrders(int totalOrders) {
            this.totalOrders = totalOrders;
        }
        
        public BigDecimal getTotalSpent() {
            return totalSpent;
        }
        
        public void setTotalSpent(BigDecimal totalSpent) {
            this.totalSpent = totalSpent;
        }
        
        public Map<String, Integer> getStatusCounts() {
            return statusCounts;
        }
        
        public void setStatusCounts(Map<String, Integer> statusCounts) {
            this.statusCounts = statusCounts;
        }
        
        public List<Order> getRecentOrders() {
            return recentOrders;
        }
        
        public void setRecentOrders(List<Order> recentOrders) {
            this.recentOrders = recentOrders;
        }
    }
}

