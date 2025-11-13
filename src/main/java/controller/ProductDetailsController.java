package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.ProductDAOImpl;
import dao.interfaces.ProductDAO;
import db.DBConnection;
import model.Product;

@WebServlet("/product")
public class ProductDetailsController extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() {
        try {
            Connection connection = DBConnection.getConnection();
            productDAO = new ProductDAOImpl(connection);
        } catch (SQLException e) {
            throw new RuntimeException("Failed to init");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Failed to init");
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
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
