package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.OrderDAOImpl;
import dao.ProductDAOImpl;
import dao.UserDAOImpl;
import dao.interfaces.OrderDAO;
import dao.interfaces.ProductDAO;
import dao.interfaces.UserDAO;
import config.DIContainer;
import model.User;

@WebServlet("/data-management.jsp")
public class DataManagementPageController extends HttpServlet {
    private UserDAO userDAO;
    private ProductDAO productDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DIContainer.getConnection();
            this.userDAO = new UserDAOImpl(connection);
            this.productDAO = new ProductDAOImpl(connection);
            this.orderDAO = new OrderDAOImpl(connection);
        } catch (Exception e) {
            throw new ServletException("Failed to initialize database connection", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Authorization check
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        Object userObj = session.getAttribute("user");
        if (!(userObj instanceof User)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        User user = (User) userObj;
        if (!"staff".equalsIgnoreCase(user.getRole()) && !"admin".equalsIgnoreCase(user.getRole())) {
            utils.ErrorAction.handleAuthorizationError(request, response, "DataManagementPageController.doGet");
            return;
        }

        try {
            // Get dashboard statistics
            int totalUsers = userDAO.getTotalUserCount();
            int totalProducts = productDAO.getTotalProductCount();
            int totalOrders = orderDAO.getTotalOrderCount();
            
            // Set attributes for JSP
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("totalOrders", totalOrders);
            
            // Forward to JSP
            request.getRequestDispatcher("/data-management.jsp").forward(request, response);
            
        } catch (SQLException e) {
            utils.ErrorAction.handleDatabaseError(request, response, e, "DataManagementPageController.doGet");
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "DataManagementPageController.doGet");
        }
    }
}

