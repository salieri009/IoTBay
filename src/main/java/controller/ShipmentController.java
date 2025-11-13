package controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import dao.ShipmentDAO;
import dao.OrderDAOImpl;
import dao.interfaces.OrderDAO;
import db.DBConnection;
import model.Shipment;
import model.Order;
import model.User;
import utils.InputValidator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;

@WebServlet("/shipment/*")
public class ShipmentController extends HttpServlet {
    
    private ShipmentDAO shipmentDAO;
    private OrderDAO orderDAO;
    private final Gson gson = new Gson();
    
    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DBConnection.getConnection();
            shipmentDAO = new ShipmentDAO(connection);
            orderDAO = new OrderDAOImpl(connection);
        } catch (Exception e) {
            throw new ServletException("Failed to initialize ShipmentController", e);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        String acceptHeader = request.getHeader("Accept");
        boolean isJsonRequest = acceptHeader != null && acceptHeader.contains("application/json");
        
        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                if (isJsonRequest) {
                    listShipmentsJson(request, response);
                } else {
                    listShipments(request, response);
                }
            } else if (pathInfo.startsWith("/view/") || pathInfo.matches("/\\d+")) {
                // Support both /view/{id} and /{id}
                String shipmentIdStr = pathInfo.startsWith("/view/") 
                    ? pathInfo.substring(6) 
                    : pathInfo.substring(1);
                int shipmentId = Integer.parseInt(shipmentIdStr);
                if (isJsonRequest) {
                    viewShipmentJson(request, response, shipmentId);
                } else {
                    viewShipment(request, response);
                }
            } else if (pathInfo.startsWith("/tracking/")) {
                // GET /shipment/tracking/{trackingNumber}
                String trackingNumber = pathInfo.substring(10);
                if (isJsonRequest) {
                    trackShipmentJson(response, trackingNumber);
                } else {
                    trackShipment(request, response);
                }
            } else if (pathInfo.equals("/search")) {
                if (isJsonRequest) {
                    searchShipmentsJson(request, response);
                } else {
                    searchShipments(request, response);
                }
            } else if (pathInfo.equals("/form")) {
                showShipmentForm(request, response);
            } else if (pathInfo.equals("/track")) {
                if (isJsonRequest) {
                    String trackingNumber = request.getParameter("trackingNumber");
                    trackShipmentJson(response, trackingNumber);
                } else {
                    trackShipment(request, response);
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            if (isJsonRequest) {
                handleJsonError(response, "Error processing shipment request", e);
            } else {
                handleError(request, response, "Error processing shipment request", e);
            }
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo == null || pathInfo.equals("/create")) {
                createShipment(request, response);
            } else if (pathInfo.equals("/update")) {
                updateShipment(request, response);
            } else if (pathInfo.equals("/delete")) {
                deleteShipment(request, response);
            } else if (pathInfo.equals("/update-status")) {
                updateShipmentStatus(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            handleError(request, response, "Error processing shipment", e);
        }
    }
    
    private void createShipment(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        // Input validation
        String shipmentMethod = InputValidator.validateAndSanitize(
            request.getParameter("shipmentMethod"), "Shipment method");
        String address = InputValidator.validateAndSanitize(
            request.getParameter("address"), "Address");
        String city = InputValidator.validateAndSanitize(
            request.getParameter("city"), "City");
        String state = InputValidator.validateAndSanitize(
            request.getParameter("state"), "State");
        String zipCode = InputValidator.validateAndSanitize(
            request.getParameter("zipCode"), "Zip code");
        String country = InputValidator.validateAndSanitize(
            request.getParameter("country"), "Country");
        String orderIdStr = request.getParameter("orderId");
        String shipmentDateStr = request.getParameter("shipmentDate");
        
        Integer orderId = Integer.parseInt(orderIdStr);
        
        // Verify order exists and belongs to user
        Order order = orderDAO.findById(orderId);
        if (order == null) {
            request.setAttribute("error", "Order not found");
            request.getRequestDispatcher("/shipment-form.jsp").forward(request, response);
            return;
        }
        
        if (order.getUserId() != currentUser.getUserId() && 
            !"staff".equalsIgnoreCase(currentUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        // Create shipment record
        Shipment shipment = new Shipment();
        shipment.setOrderId(orderId);
        shipment.setShipmentMethod(shipmentMethod);
        shipment.setAddress(address);
        shipment.setCity(city);
        shipment.setState(state);
        shipment.setZipCode(zipCode);
        shipment.setCountry(country);
        shipment.setStatus("PREPARING");
        shipment.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        
        // Parse shipment date if provided
        if (shipmentDateStr != null && !shipmentDateStr.trim().isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                shipment.setShipmentDate(new Timestamp(sdf.parse(shipmentDateStr).getTime()));
            } catch (Exception e) {
                // Use current date if parsing fails
                shipment.setShipmentDate(new Timestamp(System.currentTimeMillis()));
            }
        } else {
            shipment.setShipmentDate(new Timestamp(System.currentTimeMillis()));
        }
        
        shipmentDAO.create(shipment);
        
        session.setAttribute("successMessage", "Shipment created successfully");
        response.sendRedirect(request.getContextPath() + "/shipment/list");
    }
    
    private void updateShipment(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        Integer shipmentId = Integer.parseInt(request.getParameter("shipmentId"));
        Shipment shipment = shipmentDAO.findById(shipmentId);
        
        if (shipment == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // Check if shipment can be updated (not DELIVERED)
        if ("DELIVERED".equals(shipment.getStatus())) {
            request.setAttribute("error", "Cannot update delivered shipment");
            request.setAttribute("shipment", shipment);
            request.getRequestDispatcher("/shipment-view.jsp").forward(request, response);
            return;
        }
        
        // Verify user access
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        Order order = orderDAO.findById(shipment.getOrderId());
        
        if (order.getUserId() != currentUser.getUserId() && 
            !"staff".equalsIgnoreCase(currentUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        // Update shipment details
        String shipmentMethod = InputValidator.validateAndSanitize(
            request.getParameter("shipmentMethod"), "Shipment method");
        String address = InputValidator.validateAndSanitize(
            request.getParameter("address"), "Address");
        String city = InputValidator.validateAndSanitize(
            request.getParameter("city"), "City");
        String state = InputValidator.validateAndSanitize(
            request.getParameter("state"), "State");
        String zipCode = InputValidator.validateAndSanitize(
            request.getParameter("zipCode"), "Zip code");
        String country = InputValidator.validateAndSanitize(
            request.getParameter("country"), "Country");
        
        shipment.setShipmentMethod(shipmentMethod);
        shipment.setAddress(address);
        shipment.setCity(city);
        shipment.setState(state);
        shipment.setZipCode(zipCode);
        shipment.setCountry(country);
        shipment.setUpdatedDate(LocalDateTime.now());
        
        shipmentDAO.update(shipment);
        
        session.setAttribute("successMessage", "Shipment updated successfully");
        response.sendRedirect(request.getContextPath() + "/shipment/view/" + shipmentId);
    }
    
    private void deleteShipment(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        Integer shipmentId = Integer.parseInt(request.getParameter("shipmentId"));
        Shipment shipment = shipmentDAO.findById(shipmentId);
        
        if (shipment == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // Check if shipment can be deleted (only PREPARING status)
        if (!"PREPARING".equals(shipment.getStatus())) {
            request.setAttribute("error", "Cannot delete shipment that is already in transit");
            request.setAttribute("shipment", shipment);
            request.getRequestDispatcher("/shipment-view.jsp").forward(request, response);
            return;
        }
        
        // Verify user access
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        Order order = orderDAO.findById(shipment.getOrderId());
        
        if (order.getUserId() != currentUser.getUserId() && 
            !"staff".equalsIgnoreCase(currentUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        shipmentDAO.delete(shipmentId);
        
        session.setAttribute("successMessage", "Shipment deleted successfully");
        response.sendRedirect(request.getContextPath() + "/shipment/");
    }
    
    private void updateShipmentStatus(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        // Only staff can update shipment status
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (!"staff".equalsIgnoreCase(currentUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        Integer shipmentId = Integer.parseInt(request.getParameter("shipmentId"));
        String newStatus = InputValidator.validateAndSanitize(
            request.getParameter("status"), "Status");
        String trackingNumber = request.getParameter("trackingNumber");
        
        Shipment shipment = shipmentDAO.findById(shipmentId);
        
        if (shipment == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        shipment.setStatus(newStatus);
        if (trackingNumber != null && !trackingNumber.trim().isEmpty()) {
            shipment.setTrackingNumber(trackingNumber);
        }
        shipment.setUpdatedDate(LocalDateTime.now());
        
        // If status is SHIPPED or DELIVERED, update the corresponding date
        if ("SHIPPED".equals(newStatus) && shipment.getShipmentDate() == null) {
            shipment.setShipmentDate(new Timestamp(System.currentTimeMillis()));
        } else if ("DELIVERED".equals(newStatus)) {
            shipment.setDeliveryDate(new Timestamp(System.currentTimeMillis()));
        }
        
        shipmentDAO.update(shipment);
        
        session.setAttribute("successMessage", "Shipment status updated successfully");
        response.sendRedirect(request.getContextPath() + "/shipment/view/" + shipmentId);
    }
    
    private void listShipments(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        List<Shipment> shipments;
        
        if ("staff".equalsIgnoreCase(currentUser.getRole())) {
            // Staff can see all shipments
            shipments = shipmentDAO.findAll();
        } else {
            // Customers can only see their own shipments
            shipments = shipmentDAO.findByUserId(currentUser.getUserId());
        }
        
        request.setAttribute("shipments", shipments);
        request.getRequestDispatcher("/shipment-list.jsp").forward(request, response);
    }
    
    private void viewShipment(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        String pathInfo = request.getPathInfo();
        Integer shipmentId = Integer.parseInt(pathInfo.substring(6)); // Remove "/view/"
        
        Shipment shipment = shipmentDAO.findById(shipmentId);
        
        if (shipment == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // Verify user access
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        Order order = orderDAO.findById(shipment.getOrderId());
        
        if (order.getUserId() != currentUser.getUserId() && 
            !"staff".equalsIgnoreCase(currentUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        request.setAttribute("shipment", shipment);
        request.setAttribute("order", order);
        request.getRequestDispatcher("/shipment-view.jsp").forward(request, response);
    }
    
    private void searchShipments(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        String shipmentIdStr = request.getParameter("shipmentId");
        String trackingNumber = request.getParameter("trackingNumber");
        String dateFrom = request.getParameter("dateFrom");
        String dateTo = request.getParameter("dateTo");
        String status = request.getParameter("status");
        
        List<Shipment> shipments;
        
        if (shipmentIdStr != null && !shipmentIdStr.trim().isEmpty()) {
            // Search by shipment ID
            Integer shipmentId = Integer.parseInt(shipmentIdStr);
            Shipment shipment = shipmentDAO.findById(shipmentId);
            
            // Check access permission
            if (shipment != null) {
                Order order = orderDAO.findById(shipment.getOrderId());
                if (order.getUserId() == currentUser.getUserId() || 
                    "staff".equalsIgnoreCase(currentUser.getRole())) {
                    shipments = Collections.singletonList(shipment);
                } else {
                    shipments = Collections.emptyList();
                }
            } else {
                shipments = Collections.emptyList();
            }
        } else if (trackingNumber != null && !trackingNumber.trim().isEmpty()) {
            // Search by tracking number
            Shipment shipment = shipmentDAO.findByTrackingNumber(trackingNumber);
            
            if (shipment != null) {
                Order order = orderDAO.findById(shipment.getOrderId());
                if (order.getUserId() == currentUser.getUserId() || 
                    "staff".equalsIgnoreCase(currentUser.getRole())) {
                    shipments = Collections.singletonList(shipment);
                } else {
                    shipments = Collections.emptyList();
                }
            } else {
                shipments = Collections.emptyList();
            }
        } else {
            // Search by criteria
            if ("staff".equalsIgnoreCase(currentUser.getRole())) {
                shipments = shipmentDAO.searchShipments(null, dateFrom, dateTo, status);
            } else {
                shipments = shipmentDAO.searchShipments(currentUser.getUserId(), dateFrom, dateTo, status);
            }
        }
        
        request.setAttribute("shipments", shipments);
        request.setAttribute("searchPerformed", true);
        request.getRequestDispatcher("/shipment-list.jsp").forward(request, response);
    }
    
    private void trackShipment(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        String trackingNumber = request.getParameter("trackingNumber");
        
        if (trackingNumber == null || trackingNumber.trim().isEmpty()) {
            request.setAttribute("error", "Please provide a tracking number");
            request.getRequestDispatcher("/shipment-tracking.jsp").forward(request, response);
            return;
        }
        
        Shipment shipment = shipmentDAO.findByTrackingNumber(trackingNumber);
        
        if (shipment == null) {
            request.setAttribute("error", "Shipment not found for tracking number: " + trackingNumber);
            request.getRequestDispatcher("/shipment-tracking.jsp").forward(request, response);
            return;
        }
        
        // Get order details
        Order order = orderDAO.findById(shipment.getOrderId());
        
        request.setAttribute("shipment", shipment);
        request.setAttribute("order", order);
        request.getRequestDispatcher("/shipment-tracking.jsp").forward(request, response);
    }
    
    private void showShipmentForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String orderId = request.getParameter("orderId");
        
        if (orderId != null) {
            request.setAttribute("orderId", orderId);
        }
        
        request.getRequestDispatcher("/shipment-form.jsp").forward(request, response);
    }
    
    // JSON API methods
    private void listShipmentsJson(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            JsonObject json = new JsonObject();
            json.addProperty("success", false);
            json.addProperty("error", "Not logged in");
            response.getWriter().write(gson.toJson(json));
            return;
        }
        
        List<Shipment> shipments;
        
        if ("staff".equalsIgnoreCase(currentUser.getRole()) || 
            "admin".equalsIgnoreCase(currentUser.getRole())) {
            shipments = shipmentDAO.findAll();
        } else {
            shipments = shipmentDAO.findByUserId(currentUser.getUserId());
        }
        
        JsonObject json = new JsonObject();
        json.addProperty("success", true);
        json.add("shipments", gson.toJsonTree(shipments));
        json.addProperty("count", shipments.size());
        
        response.getWriter().write(gson.toJson(json));
    }
    
    private void viewShipmentJson(HttpServletRequest request, HttpServletResponse response, int shipmentId) 
            throws ServletException, IOException, SQLException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        Shipment shipment = shipmentDAO.findById(shipmentId);
        
        if (shipment == null) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            JsonObject json = new JsonObject();
            json.addProperty("success", false);
            json.addProperty("error", "Shipment not found");
            response.getWriter().write(gson.toJson(json));
            return;
        }
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        Order order = orderDAO.findById(shipment.getOrderId());
        
        if (order.getUserId() != currentUser.getUserId() && 
            !"staff".equalsIgnoreCase(currentUser.getRole())) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            JsonObject json = new JsonObject();
            json.addProperty("success", false);
            json.addProperty("error", "Access denied");
            response.getWriter().write(gson.toJson(json));
            return;
        }
        
        JsonObject json = new JsonObject();
        json.addProperty("success", true);
        json.add("shipment", gson.toJsonTree(shipment));
        json.add("order", gson.toJsonTree(order));
        
        response.getWriter().write(gson.toJson(json));
    }
    
    private void trackShipmentJson(HttpServletResponse response, String trackingNumber) 
            throws ServletException, IOException, SQLException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        if (trackingNumber == null || trackingNumber.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            JsonObject json = new JsonObject();
            json.addProperty("success", false);
            json.addProperty("error", "Tracking number is required");
            response.getWriter().write(gson.toJson(json));
            return;
        }
        
        Shipment shipment = shipmentDAO.findByTrackingNumber(trackingNumber);
        
        if (shipment == null) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            JsonObject json = new JsonObject();
            json.addProperty("success", false);
            json.addProperty("error", "Shipment not found for tracking number: " + trackingNumber);
            response.getWriter().write(gson.toJson(json));
            return;
        }
        
        Order order = orderDAO.findById(shipment.getOrderId());
        
        JsonObject json = new JsonObject();
        json.addProperty("success", true);
        json.add("shipment", gson.toJsonTree(shipment));
        json.add("order", gson.toJsonTree(order));
        
        response.getWriter().write(gson.toJson(json));
    }
    
    private void searchShipmentsJson(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            JsonObject json = new JsonObject();
            json.addProperty("success", false);
            json.addProperty("error", "Not logged in");
            response.getWriter().write(gson.toJson(json));
            return;
        }
        
        String shipmentIdStr = request.getParameter("shipmentId");
        String trackingNumber = request.getParameter("trackingNumber");
        String dateFrom = request.getParameter("dateFrom");
        String dateTo = request.getParameter("dateTo");
        String status = request.getParameter("status");
        
        List<Shipment> shipments;
        
        if (shipmentIdStr != null && !shipmentIdStr.trim().isEmpty()) {
            Integer shipmentId = Integer.parseInt(shipmentIdStr);
            Shipment shipment = shipmentDAO.findById(shipmentId);
            
            if (shipment != null) {
                Order order = orderDAO.findById(shipment.getOrderId());
                if (order.getUserId() == currentUser.getUserId() || 
                    "staff".equalsIgnoreCase(currentUser.getRole())) {
                    shipments = Collections.singletonList(shipment);
                } else {
                    shipments = Collections.emptyList();
                }
            } else {
                shipments = Collections.emptyList();
            }
        } else if (trackingNumber != null && !trackingNumber.trim().isEmpty()) {
            Shipment shipment = shipmentDAO.findByTrackingNumber(trackingNumber);
            
            if (shipment != null) {
                Order order = orderDAO.findById(shipment.getOrderId());
                if (order.getUserId() == currentUser.getUserId() || 
                    "staff".equalsIgnoreCase(currentUser.getRole())) {
                    shipments = Collections.singletonList(shipment);
                } else {
                    shipments = Collections.emptyList();
                }
            } else {
                shipments = Collections.emptyList();
            }
        } else {
            if ("staff".equalsIgnoreCase(currentUser.getRole()) || 
                "admin".equalsIgnoreCase(currentUser.getRole())) {
                shipments = shipmentDAO.searchShipments(null, dateFrom, dateTo, status);
            } else {
                shipments = shipmentDAO.searchShipments(currentUser.getUserId(), dateFrom, dateTo, status);
            }
        }
        
        JsonObject json = new JsonObject();
        json.addProperty("success", true);
        json.add("shipments", gson.toJsonTree(shipments));
        json.addProperty("count", shipments.size());
        
        response.getWriter().write(gson.toJson(json));
    }
    
    private void handleJsonError(HttpServletResponse response, String message, Exception e) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        
        JsonObject json = new JsonObject();
        json.addProperty("success", false);
        json.addProperty("error", message + ": " + e.getMessage());
        
        response.getWriter().write(gson.toJson(json));
    }
    
    private void handleError(HttpServletRequest request, HttpServletResponse response, 
                           String message, Exception e) throws ServletException, IOException {
        request.setAttribute("error", message + ": " + e.getMessage());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
}