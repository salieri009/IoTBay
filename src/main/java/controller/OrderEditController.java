package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DIContainer;
import dao.OrderDAO;
import dao.OrderProductDAO;
import dao.interfaces.ProductDAO;
import model.Order;
import model.OrderProduct;
import model.Product;
import model.User;

@WebServlet("/order/*")
public class OrderEditController extends HttpServlet {

    private OrderDAO orderDAO;
    private OrderProductDAO orderProductDAO;
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection conn = DIContainer.getConnection();
            orderDAO = new OrderDAO(conn);
            orderProductDAO = new OrderProductDAO(conn);
            productDAO = DIContainer.get(ProductDAO.class);
        } catch (Exception e) {
            throw new ServletException("Failed to initialize OrderEditController", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
        if ("/edit".equals(pathInfo)) {
            showEditForm(request, response, user);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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

        if (!utils.SecurityUtil.validateCSRFToken(request)) {
            utils.ErrorAction.handleValidationError(request, response,
                    "CSRF token validation failed", "OrderEditController.doPost");
            return;
        }

        String pathInfo = request.getPathInfo();
        if ("/update".equals(pathInfo)) {
            processUpdate(request, response, user);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        try {
            int orderId = utils.SecurityUtil.getValidatedIntParameter(request, "orderId", 1, Integer.MAX_VALUE);
            Order order = orderDAO.getOrderById(orderId);

            if (order == null || order.getUserId() != user.getId()) {
                utils.ErrorAction.handleAuthorizationError(request, response, "OrderEditController.showEditForm");
                return;
            }

            if (!"Pending".equalsIgnoreCase(order.getStatus()) && !"PENDING".equalsIgnoreCase(order.getStatus())) {
                request.setAttribute("error", "Only pending orders can be edited.");
                request.setAttribute("order", order);
                request.getRequestDispatcher("/order-edit.jsp").forward(request, response);
                return;
            }

            List<OrderProduct> rawItems = orderProductDAO.getProductsByOrderId(orderId);
            List<Map<String, Object>> enrichedItems = new ArrayList<>();
            for (OrderProduct op : rawItems) {
                java.util.HashMap<String, Object> item = new java.util.HashMap<>();
                item.put("productId", op.getProductId());
                item.put("quantity", op.getQuantity());
                item.put("priceAtOrderTime", op.getPriceAtOrderTime());
                try {
                    Product p = productDAO.getProductById(op.getProductId());
                    item.put("productName", p != null ? p.getName() : "Product #" + op.getProductId());
                    item.put("stock", p != null ? p.getStockQuantity() : 0);
                } catch (Exception ex) {
                    item.put("productName", "Product #" + op.getProductId());
                    item.put("stock", 0);
                }
                enrichedItems.add(item);
            }

            request.setAttribute("order", order);
            request.setAttribute("orderItems", enrichedItems);
            request.getRequestDispatcher("/order-edit.jsp").forward(request, response);

        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "OrderEditController.showEditForm");
        }
    }

    private void processUpdate(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        try {
            int orderId = utils.SecurityUtil.getValidatedIntParameter(request, "orderId", 1, Integer.MAX_VALUE);
            Order order = orderDAO.getOrderById(orderId);

            if (order == null || order.getUserId() != user.getId()) {
                utils.ErrorAction.handleAuthorizationError(request, response, "OrderEditController.processUpdate");
                return;
            }

            if (!"Pending".equalsIgnoreCase(order.getStatus()) && !"PENDING".equalsIgnoreCase(order.getStatus())) {
                response.sendRedirect(request.getContextPath() + "/orderhistory?error=Order+cannot+be+modified");
                return;
            }

            String[] productIds = request.getParameterValues("productId");
            if (productIds == null || productIds.length == 0) {
                response.sendRedirect(request.getContextPath() + "/orderhistory");
                return;
            }

            BigDecimal newTotal = BigDecimal.ZERO;

            for (String productIdStr : productIds) {
                int productId = Integer.parseInt(productIdStr);
                String qtyStr = request.getParameter("quantity_" + productId);
                if (qtyStr == null) continue;

                int newQty = Integer.parseInt(qtyStr);

                // Get current order product
                List<OrderProduct> existing = orderProductDAO.getProductsByOrderId(orderId);
                OrderProduct current = null;
                for (OrderProduct op : existing) {
                    if (op.getProductId() == productId) {
                        current = op;
                        break;
                    }
                }
                if (current == null) continue;

                int oldQty = current.getQuantity();
                int diff = newQty - oldQty;

                if (newQty <= 0) {
                    // Remove item and restore stock
                    orderProductDAO.deleteOrderProduct(orderId, productId);
                    if (oldQty > 0) {
                        productDAO.increaseStock(productId, oldQty);
                    }
                } else {
                    if (diff > 0) {
                        // Increasing quantity - check stock
                        Product p = productDAO.getProductById(productId);
                        if (p == null || p.getStockQuantity() < diff) {
                            response.sendRedirect(request.getContextPath()
                                    + "/order/edit?orderId=" + orderId
                                    + "&error=Insufficient+stock+for+product+" + productId);
                            return;
                        }
                        productDAO.decreaseStock(productId, diff);
                    } else if (diff < 0) {
                        // Decreasing quantity - restore stock
                        productDAO.increaseStock(productId, -diff);
                    }
                    current.setQuantity(newQty);
                    orderProductDAO.updateOrderProduct(current);
                    newTotal = newTotal.add(BigDecimal.valueOf(current.getPriceAtOrderTime() * newQty));
                }
            }

            // Recalculate order total
            List<OrderProduct> remaining = orderProductDAO.getProductsByOrderId(orderId);
            if (remaining.isEmpty()) {
                // No items left - cancel order
                order.setStatus("Cancelled");
            }
            BigDecimal total = BigDecimal.ZERO;
            for (OrderProduct op : remaining) {
                total = total.add(BigDecimal.valueOf(op.getPriceAtOrderTime() * op.getQuantity()));
            }
            order.setTotalAmount(total);
            orderDAO.updateOrder(order);

            response.sendRedirect(request.getContextPath() + "/orderhistory");

        } catch (Exception e) {
            utils.ErrorAction.handleServerError(request, response, e, "OrderEditController.processUpdate");
        }
    }
}
