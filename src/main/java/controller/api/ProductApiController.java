package controller.api;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import config.DIContainer;
import dao.interfaces.ProductDAO;
import model.Product;
import utils.ResponseUtil;

/**
 * 최신 트렌드: RESTful API with JSON Response
 * Modern API Design Patterns
 * Note: Mapped in web.xml to avoid conflicts
 */
public class ProductApiController extends HttpServlet {
    private ProductDAO productDAO;
    
    @Override
    public void init() throws ServletException {
        try {
            // 의존성 주입 패턴 사용
            this.productDAO = DIContainer.get(ProductDAO.class);
            if (this.productDAO == null) {
                // Fallback to stub if DIContainer fails
                this.productDAO = new dao.stub.ProductDAOStub();
            }
        } catch (Exception e) {
            // Fallback to stub on any error
            this.productDAO = new dao.stub.ProductDAOStub();
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();
        String servletPath = request.getServletPath(); // /api/v1/products
        
        try {
            // If pathInfo is null, try to extract from requestURI
            if (pathInfo == null || pathInfo.equals("/")) {
                // Check if there's an ID in the requestURI after the servlet path
                String remainingPath = requestURI.substring(contextPath.length() + servletPath.length());
                if (remainingPath != null && !remainingPath.isEmpty() && !remainingPath.equals("/")) {
                    // Extract ID from remaining path
                    String[] parts = remainingPath.split("/");
                    if (parts.length > 0 && !parts[0].isEmpty()) {
                        try {
                            int productId = Integer.parseInt(parts[0]);
                            handleGetProductById(productId, response);
                            return;
                        } catch (NumberFormatException e) {
                            ResponseUtil.sendError(response, 400, "Invalid product ID format");
                            return;
                        }
                    }
                }
                // GET /api/v1/products - Get all products
                handleGetAllProducts(response);
            } else {
                // GET /api/v1/products/{id} - Get product by ID
                String[] pathParts = pathInfo.split("/");
                // pathParts[0] is empty string, pathParts[1] should be the ID
                if (pathParts.length >= 2 && !pathParts[1].isEmpty()) {
                    try {
                        int productId = Integer.parseInt(pathParts[1]);
                        handleGetProductById(productId, response);
                    } catch (NumberFormatException e) {
                        ResponseUtil.sendError(response, 400, "Invalid product ID format");
                    }
                } else {
                    // No ID provided, return all products
                    handleGetAllProducts(response);
                }
            }
        } catch (NumberFormatException e) {
            ResponseUtil.sendError(response, 400, "Invalid product ID format");
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(null, response, e, "ProductApiController.doGet");
        }
    }
    
    private void handleGetAllProducts(HttpServletResponse response) throws Exception {
        List<Product> products = productDAO.getAllProducts();
        ResponseUtil.sendJson(response, products);
    }
    
    private void handleGetProductById(int productId, HttpServletResponse response) throws Exception {
        Product product = productDAO.getProductById(productId);
        if (product != null) {
            ResponseUtil.sendJson(response, product);
        } else {
            ResponseUtil.sendError(response, 404, "Product not found");
        }
    }
}
