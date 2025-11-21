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
            String paramName = "productId";
            if (productIdParam == null || productIdParam.isEmpty()) {
                productIdParam = request.getParameter("id");
                paramName = "id";
            }
            
            if (productIdParam == null || productIdParam.isEmpty()) {
                utils.ErrorAction.handleMissingParameterError(request, response, paramName, "ProductDetailsController.doGet");
                return;
            }
            
            try {
                int productId = utils.SecurityUtil.getValidatedIntParameter(request, paramName, 1, Integer.MAX_VALUE);
                
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
                utils.ErrorAction.handleValidationError(request, response, "Invalid product ID format", "ProductDetailsController.doGet");
            } catch (SQLException e) {
                utils.ErrorAction.handleDatabaseError(request, response, e, "ProductDetailsController.doGet");
            }
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "ProductDetailsController.doGet");
        }
    }
}
