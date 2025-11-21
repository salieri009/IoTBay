package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ProductDAOImpl;
import dao.interfaces.ProductDAO;
import db.DBConnection;
import model.Product;
import model.User;

@WebServlet("/manage/products/update")
public class UpdateProductController extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DBConnection.getConnection();
            productDAO = new ProductDAOImpl(connection);
        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException("Failed to connect to database", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            utils.ErrorAction.handleAuthorizationError(request, response, "UpdateProductController.doPost");
            return;
        }

        // CSRF protection
        if (!utils.SecurityUtil.validateCSRFToken(request)) {
            utils.ErrorAction.handleValidationError(request, response,
                "CSRF token validation failed", "UpdateProductController.doPost");
            return;
        }

        try {
            // Secure parameter extraction with validation
            int id = utils.SecurityUtil.getValidatedIntParameter(request, "product_id", 1, Integer.MAX_VALUE);
            int categoryId = utils.SecurityUtil.getValidatedIntParameter(request, "categoryId", 1, 100);
            String name = utils.SecurityUtil.getValidatedStringParameter(request, "name", 200);
            String description = utils.SecurityUtil.getValidatedStringParameter(request, "description", 2000);
            double price = utils.SecurityUtil.getValidatedDoubleParameter(request, "price");
            int stockQuantity = utils.SecurityUtil.getValidatedIntParameter(request, "stockQuantity", 0, 10000);
            String imageUrl = utils.SecurityUtil.getValidatedStringParameter(request, "imageUrl", 500);
            
            // Validate price range
            if (price <= 0 || price > 1000000) {
                utils.ErrorAction.handleValidationError(request, response,
                        "Price must be between 0 and 1,000,000", "UpdateProductController.doPost");
                return;
            }

            // Sanitize inputs
            name = utils.SecurityUtil.sanitizeInput(name);
            description = utils.SecurityUtil.sanitizeInput(description);
            imageUrl = utils.SecurityUtil.sanitizeInput(imageUrl);

            String createdAtStr = request.getParameter("created_at");
            java.time.LocalDate createdAt;
            if (createdAtStr != null && !createdAtStr.trim().isEmpty()) {
                try {
                    createdAt = java.time.LocalDate.parse(createdAtStr);
                } catch (Exception e) {
                    utils.ErrorAction.handleValidationError(request, response,
                            "Invalid date format", "UpdateProductController.doPost");
                    return;
                }
            } else {
                createdAt = java.time.LocalDate.now();
            }

            Product updatedProduct = new Product(
                id,
                categoryId,
                name,
                description,
                price,
                stockQuantity,
                imageUrl,
                createdAt
            );

            productDAO.updateProduct(id, updatedProduct);

            response.sendRedirect(request.getContextPath() + "/manage/products");

        } catch (SQLException e) {
            utils.ErrorAction.handleDatabaseError(request, response, e, "UpdateProductController.doPost");
        } catch (IllegalArgumentException e) {
            utils.ErrorAction.handleValidationError(request, response, e.getMessage(), "UpdateProductController.doPost");
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "UpdateProductController.doPost");
        }
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return false;

        Object userObj = session.getAttribute("user");
        if (!(userObj instanceof User)) return false;

        User user = (User) userObj;
        return "staff".equalsIgnoreCase(user.getRole());
    }
}
