package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.PaymentDAO;
import dao.PaymentDetailDAO;
import db.DBConnection;
import model.Payment;
import model.PaymentDetail;
import model.User;
import utils.ValidationUtil;

@WebServlet("/api/payment/*")
public class PaymentController extends HttpServlet {
    private PaymentDAO paymentDAO;
    private PaymentDetailDAO paymentDetailDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection conn = DBConnection.getConnection();
            paymentDAO = new PaymentDAO(conn);
            paymentDetailDAO = new PaymentDetailDAO(conn);
        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException("DB init failed", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // List all payments for user
                listPayments(request, response, user);
            } else if (pathInfo.startsWith("/view/")) {
                // View specific payment
                String paymentId = pathInfo.substring(6);
                viewPayment(request, response, user, Integer.parseInt(paymentId));
            } else if (pathInfo.equals("/history")) {
                // Payment history with search
                searchPayments(request, response, user);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error processing request: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
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
            request.setAttribute("error", "Error processing payment: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        
        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        try {
            String paymentIdStr = request.getParameter("paymentId");
            if (paymentIdStr == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            int paymentId = Integer.parseInt(paymentIdStr);
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
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error deleting payment: " + e.getMessage());
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
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
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
        String orderIdStr = request.getParameter("orderId");
        String amountStr = request.getParameter("amount");
        String paymentMethod = request.getParameter("paymentMethod");
        String cardNumber = request.getParameter("cardNumber");
        String expiryDate = request.getParameter("expiryDate");
        String cvv = request.getParameter("cvv");

        // Validation
        if (orderIdStr == null || amountStr == null || paymentMethod == null) {
            request.setAttribute("error", "Missing required payment information");
            request.getRequestDispatcher("/payment-form.jsp").forward(request, response);
            return;
        }

        String validationError = ValidationUtil.validatePayment(amountStr, paymentMethod, cardNumber, expiryDate, cvv);
        if (validationError != null) {
            request.setAttribute("error", validationError);
            request.getRequestDispatcher("/payment-form.jsp").forward(request, response);
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
        
        String paymentIdStr = request.getParameter("paymentId");
        if (paymentIdStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        int paymentId = Integer.parseInt(paymentIdStr);
        Payment payment = paymentDAO.getPaymentById(paymentId);
        
        if (payment == null || !payment.getUserId().equals(user.getId())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        // Only allow updating pending payments
        if (!"PENDING".equals(payment.getStatus())) {
            request.setAttribute("error", "Cannot update processed payment");
            viewPayment(request, response, user, paymentId);
            return;
        }

        // Update payment details
        String amountStr = request.getParameter("amount");
        String paymentMethod = request.getParameter("paymentMethod");

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
        
        String paymentIdStr = request.getParameter("paymentId");
        String dateFrom = request.getParameter("dateFrom");
        String dateTo = request.getParameter("dateTo");

        List<Payment> payments;

        if (paymentIdStr != null && !paymentIdStr.trim().isEmpty()) {
            int paymentId = Integer.parseInt(paymentIdStr);
            Payment payment = paymentDAO.getPaymentById(paymentId);
            payments = (payment != null && payment.getUserId().equals(user.getId())) 
                ? List.of(payment) : List.of();
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
}