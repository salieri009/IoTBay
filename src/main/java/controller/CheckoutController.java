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

import config.DIContainer;
import dao.CartItemDAO;
import dao.OrderDAO;
import dao.OrderProductDAO;
import dao.PaymentDAO;
import dao.PaymentDetailDAO;
import dao.interfaces.ProductDAO;
import model.CartItem;
import model.Order;
import model.OrderProduct;
import model.Payment;
import model.PaymentDetail;
import model.User;

@WebServlet("/checkout")
public class CheckoutController extends HttpServlet {
    private OrderDAO orderDAO;
    private CartItemDAO cartItemDao;
    private OrderProductDAO orderProductDAO;
    private ProductDAO productDAO;
    private PaymentDAO paymentDAO;
    private PaymentDetailDAO paymentDetailDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DIContainer.getConnection();
            orderDAO = new OrderDAO(connection);
            cartItemDao = new CartItemDAO(connection);
            orderProductDAO = new OrderProductDAO(connection);
            productDAO = DIContainer.get(ProductDAO.class);
            paymentDAO = new PaymentDAO(connection);
            paymentDetailDAO = new PaymentDetailDAO(connection);
        } catch (Exception e) {
            throw new ServletException("Failed to initialize CheckoutController", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            User user = null;
            if (session != null) {
                Object userObj = session.getAttribute("user");
                if (userObj instanceof User) {
                    user = (User) userObj;
                }
            }

            Integer userId;
            if (user != null) {
                userId = user.getId();
            } else {
                userId = (session != null) ? (Integer) session.getAttribute("guestId") : null;
            }

            if (userId == null) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }

            // Get cart items for checkout page
            List<CartItem> cartItems = cartItemDao.getCartItemsByUserId(userId);
            
            if (cartItems == null || cartItems.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/cart.jsp?error=Cart is empty");
                return;
            }

            // Calculate totals - handle null items and prices
            BigDecimal subtotal = cartItems.stream()
                .filter(item -> item != null && item.getPrice() != null)
                .map(item -> item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
            
            BigDecimal shipping = BigDecimal.valueOf(9.95);
            BigDecimal tax = subtotal.multiply(BigDecimal.valueOf(0.10)); // 10% GST
            BigDecimal total = subtotal.add(shipping).add(tax);

            request.setAttribute("cartItems", cartItems);
            request.setAttribute("subtotal", subtotal);
            request.setAttribute("shipping", shipping);
            request.setAttribute("tax", tax);
            request.setAttribute("total", total);
            request.getRequestDispatcher("/checkout.jsp").forward(request, response);
        } catch (SQLException e) {
            utils.ErrorAction.handleDatabaseError(request, response, e, "CheckoutController.doGet");
        } catch (NullPointerException e) {
            utils.ErrorAction.handleServerError(request, response, e, "CheckoutController.doGet");
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "CheckoutController.doGet");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // Rate limiting check
        if (utils.SecurityUtil.isRateLimited(request, 10, 60000)) { // 10 requests per minute
            utils.ErrorAction.handleRateLimitError(request, response, "CheckoutController.doPost");
            return;
        }
        
        try {
            HttpSession session = request.getSession(false);
            User user = null;
            if (session != null) {
                Object userObj = session.getAttribute("user");
                if (userObj instanceof User) {
                    user = (User) userObj;
                }
            }

            Integer userId;
            if (user != null) {
                userId = user.getId();
            } else {
                userId = (session != null) ? (Integer) session.getAttribute("guestId") : null;
            }

            if (userId == null) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }

            // CSRF protection for checkout
            if (!utils.SecurityUtil.validateCSRFToken(request)) {
                utils.ErrorAction.handleValidationError(request, response,
                        "CSRF token validation failed", "CheckoutController.doPost");
                return;
            }

            // Get cart items
            List<CartItem> cartItems = cartItemDao.getCartItemsByUserId(userId);

            if (cartItems == null || cartItems.isEmpty()) {
                response.sendRedirect("cart.jsp?error=Cart is empty");
                return;
            }

            // Validate shipping information if provided.
            // The checkout form posts these as address1/city/postalCode/country;
            // fall back to shipping* names for API/non-form callers. Read leniently —
            // the block below validates & sanitizes whatever is present.
            String shippingAddress = firstNonBlankParam(request, "shippingAddress", "address1");
            String shippingCity = firstNonBlankParam(request, "shippingCity", "city");
            String shippingPostalCode = firstNonBlankParam(request, "shippingPostalCode", "postalCode");
            String shippingCountry = firstNonBlankParam(request, "shippingCountry", "country");
            
            if (shippingAddress != null && !shippingAddress.trim().isEmpty()) {
                // Validate shipping address
                String addressError = utils.ValidationUtil.validateAddress(shippingAddress);
                if (addressError != null) {
                    utils.ErrorAction.handleValidationError(request, response, addressError,
                            "CheckoutController.doPost");
                    return;
                }
                
                // Sanitize shipping information
                shippingAddress = utils.SecurityUtil.sanitizeInput(shippingAddress);
                if (shippingCity != null) {
                    shippingCity = utils.SecurityUtil.sanitizeInput(shippingCity);
                }
                if (shippingPostalCode != null) {
                    shippingPostalCode = utils.SecurityUtil.sanitizeInput(shippingPostalCode);
                    // Validate postal code if provided
                    if (!shippingPostalCode.matches("^\\d{4}$")) {
                        utils.ErrorAction.handleValidationError(request, response,
                                "Invalid postal code format", "CheckoutController.doPost");
                        return;
                    }
                }
                if (shippingCountry != null) {
                    shippingCountry = utils.SecurityUtil.sanitizeInput(shippingCountry);
                }
            }

            // Calculate total using BigDecimal for accurate monetary calculations
            BigDecimal totalAmount = cartItems.stream()
                .filter(item -> item != null && item.getPrice() != null)
                .map(item -> item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
            
            // Validate total amount
            if (totalAmount.compareTo(BigDecimal.ZERO) <= 0) {
                utils.ErrorAction.handleValidationError(request, response,
                        "Invalid order total", "CheckoutController.doPost");
                return;
            }
            
            // Validate total amount is within reasonable range
            if (totalAmount.compareTo(BigDecimal.valueOf(1000000)) > 0) {
                utils.ErrorAction.handleValidationError(request, response,
                        "Order total exceeds maximum allowed amount", "CheckoutController.doPost");
                return;
            }

            // Validate stock availability before creating order
            for (CartItem item : cartItems) {
                if (item == null || item.getProductId() == 0) continue;
                model.Product product = productDAO.getProductById(item.getProductId());
                if (product == null || product.getStockQuantity() < item.getQuantity()) {
                    String productName = product != null ? product.getName() : "Product #" + item.getProductId();
                    utils.ErrorAction.handleValidationError(request, response,
                            "Insufficient stock for: " + productName, "CheckoutController.doPost");
                    return;
                }
            }

            // Create order
            Order order = new Order(0, userId, LocalDateTime.now(), "Pending", totalAmount);
            int orderId = orderDAO.createOrder(order);

            // Save order products and decrease stock
            for (CartItem item : cartItems) {
                if (item == null || item.getProductId() == 0) continue;
                OrderProduct op = new OrderProduct(orderId, item.getProductId(),
                        item.getQuantity(), item.getPrice() != null ? item.getPrice().doubleValue() : 0.0);
                orderProductDAO.addOrderProduct(op);
                productDAO.decreaseStock(item.getProductId(), item.getQuantity());
            }

            // Log security event
            utils.ErrorAction.logSecurityEvent("ORDER_CREATED", request,
                    "Order created for user: " + userId + ", Total: " + totalAmount);

            // Create payment record
            BigDecimal shipping = BigDecimal.valueOf(9.95);
            BigDecimal tax = totalAmount.multiply(BigDecimal.valueOf(0.10));
            BigDecimal grandTotal = totalAmount.add(shipping).add(tax);

            String paymentMethod = utils.SecurityUtil.getValidatedStringParameter(request, "paymentMethod", 50);
            if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
                paymentMethod = "Credit Card";
            }

            Payment payment = new Payment();
            payment.setOrderId(orderId);
            payment.setUserId(user != null ? user.getId() : userId);
            payment.setAmount(grandTotal);
            payment.setPaymentMethod(paymentMethod);
            payment.setPaymentDate(LocalDateTime.now());
            payment.setStatus("PENDING");

            int paymentId = paymentDAO.createPayment(payment);

            // Store card details if provided (masked). Card fields are optional —
            // only meaningful for card payments — and the form names them
            // cardholderName (lowercase h). Read leniently so PayPal/bank don't fail.
            String cardNumber = firstNonBlankParam(request, "cardNumber");
            String expiryDate = firstNonBlankParam(request, "expiryDate");
            String cardHolderName = firstNonBlankParam(request, "cardHolderName", "cardholderName");
            if (cardNumber != null && !cardNumber.trim().isEmpty()) {
                PaymentDetail detail = new PaymentDetail();
                detail.setPaymentId(paymentId);
                detail.setUserId(user != null ? user.getId() : userId);
                detail.setCardNumber(maskCardNumber(cardNumber));
                detail.setExpiryDate(expiryDate);
                detail.setCardHolderName(cardHolderName);
                detail.setCardType(detectCardType(cardNumber));
                paymentDetailDAO.createPaymentDetail(detail);
            }

            // Clear cart after checkout
            cartItemDao.clearCartByUserId(userId);

            response.sendRedirect(request.getContextPath() + "/orderhistory");

        } catch (IllegalArgumentException e) {
            utils.ErrorAction.handleValidationError(request, response, e.getMessage(),
                    "CheckoutController.doPost");
        } catch (SQLException e) {
            utils.ErrorAction.handleDatabaseError(request, response, e, "CheckoutController.doPost");
        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "CheckoutController.doPost");
        }
    }

    /** Returns the first non-blank (trimmed) request parameter among names, else null. */
    private static String firstNonBlankParam(HttpServletRequest request, String... names) {
        for (String n : names) {
            String v = request.getParameter(n);
            if (v != null && !v.trim().isEmpty()) {
                return v.trim();
            }
        }
        return null;
    }

    private String maskCardNumber(String cardNumber) {
        if (cardNumber == null || cardNumber.length() < 4) return cardNumber;
        return "**** **** **** " + cardNumber.substring(cardNumber.length() - 4);
    }

    private String detectCardType(String cardNumber) {
        if (cardNumber == null || cardNumber.isEmpty()) return "UNKNOWN";
        String cleaned = cardNumber.replaceAll("[\\s-]", "");
        if (cleaned.matches("^4[0-9]{12}(?:[0-9]{3})?$")) return "VISA";
        if (cleaned.matches("^5[1-5][0-9]{14}$")) return "MASTERCARD";
        if (cleaned.matches("^3[47][0-9]{13}$")) return "AMEX";
        return "OTHER";
    }
}