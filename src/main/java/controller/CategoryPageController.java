package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
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
import db.DBConnection;
import model.Category;
import model.Product;

/**
 * Category Page Controller
 * 
 * Handles individual category pages (e.g., /category-smarthome.jsp)
 * Maps to /category/* URL pattern
 */
@WebServlet("/category/*")
public class CategoryPageController extends HttpServlet {
    private CategoryDAO categoryDAO;
    private ProductDAO productDAO;
    
    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DBConnection.getConnection();
            this.categoryDAO = new CategoryDAO(connection);
            this.productDAO = new ProductDAOImpl(connection);
        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException("Failed to initialize database connection", e);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Extract category name from path
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendRedirect(request.getContextPath() + "/categories");
            return;
        }
        
        // Remove leading slash and get category name
        String categorySlug = pathInfo.substring(1);
        
        // Map slug to category name
        String categoryName = mapSlugToCategoryName(categorySlug);
        
        try {
            // Get category by name
            Category category = categoryDAO.getCategoryByName(categoryName);
            
            if (category == null) {
                // Try to find by slug directly
                category = findCategoryBySlug(categorySlug);
            }
            
            if (category == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Category not found");
                return;
            }
            
            // Get products for this category
            List<Product> products = productDAO.getProductsByCategoryId(category.getId());
            
            // Get product count
            int productCount = categoryDAO.getProductCountByCategoryId(category.getId());
            
            // Set attributes
            request.setAttribute("category", category);
            request.setAttribute("products", products);
            request.setAttribute("productCount", productCount);
            
            // Forward to appropriate JSP based on category
            String jspPath = getJspPathForCategory(categorySlug);
            request.getRequestDispatcher(jspPath).forward(request, response);
            
        } catch (SQLException e) {
            throw new ServletException("Database error while fetching category data", e);
        }
    }
    
    /**
     * Map URL slug to category name
     */
    private String mapSlugToCategoryName(String slug) {
        Map<String, String> slugMap = new HashMap<>();
        slugMap.put("smarthome", "Smart Home");
        slugMap.put("smart-home", "Smart Home");
        slugMap.put("industrial", "Industrial");
        slugMap.put("agriculture", "Agriculture");
        slugMap.put("warehouse", "Warehouse");
        slugMap.put("healthcare", "Healthcare");
        slugMap.put("transportation", "Transportation");
        
        return slugMap.getOrDefault(slug.toLowerCase(), slug);
    }
    
    /**
     * Find category by slug in database
     */
    private Category findCategoryBySlug(String slug) throws SQLException {
        // Use getCategoryByName which already handles slug matching
        return categoryDAO.getCategoryByName(slug);
    }
    
    /**
     * Get JSP path for category
     */
    private String getJspPathForCategory(String slug) {
        Map<String, String> jspMap = new HashMap<>();
        jspMap.put("smarthome", "/category-smarthome.jsp");
        jspMap.put("smart-home", "/category-smarthome.jsp");
        jspMap.put("industrial", "/category-industrial.jsp");
        jspMap.put("agriculture", "/category-agriculture.jsp");
        jspMap.put("warehouse", "/category-warehouse.jsp");
        jspMap.put("healthcare", "/category-healthcare.jsp");
        jspMap.put("transportation", "/category-transportation.jsp");
        
        return jspMap.getOrDefault(slug.toLowerCase(), "/browse.jsp");
    }
}

