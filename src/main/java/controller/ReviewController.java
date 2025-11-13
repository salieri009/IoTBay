package controller;

import dao.ReviewDAO;
import dao.ProductDAOImpl;
import dao.interfaces.ProductDAO;
import db.DBConnection;
import model.Review;
import model.Product;
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
import java.util.List;

@WebServlet("/review/*")
public class ReviewController extends HttpServlet {
    
    private ReviewDAO reviewDAO;
    private ProductDAO productDAO;
    
    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DBConnection.getConnection();
            reviewDAO = new ReviewDAO(connection);
            productDAO = new ProductDAOImpl(connection);
        } catch (Exception e) {
            throw new ServletException("Failed to initialize ReviewController", e);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                listReviews(request, response);
            } else if (pathInfo.startsWith("/product/")) {
                listProductReviews(request, response);
            } else if (pathInfo.startsWith("/user/")) {
                listUserReviews(request, response);
            } else if (pathInfo.startsWith("/view/")) {
                viewReview(request, response);
            } else if (pathInfo.equals("/form")) {
                showReviewForm(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            handleError(request, response, "Error processing review request", e);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo == null || pathInfo.equals("/create")) {
                createReview(request, response);
            } else if (pathInfo.equals("/update")) {
                updateReview(request, response);
            } else if (pathInfo.equals("/delete")) {
                deleteReview(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            handleError(request, response, "Error processing review", e);
        }
    }
    
    private void createReview(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        // Input validation
        String productIdStr = request.getParameter("productId");
        String ratingStr = request.getParameter("rating");
        String reviewText = InputValidator.validateAndSanitize(
            request.getParameter("reviewText"), "Review text");
        String title = InputValidator.validateAndSanitize(
            request.getParameter("title"), "Review title");
        
        if (productIdStr == null || ratingStr == null) {
            request.setAttribute("error", "Product ID and rating are required");
            request.getRequestDispatcher("/review-form.jsp").forward(request, response);
            return;
        }
        
        Integer productId = Integer.parseInt(productIdStr);
        Integer rating = Integer.parseInt(ratingStr);
        
        // Validate rating range
        if (rating < 1 || rating > 5) {
            request.setAttribute("error", "Rating must be between 1 and 5");
            request.getRequestDispatcher("/review-form.jsp").forward(request, response);
            return;
        }
        
        // Check if product exists
        Product product = productDAO.findById(productId);
        if (product == null) {
            request.setAttribute("error", "Product not found");
            request.getRequestDispatcher("/review-form.jsp").forward(request, response);
            return;
        }
        
        // Check if user has already reviewed this product
        if (reviewDAO.hasUserReviewedProduct(currentUser.getUserId(), productId)) {
            request.setAttribute("error", "You have already reviewed this product");
            request.setAttribute("product", product);
            request.getRequestDispatcher("/review-form.jsp").forward(request, response);
            return;
        }
        
        // Create review
        Review review = new Review();
        review.setUserId(currentUser.getUserId());
        review.setProductId(productId);
        review.setRating(rating);
        review.setReviewText(reviewText);
        review.setTitle(title);
        review.setReviewDate(new Timestamp(System.currentTimeMillis()));
        review.setVerified(false); // Reviews need staff verification
        
        reviewDAO.create(review);
        
        session.setAttribute("successMessage", "Review submitted successfully. It will be visible after moderation.");
        response.sendRedirect(request.getContextPath() + "/product/" + productId);
    }
    
    private void updateReview(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        Integer reviewId = Integer.parseInt(request.getParameter("reviewId"));
        Review review = reviewDAO.findById(reviewId);
        
        if (review == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // Verify ownership
        if (review.getUserId() != currentUser.getUserId() && 
            !"staff".equalsIgnoreCase(currentUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        // Update review
        String ratingStr = request.getParameter("rating");
        String reviewText = InputValidator.validateAndSanitize(
            request.getParameter("reviewText"), "Review text");
        String title = InputValidator.validateAndSanitize(
            request.getParameter("title"), "Review title");
        
        if (ratingStr != null) {
            Integer rating = Integer.parseInt(ratingStr);
            if (rating >= 1 && rating <= 5) {
                review.setRating(rating);
            }
        }
        
        review.setReviewText(reviewText);
        review.setTitle(title);
        review.setUpdatedDate(new Timestamp(System.currentTimeMillis()));
        
        // If customer updated, reset verification status
        if (!"staff".equalsIgnoreCase(currentUser.getRole())) {
            review.setVerified(false);
        }
        
        reviewDAO.update(review);
        
        session.setAttribute("successMessage", "Review updated successfully");
        response.sendRedirect(request.getContextPath() + "/review/view/" + reviewId);
    }
    
    private void deleteReview(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        Integer reviewId = Integer.parseInt(request.getParameter("reviewId"));
        Review review = reviewDAO.findById(reviewId);
        
        if (review == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // Verify ownership or staff privileges
        if (review.getUserId() != currentUser.getUserId() && 
            !"staff".equalsIgnoreCase(currentUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        Integer productId = review.getProductId();
        reviewDAO.delete(reviewId);
        
        session.setAttribute("successMessage", "Review deleted successfully");
        
        if ("staff".equalsIgnoreCase(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin/reviews");
        } else {
            response.sendRedirect(request.getContextPath() + "/product/" + productId);
        }
    }
    
    private void listReviews(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
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
        User currentUser = (User) session.getAttribute("user");
        
        if (review.getUserId() != currentUser.getUserId() && 
            !"staff".equalsIgnoreCase(currentUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
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
    
    private void handleError(HttpServletRequest request, HttpServletResponse response, 
                           String message, Exception e) throws ServletException, IOException {
        request.setAttribute("error", message + ": " + e.getMessage());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
}