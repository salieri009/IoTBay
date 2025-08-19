package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CartItemDAO;
import dao.OrderDAO;
import db.DBConnection;
import model.CartItem;
import model.Order;
import model.User;

@WebServlet("/checkout")
public class CheckoutController extends HttpServlet{
    private OrderDAO orderDAO;
    private CartItemDAO cartItemDao; 

    @Override
    public void init() {
        try {
            Connection connection = DBConnection.getConnection();
            orderDAO = new OrderDAO(connection);
            cartItemDao = new CartItemDAO(connection);
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException("Failed to initialize database connection", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        Integer userId;
        if (user != null) {
            userId = user.getId();
        } else {
            userId = (Integer) session.getAttribute("guestId");
        }

        try {
            // Get cart items
            List<CartItem> cartItems = cartItemDao.getCartItemsByUserId(userId);

            if (cartItems.isEmpty()) {
                response.sendRedirect("cart.jsp?error=Cart is empty");
                return;
            }

            // Calculate total using BigDecimal for accurate monetary calculations
            BigDecimal totalAmount = cartItems.stream()
                .map(item -> item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);

            // Create order
            Order order = new Order(0, userId, LocalDateTime.now(), "Pending", totalAmount);
            orderDAO.createOrder(order); 

            // Clear cart after checkout
            cartItemDao.clearCartByUserId(userId);

            response.sendRedirect("index.jsp");

        } catch (SQLException e) {
            System.err.println("Database error during checkout: " + e.getMessage());
            response.sendRedirect("cart.jsp?error=Database error occurred");
        } catch (NumberFormatException e) {
            System.err.println("Invalid number format during checkout: " + e.getMessage());
            response.sendRedirect("cart.jsp?error=Invalid data format");
        } catch (Exception e) {
            System.err.println("Unexpected checkout error: " + e.getMessage());
            response.sendRedirect("cart.jsp?error=Checkout failed");
        }
    }
}