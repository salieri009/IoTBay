package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAOImpl;
import dao.interfaces.UserDAO;
import db.DBConnection;
import model.User;
import utils.PasswordUtil;
import utils.ValidationUtil;

// Note: Mapped in web.xml to avoid conflicts
public class RegisterController extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        try {
            Connection connection = DBConnection.getConnection();
            userDAO = new UserDAOImpl(connection);
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException("Failed to initialize database connection", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // Rate limiting check
        if (utils.SecurityUtil.isRateLimited(request, 5, 300000)) { // 5 requests per 5 minutes
            utils.ErrorAction.handleRateLimitError(request, response, "RegisterController.doPost");
            return;
        }

        try {
            // Secure parameter extraction with validation
            String firstName = utils.SecurityUtil.getValidatedStringParameter(request, "firstName", 50);
            String lastName = utils.SecurityUtil.getValidatedStringParameter(request, "lastName", 50);
            String email = utils.SecurityUtil.getValidatedStringParameter(request, "email", 100);
            String password = request.getParameter("password"); // Don't sanitize password
            String confirmPassword = request.getParameter("confirmPassword");
            String phone = utils.SecurityUtil.getValidatedStringParameter(request, "phone", 20);
            String postalCode = utils.SecurityUtil.getValidatedStringParameter(request, "postalCode", 10);
            String addressLine1 = utils.SecurityUtil.getValidatedStringParameter(request, "addressLine1", 200);
            String addressLine2 = request.getParameter("addressLine2"); // Optional
            String dobString = request.getParameter("dateOfBirth"); // Optional
            String paymentMethod = request.getParameter("paymentMethod"); // Optional
            
            // Sanitize inputs (except passwords)
            firstName = utils.SecurityUtil.sanitizeInput(firstName);
            lastName = utils.SecurityUtil.sanitizeInput(lastName);
            email = utils.SecurityUtil.sanitizeInput(email);
            phone = utils.SecurityUtil.sanitizeInput(phone);
            postalCode = utils.SecurityUtil.sanitizeInput(postalCode);
            addressLine1 = utils.SecurityUtil.sanitizeInput(addressLine1);
            if (addressLine2 != null) {
                addressLine2 = utils.SecurityUtil.sanitizeInput(addressLine2);
            }
            if (paymentMethod != null) {
                paymentMethod = utils.SecurityUtil.sanitizeInput(paymentMethod);
            }

            // Validate terms of service acceptance
            String tos = request.getParameter("tos");
            if (tos == null || !tos.equals("on")) {
                utils.ErrorAction.handleValidationError(request, response, 
                        "Terms of service must be accepted", "RegisterController.doPost");
                return;
            }

            // Validate profile data
            String profileError = ValidationUtil.validateRegisterUserProfile(
                    firstName, lastName, phone, postalCode, addressLine1
            );
            if (profileError != null) {
                utils.ErrorAction.handleValidationError(request, response, profileError, 
                        "RegisterController.doPost");
                return;
            }

            // Validate email format
            String emailError = ValidationUtil.validateEmail(email);
            if (emailError != null) {
                utils.ErrorAction.handleValidationError(request, response, emailError, 
                        "RegisterController.doPost");
                return;
            }

            // Validate password strength
            if (!utils.SecurityUtil.isStrongPassword(password)) {
                utils.ErrorAction.handleValidationError(request, response, 
                        "Password does not meet security requirements", "RegisterController.doPost");
                return;
            }

            // Confirm password match
            String passwordError = ValidationUtil.validatePasswordChange(password, confirmPassword);
            if (passwordError != null) {
                utils.ErrorAction.handleValidationError(request, response, passwordError, 
                        "RegisterController.doPost");
                return;
            }

            // Check email duplication
            try {
                if (userDAO.getUserByEmail(email) != null) {
                    // Generic error to prevent user enumeration
                    utils.ErrorAction.handleValidationError(request, response, 
                            "Registration failed", "RegisterController.doPost");
                    return;
                }
            } catch (Exception e) {
                utils.ErrorAction.handleDatabaseError(request, response, e, "RegisterController.doPost");
                return;
            }

            // Parse date of birth (optional)
            LocalDate dateOfBirth = null;
            if (dobString != null && !dobString.trim().isEmpty()) {
                String dobError = ValidationUtil.validateBirthDate(dobString);
                if (dobError != null) {
                    utils.ErrorAction.handleValidationError(request, response, dobError, 
                            "RegisterController.doPost");
                    return;
                }
                try {
                    dateOfBirth = LocalDate.parse(dobString);
                } catch (Exception e) {
                    utils.ErrorAction.handleValidationError(request, response, 
                            "Invalid date format", "RegisterController.doPost");
                    return;
                }
            }

            // Hash password securely
            String hashedPassword = PasswordUtil.hashPassword(password);

            LocalDateTime now = LocalDateTime.now();

            User newUser = new User(
                    0, // id (auto-increment)
                    email,
                    hashedPassword,  // Use hashed password instead of plain text
                    firstName,
                    lastName,
                    phone,
                    postalCode,
                    addressLine1,
                    addressLine2,
                    dateOfBirth,
                    paymentMethod,
                    now,
                    now,
                    "customer", // default role
                    true    
            );

            userDAO.createUser(newUser);
            
            // Log security event
            utils.ErrorAction.logSecurityEvent("USER_REGISTERED", request, 
                    "New user registered: " + email);

            response.sendRedirect(request.getContextPath() + "/welcome.jsp");

        } catch (IllegalArgumentException e) {
            utils.ErrorAction.handleValidationError(request, response, e.getMessage(), 
                    "RegisterController.doPost");
        } catch (SQLException e) {
            utils.ErrorAction.handleDatabaseError(request, response, e, "RegisterController.doPost");
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "RegisterController.doPost");
        }
    }
}