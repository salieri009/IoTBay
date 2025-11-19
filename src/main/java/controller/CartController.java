package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DIContainer;
import dao.CartItemDAO;
import dao.ProductDAO;
import model.CartItem;
import model.Product;
import model.User;
import service.CartService;
import service.CartService.CartOperationResult;
import service.CartService.CartSummary;
import utils.ResponseUtil;

// Note: Mapped in web.xml to avoid conflicts
public class CartController extends HttpServlet {
    private CartItemDAO cartItemDAO;
    private ProductDAO productDAO;
    private CartService cartService;

    @Override
    public void init() throws ServletException {
        try {
            // Use DIContainer for dependency injection
            Connection connection = DIContainer.getConnection();
            cartItemDAO = new CartItemDAO(connection);
            productDAO = new ProductDAO(connection);
            cartService = new CartService(cartItemDAO, productDAO);
        } catch (Exception e) {
            throw new ServletException("Failed to initialize CartController", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();
        String path = requestURI.substring(contextPath.length());
        
        // Check if this is an API request (/api/cart/*)
        if (path.startsWith("/api/cart/")) {
            handleApiRequest(request, response);
            return;
        }
        
        // Handle traditional form submission (/cart)
        handleFormSubmission(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();
        String path = requestURI.substring(contextPath.length());
        
        // Check if this is an API request (/api/cart/*)
        if (path.startsWith("/api/cart/")) {
            handleApiGet(request, response);
            return;
        }
        
        // Handle traditional page request (/cart or /cart.jsp)
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

        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();
        String path = requestURI.substring(contextPath.length());
        
        // Extract the endpoint after /api/cart/
        String endpoint = path.substring("/api/cart".length());
        
        try {
            if (endpoint.equals("/add") || endpoint.equals("/")) {
                addToCartApi(request, response, user);
            } else if (endpoint.equals("/update")) {
                updateCartItemApi(request, response, user);
            } else {
                ResponseUtil.sendJsonError(response, HttpServletResponse.SC_NOT_FOUND, "Endpoint not found: " + endpoint);
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

        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();
        String path = requestURI.substring(contextPath.length());
        
        // Extract the endpoint after /api/cart/
        String endpoint = path.substring("/api/cart".length());
        
        try {
            if (endpoint.equals("/items") || endpoint.equals("/")) {
                getCartItemsApi(request, response, user);
            } else if (endpoint.equals("/count")) {
                getCartItemCountApi(response, user);
            } else if (endpoint.equals("/total")) {
                getCartTotalApi(response, user);
            } else {
                ResponseUtil.sendJsonError(response, HttpServletResponse.SC_NOT_FOUND, "Endpoint not found: " + endpoint);
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

        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();
        String path = requestURI.substring(contextPath.length());
        
        // Extract the endpoint after /api/cart/
        String endpoint = path.substring("/api/cart".length());
        
        try {
            if (endpoint.equals("/clear")) {
                clearCartApi(response, user);
            } else if (endpoint.equals("/remove")) {
                removeFromCartApi(request, response, user);
            } else {
                ResponseUtil.sendJsonError(response, HttpServletResponse.SC_NOT_FOUND, "Endpoint not found: " + endpoint);
            }
        } catch (Exception e) {
            ResponseUtil.sendJsonError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Error processing request: " + e.getMessage());
        }
    }

    private void handleFormSubmission(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Rate limiting check
        if (utils.SecurityUtil.isRateLimited(request, 20, 60000)) { // 20 requests per minute
            utils.ErrorAction.handleRateLimitError(request, response, "CartController.handleFormSubmission");
            return;
        }
        
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
            // Validate action parameter
            if (action != null && !action.matches("^[a-zA-Z]+$")) {
                utils.ErrorAction.handleValidationError(request, response, 
                        "Invalid action parameter", "CartController.handleFormSubmission");
                return;
            }
            
            if ("clear".equals(action)) {
                // CSRF check for destructive operations
                if (!utils.SecurityUtil.validateCSRFToken(request)) {
                    utils.ErrorAction.handleValidationError(request, response, 
                            "CSRF token validation failed", "CartController.clearCart");
                    return;
                }
                cartItemDAO.clearCartByUserId(userId);
                utils.ErrorAction.logSecurityEvent("CART_CLEARED", request, 
                        "Cart cleared for user: " + userId);
                response.sendRedirect("cart");
                return;
            }

            // Secure input validation using SecurityUtil
            int productId = utils.SecurityUtil.getValidatedIntParameter(request, "productId", 1, Integer.MAX_VALUE);
            int quantity = utils.SecurityUtil.getValidatedIntParameter(request, "quantity", 1, 100);
            double price = utils.SecurityUtil.getValidatedDoubleParameter(request, "productPrice");
            
            // Validate price range
            if (price <= 0 || price > 1000000) {
                utils.ErrorAction.handleValidationError(request, response, 
                        "Invalid price range", "CartController.handleFormSubmission");
                return;
            }

            // Check product availability
            Product product = productDAO.getProductById(productId);
            if (product == null) {
                utils.ErrorAction.handleValidationError(request, response, 
                        "Product not found", "CartController.handleFormSubmission");
                return;
            }
            
            if (product.getStockQuantity() < quantity) {
                utils.ErrorAction.handleValidationError(request, response, 
                        "Insufficient stock available", "CartController.handleFormSubmission");
                return;
            }

            CartItem existingItem = cartItemDAO.getCartItem(userId, productId);

            if (existingItem != null) {
                int updatedQuantity = existingItem.getQuantity() + quantity;
                if (product.getStockQuantity() < updatedQuantity) {
                    utils.ErrorAction.handleValidationError(request, response, 
                            "Insufficient stock for updated quantity", "CartController.handleFormSubmission");
                    return;
                }
                cartItemDAO.updateCartItemQuantity(userId, productId, updatedQuantity);
            } else {
                CartItem newItem = new CartItem(userId, productId, quantity, price, LocalDateTime.now());
                cartItemDAO.addCartItem(newItem);
            }
            
            // Log security event
            utils.ErrorAction.logSecurityEvent("CART_ITEM_ADDED", request, 
                    "Product ID: " + productId + ", Quantity: " + quantity);

            response.setStatus(HttpServletResponse.SC_OK);
            response.sendRedirect("product?productId=" + productId);

        } catch (IllegalArgumentException e) {
            utils.ErrorAction.handleValidationError(request, response, e.getMessage(), 
                    "CartController.handleFormSubmission");
        } catch (SQLException e) {
            utils.ErrorAction.handleDatabaseError(request, response, e, "CartController.handleFormSubmission");
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "CartController.handleFormSubmission");
        }
    }

    private void handlePageRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            HttpSession session = request.getSession(false);
            User user = (session != null) ? (User) session.getAttribute("user") : null;

            Integer userId;
            if (user != null) {
                userId = user.getId();
            } else {
                userId = (session != null) ? (Integer) session.getAttribute("guestId") : null;
            }

            List<CartItem> cartItems = Collections.emptyList();
            BigDecimal cartTotal = BigDecimal.ZERO;
            int itemCount = 0;

            if (userId != null) {
                try {
                    cartItems = cartItemDAO.getCartItemsByUserId(userId);
                    if (cartItems == null) {
                        cartItems = Collections.emptyList();
                    }
                    cartTotal = cartItemDAO.getCartTotal(userId);
                    if (cartTotal == null) {
                        cartTotal = BigDecimal.ZERO;
                    }
                    itemCount = cartItemDAO.getCartItemCount(userId);
                } catch (Exception e) {
                    System.err.println("Error loading cart: " + e.getMessage());
                    e.printStackTrace();
                    // Continue with empty cart
                    cartItems = Collections.emptyList();
                    cartTotal = BigDecimal.ZERO;
                    itemCount = 0;
                }
            }

            request.setAttribute("cartItems", cartItems);
            request.setAttribute("cartTotal", cartTotal);
            request.setAttribute("itemCount", itemCount);
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
        } catch (NullPointerException e) {
            System.err.println("Null pointer error in cart page: " + e.getMessage());
            e.printStackTrace();
            // Set safe defaults and continue
            request.setAttribute("cartItems", Collections.emptyList());
            request.setAttribute("cartTotal", BigDecimal.ZERO);
            request.setAttribute("itemCount", 0);
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Unexpected error in cart page: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Unable to load cart: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
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

            // Use CartService for business logic and compatibility checking
            CartOperationResult result = cartService.addToCart(user.getId(), productId, quantity);
            
            if (result.isSuccess()) {
                // Build response with compatibility warnings if any
                StringBuilder jsonResponse = new StringBuilder();
                jsonResponse.append("{\"success\": true, \"message\": \"")
                           .append(result.getMessage().replace("\"", "\\\""))
                           .append("\"");
                
                if (result.getCompatibilityIssues() != null && !result.getCompatibilityIssues().isEmpty()) {
                    jsonResponse.append(", \"compatibilityWarnings\": [");
                    for (int i = 0; i < result.getCompatibilityIssues().size(); i++) {
                        if (i > 0) jsonResponse.append(",");
                        service.CompatibilityEngine.CompatibilityIssue issue = result.getCompatibilityIssues().get(i);
                        jsonResponse.append("{\"type\": \"").append(issue.getType().name())
                                   .append("\", \"message\": \"").append(issue.getMessage().replace("\"", "\\\""))
                                   .append("\", \"severity\": \"").append(issue.getSeverity()).append("\"}");
                    }
                    jsonResponse.append("]");
                }
                
                jsonResponse.append("}");
                ResponseUtil.sendJsonResponse(response, jsonResponse.toString());
            } else {
                ResponseUtil.sendJsonError(response, HttpServletResponse.SC_BAD_REQUEST, 
                    result.getErrorMessage());
            }

        } catch (NumberFormatException e) {
            ResponseUtil.sendJsonError(response, HttpServletResponse.SC_BAD_REQUEST, 
                "Invalid product ID or quantity format");
        } catch (SQLException e) {
            ResponseUtil.sendJsonError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Database error: " + e.getMessage());
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

    private void getCartItemsApi(HttpServletRequest request, HttpServletResponse response, User user)
            throws Exception {
        try {
            CartSummary summary = cartService.getCartSummary(user.getId());
            
            // Build comprehensive response with compatibility information
            StringBuilder jsonResponse = new StringBuilder();
            jsonResponse.append("{\"items\": [");
            
            List<CartItem> items = summary.getItems();
            for (int i = 0; i < items.size(); i++) {
                if (i > 0) jsonResponse.append(",");
                CartItem item = items.get(i);
                jsonResponse.append("{\"id\": ").append(item.getId())
                           .append(", \"productId\": ").append(item.getProductId())
                           .append(", \"quantity\": ").append(item.getQuantity())
                           .append(", \"price\": ").append(item.getPrice())
                           .append("}");
            }
            
            jsonResponse.append("], \"total\": ").append(summary.getTotal())
                       .append(", \"itemCount\": ").append(summary.getItemCount());
            
            // Add compatibility warnings if any
            if (summary.getCompatibilityIssues() != null && !summary.getCompatibilityIssues().isEmpty()) {
                jsonResponse.append(", \"compatibilityWarnings\": [");
                for (int i = 0; i < summary.getCompatibilityIssues().size(); i++) {
                    if (i > 0) jsonResponse.append(",");
                    service.CompatibilityEngine.CompatibilityIssue issue = summary.getCompatibilityIssues().get(i);
                    jsonResponse.append("{\"type\": \"").append(issue.getType().name())
                               .append("\", \"message\": \"").append(issue.getMessage().replace("\"", "\\\""))
                               .append("\", \"severity\": \"").append(issue.getSeverity()).append("\"}");
                }
                jsonResponse.append("]");
            }
            
            jsonResponse.append("}");
            ResponseUtil.sendJsonResponse(response, jsonResponse.toString());
            
        } catch (SQLException e) {
            ResponseUtil.sendJsonError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Database error: " + e.getMessage());
        }
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
        
        // Support both itemId and productId for backward compatibility
        String productIdStr = request.getParameter("productId");
        String itemIdStr = request.getParameter("itemId");
        
        // If itemId is provided, try to get productId from cart item
        if (productIdStr == null && itemIdStr != null) {
            try {
                int itemId = Integer.parseInt(itemIdStr);
                CartItem cartItem = cartItemDAO.getCartItemById(itemId);
                if (cartItem != null && cartItem.getUserId() == user.getId()) {
                    productIdStr = String.valueOf(cartItem.getProductId());
                }
            } catch (Exception e) {
                // Fall through to error handling
            }
        }

        if (productIdStr == null) {
            ResponseUtil.sendJsonError(response, HttpServletResponse.SC_BAD_REQUEST, 
                "Product ID or Item ID is required");
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
            
            // Get updated cart summary
            CartSummary summary = cartService.getCartSummary(user.getId());
            
            // Build response with updated cart info
            StringBuilder jsonResponse = new StringBuilder();
            jsonResponse.append("{\"success\": true, \"message\": \"Item removed from cart\"");
            jsonResponse.append(", \"itemCount\": ").append(summary.getItemCount());
            jsonResponse.append(", \"total\": ").append(summary.getTotal());
            jsonResponse.append("}");
            
            ResponseUtil.sendJsonResponse(response, jsonResponse.toString());

        } catch (NumberFormatException e) {
            ResponseUtil.sendJsonError(response, HttpServletResponse.SC_BAD_REQUEST, 
                "Invalid product ID format");
        } catch (SQLException e) {
            ResponseUtil.sendJsonError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Database error: " + e.getMessage());
        }
    }

    private void clearCartApi(HttpServletResponse response, User user)
            throws Exception {
        
        cartItemDAO.clearCartByUserId(user.getId());
        ResponseUtil.sendJsonResponse(response, "{\"success\": true}");
    }
}