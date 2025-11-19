package service;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import config.DIContainer;
import dao.interfaces.UserDAO;
import model.User;
import model.dto.UserRegistrationRequest;
import utils.PasswordUtil;
import utils.ValidationUtil;

/**
 * 최신 트렌드: Service Layer Pattern
 * Business Logic Separation from Controllers
 */
public class UserService {
    private final UserDAO userDAO;
    
    public UserService() {
        this.userDAO = DIContainer.get(UserDAO.class);
    }
    
    public User registerUser(UserRegistrationRequest request) throws SQLException {
        // 1. Validation
        if (!request.isValid()) {
            throw new IllegalArgumentException("Invalid user registration data");
        }
        
        // 2. Business rules validation
        String emailError = ValidationUtil.validateEmail(request.getEmail());
        if (emailError != null) {
            throw new IllegalArgumentException(emailError);
        }
        
        String passwordError = ValidationUtil.validatePasswordChange(
            request.getPassword(), request.getConfirmPassword());
        if (passwordError != null) {
            throw new IllegalArgumentException(passwordError);
        }
        
        // 3. Check email uniqueness
        if (userDAO.getUserByEmail(request.getEmail()) != null) {
            throw new IllegalArgumentException("Email already exists");
        }
        
        // 4. Create user
        String hashedPassword = PasswordUtil.hashPassword(request.getPassword());
        LocalDate dateOfBirth = null;
        
        if (request.getDateOfBirth() != null && !request.getDateOfBirth().trim().isEmpty()) {
            try {
                dateOfBirth = LocalDate.parse(request.getDateOfBirth());
            } catch (Exception e) {
                throw new IllegalArgumentException("Invalid date of birth format");
            }
        }
        
        LocalDateTime now = LocalDateTime.now();
        User newUser = new User(
            0, // auto-increment
            request.getEmail(),
            hashedPassword,
            request.getFirstName(),
            request.getLastName(),
            request.getPhone(),
            request.getPostalCode(),
            request.getAddressLine1(),
            request.getAddressLine2(),
            dateOfBirth,
            request.getPaymentMethod(),
            now,
            now,
            "customer", // default role
            true
        );
        
        userDAO.createUser(newUser);
        return userDAO.getUserByEmail(request.getEmail());
    }
    
    public User authenticateUser(String email, String password) throws SQLException {
        User user = userDAO.getUserByEmail(email);
        
        if (user == null) {
            throw new IllegalArgumentException("User not found");
        }
        
        // Check if password is hashed (contains $ separator) or plain text (for migration)
        String storedPassword = user.getPassword();
        boolean passwordValid = false;
        
        if (storedPassword != null && storedPassword.contains("$")) {
            // Password is hashed, use PasswordUtil
            passwordValid = PasswordUtil.verifyPassword(password, storedPassword);
        } else {
            // Legacy plain text password (for migration period)
            // In production, all passwords should be hashed
            passwordValid = password.equals(storedPassword);
        }
        
        if (!passwordValid) {
            throw new IllegalArgumentException("Invalid password");
        }
        
        if (!user.isActive()) {
            throw new IllegalArgumentException("Account is inactive");
        }
        
        return user;
    }
    
    public List<User> getAllUsers() throws SQLException {
        return userDAO.getAllUsers();
    }
    
    public User getUserById(int userId) throws SQLException {
        return userDAO.getUserById(userId);
    }
    
    public void updateUser(int userId, User user) throws SQLException {
        userDAO.updateUser(userId, user);
    }
    
    public void deleteUser(int userId) throws SQLException {
        userDAO.deleteUser(userId);
    }
}
