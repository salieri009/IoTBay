package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DIContainer;
import dao.interfaces.UserDAO;
import model.User;
import utils.ValidationUtil;

// Note: Mapped in web.xml to avoid conflicts
public class UserProfileController extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        try {
            // Use DIContainer for dependency injection
            userDAO = DIContainer.get(UserDAO.class);
            if (userDAO == null) {
                throw new ServletException("UserDAO not available in DIContainer");
            }
        } catch (Exception e) {
            throw new ServletException("Failed to initialize UserProfileController", e);
        }
    }

    // GET: Show current user's profile (for profile page)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                //brings user to profile page
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        Object userObj = session.getAttribute("user");
        if (!(userObj instanceof User)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        User user = (User) userObj;
        // update user info
        try {
            User freshUser = userDAO.getUserById(user.getId());
            if (freshUser == null) {
                request.setAttribute("errorMessage", "User profile not found");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }
            request.setAttribute("user", freshUser);
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
        } catch (SQLException e) {
            System.err.println("Database error loading profile: " + e.getMessage());
            request.setAttribute("errorMessage", "Database error occurred");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error loading profile: " + e.getMessage());
            request.setAttribute("errorMessage", "Failed to load profile: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    
    // POST: Update current user's profile
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Object userObj = session.getAttribute("user");
        if (!(userObj instanceof User)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        User sessionUser = (User) userObj;

        // CSRF protection
        if (!utils.SecurityUtil.validateCSRFToken(request)) {
            utils.ErrorAction.handleValidationError(request, response,
                "CSRF token validation failed", "UserProfileController.doPost");
            return;
        }

        // 파라미터 추출
        String firstName = utils.SecurityUtil.getValidatedStringParameter(request, "firstName", 50);
        String lastName = utils.SecurityUtil.getValidatedStringParameter(request, "lastName", 50);
        String phone = utils.SecurityUtil.getValidatedStringParameter(request, "phone", 20);
        String postalCode = utils.SecurityUtil.getValidatedStringParameter(request, "postalCode", 10);
        String addressLine1 = utils.SecurityUtil.getValidatedStringParameter(request, "addressLine1", 200);
        String addressLine2 = utils.SecurityUtil.getValidatedStringParameter(request, "addressLine2", 200);
        String dobString = utils.SecurityUtil.getValidatedStringParameter(request, "dateOfBirth", 20);
        String paymentMethod = utils.SecurityUtil.getValidatedStringParameter(request, "paymentMethod", 50);

        // 유효성 검사
        if (firstName == null || lastName == null || phone == null || postalCode == null || addressLine1 == null) {
            utils.ErrorAction.handleMissingParameterError(request, response,
                "Required fields are missing", "UserProfileController.doPost");
            return;
        }
        
        String profileError = ValidationUtil.validateRegisterUserProfile(
            firstName, lastName, phone, postalCode, addressLine1
        );
        if (profileError != null) {
            utils.ErrorAction.handleValidationError(request, response, profileError, "UserProfileController.doPost");
            return;
        }

        LocalDate dateOfBirth = null;
        if (dobString != null && !dobString.trim().isEmpty()) {
            String dobError = ValidationUtil.validateBirthDate(dobString);
            if (dobError != null) {
                request.setAttribute("error", dobError);
                doGet(request, response);
                return;
            }
            dateOfBirth = LocalDate.parse(dobString);
        }

        try {
            // 기존 정보 유지, 변경된 정보만 업데이트
            User updatedUser = new User(
                sessionUser.getId(),
                sessionUser.getEmail(), // 이메일은 변경 불가(실무적)
                sessionUser.getPassword(),
                firstName,
                lastName,
                phone,
                postalCode,
                addressLine1,
                addressLine2,
                dateOfBirth,
                paymentMethod,
                sessionUser.getCreatedAt().toLocalDateTime(),
                java.time.LocalDateTime.now(),
                sessionUser.getRole(),
                sessionUser.isActive()
            );
            userDAO.updateUser(updatedUser.getId(), updatedUser);
            // 세션 정보도 갱신
            session.setAttribute("user", updatedUser);
            // 성공 메시지와 함께 프로필 페이지로 이동
            request.setAttribute("success", "Profile updated successfully.");
            doGet(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Failed to update profile: " + e.getMessage());
            doGet(request, response);
        }
    }

    // DELETE: Delete current user's account
    @Override
protected void doDelete(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    HttpSession session = request.getSession(false);
    if (session == null) {
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.getWriter().write("Unauthorized: Please login.");
        return;
    }
    
    Object userObj = session.getAttribute("user");
    if (!(userObj instanceof User)) {
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.getWriter().write("Unauthorized: Please login.");
        return;
    }
    
    User sessionUser = (User) userObj;

    try {
        // 실제로 DB에서 사용자 삭제
        userDAO.deleteUser(sessionUser.getId());
        // 세션 무효화
        session.invalidate();
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().write("Account deleted successfully.");
    } catch (Exception e) {
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.getWriter().write("Failed to delete account: " + e.getMessage());
    }
}
}
