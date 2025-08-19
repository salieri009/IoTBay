package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CartItemDAO;
import dao.ProductDAO;
import db.DBConnection;
import model.CartItem;
import model.Product;
import model.User;
import utils.ResponseUtil;

@WebServlet({"/cart", "/api/cart/*"})
public class CartController extends HttpServlet {
    private CartItemDAO cartItemDAO;
    private ProductDAO productDAO;

    @Override
    public void init() {
        try {
            Connection connection = DBConnection.getConnection();
            cartItemDAO = new CartItemDAO(connection);
            productDAO = new ProductDAO(connection);
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException("Failed to initialize database connection", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo != null && pathInfo.startsWith("/api/")) {
            handleApiRequest(request, response);
            return;
        }
        
        // Handle traditional form submission
        handleFormSubmission(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo != null && pathInfo.startsWith("/api/")) {
            handleApiGet(request, response);
            return;
        }
        
        // Handle traditional page request
        handlePageRequest(request, response);
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleApiDelete(request, response);
    }

    private void handleApiRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        
        if (user == null) {
            ResponseUtil.sendJsonError(response, HttpServletResponse.SC_UNAUTHORIZED, "User not authenticated");
            return;
        }

        String pathInfo = request.getPathInfo();
        
        try {
            switch (pathInfo) {
                case "/api/add":
                    addToCartApi(request, response, user);
                    break;
                case "/api/update":
                    updateCartItemApi(request, response, user);
                    break;
                default:
                    ResponseUtil.sendJsonError(response, HttpServletResponse.SC_NOT_FOUND, "Endpoint not found");
            }
        } catch (Exception e) {
            ResponseUtil.sendJsonError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Error processing request: " + e.getMessage());
        }
    }

    private void handleApiGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        
        if (user == null) {
            ResponseUtil.sendJsonError(response, HttpServletResponse.SC_UNAUTHORIZED, "User not authenticated");
            return;
        }

        String pathInfo = request.getPathInfo();
        
        try {
            switch (pathInfo) {
                case "/api/items":
                    getCartItemsApi(response, user);
                    break;
                case "/api/count":
                    getCartItemCountApi(response, user);
                    break;
                case "/api/total":
                    getCartTotalApi(response, user);
                    break;
                default:
                    ResponseUtil.sendJsonError(response, HttpServletResponse.SC_NOT_FOUND, "Endpoint not found");
            }
        } catch (Exception e) {
            ResponseUtil.sendJsonError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Error processing request: " + e.getMessage());
        }
    }

    private void handleApiDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        
        if (user == null) {
            ResponseUtil.sendJsonError(response, HttpServletResponse.SC_UNAUTHORIZED, "User not authenticated");
            return;
        }

        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo != null && pathInfo.equals("/api/clear")) {
                clearCartApi(response, user);
            } else {
                removeFromCartApi(request, response, user);
            }
        } catch (Exception e) {
            ResponseUtil.sendJsonError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Error processing request: " + e.getMessage());
        }
    }

    private void handleFormSubmission(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        Integer userId;
        if (user != null) {
            userId = user.getId();
        } else {
            if (session.getAttribute("guestId") == null) {
                int guestId = -1 * new Random().nextInt(100000);
                session.setAttribute("guestId", guestId);
            }
            userId = (Integer) session.getAttribute("guestId");
        }

        String action = request.getParameter("action");
        try {
            if ("clear".equals(action)) {
                cartItemDAO.clearCartByUserId(userId);
                response.sendRedirect("cart");
                return;
            }

            // Secure input validation
            String productIdStr = request.getParameter("productId");
            String quantityStr = request.getParameter("quantity");
            String priceStr = request.getParameter("productPrice");
            
            if (productIdStr == null || quantityStr == null || priceStr == null) {
                throw new IllegalArgumentException("Missing required parameters");
            }

            int productId = Integer.parseInt(productIdStr);
            int quantity = Integer.parseInt(quantityStr);
            double price = Double.parseDouble(priceStr);
            
            // Additional business logic validation
            if (quantity <= 0 || quantity > 100) {
                throw new IllegalArgumentException("Quantity must be between 1 and 100");
            }
            if (price <= 0) {
                throw new IllegalArgumentException("Price must be greater than zero");
            }

            // Check product availability
            Product product = productDAO.getProductById(productId);
            if (product == null) {
                throw new IllegalArgumentException("Product not found");
            }
            
            if (product.getStockQuantity() < quantity) {
                throw new IllegalArgumentException("Insufficient stock available");
            }

            CartItem existingItem = cartItemDAO.getCartItem(userId, productId);

            if (existingItem != null) {
                int updatedQuantity = existingItem.getQuantity() + quantity;
                if (product.getStockQuantity() < updatedQuantity) {
                    throw new IllegalArgumentException("Insufficient stock for updated quantity");
                }
                cartItemDAO.updateCartItemQuantity(userId, productId, updatedQuantity);
            } else {
                CartItem newItem = new CartItem(userId, productId, quantity, price, LocalDateTime.now());
                cartItemDAO.addCartItem(newItem);
            }

            response.setStatus(HttpServletResponse.SC_OK);
            response.sendRedirect("product?productId=" + productId);

        } catch (SQLException e) {
            System.err.println("Database error in cart operation: " + e.getMessage());
            request.setAttribute("error", "Database error occurred");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            System.err.println("Invalid number format in cart operation: " + e.getMessage());
            request.setAttribute("error", "Invalid data format");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (IllegalArgumentException e) {
            System.err.println("Invalid argument in cart operation: " + e.getMessage());
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Unexpected cart error: " + e.getMessage());
            request.setAttribute("error", "Cart operation failed");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void handlePageRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        Integer userId;
        if (user != null) {
            userId = user.getId();
        } else {
            userId = (Integer) session.getAttribute("guestId");
        }

        try {
            List<CartItem> cartItems = (userId != null) ? 
                cartItemDAO.getCartItemsByUserId(userId) : 
                List.of();
            
            BigDecimal cartTotal = (userId != null) ? 
                cartItemDAO.getCartTotal(userId) : 
                BigDecimal.ZERO;
            
            int itemCount = (userId != null) ? 
                cartItemDAO.getCartItemCount(userId) : 
                0;

            request.setAttribute("cartItems", cartItems);
            request.setAttribute("cartTotal", cartTotal);
            request.setAttribute("itemCount", itemCount);
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
        } catch (SQLException e) {
            System.err.println("Database error in cart page: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
        } catch (Exception e) {
            System.err.println("Unexpected error in cart page: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load cart items");
        }
    }

    // API Methods
    private void addToCartApi(HttpServletRequest request, HttpServletResponse response, User user)
            throws Exception {
        
        String productIdStr = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");

        if (productIdStr == null || quantityStr == null) {
            ResponseUtil.sendJsonError(response, HttpServletResponse.SC_BAD_REQUEST, 
                "Product ID and quantity are required");
            return;
        }

        try {
            int productId = Integer.parseInt(productIdStr);
            int quantity = Integer.parseInt(quantityStr);

            if (quantity <= 0) {
                ResponseUtil.sendJsonError(response, HttpServletResponse.SC_BAD_REQUEST, 
                    "Quantity must be greater than zero");
                return;
            }

            Product product = productDAO.getProductById(productId);
            if (product == null) {
                ResponseUtil.sendJsonError(response, HttpServletResponse.SC_NOT_FOUND, 
                    "Product not found");
                return;
            }

            if (product.getStockQuantity() < quantity) {
                ResponseUtil.sendJsonError(response, HttpServletResponse.SC_BAD_REQUEST, 
                    "Insufficient stock available");
                return;
            }

            CartItem cartItem = new CartItem();
            cartItem.setUserId(user.getId());
            cartItem.setProductId(productId);
            cartItem.setQuantity(quantity);
            cartItem.setPrice(BigDecimal.valueOf(product.getPrice()));
            cartItem.setAddedAt(LocalDateTime.now());

            int itemId = cartItemDAO.addCartItem(cartItem);
            ResponseUtil.sendJsonResponse(response, "{\"success\": true, \"itemId\": " + itemId + "}");

        } catch (NumberFormatException e) {
            ResponseUtil.sendJsonError(response, HttpServletResponse.SC_BAD_REQUEST, 
                "Invalid product ID or quantity format");
        }
    }

    private void updateCartItemApi(HttpServletRequest request, HttpServletResponse response, User user)
            throws Exception {
        
        String productIdStr = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");

        if (productIdStr == null || quantityStr == null) {
            ResponseUtil.sendJsonError(response, HttpServletResponse.SC_BAD_REQUEST, 
                "Product ID and quantity are required");
            return;
        }

        try {
            int productId = Integer.parseInt(productIdStr);
            int quantity = Integer.parseInt(quantityStr);

            if (quantity < 0) {
                ResponseUtil.sendJsonError(response, HttpServletResponse.SC_BAD_REQUEST, 
                    "Quantity cannot be negative");
                return;
            }

            if (!cartItemDAO.isProductInCart(user.getId(), productId)) {
                ResponseUtil.sendJsonError(response, HttpServletResponse.SC_NOT_FOUND, 
                    "Item not found in cart");
                return;
            }

            if (quantity == 0) {
                cartItemDAO.deleteCartItem(user.getId(), productId);
            } else {
                Product product = productDAO.getProductById(productId);
                if (product != null && product.getStockQuantity() < quantity) {
                    ResponseUtil.sendJsonError(response, HttpServletResponse.SC_BAD_REQUEST, 
                        "Insufficient stock available");
                    return;
                }
                
                cartItemDAO.updateCartItemQuantity(user.getId(), productId, quantity);
            }

            ResponseUtil.sendJsonResponse(response, "{\"success\": true}");

        } catch (NumberFormatException e) {
            ResponseUtil.sendJsonError(response, HttpServletResponse.SC_BAD_REQUEST, 
                "Invalid product ID or quantity format");
        }
    }

    private void getCartItemsApi(HttpServletResponse response, User user)
            throws Exception {
        List<CartItem> cartItems = cartItemDAO.getCartItemsByUserId(user.getId());
        ResponseUtil.sendJsonResponse(response, cartItems);
    }

    private void getCartItemCountApi(HttpServletResponse response, User user)
            throws Exception {
        int count = cartItemDAO.getCartItemCount(user.getId());
        ResponseUtil.sendJsonResponse(response, "{\"count\": " + count + "}");
    }

    private void getCartTotalApi(HttpServletResponse response, User user)
            throws Exception {
        BigDecimal total = cartItemDAO.getCartTotal(user.getId());
        ResponseUtil.sendJsonResponse(response, "{\"total\": " + total + "}");
    }

    private void removeFromCartApi(HttpServletRequest request, HttpServletResponse response, User user)
            throws Exception {
        
        String productIdStr = request.getParameter("productId");

        if (productIdStr == null) {
            ResponseUtil.sendJsonError(response, HttpServletResponse.SC_BAD_REQUEST, 
                "Product ID is required");
            return;
        }

        try {
            int productId = Integer.parseInt(productIdStr);

            if (!cartItemDAO.isProductInCart(user.getId(), productId)) {
                ResponseUtil.sendJsonError(response, HttpServletResponse.SC_NOT_FOUND, 
                    "Item not found in cart");
                return;
            }

            cartItemDAO.deleteCartItem(user.getId(), productId);
            ResponseUtil.sendJsonResponse(response, "{\"success\": true}");

        } catch (NumberFormatException e) {
            ResponseUtil.sendJsonError(response, HttpServletResponse.SC_BAD_REQUEST, 
                "Invalid product ID format");
        }
    }

    private void clearCartApi(HttpServletResponse response, User user)
            throws Exception {
        
        cartItemDAO.clearCartByUserId(user.getId());
        ResponseUtil.sendJsonResponse(response, "{\"success\": true}");
    }
}