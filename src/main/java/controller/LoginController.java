package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.interfaces.AccessLogDAO;
import config.DIContainer;
import model.AccessLog;
import model.User;
import service.UserService;
import java.util.logging.Logger;
import java.util.logging.Level;

@WebServlet("/api/login")
public class LoginController extends HttpServlet {
    private UserService userService;
    private static final Logger logger = Logger.getLogger(LoginController.class.getName());

    @Override
    public void init() {
        try {
            // Initialize UserService (uses DIContainer internally)
            userService = new UserService();
        } catch (Exception e) {
            // Log error but allow servlet to start - requests might fail gracefully later
            logger.log(Level.SEVERE, "Failed to initialize LoginController dependencies", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Ensure userService is initialized if init() failed previously
        if (userService == null) {
            try {
                userService = new UserService();
            } catch (Exception e) {
                utils.ErrorAction.handleServerError(request, response, e, "LoginController.doPost_LazyInit");
                return;
            }
        }

        try {
            // Debug: Log all parameters (using getParameter for logging only, before
            // validation)
            String emailParam = request.getParameter("email");
            String passwordParam = request.getParameter("password");
            String csrfTokenParam = request.getParameter("csrfToken");
            logger.log(Level.FINE, "Login attempt - Parameters: email=" + emailParam +
                    ", password=" + (passwordParam != null ? "***" : "null") +
                    ", csrfToken=" + csrfTokenParam);

            // CSRF protection
            if (!utils.SecurityUtil.validateCSRFToken(request)) {
                logger.log(Level.WARNING, "CSRF validation failed for login attempt");
                utils.ErrorAction.handleValidationError(request, response,
                        "Invalid security token. Please refresh the page and try again.", "LoginController.doPost");
                return;
            }

            // Validate parameters using SecurityUtil
            String email = utils.SecurityUtil.getValidatedStringParameter(request, "email", 100);
            String password = utils.SecurityUtil.getValidatedStringParameter(request, "password", 255);

            if (email == null || password == null) {
                logger.log(Level.WARNING, "Login attempt with empty credentials");
                utils.ErrorAction.handleMissingParameterError(request, response,
                        "Email and password are required", "LoginController.doPost");
                return;
            }

            // Normalize email casing for comparison
            email = email.toLowerCase();

            // Validate email format
            if (!utils.SecurityUtil.isValidEmail(email)) {
                utils.ErrorAction.handleValidationError(request, response,
                        "Invalid login credentials", "LoginController.doPost");
                return;
            }

            // Generic error message to prevent user enumeration
            String genericError = "Invalid login credentials";

            // Use UserService for authentication (handles password verification)
            User user;
            try {
                // Note: UserService handles its own DB connection lifecycle internally
                // Ideally UserService should also accept a connection or be stateless,
                // but we are focusing on Controller layer first.
                user = userService.authenticateUser(email, password);
            } catch (IllegalArgumentException e) {
                // Authentication failed - use generic error to prevent enumeration
                utils.ErrorAction.handleValidationError(request, response, genericError, "LoginController.doPost");
                return;
            } catch (SQLException e) {
                // Database error
                utils.ErrorAction.handleDatabaseError(request, response, e, "LoginController.doPost");
                return;
            } catch (Exception e) {
                utils.ErrorAction.handleServerError(request, response, e, "LoginController.doPost");
                return;
            }

            // Create access log with structured logging
            try {
                AccessLogDAO accessLogDAO = DIContainer.get(AccessLogDAO.class);

                LocalDateTime now = LocalDateTime.now();
                String action = String.format("User %s (ID: %d, Role: %s) logged in successfully",
                        user.getEmail(), user.getId(), user.getRole());
                AccessLog accessLog = new AccessLog(0, user.getId(), action, now);

                accessLogDAO.createAccessLog(accessLog);
                logger.log(Level.INFO, "Login successful: userId={0}, email={1}, role={2}, ip={3}",
                        new Object[] { user.getId(), user.getEmail(), user.getRole(),
                                utils.SecurityUtil.getClientIP(request) });
            } catch (SQLException e) {
                // Log error but don't fail login - logging is secondary
                logger.log(Level.WARNING, "Failed to create access log for login: " + e.getMessage(), e);
            }

            // Successful login: set session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Redirect to home page (with context path!)
            response.sendRedirect(request.getContextPath() + "/");
        } catch (Exception e) {
            // Catch-all for unexpected errors (including generic runtime exceptions)
            logger.log(Level.SEVERE, "Error during login: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "An error occurred. Please try again later.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
