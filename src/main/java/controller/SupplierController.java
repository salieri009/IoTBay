package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DIContainer;
import dao.SupplierDAOImpl;
import model.Supplier;

@WebServlet("/admin/supplier/*")
public class SupplierController extends HttpServlet {

    private SupplierDAOImpl supplierDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DIContainer.getConnection();
            supplierDAO = new SupplierDAOImpl(connection);
        } catch (Exception e) {
            throw new ServletException("Failed to initialize SupplierController", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check staff privileges
        if (!isStaff(request)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String pathInfo = request.getPathInfo();

        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                listSuppliers(request, response);
            } else if (pathInfo.startsWith("/view/")) {
                viewSupplier(request, response);
            } else if (pathInfo.equals("/search")) {
                searchSuppliers(request, response);
            } else if (pathInfo.equals("/form")) {
                showSupplierForm(request, response);
            } else if (pathInfo.startsWith("/edit/")) {
                editSupplier(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            handleError(request, response, "Error processing supplier request", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check staff privileges
        if (!isStaff(request)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String pathInfo = request.getPathInfo();

        try {
            if (pathInfo == null || pathInfo.equals("/create")) {
                createSupplier(request, response);
            } else if (pathInfo.equals("/update")) {
                updateSupplier(request, response);
            } else if (pathInfo.equals("/delete")) {
                deleteSupplier(request, response);
            } else if (pathInfo.equals("/toggle-status")) {
                toggleSupplierStatus(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            handleError(request, response, "Error processing supplier", e);
        }
    }

    private void createSupplier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        // Rate limiting check
        if (utils.SecurityUtil.isRateLimited(request, 10, 60000)) { // 10 requests per minute
            utils.ErrorAction.handleRateLimitError(request, response, "SupplierController.createSupplier");
            return;
        }

        // CSRF protection
        if (!utils.SecurityUtil.validateCSRFToken(request)) {
            utils.ErrorAction.handleValidationError(request, response,
                    "CSRF token validation failed", "SupplierController.createSupplier");
            return;
        }

        // Secure parameter extraction with validation
        String contactName = utils.SecurityUtil.getValidatedStringParameter(request, "contactName", 100);
        String companyName = utils.SecurityUtil.getValidatedStringParameter(request, "companyName", 200);
        String email = utils.SecurityUtil.getValidatedStringParameter(request, "email", 100);
        String phone = utils.SecurityUtil.getValidatedStringParameter(request, "phone", 20);
        String address = utils.SecurityUtil.getValidatedStringParameter(request, "address", 200);
        String city = utils.SecurityUtil.getValidatedStringParameter(request, "city", 100);
        String state = utils.SecurityUtil.getValidatedStringParameter(request, "state", 50);
        String zipCode = utils.SecurityUtil.getValidatedStringParameter(request, "zipCode", 10);
        String country = utils.SecurityUtil.getValidatedStringParameter(request, "country", 100);
        String website = request.getParameter("website"); // Optional
        String description = request.getParameter("description"); // Optional

        // Sanitize inputs
        contactName = utils.SecurityUtil.sanitizeInput(contactName);
        companyName = utils.SecurityUtil.sanitizeInput(companyName);
        email = utils.SecurityUtil.sanitizeInput(email);
        phone = utils.SecurityUtil.sanitizeInput(phone);
        address = utils.SecurityUtil.sanitizeInput(address);
        city = utils.SecurityUtil.sanitizeInput(city);
        state = utils.SecurityUtil.sanitizeInput(state);
        zipCode = utils.SecurityUtil.sanitizeInput(zipCode);
        country = utils.SecurityUtil.sanitizeInput(country);
        if (website != null) {
            website = utils.SecurityUtil.sanitizeInput(website);
        }
        if (description != null) {
            description = utils.SecurityUtil.sanitizeInput(description);
        }

        // Validate email format
        String emailError = utils.ValidationUtil.validateEmail(email);
        if (emailError != null) {
            utils.ErrorAction.handleValidationError(request, response, emailError,
                    "SupplierController.createSupplier");
            return;
        }

        // Check if supplier already exists
        if (supplierDAO.findByEmail(email) != null) {
            utils.ErrorAction.handleValidationError(request, response,
                    "Supplier with this email already exists", "SupplierController.createSupplier");
            return;
        }

        // Create supplier
        Supplier supplier = new Supplier();
        supplier.setContactName(contactName);
        supplier.setCompanyName(companyName);
        supplier.setEmail(email);
        supplier.setPhone(phone);
        supplier.setAddress(address);
        supplier.setCity(city);
        supplier.setState(state);
        supplier.setZipCode(zipCode);
        supplier.setCountry(country);
        supplier.setWebsite(website);
        supplier.setDescription(description);
        supplier.setActive(true);
        supplier.setCreatedDate(new Timestamp(System.currentTimeMillis()));

        Supplier createdSupplier = supplierDAO.createSupplier(supplier);
        int supplierId = createdSupplier.getId();

        // Log security event
        utils.ErrorAction.logSecurityEvent("SUPPLIER_CREATED", request,
                "Supplier created: " + companyName + ", Email: " + email);

        HttpSession session = request.getSession();
        session.setAttribute("successMessage", "Supplier created successfully");
        response.sendRedirect(request.getContextPath() + "/admin/supplier/view/" + supplierId);
    }

    private void updateSupplier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        Integer supplierId = Integer.parseInt(request.getParameter("supplierId"));
        Supplier supplier = supplierDAO.findById(supplierId);

        if (supplier == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Rate limiting check
        if (utils.SecurityUtil.isRateLimited(request, 10, 60000)) { // 10 requests per minute
            utils.ErrorAction.handleRateLimitError(request, response, "SupplierController.updateSupplier");
            return;
        }

        // CSRF protection
        if (!utils.SecurityUtil.validateCSRFToken(request)) {
            utils.ErrorAction.handleValidationError(request, response,
                    "CSRF token validation failed", "SupplierController.updateSupplier");
            return;
        }

        // Secure parameter extraction with validation
        String contactName = utils.SecurityUtil.getValidatedStringParameter(request, "contactName", 100);
        String companyName = utils.SecurityUtil.getValidatedStringParameter(request, "companyName", 200);
        String email = utils.SecurityUtil.getValidatedStringParameter(request, "email", 100);
        String phone = utils.SecurityUtil.getValidatedStringParameter(request, "phone", 20);
        String address = utils.SecurityUtil.getValidatedStringParameter(request, "address", 200);
        String city = utils.SecurityUtil.getValidatedStringParameter(request, "city", 100);
        String state = utils.SecurityUtil.getValidatedStringParameter(request, "state", 50);
        String zipCode = utils.SecurityUtil.getValidatedStringParameter(request, "zipCode", 10);
        String country = utils.SecurityUtil.getValidatedStringParameter(request, "country", 100);
        String website = request.getParameter("website"); // Optional
        String description = request.getParameter("description"); // Optional

        // Sanitize inputs
        contactName = utils.SecurityUtil.sanitizeInput(contactName);
        companyName = utils.SecurityUtil.sanitizeInput(companyName);
        email = utils.SecurityUtil.sanitizeInput(email);
        phone = utils.SecurityUtil.sanitizeInput(phone);
        address = utils.SecurityUtil.sanitizeInput(address);
        city = utils.SecurityUtil.sanitizeInput(city);
        state = utils.SecurityUtil.sanitizeInput(state);
        zipCode = utils.SecurityUtil.sanitizeInput(zipCode);
        country = utils.SecurityUtil.sanitizeInput(country);
        if (website != null) {
            website = utils.SecurityUtil.sanitizeInput(website);
        }
        if (description != null) {
            description = utils.SecurityUtil.sanitizeInput(description);
        }

        // Validate email format
        String emailError = utils.ValidationUtil.validateEmail(email);
        if (emailError != null) {
            utils.ErrorAction.handleValidationError(request, response, emailError,
                    "SupplierController.updateSupplier");
            return;
        }

        // Check if email is already used by another supplier
        Supplier existingSupplier = supplierDAO.findByEmail(email);
        if (existingSupplier != null && existingSupplier.getSupplierId() != supplierId) {
            utils.ErrorAction.handleValidationError(request, response,
                    "Email already used by another supplier", "SupplierController.updateSupplier");
            return;
        }

        supplier.setContactName(contactName);
        supplier.setCompanyName(companyName);
        supplier.setEmail(email);
        supplier.setPhone(phone);
        supplier.setAddress(address);
        supplier.setCity(city);
        supplier.setState(state);
        supplier.setZipCode(zipCode);
        supplier.setCountry(country);
        supplier.setWebsite(website);
        supplier.setDescription(description);
        supplier.setUpdatedDate(new Timestamp(System.currentTimeMillis()));

        supplierDAO.update(supplier);

        // Log security event
        utils.ErrorAction.logSecurityEvent("SUPPLIER_UPDATED", request,
                "Supplier updated: " + companyName + ", ID: " + supplierId);

        HttpSession session = request.getSession();
        session.setAttribute("successMessage", "Supplier updated successfully");
        response.sendRedirect(request.getContextPath() + "/admin/supplier/view/" + supplierId);
    }

    private void deleteSupplier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        Integer supplierId = Integer.parseInt(request.getParameter("supplierId"));
        Supplier supplier = supplierDAO.findById(supplierId);

        if (supplier == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Check if supplier has associated products
        if (supplierDAO.hasAssociatedProducts(supplierId)) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage",
                    "Cannot delete supplier with associated products. Please deactivate instead.");
            response.sendRedirect(request.getContextPath() + "/admin/supplier/view/" + supplierId);
            return;
        }

        supplierDAO.delete(supplierId);

        HttpSession session = request.getSession();
        session.setAttribute("successMessage", "Supplier deleted successfully");
        response.sendRedirect(request.getContextPath() + "/admin/supplier/");
    }

    private void toggleSupplierStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        Integer supplierId = Integer.parseInt(request.getParameter("supplierId"));
        Supplier supplier = supplierDAO.findById(supplierId);

        if (supplier == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Toggle active status
        supplier.setActive(!supplier.isActive());
        supplier.setUpdatedDate(new Timestamp(System.currentTimeMillis()));
        supplierDAO.update(supplier);

        HttpSession session = request.getSession();
        String status = supplier.isActive() ? "activated" : "deactivated";
        session.setAttribute("successMessage", "Supplier " + status + " successfully");

        response.sendRedirect(request.getContextPath() + "/admin/supplier/view/" + supplierId);
    }

    private void listSuppliers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String statusFilter = request.getParameter("status");
        List<Supplier> suppliers;

        if ("active".equals(statusFilter)) {
            suppliers = supplierDAO.findActiveSuppliers();
        } else if ("inactive".equals(statusFilter)) {
            suppliers = supplierDAO.findInactiveSuppliers();
        } else {
            suppliers = supplierDAO.findAll();
        }

        request.setAttribute("suppliers", suppliers);
        request.setAttribute("statusFilter", statusFilter);
        request.getRequestDispatcher("/admin/supplier-list.jsp").forward(request, response);
    }

    private void viewSupplier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String pathInfo = request.getPathInfo();
        Integer supplierId = Integer.parseInt(pathInfo.substring(6)); // Remove "/view/"

        Supplier supplier = supplierDAO.findById(supplierId);

        if (supplier == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Get supplier statistics
        int totalProducts = supplierDAO.getProductCount(supplierId);
        int activeProducts = supplierDAO.getActiveProductCount(supplierId);

        request.setAttribute("supplier", supplier);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("activeProducts", activeProducts);
        request.getRequestDispatcher("/admin/supplier-view.jsp").forward(request, response);
    }

    private void editSupplier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String pathInfo = request.getPathInfo();
        Integer supplierId = Integer.parseInt(pathInfo.substring(6)); // Remove "/edit/"

        Supplier supplier = supplierDAO.findById(supplierId);

        if (supplier == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        request.setAttribute("supplier", supplier);
        request.setAttribute("editMode", true);
        request.getRequestDispatcher("/admin/supplier-form.jsp").forward(request, response);
    }

    private void searchSuppliers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String contactName = request.getParameter("contactName");
        String companyName = request.getParameter("companyName");
        String email = request.getParameter("email");
        String city = request.getParameter("city");
        String country = request.getParameter("country");

        List<Supplier> suppliers;

        if (contactName != null && !contactName.trim().isEmpty()) {
            suppliers = supplierDAO.findByContactName(contactName);
        } else if (companyName != null && !companyName.trim().isEmpty()) {
            suppliers = supplierDAO.findByCompanyName(companyName);
        } else if (email != null && !email.trim().isEmpty()) {
            Supplier foundSupplier = supplierDAO.findByEmail(email);
            if (foundSupplier != null) {
                suppliers = java.util.Collections.singletonList(foundSupplier);
            } else {
                suppliers = java.util.Collections.emptyList();
            }
        } else if (city != null && !city.trim().isEmpty()) {
            suppliers = supplierDAO.findByCity(city);
        } else if (country != null && !country.trim().isEmpty()) {
            suppliers = supplierDAO.findByCountry(country);
        } else {
            suppliers = supplierDAO.findAll();
        }

        request.setAttribute("suppliers", suppliers);
        request.setAttribute("searchCriteria",
                "Contact Name: " + contactName + ", Company Name: " + companyName +
                        ", Email: " + email + ", City: " + city + ", Country: " + country);
        request.getRequestDispatcher("/admin/supplier-list.jsp").forward(request, response);
    }

    private void showSupplierForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to supplier form page
        request.getRequestDispatcher("/admin/supplier-form.jsp").forward(request, response);
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response,
            String message, Exception e) throws ServletException, IOException {

        request.setAttribute("errorMessage", message);
        request.setAttribute("exception", e);
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }

    private boolean isStaff(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return false;
        }
        
        Object userObj = session.getAttribute("user");
        return (userObj instanceof model.User);
    }
}