package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ProductDAOImpl;
import dao.interfaces.ProductDAO;
import config.DIContainer;
import model.Product;
import model.User;

@WebServlet("/api/manage/products/*")
public class ManageProductController extends HttpServlet {

    // Stateless Controller: No instance variables for DAO or Connection

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            utils.ErrorAction.handleAuthorizationError(request, response, "ManageProductController.doGet");
            return;
        }

        // Try-with-resources removed as DAOs manage their own connections
        try {
            ProductDAO productDAO = new ProductDAOImpl();

            String pathInfo = request.getPathInfo();

            // Validate pathInfo
            if (pathInfo != null && !pathInfo.isEmpty() && !pathInfo.equals("/") && !pathInfo.equals("/form")) {
                // Return 404 for invalid paths instead of 500/400 generic error
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            // Check if requesting form page
            if (pathInfo != null && pathInfo.equals("/form")) {
                // Get categories for dropdown
                try {
                    dao.CategoryDAO categoryDAO = new dao.CategoryDAO();
                    List<model.Category> categories = categoryDAO.getAllCategories();
                    request.setAttribute("categories", categories);
                } catch (Exception e) {
                    // Log warning but continue - form can still load, just without categories
                    System.err
                            .println("[ManageProductController] Warning: Failed to load categories: " + e.getMessage());
                }
                request.getRequestDispatcher("/manage-product-form.jsp").forward(request, response);
                return;
            }

            // Default: show product list
            List<Product> products = productDAO.getAllProducts(); // Get all products
            request.setAttribute("products", products); // Add products to request attribute

            // Forward to JSP page to display products
            request.getRequestDispatcher("/WEB-INF/views/manage-products.jsp").forward(request, response);

        } catch (SQLException e) {
            utils.ErrorAction.handleDatabaseError(request, response, e, "ManageProductController.doGet");
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "ManageProductController.doGet");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Authorization check
        if (!isAdmin(request)) {
            utils.ErrorAction.handleAuthorizationError(request, response, "ManageProductController.doPost");
            return;
        }

        // CSRF protection
        if (!utils.SecurityUtil.validateCSRFToken(request)) {
            utils.ErrorAction.handleValidationError(request, response, "CSRF token validation failed",
                    "ManageProductController.doPost");
            return;
        }

        // Rate limiting check
        if (utils.SecurityUtil.isRateLimited(request, 10, 60000)) { // 10 requests per minute
            utils.ErrorAction.handleRateLimitError(request, response, "ManageProductController.doPost");
            return;
        }

        try {
            ProductDAO productDAO = new ProductDAOImpl();

            // Secure parameter extraction with validation
            int categoryId = utils.SecurityUtil.getValidatedIntParameter(request, "categoryId", 1, 100);
            String name = utils.SecurityUtil.getValidatedStringParameter(request, "name", 200);
            String description = utils.SecurityUtil.getValidatedStringParameter(request, "description", 2000);
            double price = utils.SecurityUtil.getValidatedDoubleParameter(request, "price");
            int stockQuantity = utils.SecurityUtil.getValidatedIntParameter(request, "stockQuantity", 0, 10000);
            String imageUrl = utils.SecurityUtil.getValidatedStringParameter(request, "imageUrl", 500);

            // Sanitize inputs
            name = utils.SecurityUtil.sanitizeInput(name);
            description = utils.SecurityUtil.sanitizeInput(description);
            imageUrl = utils.SecurityUtil.sanitizeInput(imageUrl);

            // Validate price range
            if (price <= 0 || price > 1000000) {
                utils.ErrorAction.handleValidationError(request, response,
                        "Price must be between 0 and 1,000,000", "ManageProductController.doPost");
                return;
            }

            String createdAtStr = request.getParameter("created_at");
            java.time.LocalDate createdAt;
            if (createdAtStr != null && !createdAtStr.trim().isEmpty()) {
                try {
                    createdAt = java.time.LocalDate.parse(createdAtStr);
                } catch (Exception e) {
                    utils.ErrorAction.handleValidationError(request, response,
                            "Invalid date format", "ManageProductController.doPost");
                    return;
                }
            } else {
                createdAt = java.time.LocalDate.now();
            }

            Product product = new Product(0, categoryId, name, description, price, stockQuantity, imageUrl, createdAt);

            productDAO.createProduct(product);

            // Log security event
            utils.ErrorAction.logSecurityEvent("PRODUCT_CREATED", request,
                    "Product created: " + name);

            response.sendRedirect(request.getContextPath() + "/manage/products");

        } catch (IllegalArgumentException e) {
            utils.ErrorAction.handleValidationError(request, response, e.getMessage(),
                    "ManageProductController.doPost");
        } catch (SQLException e) {
            utils.ErrorAction.handleDatabaseError(request, response, e, "ManageProductController.doPost");
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "ManageProductController.doPost");
        }
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null)
            return false;

        Object userObj = session.getAttribute("user");
        if (!(userObj instanceof User))
            return false;

        User user = (User) userObj;
        return "staff".equalsIgnoreCase(user.getRole());
    }
}
