package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;

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

@WebServlet("/manage/users/update")
public class UpdateUserController extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DIContainer.getConnection();
            userDAO = new UserDAOImpl(connection);
        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException("Failed to connect to database", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // Authorization check
        if (!isAdmin(request)) {
            utils.ErrorAction.handleAuthorizationError(request, response, "UpdateUserController.doPost");
            return;
        }

        // Rate limiting check
        if (utils.SecurityUtil.isRateLimited(request, 10, 60000)) { // 10 requests per minute
            utils.ErrorAction.handleRateLimitError(request, response, "UpdateUserController.doPost");
            return;
        }

        // CSRF protection
        if (!utils.SecurityUtil.validateCSRFToken(request)) {
            utils.ErrorAction.handleValidationError(request, response,
                    "CSRF token validation failed", "UpdateUserController.doPost");
            return;
        }

        try {
            // Secure parameter extraction with validation
            int id = utils.SecurityUtil.getValidatedIntParameter(request, "user_id", 1, Integer.MAX_VALUE);
            String email = utils.SecurityUtil.getValidatedStringParameter(request, "email", 100);
            String password = request.getParameter("password"); // Optional for update
            String firstName = utils.SecurityUtil.getValidatedStringParameter(request, "firstName", 50);
            String lastName = utils.SecurityUtil.getValidatedStringParameter(request, "lastName", 50);
            String phone = request.getParameter("phone"); // Optional
            String postalCode = request.getParameter("postalCode"); // Optional
            String addressLine1 = request.getParameter("addressLine1"); // Optional
            String addressLine2 = request.getParameter("addressLine2"); // Optional
            String paymentMethod = request.getParameter("paymentMethod"); // Optional
            String dateOfBirthStr = request.getParameter("dateOfBirth");
            String role = utils.SecurityUtil.getValidatedStringParameter(request, "role", 20);
            String isActiveStr = request.getParameter("isActive");

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
                        "UpdateUserController.doPost");
                return;
            }

            // Validate password if provided
            if (password != null && !password.trim().isEmpty()) {
                if (!utils.SecurityUtil.isStrongPassword(password)) {
                    utils.ErrorAction.handleValidationError(request, response,
                            "Password does not meet security requirements", "UpdateUserController.doPost");
                    return;
                }
                password = utils.PasswordUtil.hashPassword(password); // Hash password
            }

            // Validate profile data
            String profileError = utils.ValidationUtil.validateRegisterUserProfile(
                    firstName, lastName, phone != null ? phone : "", 
                    postalCode != null ? postalCode : "", 
                    addressLine1 != null ? addressLine1 : "");
            if (profileError != null) {
                utils.ErrorAction.handleValidationError(request, response, profileError,
                        "UpdateUserController.doPost");
                return;
            }

            // Parse date of birth
            LocalDate dateOfBirth = null;
            if (dateOfBirthStr != null && !dateOfBirthStr.trim().isEmpty()) {
                String dobError = utils.ValidationUtil.validateBirthDate(dateOfBirthStr);
                if (dobError != null) {
                    utils.ErrorAction.handleValidationError(request, response, dobError,
                            "UpdateUserController.doPost");
                    return;
                }
                try {
                    dateOfBirth = LocalDate.parse(dateOfBirthStr);
                } catch (Exception e) {
                    utils.ErrorAction.handleValidationError(request, response,
                            "Invalid date format", "UpdateUserController.doPost");
                    return;
                }
            }

            // Validate role
            String[] validRoles = {"customer", "staff", "admin"};
            boolean isValidRole = false;
            for (String validRole : validRoles) {
                if (validRole.equalsIgnoreCase(role)) {
                    isValidRole = true;
                    break;
                }
            }
            if (!isValidRole) {
                utils.ErrorAction.handleValidationError(request, response,
                        "Invalid user role", "UpdateUserController.doPost");
                return;
            }

            // Check if user exists
            User existingUser = userDAO.getUserById(id);
            if (existingUser == null) {
                utils.ErrorAction.handleValidationError(request, response,
                        "User not found", "UpdateUserController.doPost");
                return;
            }

            // Check email duplication (if email changed)
            if (!email.equalsIgnoreCase(existingUser.getEmail())) {
                if (userDAO.getUserByEmail(email) != null) {
                    utils.ErrorAction.handleValidationError(request, response,
                            "Email already exists", "UpdateUserController.doPost");
                    return;
                }
            }

            // Set createdAt and updatedAt to the current time
            LocalDateTime now = LocalDateTime.now();

            // Parse isActive (checkbox or boolean string)
            boolean isActive = isActiveStr != null &&
                    (isActiveStr.equalsIgnoreCase("true") || isActiveStr.equalsIgnoreCase("on") || isActiveStr.equals("1"));

            // Use existing password if new password not provided
            String finalPassword = (password != null && !password.trim().isEmpty()) 
                    ? password 
                    : existingUser.getPassword();

            // Construct the User object
            // Use existing creation date or current time if null
            java.sql.Timestamp createdAtTimestamp = existingUser.getCreatedAt();
            LocalDateTime createdAt;
            if (createdAtTimestamp != null) {
                createdAt = createdAtTimestamp.toLocalDateTime();
            } else {
                createdAt = now;
            }
            
            // Use existing values for optional fields if not provided
            String finalPhone = (phone != null && !phone.trim().isEmpty()) ? phone : existingUser.getPhone();
            String finalPostalCode = (postalCode != null && !postalCode.trim().isEmpty()) ? postalCode : existingUser.getPostalCode();
            String finalAddressLine1 = (addressLine1 != null && !addressLine1.trim().isEmpty()) ? addressLine1 : existingUser.getAddressLine1();
            String finalAddressLine2 = (addressLine2 != null && !addressLine2.trim().isEmpty()) ? addressLine2 : existingUser.getAddressLine2();
            String finalPaymentMethod = (paymentMethod != null && !paymentMethod.trim().isEmpty()) ? paymentMethod : existingUser.getPaymentMethod();
            LocalDate finalDateOfBirth = (dateOfBirth != null) ? dateOfBirth : existingUser.getDateOfBirth();
            
            User updatedUser = new User(
                0, // id (actual id is passed separately)
                email,
                finalPassword,
                firstName,
                lastName,
                finalPhone,
                finalPostalCode,
                finalAddressLine1,
                finalAddressLine2,
                finalDateOfBirth,
                finalPaymentMethod,
                createdAt, // Preserve original creation date
                now, // Update timestamp
                role.toLowerCase(),
                isActive
            );

            userDAO.updateUser(id, updatedUser);

            // Log security event
            utils.ErrorAction.logSecurityEvent("USER_UPDATED_BY_ADMIN", request,
                    "User updated: " + email + ", ID: " + id);

            response.sendRedirect(request.getContextPath() + "/manage/users");

        } catch (IllegalArgumentException e) {
            utils.ErrorAction.handleValidationError(request, response, e.getMessage(),
                    "UpdateUserController.doPost");
        } catch (SQLException e) {
            utils.ErrorAction.handleDatabaseError(request, response, e, "UpdateUserController.doPost");
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "UpdateUserController.doPost");
        }
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return false;

        Object userObj = session.getAttribute("user");
        if (!(userObj instanceof User)) return false;

        User user = (User) userObj;
        return "staff".equalsIgnoreCase(user.getRole());
    }
}
