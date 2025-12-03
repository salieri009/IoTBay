package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.OrderDAOImpl;
import dao.interfaces.OrderDAO;
import config.DIContainer;
import model.Order;
import model.User;

@WebServlet("/manage/orders")
public class ManageOrderController extends HttpServlet {
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DIContainer.getConnection();
            orderDAO = new OrderDAOImpl(connection);
        } catch (Exception e) {
            throw new ServletException("Failed to initialize database connection", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    
        if (!isAdmin(request)) {
            utils.ErrorAction.handleAuthorizationError(request, response, "ManageOrderController.doGet");
            return;
        }
    
        try {
            List<Order> orders = orderDAO.getAllOrders();
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/manage-orders.jsp").forward(request, response);
        } catch (SQLException e) {
            utils.ErrorAction.handleDatabaseError(request, response, e, "ManageOrderController.doGet");
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "ManageOrderController.doGet");
        }
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return false;
        
        Object userObj = session.getAttribute("user");
        if (!(userObj instanceof User)) return false;
        
        User user = (User) userObj;
        return "admin".equalsIgnoreCase(user.getRole()) || "staff".equalsIgnoreCase(user.getRole());
    }
}
