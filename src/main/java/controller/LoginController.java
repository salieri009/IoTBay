package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.interfaces.AccessLogDAO;
import config.DIContainer;
import db.DBConnection;
import model.AccessLog;
import model.User;
import service.UserService;
import java.util.logging.Logger;
import java.util.logging.Level;

// Note: Mapped in web.xml to avoid conflicts
public class LoginController extends HttpServlet {
    private AccessLogDAO accessLogDAO;
    private UserService userService;
    private static final Logger logger = Logger.getLogger(LoginController.class.getName());

    @Override
    public void init() {
        try {
            // Use DIContainer for dependency injection, fallback to direct instantiation
            accessLogDAO = DIContainer.get(AccessLogDAO.class);
            
            // Fallback if DIContainer not available
            if (accessLogDAO == null) {
                java.sql.Connection connection = DBConnection.getConnection();
                accessLogDAO = new dao.AccessLogDAOImpl(connection);
            }
            
            // Initialize UserService (uses DIContainer internally)
            userService = new UserService();
        } catch (Exception e) {
            throw new RuntimeException("Failed to initialize LoginController", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Debug: Log all parameters
            logger.log(Level.FINE, "Login attempt - Parameters: email=" + request.getParameter("email") + 
                    ", password=" + (request.getParameter("password") != null ? "***" : "null") +
                    ", csrfToken=" + request.getParameter("csrfToken"));
            
            // CSRF protection
            if (!utils.SecurityUtil.validateCSRFToken(request)) {
                logger.log(Level.WARNING, "CSRF validation failed for login attempt");
                request.setAttribute("errorMessage", "Invalid security token. Please refresh the page and try again.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }
            
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            // Validate parameters are not empty
            if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
                logger.log(Level.WARNING, "Login attempt with empty credentials - email: " + 
                        (email != null ? email : "null") + ", password: " + 
                        (password != null ? "provided" : "null"));
                request.setAttribute("errorMessage", "Email and password are required");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }
            
            // Validate and sanitize - handle potential exceptions
            try {
                email = utils.SecurityUtil.getValidatedStringParameter(request, "email", 100);
                password = utils.SecurityUtil.getValidatedStringParameter(request, "password", 255);
            } catch (IllegalArgumentException e) {
                request.setAttribute("errorMessage", "Invalid input format");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }
            
            // Normalize email casing for comparison
            email = email.toLowerCase();
            
            // Validate email format
            if (!utils.SecurityUtil.isValidEmail(email)) {
                request.setAttribute("errorMessage", "Invalid login credentials");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }
            
            // Generic error message to prevent user enumeration
            String genericError = "Invalid login credentials";
            
            // Use UserService for authentication (handles password verification)
            User user;
            try {
                user = userService.authenticateUser(email, password);
            } catch (IllegalArgumentException e) {
                // Authentication failed - use generic error to prevent enumeration
                request.setAttribute("errorMessage", genericError);
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            } catch (SQLException e) {
                // Database error
                System.err.println("Login error: " + e.getMessage());
                request.setAttribute("errorMessage", "An error occurred. Please try again later.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }


            // =================Check if the user is active ======================

            // 2. Account locked (too many failed attempts)
            // if (user.isLocked()) {
            //     response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            //     response.getWriter().write("{\"message\": \"Your account is locked due to too many failed login attempts. Please reset your password or contact support.\"}");
            //     return;
            // }

            // // 3. Account inactive or suspended
            // if (!user.isActive()) {
            //     response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            //     response.getWriter().write("{\"message\": \"Your account is inactive or suspended. Please contact support.\"}");
            //     return;
            // }

            // // 4. Email not verified
            // if (!user.isEmailVerified()) {
            //     response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            //     response.getWriter().write("{\"message\": \"Please verify your email before logging in.\"}");
            //     return;
            // }

            // // 5. Password expired
            // if (user.isPasswordExpired()) {
            //     response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            //     response.getWriter().write("{\"message\": \"Your password has expired. Please reset your password.\"}");
            //     return;
            // }

            // // 6. Password check (use hashed password)
            // if (!PasswordUtil.checkPassword(password, user.getPassword())) {
            //     // Optionally, increment failed login attempts here
            //     response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            //     response.getWriter().write(genericError);
            //     return;
            // }

            // // 7. Multi-factor authentication required (stub, expand as needed)
            // if (user.isMfaEnabled() && !user.isMfaVerified()) {
            //     response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            //     response.getWriter().write("{\"message\": \"Multi-factor authentication required.\"}");
            //     // Optionally, redirect to MFA verification page.
            //     return;
            // }

//=======================================================================




            // Create access log with structured logging
            LocalDateTime now = LocalDateTime.now();
            String action = String.format("User %s (ID: %d, Role: %s) logged in successfully", 
                    user.getEmail(), user.getId(), user.getRole());
            AccessLog accessLog = new AccessLog(0, user.getId(), action, now);
            try {
                accessLogDAO.createAccessLog(accessLog);
                logger.log(Level.INFO, "Login successful: userId={0}, email={1}, role={2}, ip={3}", 
                        new Object[]{user.getId(), user.getEmail(), user.getRole(), 
                        utils.SecurityUtil.getClientIP(request)});
            } catch (SQLException e) {
                // Log error but don't fail login
                logger.log(Level.WARNING, "Failed to create access log for login: " + e.getMessage(), e);
            }

            // Successful login: set session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            

            // Redirect to index.jsp (with context path!)
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } catch (Exception e) {
            // Catch-all for unexpected errors (including SQLException from access log)
            logger.log(Level.SEVERE, "Error during login: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "An error occurred. Please try again later.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
