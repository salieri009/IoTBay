package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import config.DIContainer;
import dao.ProductDAOImpl;
import dao.ReviewDAO;
import dao.interfaces.ProductDAO;
import model.Product;
import model.Review;
import model.User;
import service.ReviewService;
import utils.ValidationUtil;

@WebServlet("/review/*")
public class ReviewController extends HttpServlet {
    
    private ReviewDAO reviewDAO;
    private ProductDAO productDAO;
    private ReviewService reviewService;
    private final Gson gson = new Gson();
    
    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DIContainer.getConnection();
            reviewDAO = new ReviewDAO(connection);
            productDAO = new ProductDAOImpl(connection);
            reviewService = new ReviewService(reviewDAO, productDAO);
        } catch (Exception e) {
            throw new ServletException("Failed to initialize ReviewController", e);
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
                    listReviewsJson(request, response);
                } else {
                    listReviews(request, response);
                }
            } else if (pathInfo.startsWith("/product/")) {
                if (isJsonRequest) {
                    listProductReviewsJson(request, response);
                } else {
                    listProductReviews(request, response);
                }
            } else if (pathInfo.startsWith("/user/")) {
                if (isJsonRequest) {
                    listUserReviewsJson(request, response);
                } else {
                    listUserReviews(request, response);
                }
            } else if (pathInfo.startsWith("/view/")) {
                if (isJsonRequest) {
                    viewReviewJson(request, response);
                } else {
                    viewReview(request, response);
                }
            } else if (pathInfo.equals("/form")) {
                showReviewForm(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            if (isJsonRequest) {
                handleJsonError(response, "Error processing review request", e);
            } else {
                handleError(request, response, "Error processing review request", e);
            }
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // CSRF protection
        if (!utils.SecurityUtil.validateCSRFToken(request)) {
            String acceptHeader = request.getHeader("Accept");
            boolean isJsonRequest = acceptHeader != null && acceptHeader.contains("application/json");
            if (isJsonRequest) {
                handleJsonError(response, "CSRF token validation failed", null);
            } else {
                utils.ErrorAction.handleValidationError(request, response,
                    "CSRF token validation failed", "ReviewController.doPost");
            }
            return;
        }
        
        String pathInfo = request.getPathInfo();
        String acceptHeader = request.getHeader("Accept");
        boolean isJsonRequest = acceptHeader != null && acceptHeader.contains("application/json");
        
        try {
            if (pathInfo == null || pathInfo.equals("/create")) {
                if (isJsonRequest) {
                    createReviewJson(request, response);
                } else {
                    createReview(request, response);
                }
            } else if (pathInfo.equals("/update")) {
                if (isJsonRequest) {
                    updateReviewJson(request, response);
                } else {
                    updateReview(request, response);
                }
            } else if (pathInfo.equals("/delete")) {
                if (isJsonRequest) {
                    deleteReviewJson(request, response);
                } else {
                    deleteReview(request, response);
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            if (isJsonRequest) {
                handleJsonError(response, "Error processing review", e);
            } else {
                handleError(request, response, "Error processing review", e);
            }
        }
    }
    
    private void createReview(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
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
        
        User currentUser = (User) userObj;
        
        // Rate limiting check
        if (utils.SecurityUtil.isRateLimited(request, 5, 60000)) { // 5 requests per minute
            utils.ErrorAction.handleRateLimitError(request, response, "ReviewController.createReview");
            return;
        }

        // Input validation using SecurityUtil
        int productId = utils.SecurityUtil.getValidatedIntParameter(request, "productId", 1, Integer.MAX_VALUE);
        int rating = utils.SecurityUtil.getValidatedIntParameter(request, "rating", 1, 5);
        
        String reviewText = utils.SecurityUtil.getValidatedStringParameter(request, "reviewText", 1000);
        String title = utils.SecurityUtil.getValidatedStringParameter(request, "title", 200);
        
        // Sanitize inputs
        if (reviewText != null) {
            reviewText = utils.SecurityUtil.sanitizeInput(reviewText);
            // Validate review text length
            if (reviewText.length() > 1000) {
                utils.ErrorAction.handleValidationError(request, response,
                        "Review text must be less than 1000 characters", "ReviewController.createReview");
                return;
            }
        }
        if (title != null) {
            title = utils.SecurityUtil.sanitizeInput(title);
            // Validate title length
            if (title.length() > 100) {
                utils.ErrorAction.handleValidationError(request, response,
                        "Review title must be less than 100 characters", "ReviewController.createReview");
                return;
            }
        }
        
        // Validate rating range (already validated by getValidatedIntParameter, but double-check)
        if (rating < 1 || rating > 5) {
            utils.ErrorAction.handleValidationError(request, response,
                    "Rating must be between 1 and 5", "ReviewController.createReview");
            return;
        }
        
        // Validate review using ValidationUtil
        String validationError = ValidationUtil.validateReview(
                String.valueOf(rating), reviewText, title);
        if (validationError != null) {
            utils.ErrorAction.handleValidationError(request, response, validationError,
                    "ReviewController.createReview");
            return;
        }
        
        // Use ReviewService for business logic
        ReviewService.ReviewOperationResult result = reviewService.createReview(
            currentUser.getUserId(), productId, rating, title, reviewText);
        
        if (!result.isSuccess()) {
            utils.ErrorAction.handleValidationError(request, response, result.getErrorMessage(),
                    "ReviewController.createReview");
            return;
        }
        
        // Log security event
        utils.ErrorAction.logSecurityEvent("REVIEW_CREATED", request,
                "Review created for product: " + productId + ", Rating: " + rating);
        
        session.setAttribute("successMessage", result.getMessage());
        response.sendRedirect(request.getContextPath() + "/product/" + productId);
    }
    
    private void createReviewJson(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            JsonObject json = new JsonObject();
            json.addProperty("success", false);
            json.addProperty("error", "Not logged in");
            response.getWriter().write(gson.toJson(json));
            return;
        }
        
        Object userObj = session.getAttribute("user");
        if (!(userObj instanceof User)) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            JsonObject json = new JsonObject();
            json.addProperty("success", false);
            json.addProperty("error", "Not logged in");
            response.getWriter().write(gson.toJson(json));
            return;
        }
        
        User currentUser = (User) userObj;
        
        // Parse JSON request body or form parameters using SecurityUtil
        int productId = utils.SecurityUtil.getValidatedIntParameter(request, "productId", 1, Integer.MAX_VALUE);
        int rating = utils.SecurityUtil.getValidatedIntParameter(request, "rating", 1, 5);
        String reviewText = utils.SecurityUtil.getValidatedStringParameter(request, "reviewText", 1000);
        String title = utils.SecurityUtil.getValidatedStringParameter(request, "title", 200);
        
        if (reviewText == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            JsonObject json = new JsonObject();
            json.addProperty("success", false);
            json.addProperty("error", "Product ID, rating, and review text are required");
            response.getWriter().write(gson.toJson(json));
            return;
        }
        
        ReviewService.ReviewOperationResult result = reviewService.createReview(
            currentUser.getUserId(), productId, rating, title, reviewText);
        
        JsonObject json = new JsonObject();
        json.addProperty("success", result.isSuccess());
        
        if (result.isSuccess()) {
            json.addProperty("message", result.getMessage());
            json.add("review", gson.toJsonTree(result.getReview()));
        } else {
            json.addProperty("error", result.getErrorMessage());
        }
        
        response.getWriter().write(gson.toJson(json));
    }
    
    private void updateReview(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
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
        
        User currentUser = (User) userObj;
        
        int reviewId = utils.SecurityUtil.getValidatedIntParameter(request, "reviewId", 1, Integer.MAX_VALUE);
        String ratingStr = request.getParameter("rating");
        String reviewText = utils.SecurityUtil.getValidatedStringParameter(request, "reviewText", 1000);
        String title = utils.SecurityUtil.getValidatedStringParameter(request, "title", 200);
        
        // Sanitize inputs
        if (reviewText != null) {
            reviewText = utils.SecurityUtil.sanitizeInput(reviewText);
        }
        if (title != null) {
            title = utils.SecurityUtil.sanitizeInput(title);
        }
        
        Integer rating = null;
        if (ratingStr != null && !ratingStr.isEmpty()) {
            rating = utils.SecurityUtil.getValidatedIntParameter(request, "rating", 1, 5);
        }
        
        boolean isStaff = "staff".equalsIgnoreCase(currentUser.getRole()) || 
                         "admin".equalsIgnoreCase(currentUser.getRole());
        
        ReviewService.ReviewOperationResult result = reviewService.updateReview(
            reviewId, currentUser.getUserId(), rating, title, reviewText, isStaff);
        
        if (!result.isSuccess()) {
            request.setAttribute("error", result.getErrorMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }
        
        session.setAttribute("successMessage", result.getMessage());
        response.sendRedirect(request.getContextPath() + "/review/view/" + reviewId);
    }
    
    private void updateReviewJson(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            JsonObject json = new JsonObject();
            json.addProperty("success", false);
            json.addProperty("error", "Not logged in");
            response.getWriter().write(gson.toJson(json));
            return;
        }
        
        Object userObj = session.getAttribute("user");
        if (!(userObj instanceof User)) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            JsonObject json = new JsonObject();
            json.addProperty("success", false);
            json.addProperty("error", "Not logged in");
            response.getWriter().write(gson.toJson(json));
            return;
        }
        
        User currentUser = (User) userObj;
        
        int reviewId = utils.SecurityUtil.getValidatedIntParameter(request, "reviewId", 1, Integer.MAX_VALUE);
        String ratingStr = request.getParameter("rating");
        String reviewText = utils.SecurityUtil.getValidatedStringParameter(request, "reviewText", 1000);
        String title = utils.SecurityUtil.getValidatedStringParameter(request, "title", 200);
        
        // Sanitize inputs
        if (reviewText != null) {
            reviewText = utils.SecurityUtil.sanitizeInput(reviewText);
        }
        if (title != null) {
            title = utils.SecurityUtil.sanitizeInput(title);
        }
        
        Integer rating = null;
        if (ratingStr != null && !ratingStr.isEmpty()) {
            rating = utils.SecurityUtil.getValidatedIntParameter(request, "rating", 1, 5);
        }
        
        boolean isStaff = "staff".equalsIgnoreCase(currentUser.getRole()) || 
                         "admin".equalsIgnoreCase(currentUser.getRole());
        
        ReviewService.ReviewOperationResult result = reviewService.updateReview(
            reviewId, currentUser.getUserId(), rating, title, reviewText, isStaff);
        
        JsonObject json = new JsonObject();
        json.addProperty("success", result.isSuccess());
        
        if (result.isSuccess()) {
            json.addProperty("message", result.getMessage());
            json.add("review", gson.toJsonTree(result.getReview()));
        } else {
            json.addProperty("error", result.getErrorMessage());
        }
        
        response.getWriter().write(gson.toJson(json));
    }
    
    private void deleteReview(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
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
        
        User currentUser = (User) userObj;
        
        Integer reviewId = Integer.parseInt(request.getParameter("reviewId"));
        boolean isStaff = "staff".equalsIgnoreCase(currentUser.getRole()) || 
                         "admin".equalsIgnoreCase(currentUser.getRole());
        
        ReviewService.ReviewOperationResult result = reviewService.deleteReview(
            reviewId, currentUser.getUserId(), isStaff);
        
        if (!result.isSuccess()) {
            request.setAttribute("error", result.getErrorMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }
        
        session.setAttribute("successMessage", result.getMessage());
        
        Review review = reviewDAO.findById(reviewId);
        if (review != null) {
            Integer productId = review.getProductId();
            if (isStaff) {
                response.sendRedirect(request.getContextPath() + "/admin/reviews");
            } else {
                response.sendRedirect(request.getContextPath() + "/product/" + productId);
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/review");
        }
    }
    
    private void deleteReviewJson(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            JsonObject json = new JsonObject();
            json.addProperty("success", false);
            json.addProperty("error", "Not logged in");
            response.getWriter().write(gson.toJson(json));
            return;
        }
        
        Object userObj = session.getAttribute("user");
        if (!(userObj instanceof User)) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            JsonObject json = new JsonObject();
            json.addProperty("success", false);
            json.addProperty("error", "Not logged in");
            response.getWriter().write(gson.toJson(json));
            return;
        }
        
        User currentUser = (User) userObj;
        
        String reviewIdStr = request.getParameter("reviewId");
        if (reviewIdStr == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            JsonObject json = new JsonObject();
            json.addProperty("success", false);
            json.addProperty("error", "Review ID is required");
            response.getWriter().write(gson.toJson(json));
            return;
        }
        
        Integer reviewId = Integer.parseInt(reviewIdStr);
        boolean isStaff = "staff".equalsIgnoreCase(currentUser.getRole()) || 
                         "admin".equalsIgnoreCase(currentUser.getRole());
        
        ReviewService.ReviewOperationResult result = reviewService.deleteReview(
            reviewId, currentUser.getUserId(), isStaff);
        
        JsonObject json = new JsonObject();
        json.addProperty("success", result.isSuccess());
        
        if (result.isSuccess()) {
            json.addProperty("message", result.getMessage());
        } else {
            json.addProperty("error", result.getErrorMessage());
        }
        
        response.getWriter().write(gson.toJson(json));
    }
    
    private void listReviews(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
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
        
        User currentUser = (User) userObj;
        
        List<Review> reviews;
        
        if ("staff".equalsIgnoreCase(currentUser.getRole())) {
            // Staff can see all reviews
            reviews = reviewDAO.findAll();
        } else {
            // Customers can only see their own reviews
            reviews = reviewDAO.findByUserId(currentUser.getUserId());
        }
        
        request.setAttribute("reviews", reviews);
        request.getRequestDispatcher("/review-list.jsp").forward(request, response);
    }
    
    private void listProductReviews(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        String pathInfo = request.getPathInfo();
        Integer productId = Integer.parseInt(pathInfo.substring(9)); // Remove "/product/"
        
        Product product = productDAO.findById(productId);
        if (product == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // Get only verified reviews for public display
        List<Review> reviews = reviewDAO.findByProductIdVerified(productId);
        
        request.setAttribute("product", product);
        request.setAttribute("reviews", reviews);
        request.setAttribute("averageRating", reviewDAO.getAverageRating(productId));
        request.setAttribute("totalReviews", reviews.size());
        
        request.getRequestDispatcher("/product-reviews.jsp").forward(request, response);
    }
    
    private void listUserReviews(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        String pathInfo = request.getPathInfo();
        Integer userId = Integer.parseInt(pathInfo.substring(6)); // Remove "/user/"
        
        User user = new User();
        user.setUserId(userId);
        
        // For simplicity, assuming user object is fully populated
        List<Review> reviews = reviewDAO.findByUserId(userId);
        
        request.setAttribute("reviews", reviews);
        request.setAttribute("userId", userId);
        request.getRequestDispatcher("/user-reviews.jsp").forward(request, response);
    }
    
    private void viewReview(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        String pathInfo = request.getPathInfo();
        Integer reviewId = Integer.parseInt(pathInfo.substring(6)); // Remove "/view/"
        
        Review review = reviewDAO.findById(reviewId);
        
        if (review == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // Verify access
        HttpSession session = request.getSession();
        Object userObj = session.getAttribute("user");
        if (!(userObj instanceof User)) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        User currentUser = (User) userObj;
        
        if (review.getUserId() != currentUser.getUserId() && 
            !"staff".equalsIgnoreCase(currentUser.getRole())) {
            utils.ErrorAction.handleAuthorizationError(request, response, "ReviewController.viewReview");
            return;
        }
        
        Product product = productDAO.findById(review.getProductId());
        
        request.setAttribute("review", review);
        request.setAttribute("product", product);
        request.getRequestDispatcher("/review-view.jsp").forward(request, response);
    }
    
    private void showReviewForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        String productIdStr = request.getParameter("productId");
        
        if (productIdStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        Integer productId = Integer.parseInt(productIdStr);
        Product product = productDAO.findById(productId);
        
        if (product == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        request.setAttribute("product", product);
        request.getRequestDispatcher("/review-form.jsp").forward(request, response);
    }
    
    // JSON API methods
    private void listReviewsJson(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            JsonObject json = new JsonObject();
            json.addProperty("success", false);
            json.addProperty("error", "Not logged in");
            response.getWriter().write(gson.toJson(json));
            return;
        }
        
        Object userObj = session.getAttribute("user");
        if (!(userObj instanceof User)) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            JsonObject json = new JsonObject();
            json.addProperty("success", false);
            json.addProperty("error", "Not logged in");
            response.getWriter().write(gson.toJson(json));
            return;
        }
        
        User currentUser = (User) userObj;
        
        List<Review> reviews;
        if ("staff".equalsIgnoreCase(currentUser.getRole()) || 
            "admin".equalsIgnoreCase(currentUser.getRole())) {
            reviews = reviewDAO.findAll();
        } else {
            reviews = reviewDAO.findByUserId(currentUser.getUserId());
        }
        
        JsonObject json = new JsonObject();
        json.addProperty("success", true);
        json.add("reviews", gson.toJsonTree(reviews));
        json.addProperty("count", reviews.size());
        
        response.getWriter().write(gson.toJson(json));
    }
    
    private void listProductReviewsJson(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String pathInfo = request.getPathInfo();
        Integer productId = Integer.parseInt(pathInfo.substring(9)); // Remove "/product/"
        
        Product product = productDAO.findById(productId);
        if (product == null) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            JsonObject json = new JsonObject();
            json.addProperty("success", false);
            json.addProperty("error", "Product not found");
            response.getWriter().write(gson.toJson(json));
            return;
        }
        
        ReviewService.ProductReviewStatistics stats = reviewService.getProductReviewStatistics(productId, true);
        
        JsonObject json = new JsonObject();
        json.addProperty("success", true);
        json.add("product", gson.toJsonTree(product));
        json.add("reviews", gson.toJsonTree(stats.getReviews()));
        json.addProperty("averageRating", stats.getAverageRating());
        json.addProperty("totalReviews", stats.getTotalReviews());
        json.add("ratingDistribution", gson.toJsonTree(stats.getRatingDistribution()));
        
        response.getWriter().write(gson.toJson(json));
    }
    
    private void listUserReviewsJson(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String pathInfo = request.getPathInfo();
        Integer userId = Integer.parseInt(pathInfo.substring(6)); // Remove "/user/"
        
        List<Review> reviews = reviewDAO.findByUserId(userId);
        
        JsonObject json = new JsonObject();
        json.addProperty("success", true);
        json.add("reviews", gson.toJsonTree(reviews));
        json.addProperty("count", reviews.size());
        json.addProperty("userId", userId);
        
        response.getWriter().write(gson.toJson(json));
    }
    
    private void viewReviewJson(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String pathInfo = request.getPathInfo();
        Integer reviewId = Integer.parseInt(pathInfo.substring(6)); // Remove "/view/"
        
        Review review = reviewDAO.findById(reviewId);
        if (review == null) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            JsonObject json = new JsonObject();
            json.addProperty("success", false);
            json.addProperty("error", "Review not found");
            response.getWriter().write(gson.toJson(json));
            return;
        }
        
        HttpSession session = request.getSession();
        Object userObj = session.getAttribute("user");
        if (!(userObj instanceof User)) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        User currentUser = (User) userObj;
        
        if (review.getUserId() != currentUser.getUserId() && 
            !"staff".equalsIgnoreCase(currentUser.getRole())) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            JsonObject json = new JsonObject();
            json.addProperty("success", false);
            json.addProperty("error", "Access denied");
            response.getWriter().write(gson.toJson(json));
            // Note: For JSON responses, we keep the direct response but log it
            return;
        }
        
        Product product = productDAO.findById(review.getProductId());
        
        JsonObject json = new JsonObject();
        json.addProperty("success", true);
        json.add("review", gson.toJsonTree(review));
        json.add("product", gson.toJsonTree(product));
        
        response.getWriter().write(gson.toJson(json));
    }
    
    private void handleJsonError(HttpServletResponse response, String message, Exception e) 
            throws IOException {
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