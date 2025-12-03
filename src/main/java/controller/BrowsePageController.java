package controller;

import dao.ProductDAOImpl;
import dao.interfaces.ProductDAO;
import config.DIContainer;
import model.Product;
import utils.ErrorAction;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

/**
 * Controller to handle direct access to browse.jsp
 * This ensures browse.jsp always has product data when accessed directly
 */
@WebServlet({"/browse", "/browse.jsp"})
public class BrowsePageController extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DIContainer.getConnection();
            productDAO = new ProductDAOImpl(connection);
        } catch (Exception e) {
            throw new ServletException("Failed to initialize database connection", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get query parameters using SecurityUtil for validation
            String keyword = utils.SecurityUtil.getValidatedStringParameter(request, "q", 200);
            String categoryIdParam = utils.SecurityUtil.getValidatedStringParameter(request, "categoryId", 10);
            String categoryParam = utils.SecurityUtil.getValidatedStringParameter(request, "category", 100);
            String featuredParam = utils.SecurityUtil.getValidatedStringParameter(request, "featured", 10);
            String newParam = utils.SecurityUtil.getValidatedStringParameter(request, "new", 10);
            
            List<Product> products;
            String categoryName = null;
            Integer categoryId = null;
            
            // Handle featured products filter
            if ("true".equalsIgnoreCase(featuredParam)) {
                products = productDAO.getAllProducts();
                // Limit to first 50 for featured
                if (products.size() > 50) {
                    products = products.subList(0, 50);
                }
                request.setAttribute("keyword", "featured");
            }
            // Handle new arrivals filter
            else if ("true".equalsIgnoreCase(newParam)) {
                products = productDAO.getAllProducts();
                // Sort by creation date (newest first) - assuming getAllProducts returns sorted
                request.setAttribute("keyword", "new");
            }
            // Handle category filter
            else if (categoryParam != null && !categoryParam.trim().isEmpty()) {
                categoryName = categoryParam.trim();
                // Try to find category by name
                try {
                    dao.CategoryDAO categoryDAO = new dao.CategoryDAO(DIContainer.getConnection());
                    model.Category category = categoryDAO.getCategoryByName(categoryName);
                    if (category != null) {
                        categoryId = category.getId();
                        products = productDAO.getProductsByCategoryId(categoryId);
                    } else {
                        // Fallback: get all products if category not found
                        products = productDAO.getAllProducts();
                    }
                } catch (SQLException e) {
                    products = productDAO.getAllProducts();
                }
                request.setAttribute("category", categoryName);
                if (categoryId != null) {
                    request.setAttribute("categoryId", categoryId);
                }
            }
            // Handle category ID filter
            else if (categoryIdParam != null && !categoryIdParam.trim().isEmpty()) {
                try {
                    categoryId = Integer.parseInt(categoryIdParam);
                    products = productDAO.getProductsByCategoryId(categoryId);
                    request.setAttribute("categoryId", categoryId);
                } catch (NumberFormatException e) {
                    products = productDAO.getAllProducts();
                }
            }
            // Handle keyword search
            else if (keyword != null && !keyword.trim().isEmpty()) {
                products = productDAO.getProductsByName(keyword.trim());
                request.setAttribute("keyword", keyword);
            }
            // Default: get all products
            else {
                products = productDAO.getAllProducts();
            }
            
            // Set attributes for browse.jsp
            request.setAttribute("results", products);
            
            // Forward to browse.jsp
            request.getRequestDispatcher("/browse.jsp").forward(request, response);
            
        } catch (SQLException e) {
            ErrorAction.handleDatabaseError(request, response, e, "BrowsePageController.doGet");
        } catch (Exception e) {
            ErrorAction.handleServerError(request, response, e, "BrowsePageController.doGet");
        }
    }
}

