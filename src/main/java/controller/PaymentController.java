package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import dao.PaymentDAO;
import dao.PaymentDetailDAO;
import config.DIContainer;
import model.Payment;
import model.PaymentDetail;
import model.User;
import utils.ValidationUtil;

@WebServlet("/api/payment/*")
public class PaymentController extends HttpServlet {
    private PaymentDAO paymentDAO;
    private PaymentDetailDAO paymentDetailDAO;
    private final Gson gson = new Gson();

    @Override
    public void init() throws ServletException {
        Connection conn = DIContainer.getConnection();
        paymentDAO = new PaymentDAO(conn);
        paymentDetailDAO = new PaymentDetailDAO(conn);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
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

        String acceptHeader = request.getHeader("Accept");
        boolean isJsonRequest = acceptHeader != null && acceptHeader.contains("application/json");

        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // List all payments for user
                if (isJsonRequest) {
                    listPaymentsJson(response, user);
                } else {
                    listPayments(request, response, user);
                }
            } else if (pathInfo.startsWith("/view/") || pathInfo.matches("/\\d+")) {
                // View specific payment - support both /view/{id} and /{id}
                String paymentIdStr = pathInfo.startsWith("/view/") 
                    ? pathInfo.substring(6) 
                    : pathInfo.substring(1);
                int paymentId = Integer.parseInt(paymentIdStr);
                if (isJsonRequest) {
                    viewPaymentJson(response, user, paymentId);
                } else {
                    viewPayment(request, response, user, paymentId);
                }
            } else if (pathInfo.equals("/history") || pathInfo.equals("/search")) {
                // Payment history with search
                if (isJsonRequest) {
                    searchPaymentsJson(response, user, request);
                } else {
                    searchPayments(request, response, user);
                }
            } else if (pathInfo.startsWith("/user/")) {
                // GET /api/payment/user/{userId} - Get user payments
                String userIdStr = pathInfo.substring(6);
                int userId = Integer.parseInt(userIdStr);
                boolean isStaff = "staff".equalsIgnoreCase(user.getRole()) || 
                                 "admin".equalsIgnoreCase(user.getRole());
                if (isStaff || user.getId() == userId) {
                    if (isJsonRequest) {
                        getUserPaymentsJson(response, userId);
                    } else {
                        listPayments(request, response, user);
                    }
                } else {
                    utils.ErrorAction.handleAuthorizationError(request, response, "PaymentController.doGet");
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            if (isJsonRequest) {
                handleJsonError(response, "Error processing request", e);
            } else {
                request.setAttribute("error", "Error processing request: " + e.getMessage());
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
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

        // CSRF protection
        if (!utils.SecurityUtil.validateCSRFToken(request)) {
            utils.ErrorAction.handleValidationError(request, response,
                "CSRF token validation failed", "PaymentController.doPost");
            return;
        }

        try {
            if (pathInfo == null || pathInfo.equals("/create")) {
                createPayment(request, response, user);
            } else if (pathInfo.equals("/update")) {
                updatePayment(request, response, user);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "PaymentController.doPost");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        if (session == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        Object userObj = session.getAttribute("user");
        if (!(userObj instanceof User)) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        User user = (User) userObj;

        try {
            String paymentIdStr = utils.SecurityUtil.getValidatedStringParameter(request, "paymentId", 10);
            if (paymentIdStr == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            int paymentId = utils.SecurityUtil.getValidatedIntParameter(request, "paymentId", 1, Integer.MAX_VALUE);
            Payment payment = paymentDAO.getPaymentById(paymentId);
            
            if (payment == null || !payment.getUserId().equals(user.getId())) {
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                return;
            }

            // Only allow deletion of pending payments
            if (!"PENDING".equals(payment.getStatus())) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Cannot delete processed payment");
                return;
            }

            paymentDetailDAO.deleteByPaymentId(paymentId);
            paymentDAO.deletePayment(paymentId);
            
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Payment deleted successfully");
            
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "PaymentController.doDelete");
        }
    }

    private void listPayments(HttpServletRequest request, HttpServletResponse response, User user)
            throws Exception {
        List<Payment> payments = paymentDAO.getPaymentsByUserId(user.getId());
        request.setAttribute("payments", payments);
        request.getRequestDispatcher("/payment-list.jsp").forward(request, response);
    }

    private void viewPayment(HttpServletRequest request, HttpServletResponse response, User user, int paymentId)
            throws Exception {
        Payment payment = paymentDAO.getPaymentById(paymentId);
        
        if (payment == null || !payment.getUserId().equals(user.getId())) {
            utils.ErrorAction.handleAuthorizationError(request, response, "PaymentController.viewPayment");
            return;
        }

        PaymentDetail paymentDetail = paymentDetailDAO.getByPaymentId(paymentId);
        
        request.setAttribute("payment", payment);
        request.setAttribute("paymentDetail", paymentDetail);
        request.getRequestDispatcher("/payment-view.jsp").forward(request, response);
    }

    private void createPayment(HttpServletRequest request, HttpServletResponse response, User user)
            throws Exception {
        
        // Extract and validate parameters
        String orderIdStr = utils.SecurityUtil.getValidatedStringParameter(request, "orderId", 10);
        String amountStr = utils.SecurityUtil.getValidatedStringParameter(request, "amount", 20);
        String paymentMethod = utils.SecurityUtil.getValidatedStringParameter(request, "paymentMethod", 50);
        String cardNumber = utils.SecurityUtil.getValidatedStringParameter(request, "cardNumber", 20);
        String expiryDate = utils.SecurityUtil.getValidatedStringParameter(request, "expiryDate", 10);
        String cvv = utils.SecurityUtil.getValidatedStringParameter(request, "cvv", 5);

        // Validation
        if (orderIdStr == null || amountStr == null || paymentMethod == null) {
            utils.ErrorAction.handleMissingParameterError(request, response,
                "Missing required payment information", "PaymentController.createPayment");
            return;
        }

        String validationError = ValidationUtil.validatePayment(amountStr, paymentMethod, cardNumber, expiryDate, cvv);
        if (validationError != null) {
            utils.ErrorAction.handleValidationError(request, response, validationError, "PaymentController.createPayment");
            return;
        }

        // Create payment
        Payment payment = new Payment();
        payment.setOrderId(Integer.parseInt(orderIdStr));
        payment.setUserId(user.getId());
        payment.setAmount(new BigDecimal(amountStr));
        payment.setPaymentMethod(paymentMethod);
        payment.setPaymentDate(LocalDateTime.now());
        payment.setStatus("PENDING");

        int paymentId = paymentDAO.createPayment(payment);

        // Create payment details (mask sensitive data)
        PaymentDetail paymentDetail = new PaymentDetail();
        paymentDetail.setPaymentId(paymentId);
        paymentDetail.setUserId(user.getId());
        paymentDetail.setCardNumber(maskCardNumber(cardNumber));
        paymentDetail.setExpiryDate(expiryDate);
        paymentDetail.setCardType(detectCardType(cardNumber));
        // Don't store CVV for security

        paymentDetailDAO.createPaymentDetail(paymentDetail);

        response.sendRedirect(request.getContextPath() + "/api/payment/view/" + paymentId);
    }

    private void updatePayment(HttpServletRequest request, HttpServletResponse response, User user)
            throws Exception {
        
        String paymentIdStr = utils.SecurityUtil.getValidatedStringParameter(request, "paymentId", 10);
        if (paymentIdStr == null) {
            utils.ErrorAction.handleMissingParameterError(request, response,
                "Payment ID is required", "PaymentController.updatePayment");
            return;
        }

        int paymentId = utils.SecurityUtil.getValidatedIntParameter(request, "paymentId", 1, Integer.MAX_VALUE);
        Payment payment = paymentDAO.getPaymentById(paymentId);
        
        if (payment == null || !payment.getUserId().equals(user.getId())) {
            utils.ErrorAction.handleAuthorizationError(request, response, "PaymentController.updatePayment");
            return;
        }

        // Only allow updating pending payments
        if (!"PENDING".equals(payment.getStatus())) {
            utils.ErrorAction.handleValidationError(request, response,
                "Cannot update processed payment", "PaymentController.updatePayment");
            return;
        }

        // Update payment details
        String amountStr = utils.SecurityUtil.getValidatedStringParameter(request, "amount", 20);
        String paymentMethod = utils.SecurityUtil.getValidatedStringParameter(request, "paymentMethod", 50);

        if (amountStr != null && ValidationUtil.isValidAmount(amountStr)) {
            payment.setAmount(new BigDecimal(amountStr));
        }
        if (paymentMethod != null) {
            payment.setPaymentMethod(paymentMethod);
        }
        payment.setUpdatedAt(LocalDateTime.now());

        paymentDAO.updatePayment(payment);

        response.sendRedirect(request.getContextPath() + "/api/payment/view/" + paymentId);
    }

    private void searchPayments(HttpServletRequest request, HttpServletResponse response, User user)
            throws Exception {
        
        String paymentIdStr = utils.SecurityUtil.getValidatedStringParameter(request, "paymentId", 10);
        String dateFrom = utils.SecurityUtil.getValidatedStringParameter(request, "dateFrom", 20);
        String dateTo = utils.SecurityUtil.getValidatedStringParameter(request, "dateTo", 20);

        List<Payment> payments;

        if (paymentIdStr != null && !paymentIdStr.trim().isEmpty()) {
            int paymentId = Integer.parseInt(paymentIdStr);
            Payment payment = paymentDAO.getPaymentById(paymentId);
            payments = (payment != null && payment.getUserId().equals(user.getId())) 
                ? Collections.singletonList(payment) : Collections.emptyList();
        } else if (dateFrom != null && dateTo != null) {
            payments = paymentDAO.getPaymentsByUserIdAndDateRange(user.getId(), dateFrom, dateTo);
        } else {
            payments = paymentDAO.getPaymentsByUserId(user.getId());
        }

        request.setAttribute("payments", payments);
        request.setAttribute("searchPerformed", true);
        request.getRequestDispatcher("/payment-list.jsp").forward(request, response);
    }

    private String maskCardNumber(String cardNumber) {
        if (cardNumber == null || cardNumber.length() < 4) {
            return cardNumber;
        }
        String lastFour = cardNumber.substring(cardNumber.length() - 4);
        return "**** **** **** " + lastFour;
    }

    private String detectCardType(String cardNumber) {
        if (cardNumber == null || cardNumber.isEmpty()) {
            return "UNKNOWN";
        }
        
        // Remove spaces and dashes
        String cleaned = cardNumber.replaceAll("[\\s-]", "");
        
        if (cleaned.matches("^4[0-9]{12}(?:[0-9]{3})?$")) {
            return "VISA";
        } else if (cleaned.matches("^5[1-5][0-9]{14}$")) {
            return "MASTERCARD";
        } else if (cleaned.matches("^3[47][0-9]{13}$")) {
            return "AMEX";
        } else if (cleaned.matches("^6(?:011|5[0-9]{2})[0-9]{12}$")) {
            return "DISCOVER";
        } else {
            return "OTHER";
        }
    }
    
    // JSON API methods
    private void listPaymentsJson(HttpServletResponse response, User user) throws Exception {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        List<Payment> payments = paymentDAO.getPaymentsByUserId(user.getId());
        
        JsonObject json = new JsonObject();
        json.addProperty("success", true);
        json.add("payments", gson.toJsonTree(payments));
        json.addProperty("count", payments.size());
        
        response.getWriter().write(gson.toJson(json));
    }
    
    private void viewPaymentJson(HttpServletResponse response, User user, int paymentId) throws Exception {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        Payment payment = paymentDAO.getPaymentById(paymentId);
        
        if (payment == null || !payment.getUserId().equals(user.getId())) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            JsonObject json = new JsonObject();
            json.addProperty("success", false);
            json.addProperty("error", "Payment not found or access denied");
            response.getWriter().write(gson.toJson(json));
            return;
        }
        
        PaymentDetail paymentDetail = paymentDetailDAO.getByPaymentId(paymentId);
        
        JsonObject json = new JsonObject();
        json.addProperty("success", true);
        json.add("payment", gson.toJsonTree(payment));
        json.add("paymentDetail", gson.toJsonTree(paymentDetail));
        
        response.getWriter().write(gson.toJson(json));
    }
    
    private void searchPaymentsJson(HttpServletResponse response, User user, HttpServletRequest request) throws Exception {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String paymentIdStr = utils.SecurityUtil.getValidatedStringParameter(request, "paymentId", 10);
        String dateFrom = utils.SecurityUtil.getValidatedStringParameter(request, "dateFrom", 20);
        String dateTo = utils.SecurityUtil.getValidatedStringParameter(request, "dateTo", 20);
        String status = utils.SecurityUtil.getValidatedStringParameter(request, "status", 20);
        
        List<Payment> payments;
        
        if (paymentIdStr != null && !paymentIdStr.trim().isEmpty()) {
            int paymentId = Integer.parseInt(paymentIdStr);
            Payment payment = paymentDAO.getPaymentById(paymentId);
            payments = (payment != null && payment.getUserId().equals(user.getId())) 
                ? Collections.singletonList(payment) : Collections.emptyList();
        } else if (dateFrom != null && dateTo != null) {
            payments = paymentDAO.getPaymentsByUserIdAndDateRange(user.getId(), dateFrom, dateTo);
        } else {
            payments = paymentDAO.getPaymentsByUserId(user.getId());
        }
        
        // Filter by status if provided
        if (status != null && !status.trim().isEmpty()) {
            final String statusFilter = status.trim();
            payments = payments.stream()
                .filter(p -> statusFilter.equalsIgnoreCase(p.getStatus()))
                .collect(java.util.stream.Collectors.toList());
        }
        
        JsonObject json = new JsonObject();
        json.addProperty("success", true);
        json.add("payments", gson.toJsonTree(payments));
        json.addProperty("count", payments.size());
        
        response.getWriter().write(gson.toJson(json));
    }
    
    private void getUserPaymentsJson(HttpServletResponse response, int userId) throws Exception {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        List<Payment> payments = paymentDAO.getPaymentsByUserId(userId);
        
        JsonObject json = new JsonObject();
        json.addProperty("success", true);
        json.add("payments", gson.toJsonTree(payments));
        json.addProperty("count", payments.size());
        json.addProperty("userId", userId);
        
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
}