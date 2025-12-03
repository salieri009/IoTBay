package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CategoryDAO;
import dao.ProductDAOImpl;
import dao.interfaces.ProductDAO;
import config.DIContainer;
import model.Category;
import model.Product;

/**
 * Category Controller
 * 
 * Handles category listing page
 */
@WebServlet("/categories")
public class CategoryController extends HttpServlet {
    private CategoryDAO categoryDAO;
    private ProductDAO productDAO;
    
    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DIContainer.getConnection();
            categoryDAO = new CategoryDAO(connection);
            this.productDAO = new ProductDAOImpl(connection);
        } catch (Exception e) {
            throw new ServletException("Failed to initialize database connection", e);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get all active categories
            List<Category> categories = categoryDAO.getActiveCategories();
            
            // If no categories found, try getting all categories (fallback)
            if (categories.isEmpty()) {
                categories = categoryDAO.getAllCategories();
            }
            
            // Get product count for each category
            Map<Integer, Integer> categoryProductCounts = new HashMap<>();
            for (Category category : categories) {
                int count = categoryDAO.getProductCountByCategoryId(category.getId());
                categoryProductCounts.put(category.getId(), count);
            }
            
            // Get popular products (top 8 products)
            List<Product> popularProducts = getPopularProducts(8);
            
            // Set attributes
            request.setAttribute("categories", categories);
            request.setAttribute("categoryProductCounts", categoryProductCounts);
            request.setAttribute("popularProducts", popularProducts);
            
            // Forward to categories.jsp
            request.getRequestDispatcher("/categories.jsp").forward(request, response);
            
        } catch (SQLException e) {
            utils.ErrorAction.handleDatabaseError(request, response, e, "CategoryController.doGet");
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "CategoryController.doGet");
        }
    }
    
    /**
     * Get popular products (featured or by sales)
     */
    private List<Product> getPopularProducts(int limit) {
        try {
            List<Product> allProducts = productDAO.getAllProducts();
            // Return top products (can be enhanced with actual popularity logic)
            if (allProducts.size() > limit) {
                return allProducts.subList(0, Math.min(limit, allProducts.size()));
            }
            return allProducts;
        } catch (SQLException e) {
            return new ArrayList<>();
        }
    }
}

