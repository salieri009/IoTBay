package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import config.DIContainer;
import dao.interfaces.ProductDAO;
import model.Product;

// Note: Mapped in web.xml to avoid conflicts
public class ProductDetailsController extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        try {
            // Use DIContainer for dependency injection
            this.productDAO = DIContainer.get(ProductDAO.class);
            if (this.productDAO == null) {
                throw new ServletException("ProductDAO not available in DIContainer");
            }
        } catch (Exception e) {
            throw new ServletException("Failed to initialize ProductDetailsController", e);
        }
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String productIdParam = request.getParameter("productId");
            if (productIdParam == null || productIdParam.isEmpty()) {
                productIdParam = request.getParameter("id");
            }
            
            if (productIdParam == null || productIdParam.isEmpty()) {
                request.setAttribute("errorMessage", "Product ID is required");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }
            
            try {
                int productId = Integer.parseInt(productIdParam);
                
                if (productDAO == null) {
                    request.setAttribute("errorMessage", "Service temporarily unavailable");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                    return;
                }
                
                Product product = productDAO.getProductById(productId);
                if (product != null) {
                    request.setAttribute("product", product);
                    request.getRequestDispatcher("productDetails.jsp").forward(request, response);
                } else {
                    request.setAttribute("errorMessage", "Product not found");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid product ID format");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            } catch (SQLException e) {
                System.err.println("Database error in ProductDetailsController: " + e.getMessage());
                request.setAttribute("errorMessage", "Database error occurred");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.err.println("Unexpected error in ProductDetailsController: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while loading product details");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
