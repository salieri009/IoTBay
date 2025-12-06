package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

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

@WebServlet("/api/manage/access-logs")
public class ManageAccessLogController extends HttpServlet {
    private AccessLogDAO accessLogDAO;

    @Override
    public void init() throws ServletException {
        accessLogDAO = DIContainer.get(AccessLogDAO.class);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            utils.ErrorAction.handleAuthorizationError(request, response, "ManageAccessLogController.doGet");
            return;
        }

        try {
            List<AccessLog> accessLogs = accessLogDAO.getAllAccessLogs();
            request.setAttribute("accessLogs", accessLogs);

            request.getRequestDispatcher("/WEB-INF/views/manage-access-logs.jsp").forward(request, response);

        } catch (SQLException e) {
            utils.ErrorAction.handleDatabaseError(request, response, e, "ManageAccessLogController.doGet");
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "ManageAccessLogController.doGet");
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
        return "staff".equalsIgnoreCase(user.getRole());
    }
}
