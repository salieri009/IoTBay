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

@WebServlet("/reports-dashboard.jsp")
public class ReportsDashboardController extends HttpServlet {
    private UserDAO userDAO;
    private ProductDAO productDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        this.userDAO = DIContainer.get(UserDAO.class);
        this.productDAO = DIContainer.get(ProductDAO.class);
        this.orderDAO = DIContainer.get(OrderDAO.class);
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
            utils.ErrorAction.handleAuthorizationError(request, response, "ReportsDashboardController.doGet");
            return;
        }

        try {
            // Fetch statistics from database
            int totalUsers = userDAO.getTotalUserCount();
            int totalProducts = productDAO.getTotalProductCount();
            int totalOrders = orderDAO.getTotalOrderCount();

            // Calculate revenue (sum of all order totals)
            // Note: This is a simplified calculation. In a real system, you'd have a
            // dedicated method
            double totalRevenue = 0.0;
            try {
                // Get all orders and sum their totals
                java.util.List<model.Order> orders = orderDAO.getAllOrders();
                for (model.Order order : orders) {
                    if (order.getTotalAmount() != null) {
                        totalRevenue += order.getTotalAmount().doubleValue();
                    }
                }
            } catch (Exception e) {
                // If calculation fails, use 0
                totalRevenue = 0.0;
            }

            // Set attributes for JSP
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalRevenue", totalRevenue);

            // Forward to JSP
            request.getRequestDispatcher("/WEB-INF/views/reports-dashboard.jsp").forward(request, response);

        } catch (SQLException e) {
            utils.ErrorAction.handleDatabaseError(request, response, e, "ReportsDashboardController.doGet");
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "ReportsDashboardController.doGet");
        }
    }
}
