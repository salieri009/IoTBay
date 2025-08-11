package controller.api;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
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
 */
@WebServlet("/api/v1/products/*")
public class ProductApiController extends HttpServlet {
    private ProductDAO productDAO;
    
    @Override
    public void init() throws ServletException {
        // 의존성 주입 패턴 사용
        this.productDAO = DIContainer.get(ProductDAO.class);
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // GET /api/v1/products - Get all products
                handleGetAllProducts(response);
            } else {
                // GET /api/v1/products/{id} - Get product by ID
                String[] pathParts = pathInfo.split("/");
                if (pathParts.length == 2) {
                    int productId = Integer.parseInt(pathParts[1]);
                    handleGetProductById(productId, response);
                } else {
                    ResponseUtil.sendError(response, 400, "Invalid product ID");
                }
            }
        } catch (NumberFormatException e) {
            ResponseUtil.sendError(response, 400, "Invalid product ID format");
        } catch (Exception e) {
            ResponseUtil.sendError(response, 500, "Internal server error");
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
