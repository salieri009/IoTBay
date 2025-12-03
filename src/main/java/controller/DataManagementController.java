package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AccessLogDAOImpl;
import dao.UserDAOImpl;
import dao.OrderDAOImpl;
import dao.ProductDAOImpl;
import dao.interfaces.AccessLogDAO;
import dao.interfaces.UserDAO;
import dao.interfaces.OrderDAO;
import dao.interfaces.ProductDAO;
import config.DIContainer;
import model.AccessLog;
import model.User;
import model.Order;
import model.Product;
import utils.CSVUtil;

@WebServlet("/api/dataManagement/*")
public class DataManagementController extends HttpServlet {
    private AccessLogDAO accessLogDAO;
    private UserDAO userDAO;
    private OrderDAO orderDAO;
    private ProductDAO productDAO;
    private static final Logger logger = Logger.getLogger(DataManagementController.class.getName());

    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DIContainer.getConnection();
            this.accessLogDAO = new AccessLogDAOImpl(connection);
            this.userDAO = new UserDAOImpl(connection);
            this.orderDAO = new OrderDAOImpl(connection);
            this.productDAO = new ProductDAOImpl(connection);
        } catch (Exception e) {
            throw new ServletException("Failed to initialize DataManagementController", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        if (pathInfo == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Please log in");
            return;
        }

        Object userObj = session.getAttribute("user");
        if (!(userObj instanceof User)) {
            utils.ErrorAction.handleAuthenticationError(request, response, "DataManagementController.doGet");
            return;
        }

        User user = (User) userObj;

        // Check if user is admin/staff for data management operations
        // Note: Role comparison should be case-insensitive
        String role = user.getRole();
        if (role == null || (!"admin".equalsIgnoreCase(role) && !"staff".equalsIgnoreCase(role))) {
            utils.ErrorAction.handleAuthorizationError(request, response, "DataManagementController.doGet");
            return;
        }

        try {
            switch (pathInfo) {
                case "/exportUsers":
                    exportUsers(request, response);
                    break;
                case "/exportAccessLogs":
                    exportAccessLogs(request, response);
                    break;
                case "/exportOrders":
                    exportOrders(request, response);
                    break;
                case "/exportProducts":
                    exportProducts(request, response);
                    break;
                case "/dashboard":
                    showDashboard(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException e) {
            utils.ErrorAction.handleDatabaseError(request, response, e, "DataManagementController.doGet");
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "DataManagementController.doGet");
        }
    }

    private void exportUsers(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        List<User> users = userDAO.getAllUsers();
        String csvContent = CSVUtil.generateUserCSV(users);

        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=\"users_export.csv\"");

        try (PrintWriter out = response.getWriter()) {
            out.write(csvContent);
        }
    }

    private void exportAccessLogs(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");

        List<AccessLog> accessLogs;
        if (startDateStr != null && endDateStr != null) {
            try {
                LocalDate startDate = LocalDate.parse(startDateStr);
                LocalDate endDate = LocalDate.parse(endDateStr);
                accessLogs = accessLogDAO.getAccessLogsByDateRange(startDate, endDate);
            } catch (DateTimeParseException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid date format");
                return;
            }
        } else {
            accessLogs = accessLogDAO.getAllAccessLogs();
        }

        String csvContent = CSVUtil.generateAccessLogCSV(accessLogs);

        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=\"access_logs_export.csv\"");

        try (PrintWriter out = response.getWriter()) {
            out.write(csvContent);
        }
    }

    private void exportOrders(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        List<Order> orders = orderDAO.getAllOrders();
        String csvContent = CSVUtil.generateOrderCSV(orders);

        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=\"orders_export.csv\"");

        try (PrintWriter out = response.getWriter()) {
            out.write(csvContent);
        }
    }

    private void exportProducts(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        List<Product> products = productDAO.getAllProducts();
        String csvContent = CSVUtil.generateProductCSV(products);

        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=\"products_export.csv\"");

        try (PrintWriter out = response.getWriter()) {
            out.write(csvContent);
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        // Get dashboard statistics
        int totalUsers = userDAO.getTotalUserCount();
        int totalOrders = orderDAO.getTotalOrderCount();
        int totalProducts = productDAO.getTotalProductCount();

        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalProducts", totalProducts);

        request.getRequestDispatcher("/WEB-INF/views/data-management.jsp").forward(request, response);
    }
}
