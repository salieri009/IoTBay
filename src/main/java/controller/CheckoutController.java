package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DIContainer;
import dao.CartItemDAO;
import dao.OrderDAO;
import model.CartItem;
import model.Order;
import model.User;

// Note: Mapped in web.xml to avoid conflicts
public class CheckoutController extends HttpServlet{
    private OrderDAO orderDAO;
    private CartItemDAO cartItemDao; 

    @Override
    public void init() throws ServletException {
        try {
            // Use DIContainer for dependency injection
            Connection connection = DIContainer.getConnection();
            orderDAO = new OrderDAO(connection);
            cartItemDao = new CartItemDAO(connection);
        } catch (Exception e) {
            throw new ServletException("Failed to initialize CheckoutController", e);
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
            
            if (cartItems == null || cartItems.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/cart.jsp?error=Cart is empty");
                return;
            }

            // Calculate totals - handle null items and prices
            BigDecimal subtotal = cartItems.stream()
                .filter(item -> item != null && item.getPrice() != null)
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
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error occurred while loading checkout");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (NullPointerException e) {
            System.err.println("Null pointer error in checkout: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error loading checkout: Missing required data");
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
        request.setCharacterEncoding("UTF-8");
        
        // Rate limiting check
        if (utils.SecurityUtil.isRateLimited(request, 10, 60000)) { // 10 requests per minute
            utils.ErrorAction.handleRateLimitError(request, response, "CheckoutController.doPost");
            return;
        }
        
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

            // CSRF protection for checkout
            if (!utils.SecurityUtil.validateCSRFToken(request)) {
                utils.ErrorAction.handleValidationError(request, response,
                        "CSRF token validation failed", "CheckoutController.doPost");
                return;
            }

            // Get cart items
            List<CartItem> cartItems = cartItemDao.getCartItemsByUserId(userId);

            if (cartItems == null || cartItems.isEmpty()) {
                response.sendRedirect("cart.jsp?error=Cart is empty");
                return;
            }

            // Validate shipping information if provided
            String shippingAddress = request.getParameter("shippingAddress");
            String shippingCity = request.getParameter("shippingCity");
            String shippingPostalCode = request.getParameter("shippingPostalCode");
            String shippingCountry = request.getParameter("shippingCountry");
            
            if (shippingAddress != null && !shippingAddress.trim().isEmpty()) {
                // Validate shipping address
                String addressError = utils.ValidationUtil.validateAddress(shippingAddress);
                if (addressError != null) {
                    utils.ErrorAction.handleValidationError(request, response, addressError,
                            "CheckoutController.doPost");
                    return;
                }
                
                // Sanitize shipping information
                shippingAddress = utils.SecurityUtil.sanitizeInput(shippingAddress);
                if (shippingCity != null) {
                    shippingCity = utils.SecurityUtil.sanitizeInput(shippingCity);
                }
                if (shippingPostalCode != null) {
                    shippingPostalCode = utils.SecurityUtil.sanitizeInput(shippingPostalCode);
                    // Validate postal code if provided
                    if (!shippingPostalCode.matches("^\\d{4}$")) {
                        utils.ErrorAction.handleValidationError(request, response,
                                "Invalid postal code format", "CheckoutController.doPost");
                        return;
                    }
                }
                if (shippingCountry != null) {
                    shippingCountry = utils.SecurityUtil.sanitizeInput(shippingCountry);
                }
            }

            // Calculate total using BigDecimal for accurate monetary calculations
            BigDecimal totalAmount = cartItems.stream()
                .filter(item -> item != null && item.getPrice() != null)
                .map(item -> item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
            
            // Validate total amount
            if (totalAmount.compareTo(BigDecimal.ZERO) <= 0) {
                utils.ErrorAction.handleValidationError(request, response,
                        "Invalid order total", "CheckoutController.doPost");
                return;
            }
            
            // Validate total amount is within reasonable range
            if (totalAmount.compareTo(BigDecimal.valueOf(1000000)) > 0) {
                utils.ErrorAction.handleValidationError(request, response,
                        "Order total exceeds maximum allowed amount", "CheckoutController.doPost");
                return;
            }

            // Create order
            Order order = new Order(0, userId, LocalDateTime.now(), "Pending", totalAmount);
            orderDAO.createOrder(order); 

            // Log security event
            utils.ErrorAction.logSecurityEvent("ORDER_CREATED", request,
                    "Order created for user: " + userId + ", Total: " + totalAmount);

            // Clear cart after checkout
            cartItemDao.clearCartByUserId(userId);

            response.sendRedirect("index.jsp");

        } catch (IllegalArgumentException e) {
            utils.ErrorAction.handleValidationError(request, response, e.getMessage(),
                    "CheckoutController.doPost");
        } catch (SQLException e) {
            utils.ErrorAction.handleDatabaseError(request, response, e, "CheckoutController.doPost");
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "CheckoutController.doPost");
        }
    }
}