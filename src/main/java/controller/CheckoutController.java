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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            User user = (session != null) ? (User) session.getAttribute("user") : null;

            Integer userId;
            if (user != null) {
                userId = user.getId();
            } else {
                userId = (session != null) ? (Integer) session.getAttribute("guestId") : null;
            }

            if (userId == null) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }

            // Get cart items for checkout page
            List<CartItem> cartItems = cartItemDao.getCartItemsByUserId(userId);
            
            if (cartItems.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/cart.jsp?error=Cart is empty");
                return;
            }

            // Calculate totals
            BigDecimal subtotal = cartItems.stream()
                .map(item -> item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
            
            BigDecimal shipping = BigDecimal.valueOf(9.95);
            BigDecimal tax = subtotal.multiply(BigDecimal.valueOf(0.10)); // 10% GST
            BigDecimal total = subtotal.add(shipping).add(tax);

            request.setAttribute("cartItems", cartItems);
            request.setAttribute("subtotal", subtotal);
            request.setAttribute("shipping", shipping);
            request.setAttribute("tax", tax);
            request.setAttribute("total", total);
            request.getRequestDispatcher("/checkout.jsp").forward(request, response);
        } catch (SQLException e) {
            System.err.println("Database error loading checkout: " + e.getMessage());
            request.setAttribute("errorMessage", "Database error occurred");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error loading checkout: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to load checkout: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            User user = (session != null) ? (User) session.getAttribute("user") : null;

            Integer userId;
            if (user != null) {
                userId = user.getId();
            } else {
                userId = (session != null) ? (Integer) session.getAttribute("guestId") : null;
            }

            if (userId == null) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }

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