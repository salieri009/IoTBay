package controller;

import dao.UserDAOImpl;
import dao.interfaces.UserDAO;
import db.DBConnection;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/manage/users/delete")
public class DeleteUserController extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
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

        if (!isAdmin(request)) {
            utils.ErrorAction.handleAuthorizationError(request, response, "DeleteUserController.doPost");
            return;
        }
        
        // CSRF protection
        if (!utils.SecurityUtil.validateCSRFToken(request)) {
            utils.ErrorAction.handleValidationError(request, response, "CSRF token validation failed", "DeleteUserController.doPost");
            return;
        }

        try {
            int userId = utils.SecurityUtil.getValidatedIntParameter(request, "id", 1, Integer.MAX_VALUE);
            userDAO.deleteUser(userId);
            response.sendRedirect(request.getContextPath() + "/manage/users");
        } catch (SQLException e) {
            utils.ErrorAction.handleDatabaseError(request, response, e, "DeleteUserController.doPost");
        } catch (IllegalArgumentException e) {
            utils.ErrorAction.handleValidationError(request, response, e.getMessage(), "DeleteUserController.doPost");
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "DeleteUserController.doPost");
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
