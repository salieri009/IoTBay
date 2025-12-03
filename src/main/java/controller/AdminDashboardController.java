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
import dao.SupplierDAOImpl;
import dao.UserDAOImpl;
import dao.interfaces.OrderDAO;
import dao.interfaces.ProductDAO;
import dao.interfaces.SupplierDAO;
import dao.interfaces.UserDAO;
import config.DIContainer;
import model.User;

/**
 * Admin Dashboard Controller
 * 
 * Provides dashboard statistics from the database
 */
@WebServlet("/admin-dashboard")
public class AdminDashboardController extends HttpServlet {
    private UserDAO userDAO;
    private ProductDAO productDAO;
    private OrderDAO orderDAO;
    private SupplierDAO supplierDAO;
    
    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DIContainer.getConnection();
            this.userDAO = new UserDAOImpl(connection);
            this.productDAO = new ProductDAOImpl(connection);
            this.orderDAO = new OrderDAOImpl(connection);
            this.supplierDAO = new SupplierDAOImpl(connection);
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize database connection", e);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check authorization
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
        
        User currentUser = (User) userObj;
        if (!"staff".equalsIgnoreCase(currentUser.getRole()) && !"admin".equalsIgnoreCase(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        try {
            // Get statistics from database
            int totalUsers = userDAO.getTotalUserCount();
            int totalProducts = productDAO.getTotalProductCount();
            int totalOrders = orderDAO.getTotalOrderCount();
            int totalSuppliers = supplierDAO.getTotalSupplierCount();
            
            // Set attributes for JSP
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalSuppliers", totalSuppliers);
            
            // Forward to admin dashboard JSP
            request.getRequestDispatcher("/admin-dashboard.jsp").forward(request, response);
            
        } catch (SQLException e) {
            utils.ErrorAction.handleDatabaseError(request, response, e, "AdminDashboardController.doGet");
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "AdminDashboardController.doGet");
        }
    }
}

