package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.Part;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.interfaces.AccessLogDAO;
import dao.interfaces.OrderDAO;
import dao.interfaces.ProductDAO;
import dao.interfaces.UserDAO;
import model.AccessLog;
import model.User;
import model.Order;
import model.Product;
import utils.CSVUtil;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.LocalDateTime;

@WebServlet("/api/dataManagement/*")
@MultipartConfig(maxFileSize = 10 * 1024 * 1024) // 10MB
public class DataManagementController extends HttpServlet {
    private AccessLogDAO accessLogDAO;
    private UserDAO userDAO;
    private OrderDAO orderDAO;
    private ProductDAO productDAO;
    private static final Logger logger = Logger.getLogger(DataManagementController.class.getName());

    @Override
    public void init() throws ServletException {
        // DAOs are stateless, so we can instantiate them directly or use DI if DI
        // supports it.
        // Given previous pattern, we should just new them up or rely on local variable
        // usage if fields are removed.
        // However, keeping fields and initializing them with no-arg cons is also fine
        // if they have no state.
        this.accessLogDAO = new dao.AccessLogDAOImpl();
        this.userDAO = new dao.UserDAOImpl();
        this.orderDAO = new dao.OrderDAOImpl();
        this.productDAO = new dao.ProductDAOImpl();
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
            response.sendRedirect(request.getContextPath() + "/login.jsp");
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

    // ─── POST ───────────────────────────────────────────────────────────────────

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        if (pathInfo == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Object userObj = session.getAttribute("user");
        if (!(userObj instanceof User)) {
            utils.ErrorAction.handleAuthenticationError(request, response, "DataManagementController.doPost");
            return;
        }

        User user = (User) userObj;
        String role = user.getRole();
        if (role == null || (!"admin".equalsIgnoreCase(role) && !"staff".equalsIgnoreCase(role))) {
            utils.ErrorAction.handleAuthorizationError(request, response, "DataManagementController.doPost");
            return;
        }

        try {
            switch (pathInfo) {
                case "/import":
                    handleImport(request, response);
                    break;
                case "/confirmImport":
                    handleConfirmImport(request, response, session);
                    break;
                case "/bulkDelete":
                    handleBulkDelete(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException e) {
            utils.ErrorAction.handleDatabaseError(request, response, e, "DataManagementController.doPost");
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "DataManagementController.doPost");
        }
    }

    private void handleImport(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        Part filePart = request.getPart("csvFile");
        String entityType = request.getParameter("entityType");

        if (filePart == null || filePart.getSize() == 0) {
            request.setAttribute("errorMessage", "Please select a CSV file to upload.");
            request.getRequestDispatcher("/WEB-INF/views/data-management.jsp").forward(request, response);
            return;
        }

        String submittedFileName = filePart.getSubmittedFileName();
        if (submittedFileName == null || !submittedFileName.toLowerCase().endsWith(".csv")) {
            request.setAttribute("errorMessage", "Only CSV files are accepted.");
            request.getRequestDispatcher("/WEB-INF/views/data-management.jsp").forward(request, response);
            return;
        }

        if (entityType == null || entityType.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please select an entity type.");
            request.getRequestDispatcher("/WEB-INF/views/data-management.jsp").forward(request, response);
            return;
        }

        String csvContent;
        try (InputStream inputStream = filePart.getInputStream();
             java.io.ByteArrayOutputStream baos = new java.io.ByteArrayOutputStream()) {
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                baos.write(buffer, 0, bytesRead);
            }
            csvContent = baos.toString(StandardCharsets.UTF_8.name());
        }

        java.util.List<String[]> rows = CSVUtil.parseCSV(csvContent);
        if (rows.isEmpty()) {
            request.setAttribute("errorMessage", "The CSV file is empty.");
            request.getRequestDispatcher("/WEB-INF/views/data-management.jsp").forward(request, response);
            return;
        }

        // Validate headers
        String[] headers = rows.get(0);
        String[] expectedHeaders = getExpectedHeaders(entityType);
        if (expectedHeaders == null) {
            request.setAttribute("errorMessage", "Import not supported for entity type: " + entityType);
            request.getRequestDispatcher("/WEB-INF/views/data-management.jsp").forward(request, response);
            return;
        }

        if (!CSVUtil.validateCSVHeaders(headers, expectedHeaders)) {
            request.setAttribute("errorMessage",
                    "Invalid CSV headers. Expected: " + String.join(", ", expectedHeaders));
            request.getRequestDispatcher("/WEB-INF/views/data-management.jsp").forward(request, response);
            return;
        }

        // Store parsed data in session for confirmImport
        java.util.List<String[]> dataRows = rows.subList(1, rows.size());
        request.getSession(true).setAttribute("importRows", dataRows);
        request.getSession(true).setAttribute("importEntityType", entityType);
        request.getSession(true).setAttribute("importHeaders", headers);

        request.setAttribute("importHeaders", headers);
        request.setAttribute("importRows", dataRows);
        request.setAttribute("importEntityType", entityType);

        request.getRequestDispatcher("/WEB-INF/views/import-preview.jsp").forward(request, response);
    }

    private void handleConfirmImport(HttpServletRequest request, HttpServletResponse response,
            HttpSession session) throws SQLException, ServletException, IOException {

        @SuppressWarnings("unchecked")
        java.util.List<String[]> rows = (java.util.List<String[]>) session.getAttribute("importRows");
        String entityType = (String) session.getAttribute("importEntityType");

        if (rows == null || entityType == null) {
            request.setAttribute("errorMessage", "No pending import found. Please upload a CSV first.");
            request.getRequestDispatcher("/WEB-INF/views/data-management.jsp").forward(request, response);
            return;
        }

        int successCount = 0;
        int failCount = 0;

        if ("users".equalsIgnoreCase(entityType)) {
            for (String[] row : rows) {
                try {
                    if (row.length < 4) { failCount++; continue; }
                    String email = row[0].trim();
                    String firstName = row[1].trim();
                    String lastName = row[2].trim();
                    String phone = row.length > 3 ? row[3].trim() : null;
                    boolean isActive = row.length > 4 && "true".equalsIgnoreCase(row[4].trim());

                    if (email.isEmpty() || firstName.isEmpty() || lastName.isEmpty()) { failCount++; continue; }
                    if (userDAO.getUserByEmail(email) != null) { failCount++; continue; }

                    String tempPassword = utils.PasswordUtil.hashPassword("IoTBay@" + email.split("@")[0]);
                    model.User newUser = new model.User(0, email, tempPassword, firstName, lastName,
                            phone, null, null, null, null, null,
                            LocalDateTime.now(), LocalDateTime.now(), "customer", isActive);
                    userDAO.createUser(newUser);
                    successCount++;
                } catch (Exception e) {
                    failCount++;
                }
            }
        } else if ("products".equalsIgnoreCase(entityType)) {
            for (String[] row : rows) {
                try {
                    if (row.length < 3) { failCount++; continue; }
                    String name = row[0].trim();
                    String category = row[1].trim();
                    double price = Double.parseDouble(row[2].trim());
                    int stock = row.length > 3 ? Integer.parseInt(row[3].trim()) : 0;
                    String description = row.length > 4 ? row[4].trim() : "";

                    if (name.isEmpty()) { failCount++; continue; }

                    model.Product prod = new model.Product();
                    prod.setName(name);
                    prod.setCategory(category);
                    prod.setPrice(price);
                    prod.setStockQuantity(stock);
                    prod.setDescription(description);
                    productDAO.createProduct(prod);
                    successCount++;
                } catch (Exception e) {
                    failCount++;
                }
            }
        }

        // Clear session import data
        session.removeAttribute("importRows");
        session.removeAttribute("importEntityType");
        session.removeAttribute("importHeaders");

        request.setAttribute("successMessage",
                "Import complete: " + successCount + " record(s) imported, " + failCount + " failed.");
        showDashboard(request, response);
    }

    private void handleBulkDelete(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        String deleteType = request.getParameter("deleteType");
        String[] ids = request.getParameterValues("ids");

        if (ids == null || ids.length == 0) {
            request.setAttribute("errorMessage", "No IDs provided for bulk delete.");
            showDashboard(request, response);
            return;
        }

        int successCount = 0;
        int failCount = 0;

        for (String idStr : ids) {
            try {
                int id = Integer.parseInt(idStr.trim());
                if ("users".equalsIgnoreCase(deleteType)) {
                    userDAO.deleteUser(id);
                    successCount++;
                } else if ("products".equalsIgnoreCase(deleteType)) {
                    productDAO.deleteProduct(id);
                    successCount++;
                }
            } catch (Exception e) {
                failCount++;
            }
        }

        request.setAttribute("successMessage",
                "Bulk delete complete: " + successCount + " record(s) deleted, " + failCount + " failed.");
        showDashboard(request, response);
    }

    private String[] getExpectedHeaders(String entityType) {
        switch (entityType.toLowerCase()) {
            case "users":
                return new String[]{"Email", "First Name", "Last Name", "Phone", "Is Active"};
            case "products":
                return new String[]{"Name", "Category", "Price", "Stock Quantity", "Description"};
            default:
                return null;
        }
    }
}
