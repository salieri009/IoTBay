package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DIContainer;
import dao.interfaces.UserDAO;
import model.User;

@WebServlet("/admin/customer/*")
public class CustomerController extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = DIContainer.get(UserDAO.class);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isStaff(request)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String pathInfo = request.getPathInfo();
        if (pathInfo == null) pathInfo = "/";

        try {
            if (pathInfo.equals("/") || pathInfo.equals("/search")) {
                listCustomers(request, response);
            } else if (pathInfo.equals("/form")) {
                request.getRequestDispatcher("/admin/customer-form.jsp").forward(request, response);
            } else if (pathInfo.startsWith("/edit/")) {
                editCustomer(request, response, pathInfo);
            } else if (pathInfo.startsWith("/view/")) {
                viewCustomer(request, response, pathInfo);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException e) {
            utils.ErrorAction.handleDatabaseError(request, response, e, "CustomerController.doGet");
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "CustomerController.doGet");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isStaff(request)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        if (!utils.SecurityUtil.validateCSRFToken(request)) {
            utils.ErrorAction.handleValidationError(request, response, "CSRF token validation failed", "CustomerController.doPost");
            return;
        }

        String pathInfo = request.getPathInfo();
        if (pathInfo == null) pathInfo = "/";

        try {
            if (pathInfo.equals("/create")) {
                createCustomer(request, response);
            } else if (pathInfo.equals("/update")) {
                updateCustomer(request, response);
            } else if (pathInfo.equals("/delete")) {
                deleteCustomer(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException e) {
            utils.ErrorAction.handleDatabaseError(request, response, e, "CustomerController.doPost");
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "CustomerController.doPost");
        }
    }

    private void listCustomers(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String name = request.getParameter("name");
        String type = request.getParameter("type");

        List<User> customers;
        if ((name != null && !name.trim().isEmpty()) || (type != null && !type.trim().isEmpty() && !type.equals("all"))) {
            customers = userDAO.searchCustomers(name, type);
        } else {
            customers = userDAO.getCustomers();
        }
        request.setAttribute("customers", customers);
        request.setAttribute("searchName", name);
        request.setAttribute("searchType", type);
        request.getRequestDispatcher("/admin/customer-list.jsp").forward(request, response);
    }

    private void viewCustomer(HttpServletRequest request, HttpServletResponse response, String pathInfo)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(pathInfo.substring(6));
        User customer = userDAO.getUserById(id);
        if (customer == null || !"customer".equalsIgnoreCase(customer.getRole())) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("/admin/customer-view.jsp").forward(request, response);
    }

    private void editCustomer(HttpServletRequest request, HttpServletResponse response, String pathInfo)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(pathInfo.substring(6));
        User customer = userDAO.getUserById(id);
        if (customer == null || !"customer".equalsIgnoreCase(customer.getRole())) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        request.setAttribute("editCustomer", customer);
        request.getRequestDispatcher("/admin/customer-form.jsp").forward(request, response);
    }

    private void createCustomer(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String firstName = utils.SecurityUtil.sanitizeInput(utils.SecurityUtil.getValidatedStringParameter(request, "firstName", 50));
        String lastName = utils.SecurityUtil.sanitizeInput(utils.SecurityUtil.getValidatedStringParameter(request, "lastName", 50));
        String email = utils.SecurityUtil.sanitizeInput(utils.SecurityUtil.getValidatedStringParameter(request, "email", 100));
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String postalCode = request.getParameter("postalCode");
        String addressLine1 = request.getParameter("addressLine1");
        String addressLine2 = request.getParameter("addressLine2");
        String customerType = request.getParameter("customerType");
        String dobStr = request.getParameter("dateOfBirth");
        String isActiveStr = request.getParameter("isActive");

        if (userDAO.getUserByEmail(email) != null) {
            request.setAttribute("error", "Email already exists: " + email);
            request.getRequestDispatcher("/admin/customer-form.jsp").forward(request, response);
            return;
        }

        String hashedPassword = utils.PasswordUtil.hashPassword(password);
        LocalDate dob = null;
        if (dobStr != null && !dobStr.trim().isEmpty()) {
            try { dob = LocalDate.parse(dobStr); } catch (Exception ignored) {}
        }
        boolean isActive = !"false".equalsIgnoreCase(isActiveStr);

        User user = new User(0, email, hashedPassword, firstName, lastName,
                phone, postalCode, addressLine1, addressLine2,
                dob, null, LocalDateTime.now(), LocalDateTime.now(), "customer", isActive);
        if (customerType != null && !customerType.isEmpty()) {
            user.setCustomerType(customerType);
        }
        userDAO.createUser(user);

        utils.ErrorAction.logSecurityEvent("CUSTOMER_CREATED", request, "Customer created: " + email);
        response.sendRedirect(request.getContextPath() + "/admin/customer/");
    }

    private void updateCustomer(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = utils.SecurityUtil.getValidatedIntParameter(request, "user_id", 1, Integer.MAX_VALUE);
        User existing = userDAO.getUserById(id);
        if (existing == null || !"customer".equalsIgnoreCase(existing.getRole())) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String firstName = utils.SecurityUtil.sanitizeInput(utils.SecurityUtil.getValidatedStringParameter(request, "firstName", 50));
        String lastName = utils.SecurityUtil.sanitizeInput(utils.SecurityUtil.getValidatedStringParameter(request, "lastName", 50));
        String email = utils.SecurityUtil.sanitizeInput(utils.SecurityUtil.getValidatedStringParameter(request, "email", 100));
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String postalCode = request.getParameter("postalCode");
        String addressLine1 = request.getParameter("addressLine1");
        String addressLine2 = request.getParameter("addressLine2");
        String customerType = request.getParameter("customerType");
        String dobStr = request.getParameter("dateOfBirth");
        String isActiveStr = request.getParameter("isActive");

        String finalPassword = (password != null && !password.trim().isEmpty())
                ? utils.PasswordUtil.hashPassword(password) : existing.getPassword();
        LocalDate dob = null;
        if (dobStr != null && !dobStr.trim().isEmpty()) {
            try { dob = LocalDate.parse(dobStr); } catch (Exception ignored) {}
        }
        if (dob == null) dob = existing.getDateOfBirth();
        boolean isActive = !"false".equalsIgnoreCase(isActiveStr);

        User updated = new User(0, email, finalPassword, firstName, lastName,
                phone, postalCode, addressLine1, addressLine2,
                dob, existing.getPaymentMethod(),
                existing.getCreatedAt() != null ? existing.getCreatedAt().toLocalDateTime() : LocalDateTime.now(),
                LocalDateTime.now(), "customer", isActive);
        if (customerType != null && !customerType.isEmpty()) {
            updated.setCustomerType(customerType);
        }
        userDAO.updateUser(id, updated);
        response.sendRedirect(request.getContextPath() + "/admin/customer/view/" + id);
    }

    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = utils.SecurityUtil.getValidatedIntParameter(request, "user_id", 1, Integer.MAX_VALUE);
        userDAO.deleteUser(id);
        utils.ErrorAction.logSecurityEvent("CUSTOMER_DELETED", request, "Customer deleted: ID " + id);
        response.sendRedirect(request.getContextPath() + "/admin/customer/");
    }

    private boolean isStaff(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return false;
        Object obj = session.getAttribute("user");
        if (!(obj instanceof User)) return false;
        User u = (User) obj;
        return "staff".equalsIgnoreCase(u.getRole()) || "admin".equalsIgnoreCase(u.getRole());
    }
}
