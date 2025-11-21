package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CategoryDAO;
import dao.ProductDAOImpl;
import dao.interfaces.ProductDAO;
import db.DBConnection;
import model.Category;
import model.Product;

// Note: Mapped in web.xml to avoid conflicts
public class BrowseProductController extends HttpServlet {
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() {
        try {
            Connection connection = DBConnection.getConnection();
            productDAO = new ProductDAOImpl(connection);
            categoryDAO = new CategoryDAO(connection);
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException("Failed to initialize database connection", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = utils.SecurityUtil.getValidatedStringParameter(request, "query", 200);
        String categoryIdParam = utils.SecurityUtil.getValidatedStringParameter(request, "categoryId", 10);
        String categoryParam = utils.SecurityUtil.getValidatedStringParameter(request, "category", 100);
        List<Product> products;
        String categoryName = null;
        Integer categoryId = null;

        try {
            boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
            boolean hasCategoryId = categoryIdParam != null && !categoryIdParam.trim().isEmpty();
            boolean hasCategory = categoryParam != null && !categoryParam.trim().isEmpty();

            // If category name is provided, find category ID
            if (hasCategory && !hasCategoryId) {
                categoryName = categoryParam.trim();
                // Try to find category by name from database
                try {
                    Category category = categoryDAO.getCategoryByName(categoryName);
                    if (category != null) {
                        categoryId = category.getId();
                        categoryName = category.getName();
                    } else {
                        // Fallback to mapping if not found in DB
                        categoryId = mapCategoryNameToId(categoryName);
                    }
                } catch (SQLException e) {
                    // Fallback to mapping on error
                    categoryId = mapCategoryNameToId(categoryName);
                }
            } else if (hasCategoryId) {
                categoryId = Integer.parseInt(categoryIdParam);
                // Get category name from database
                try {
                    Category category = categoryDAO.getCategoryById(categoryId);
                    if (category != null) {
                        categoryName = category.getName();
                    } else {
                        categoryName = getCategoryNameById(categoryId);
                    }
                } catch (SQLException e) {
                    categoryName = getCategoryNameById(categoryId);
                }
            }

            if (categoryId != null) {
                products = productDAO.getProductsByCategoryId(categoryId);
                
                // Ensure category name is set
                if (categoryName == null) {
                    try {
                        Category category = categoryDAO.getCategoryById(categoryId);
                        categoryName = category != null ? category.getName() : getCategoryNameById(categoryId);
                    } catch (SQLException e) {
                        categoryName = getCategoryNameById(categoryId);
                    }
                }

                if (hasKeyword) {
                    String lowerKeyword = keyword.trim().toLowerCase();
                    products = products.stream()
                            .filter(p -> p.getName().toLowerCase().contains(lowerKeyword))
                            .collect(Collectors.toList());
                }

                request.setAttribute("categoryId", categoryId);
                request.setAttribute("category", categoryName);
            } else if (hasKeyword) {
                products = productDAO.getProductsByName(keyword.trim());
            } else {
                products = productDAO.getAllProducts();
            }

            request.setAttribute("results", products);
            request.setAttribute("keyword", keyword);
            request.getRequestDispatcher("browse.jsp").forward(request, response);

        } catch (SQLException e) {
            utils.ErrorAction.handleDatabaseError(request, response, e, "BrowseProductController.doGet");
        } catch (NumberFormatException e) {
            utils.ErrorAction.handleValidationError(request, response, "Invalid category ID", "BrowseProductController.doGet");
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "BrowseProductController.doGet");
        }
    }
    
    /**
     * Map category name to category ID
     */
    private Integer mapCategoryNameToId(String categoryName) {
        // Common category name mappings
        Map<String, Integer> categoryMap = new HashMap<>();
        categoryMap.put("smart-home", 1);
        categoryMap.put("smarthome", 1);
        categoryMap.put("industrial", 2);
        categoryMap.put("agriculture", 3);
        categoryMap.put("warehouse", 4);
        categoryMap.put("healthcare", 5);
        categoryMap.put("transportation", 6);
        
        String lowerName = categoryName.toLowerCase().replace(" ", "-");
        return categoryMap.get(lowerName);
    }
    
    /**
     * Get category name by ID (simplified - should use CategoryDAO)
     */
    private String getCategoryNameById(int categoryId) {
        Map<Integer, String> idMap = new HashMap<>();
        idMap.put(1, "Smart Home");
        idMap.put(2, "Industrial");
        idMap.put(3, "Agriculture");
        idMap.put(4, "Warehouse");
        idMap.put(5, "Healthcare");
        idMap.put(6, "Transportation");
        
        return idMap.getOrDefault(categoryId, "Category " + categoryId);
    }
}
