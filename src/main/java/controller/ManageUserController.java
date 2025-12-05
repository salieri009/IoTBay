package controller;

import java.io.IOException;
import java.sql.Connection;
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

import dao.UserDAOImpl;
import dao.interfaces.UserDAO;
import config.DIContainer;
import model.User;

@WebServlet("/api/manage/users/*")
public class ManageUserController extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DIContainer.getConnection();
            userDAO = new UserDAOImpl(connection);
        } catch (Exception e) {
            throw new ServletException("Failed to initialize database connection", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            utils.ErrorAction.handleAuthorizationError(request, response, "ManageUserController.doGet");
            return;
        }

        try {
            String pathInfo = request.getPathInfo();

            // Validate pathInfo
            if (pathInfo != null && !pathInfo.isEmpty() && !pathInfo.equals("/") && !pathInfo.equals("/form")) {
                utils.ErrorAction.handleMissingParameterError(request, response,
                        "Invalid path", "ManageUserController.doGet");
                return;
            }

            // Check if requesting form page
            if (pathInfo != null && pathInfo.equals("/form")) {
                request.getRequestDispatcher("/manage-user-form.jsp").forward(request, response);
                return;
            }

            List<User> users = userDAO.getAllUsers();
            request.setAttribute("users", users);

            request.getRequestDispatcher("/WEB-INF/views/manage-users.jsp").forward(request, response);

        } catch (SQLException e) {
            utils.ErrorAction.handleDatabaseError(request, response, e, "ManageUserController.doGet");
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "ManageUserController.doGet");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // Authorization check
        if (!isAdmin(request)) {
            utils.ErrorAction.handleAuthorizationError(request, response, "ManageUserController.doPost");
            return;
        }

        // Rate limiting check
        if (utils.SecurityUtil.isRateLimited(request, 10, 60000)) { // 10 requests per minute
            utils.ErrorAction.handleRateLimitError(request, response, "ManageUserController.doPost");
            return;
        }

        // CSRF protection
        if (!utils.SecurityUtil.validateCSRFToken(request)) {
            utils.ErrorAction.handleValidationError(request, response,
                    "CSRF token validation failed", "ManageUserController.doPost");
            return;
        }

        try {
            // Secure parameter extraction with validation
            String email = utils.SecurityUtil.getValidatedStringParameter(request, "email", 100);
            String password = request.getParameter("password"); // Don't sanitize password
            String firstName = utils.SecurityUtil.getValidatedStringParameter(request, "firstName", 50);
            String lastName = utils.SecurityUtil.getValidatedStringParameter(request, "lastName", 50);
            String phone = request.getParameter("phone"); // Optional
            String postalCode = request.getParameter("postalCode"); // Optional
            String addressLine1 = request.getParameter("addressLine1"); // Optional
            String addressLine2 = request.getParameter("addressLine2"); // Optional
            String paymentMethod = request.getParameter("paymentMethod"); // Optional
            String dob = utils.SecurityUtil.getValidatedStringParameter(request, "dateOfBirth", 20);
            String role = utils.SecurityUtil.getValidatedStringParameter(request, "role", 20);

            // Sanitize inputs (except password)
            email = utils.SecurityUtil.sanitizeInput(email);
            firstName = utils.SecurityUtil.sanitizeInput(firstName);
            lastName = utils.SecurityUtil.sanitizeInput(lastName);
            if (phone != null) {
                phone = utils.SecurityUtil.sanitizeInput(phone);
            }
            if (postalCode != null) {
                postalCode = utils.SecurityUtil.sanitizeInput(postalCode);
            }
            if (addressLine1 != null) {
                addressLine1 = utils.SecurityUtil.sanitizeInput(addressLine1);
            }
            if (addressLine2 != null) {
                addressLine2 = utils.SecurityUtil.sanitizeInput(addressLine2);
            }
            if (paymentMethod != null) {
                paymentMethod = utils.SecurityUtil.sanitizeInput(paymentMethod);
            }

            // Validate email format
            String emailError = utils.ValidationUtil.validateEmail(email);
            if (emailError != null) {
                utils.ErrorAction.handleValidationError(request, response, emailError,
                        "ManageUserController.doPost");
                return;
            }

            // Validate password strength
            if (!utils.SecurityUtil.isStrongPassword(password)) {
                utils.ErrorAction.handleValidationError(request, response,
                        "Password does not meet security requirements", "ManageUserController.doPost");
                return;
            }

            // Validate profile data
            String profileError = utils.ValidationUtil.validateRegisterUserProfile(
                    firstName, lastName, phone != null ? phone : "",
                    postalCode != null ? postalCode : "",
                    addressLine1 != null ? addressLine1 : "");
            if (profileError != null) {
                utils.ErrorAction.handleValidationError(request, response, profileError,
                        "ManageUserController.doPost");
                return;
            }

            // Validate date of birth
            String dobError = utils.ValidationUtil.validateBirthDate(dob);
            if (dobError != null) {
                utils.ErrorAction.handleValidationError(request, response, dobError,
                        "ManageUserController.doPost");
                return;
            }

            // Validate role
            String[] validRoles = { "customer", "staff", "admin" };
            boolean isValidRole = false;
            for (String validRole : validRoles) {
                if (validRole.equalsIgnoreCase(role)) {
                    isValidRole = true;
                    break;
                }
            }
            if (!isValidRole) {
                utils.ErrorAction.handleValidationError(request, response,
                        "Invalid user role", "ManageUserController.doPost");
                return;
            }

            // Check email duplication
            if (userDAO.getUserByEmail(email) != null) {
                utils.ErrorAction.handleValidationError(request, response,
                        "Email already exists", "ManageUserController.doPost");
                return;
            }

            // Hash password securely
            String hashedPassword = utils.PasswordUtil.hashPassword(password);

            User user = new User(
                    0, // id (auto-generated)
                    email,
                    hashedPassword, // Use hashed password
                    firstName,
                    lastName,
                    phone,
                    postalCode,
                    addressLine1,
                    addressLine2,
                    LocalDate.parse(dob),
                    paymentMethod,
                    LocalDateTime.now(),
                    LocalDateTime.now(),
                    role.toLowerCase(),
                    true // isActive
            );
            userDAO.createUser(user);

            // Log security event
            utils.ErrorAction.logSecurityEvent("USER_CREATED_BY_ADMIN", request,
                    "User created: " + email + ", Role: " + role);

            response.sendRedirect(request.getContextPath() + "/manage/users");

        } catch (IllegalArgumentException e) {
            utils.ErrorAction.handleValidationError(request, response, e.getMessage(),
                    "ManageUserController.doPost");
        } catch (SQLException e) {
            utils.ErrorAction.handleDatabaseError(request, response, e, "ManageUserController.doPost");
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "ManageUserController.doPost");
        }
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null)
            return false;

        Object userObj = session.getAttribute("user");
        if (!(userObj instanceof User))
            return false;

        User user = (User) userObj;
        return "staff".equalsIgnoreCase(user.getRole()) || "admin".equalsIgnoreCase(user.getRole());
    }
}