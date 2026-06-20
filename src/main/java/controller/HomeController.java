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

// Map to the context root ONLY (exact-match empty pattern). Using "/" here would
// replace Tomcat's DefaultServlet and break ALL static resources (css, images, js),
// causing them to be forwarded to index.jsp and served as text/html.
@WebServlet("")
public class HomeController extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get featured products (limit to 4 for homepage)
            // Use getAllProducts and take first 4 as featured
            List<Product> allProducts = productDAO.getAllProducts();
            List<Product> featuredProducts = allProducts.stream()
                    .limit(4)
                    .collect(java.util.stream.Collectors.toList());

            // Set as request attribute for index.jsp
            request.setAttribute("featuredProducts", featuredProducts);

            // Forward to index.jsp
            request.getRequestDispatcher("/index.jsp").forward(request, response);

        } catch (SQLException e) {
            ErrorAction.handleDatabaseError(request, response, e, "HomeController.doGet");
        } catch (Exception e) {
            ErrorAction.handleServerError(request, response, e, "HomeController.doGet");
        }
    }
}
