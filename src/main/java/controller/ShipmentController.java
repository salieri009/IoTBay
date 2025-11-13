package controller;

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
import java.util.List;

@WebServlet("/shipment/*")
public class ShipmentController extends HttpServlet {
    
    private ShipmentDAO shipmentDAO;
    private OrderDAO orderDAO;
    
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
        
        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                listShipments(request, response);
            } else if (pathInfo.startsWith("/view/")) {
                viewShipment(request, response);
            } else if (pathInfo.equals("/search")) {
                searchShipments(request, response);
            } else if (pathInfo.equals("/form")) {
                showShipmentForm(request, response);
            } else if (pathInfo.equals("/track")) {
                trackShipment(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            handleError(request, response, "Error processing shipment request", e);
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
                    shipments = List.of(shipment);
                } else {
                    shipments = List.of();
                }
            } else {
                shipments = List.of();
            }
        } else if (trackingNumber != null && !trackingNumber.trim().isEmpty()) {
            // Search by tracking number
            Shipment shipment = shipmentDAO.findByTrackingNumber(trackingNumber);
            
            if (shipment != null) {
                Order order = orderDAO.findById(shipment.getOrderId());
                if (order.getUserId() == currentUser.getUserId() || 
                    "staff".equalsIgnoreCase(currentUser.getRole())) {
                    shipments = List.of(shipment);
                } else {
                    shipments = List.of();
                }
            } else {
                shipments = List.of();
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
    
    private void handleError(HttpServletRequest request, HttpServletResponse response, 
                           String message, Exception e) throws ServletException, IOException {
        request.setAttribute("error", message + ": " + e.getMessage());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
}