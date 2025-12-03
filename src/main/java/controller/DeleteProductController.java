package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ProductDAOImpl;
import dao.interfaces.ProductDAO;
import config.DIContainer;

@WebServlet("/manage/products/delete")
public class DeleteProductController extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DIContainer.getConnection();
            productDAO = new ProductDAOImpl(connection);
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException("Failed to initialize database connection", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            utils.ErrorAction.handleAuthorizationError(request, response, "DeleteProductController.doPost");
            return;
        }

        Object userObj = session.getAttribute("user");
        if (!(userObj instanceof model.User)) {
            utils.ErrorAction.handleAuthorizationError(request, response, "DeleteProductController.doPost");
            return;
        }

        model.User user = (model.User) userObj;
        if (!"staff".equalsIgnoreCase(user.getRole())) {
            utils.ErrorAction.handleAuthorizationError(request, response, "DeleteProductController.doPost");
            return;
        }
        
        // CSRF protection
        if (!utils.SecurityUtil.validateCSRFToken(request)) {
            utils.ErrorAction.handleValidationError(request, response, "CSRF token validation failed", "DeleteProductController.doPost");
            return;
        }

        try {
            int id = utils.SecurityUtil.getValidatedIntParameter(request, "id", 1, Integer.MAX_VALUE);
            productDAO.deleteProduct(id);
            response.sendRedirect(request.getContextPath() + "/manage/products");
        } catch (SQLException e) {
            utils.ErrorAction.handleDatabaseError(request, response, e, "DeleteProductController.doPost");
        } catch (IllegalArgumentException e) {
            utils.ErrorAction.handleValidationError(request, response, e.getMessage(), "DeleteProductController.doPost");
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "DeleteProductController.doPost");
        }
    }
}
