package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import dao.OrderDAO;
import config.DIContainer;
import model.Order;
import model.User;
import service.OrderService;
import config.DIContainer;

// Note: Mapped in web.xml to avoid conflicts
public class OrderHistoryController extends HttpServlet {
    private OrderDAO orderDAO;
    private OrderService orderService;
    private final Gson gson = new Gson();

    @Override
    public void init() throws ServletException {
        Connection connection = DIContainer.getConnection();
        orderDAO = new OrderDAO(connection);
        orderService = new OrderService(orderDAO);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        Object userObj = session.getAttribute("user");
        if (!(userObj instanceof User)) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        User user = (User) userObj;

        String acceptHeader = request.getHeader("Accept");
        boolean isJsonRequest = acceptHeader != null && acceptHeader.contains("application/json");
        
        // Get filter parameters
        String statusFilter = request.getParameter("status");
        String dateRangeStr = request.getParameter("dateRange");
        String orderNumber = request.getParameter("orderNumber");
        
        Integer dateRange = null;
        if (dateRangeStr != null && !dateRangeStr.isEmpty()) {
            try {
                dateRange = Integer.parseInt(dateRangeStr);
            } catch (NumberFormatException e) {
                dateRange = null;
            }
        }
        
        try {
            // Use OrderService for filtering
            List<Order> orders = orderService.getUserOrders(
                user.getId(), statusFilter, dateRange, orderNumber);
            
            if (isJsonRequest) {
                // Return JSON response
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                
                JsonObject json = new JsonObject();
                json.addProperty("success", true);
                json.add("orders", gson.toJsonTree(orders));
                json.addProperty("count", orders.size());
                
                // Add statistics
                OrderService.OrderStatistics stats = orderService.getUserOrderStatistics(user.getId());
                json.add("statistics", gson.toJsonTree(stats));
                
                response.getWriter().write(gson.toJson(json));
            } else {
                // Return JSP view
                request.setAttribute("orders", orders);
                request.setAttribute("statusFilter", statusFilter);
                request.setAttribute("dateRange", dateRangeStr);
                request.setAttribute("orderNumber", orderNumber);
                
                request.getRequestDispatcher("orderList.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            utils.ErrorAction.handleDatabaseError(request, response, e, "OrderHistoryController.doGet");
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "OrderHistoryController.doGet");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Handle order status updates (staff/admin only)
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        Object userObj = session.getAttribute("user");
        if (!(userObj instanceof User)) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        User user = (User) userObj;
        
        // CSRF protection
        if (!utils.SecurityUtil.validateCSRFToken(request)) {
            utils.ErrorAction.handleValidationError(request, response,
                "CSRF token validation failed", "OrderHistoryController.doPost");
            return;
        }
        
        boolean isStaff = "staff".equalsIgnoreCase(user.getRole()) || 
                         "admin".equalsIgnoreCase(user.getRole());
        
        if (!isStaff) {
            utils.ErrorAction.handleAuthorizationError(request, response, "OrderHistoryController.doPost");
            return;
        }
        
        String orderIdStr = utils.SecurityUtil.getValidatedStringParameter(request, "orderId", 10);
        String newStatus = utils.SecurityUtil.getValidatedStringParameter(request, "status", 50);
        
        if (orderIdStr == null || newStatus == null) {
            utils.ErrorAction.handleMissingParameterError(request, response, 
                "Order ID and status are required", "OrderHistoryController.doPost");
            return;
        }
        
        try {
            Integer orderId = Integer.parseInt(orderIdStr);
            OrderService.OrderOperationResult result = orderService.updateOrderStatus(
                orderId, newStatus, user.getId(), true);
            
            String acceptHeader = request.getHeader("Accept");
            boolean isJsonRequest = acceptHeader != null && acceptHeader.contains("application/json");
            
            if (isJsonRequest) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                
                JsonObject json = new JsonObject();
                json.addProperty("success", result.isSuccess());
                
                if (result.isSuccess()) {
                    json.addProperty("message", result.getMessage());
                    json.add("order", gson.toJsonTree(result.getOrder()));
                } else {
                    json.addProperty("error", result.getErrorMessage());
                }
                
                response.getWriter().write(gson.toJson(json));
            } else {
                if (result.isSuccess()) {
                    session.setAttribute("successMessage", result.getMessage());
                } else {
                    session.setAttribute("error", result.getErrorMessage());
                }
                response.sendRedirect(request.getContextPath() + "/orderhistory");
            }
        } catch (SQLException e) {
            utils.ErrorAction.handleDatabaseError(request, response, e, "OrderHistoryController.doPost");
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "OrderHistoryController.doPost");
        }
    }
}