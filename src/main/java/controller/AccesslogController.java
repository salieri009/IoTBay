package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import dao.AccessLogDAOImpl;
import dao.interfaces.AccessLogDAO;
import config.DIContainer;
import model.AccessLog;
import model.User;

@WebServlet("/api/accessLog/*")
public class AccesslogController extends HttpServlet {
    private AccessLogDAO accessLogDAO;
    private static final Logger logger = Logger.getLogger(AccesslogController.class.getName());
    private final Gson gson = new Gson();

    @Override
    public void init() throws ServletException {
        Connection connection = DIContainer.getConnection();
        this.accessLogDAO = new AccessLogDAOImpl(connection);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Session check: Only allow logged-in users
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
        String pathInfo = request.getPathInfo();
        
        // Validate pathInfo
        if (pathInfo == null) {
            pathInfo = "/";
        }
        String acceptHeader = request.getHeader("Accept");
        boolean isJsonRequest = acceptHeader != null && acceptHeader.contains("application/json");
        
        // Check if this is a specific endpoint
        if (pathInfo != null && !pathInfo.equals("/")) {
            if (pathInfo.startsWith("/user/")) {
                // GET /api/accessLog/user/{userId}
                String userIdStr = pathInfo.substring(7);
                try {
                    int userId = Integer.parseInt(userIdStr);
                    boolean isStaff = "staff".equalsIgnoreCase(user.getRole()) || 
                                     "admin".equalsIgnoreCase(user.getRole());
                    if (isStaff || user.getId() == userId) {
                        if (isJsonRequest) {
                            getUserAccessLogsJson(response, userId);
                        } else {
                            // Redirect to main access log page
                            response.sendRedirect(request.getContextPath() + "/api/accessLog");
                        }
                    } else {
                        utils.ErrorAction.handleAuthorizationError(request, response, "AccesslogController.doGet");
                    }
                } catch (NumberFormatException e) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID");
                }
                return;
            } else if (pathInfo.equals("/search")) {
                // GET /api/accessLog/search
                if (isJsonRequest) {
                    searchAccessLogsJson(request, response, user);
                } else {
                    // Use existing search logic
                    doGet(request, response);
                }
                return;
            }
        }

        // 2. Date parameter check and validation
        String startDateStr = utils.SecurityUtil.getValidatedStringParameter(request, "startDate", 20);
        String endDateStr = utils.SecurityUtil.getValidatedStringParameter(request, "endDate", 20);
        LocalDate startDate = null, endDate = null;
        LocalDate today = LocalDate.now();


        //date parsing with error handling
        try {
            if (startDateStr != null && !startDateStr.isEmpty()) {
                startDate = LocalDate.parse(startDateStr);
            }
            if (endDateStr != null && !endDateStr.isEmpty()) {
                endDate = LocalDate.parse(endDateStr);
            }
        } catch (DateTimeParseException e) {
            utils.ErrorAction.handleValidationError(request, response, 
                "Date format is invalid. Please use YYYY-MM-DD.", "AccesslogController.doPost");
            return;
        }

        // 3. Date validation
        if ((startDate != null && startDate.isAfter(today)) || (endDate != null && endDate.isAfter(today))) {
            utils.ErrorAction.handleValidationError(request, response, 
                "You cannot search for access logs in the future.", "AccesslogController.doPost");
            return;
        }

      //the start date is null and end date is not null
        if (startDate == null && endDate != null) {
            utils.ErrorAction.handleValidationError(request, response, 
                "Please select a start date when searching with an end date.", "AccesslogController.doPost");
            return;
        }

        //if the start date is null and end date is null
        if (startDate != null && endDate == null) {
            endDate = today;
        }

        // if end date is ealier than start date
        if (startDate != null && endDate != null && endDate.isBefore(startDate)) {
            request.setAttribute("error", "End date cannot be before start date.");
            request.getRequestDispatcher("/WEB-INF/views/accessLog.jsp").forward(request, response);
            return;
        }

        // preventing the date range from being too large
        if (startDate != null && endDate != null && startDate.plusYears(1).isBefore(endDate)) {
            request.setAttribute("error", "Date range is too large. Please select a range within 1 year.");
            request.getRequestDispatcher("/WEB-INF/views/accessLog.jsp").forward(request, response);
            return;
        }

        // 3. Retrieve only the current user's logs from the database
        List<AccessLog> accessLogList = null;
        try {
            if (startDate != null && endDate != null) {
                accessLogList = accessLogDAO.getAccessLogsByUserIdAndDateRange(user.getId(), startDate, endDate);
            } else {
                accessLogList = accessLogDAO.getAccessLogsByUserId(user.getId());
            }
            request.setAttribute("accessLogList", accessLogList);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Failed to retrieve access logs for userId " + user.getId(), e);
            request.setAttribute("error", "An error occurred while retrieving access logs.");
        }

        // 4. Forward to JSP or return JSON
        if (isJsonRequest) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            JsonObject json = new JsonObject();
            json.addProperty("success", true);
            json.add("accessLogs", gson.toJsonTree(accessLogList != null ? accessLogList : Collections.emptyList()));
            json.addProperty("count", accessLogList != null ? accessLogList.size() : 0);
            
            response.getWriter().write(gson.toJson(json));
        } else {
            request.getRequestDispatcher("/WEB-INF/views/accessLog.jsp").forward(request, response);
        }
    }
    
    // JSON API methods
    private void getUserAccessLogsJson(HttpServletResponse response, int userId) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            List<AccessLog> accessLogs = accessLogDAO.getAccessLogsByUserId(userId);
            
            JsonObject json = new JsonObject();
            json.addProperty("success", true);
            json.add("accessLogs", gson.toJsonTree(accessLogs));
            json.addProperty("count", accessLogs.size());
            json.addProperty("userId", userId);
            
            response.getWriter().write(gson.toJson(json));
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Failed to retrieve access logs for userId " + userId, e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JsonObject json = new JsonObject();
            json.addProperty("success", false);
            json.addProperty("error", "Failed to retrieve access logs");
            response.getWriter().write(gson.toJson(json));
        }
    }
    
    private void searchAccessLogsJson(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String userIdStr = request.getParameter("userId");
        String action = request.getParameter("action");
        String dateFrom = request.getParameter("dateFrom");
        String dateTo = request.getParameter("dateTo");
        String ipAddress = request.getParameter("ipAddress");
        
        boolean isStaff = "staff".equalsIgnoreCase(user.getRole()) || 
                         "admin".equalsIgnoreCase(user.getRole());
        
        try {
            List<AccessLog> accessLogs;
            
            // If staff/admin, can search all logs; otherwise only own logs
            if (isStaff && userIdStr != null && !userIdStr.trim().isEmpty()) {
                int searchUserId = Integer.parseInt(userIdStr);
                accessLogs = accessLogDAO.getAccessLogsByUserId(searchUserId);
            } else {
                accessLogs = accessLogDAO.getAccessLogsByUserId(user.getId());
            }
            
            // Apply additional filters if provided
            if (action != null && !action.trim().isEmpty()) {
                final String actionFilter = action.trim();
                accessLogs = accessLogs.stream()
                    .filter(log -> actionFilter.equalsIgnoreCase(log.getAction()))
                    .collect(java.util.stream.Collectors.toList());
            }
            
            if (ipAddress != null && !ipAddress.trim().isEmpty()) {
                final String ipFilter = ipAddress.trim();
                accessLogs = accessLogs.stream()
                    .filter(log -> log.getIpAddress() != null && log.getIpAddress().contains(ipFilter))
                    .collect(java.util.stream.Collectors.toList());
            }
            
            // Date range filtering would require additional DAO methods
            // For now, filter in memory if dates provided
            if (dateFrom != null && dateTo != null) {
                try {
                    LocalDate startDate = LocalDate.parse(dateFrom);
                    LocalDate endDate = LocalDate.parse(dateTo);
                    final LocalDate finalStartDate = startDate;
                    final LocalDate finalEndDate = endDate;
                    accessLogs = accessLogs.stream()
                        .filter(log -> {
                            if (log.getTimestamp() == null) return false;
                            LocalDate logDate = log.getTimestamp().toLocalDate();
                            return (logDate.isEqual(finalStartDate) || logDate.isAfter(finalStartDate)) && 
                                   (logDate.isEqual(finalEndDate) || logDate.isBefore(finalEndDate));
                        })
                        .collect(java.util.stream.Collectors.toList());
                } catch (DateTimeParseException e) {
                    // Invalid date format, ignore filter
                }
            }
            
            JsonObject json = new JsonObject();
            json.addProperty("success", true);
            json.add("accessLogs", gson.toJsonTree(accessLogs));
            json.addProperty("count", accessLogs.size());
            
            response.getWriter().write(gson.toJson(json));
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Failed to search access logs", e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JsonObject json = new JsonObject();
            json.addProperty("success", false);
            json.addProperty("error", "Failed to search access logs");
            response.getWriter().write(gson.toJson(json));
        }
    }

    // POST, PUT, DELETE are not implemented (users cannot edit/delete their access logs)
}