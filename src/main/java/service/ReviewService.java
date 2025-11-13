package service;

import dao.ReviewDAO;
import dao.interfaces.ProductDAO;
import model.Review;
import model.Product;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.stream.Collectors;

/**
 * Review Service
 * Business logic for product reviews and ratings
 * 
 * Based on FEATURES.md Section 4: Product Reviews & Ratings
 * - Review submission with validation
 * - Duplicate review prevention
 * - Moderation queue management
 * - Average rating calculation
 * - Review statistics
 */
public class ReviewService {
    private final ReviewDAO reviewDAO;
    private final ProductDAO productDAO;
    
    public ReviewService(ReviewDAO reviewDAO, ProductDAO productDAO) {
        this.reviewDAO = reviewDAO;
        this.productDAO = productDAO;
    }
    
    /**
     * Create a new review with validation
     * 
     * @param userId User ID
     * @param productId Product ID
     * @param rating Rating (1-5)
     * @param title Review title
     * @param reviewText Review text
     * @return ReviewOperationResult with success status and messages
     */
    public ReviewOperationResult createReview(int userId, int productId, int rating, 
                                             String title, String reviewText) throws SQLException {
        ReviewOperationResult result = new ReviewOperationResult();
        
        // 1. Validate product exists
        Product product = productDAO.findById(productId);
        if (product == null) {
            result.setSuccess(false);
            result.setErrorMessage("Product not found");
            return result;
        }
        
        // 2. Validate rating range
        if (rating < 1 || rating > 5) {
            result.setSuccess(false);
            result.setErrorMessage("Rating must be between 1 and 5");
            return result;
        }
        
        // 3. Validate review text length
        if (reviewText == null || reviewText.trim().isEmpty()) {
            result.setSuccess(false);
            result.setErrorMessage("Review text is required");
            return result;
        }
        
        if (reviewText.length() < 50) {
            result.setSuccess(false);
            result.setErrorMessage("Review text must be at least 50 characters");
            return result;
        }
        
        if (reviewText.length() > 2000) {
            result.setSuccess(false);
            result.setErrorMessage("Review text must not exceed 2000 characters");
            return result;
        }
        
        // 4. Check for duplicate review
        if (reviewDAO.hasUserReviewedProduct(userId, productId)) {
            result.setSuccess(false);
            result.setErrorMessage("You have already reviewed this product");
            return result;
        }
        
        // 5. Create review
        Review review = new Review();
        review.setUserId(userId);
        review.setProductId(productId);
        review.setRating(rating);
        review.setTitle(title != null ? title.trim() : "");
        review.setComment(reviewText.trim());
        review.setReviewedAt(LocalDateTime.now());
        review.setVerified(false); // Reviews need staff verification
        
        int reviewId = reviewDAO.createReview(review);
        review.setId(reviewId);
        
        result.setSuccess(true);
        result.setReview(review);
        result.setMessage("Review submitted successfully. It will be visible after moderation.");
        
        return result;
    }
    
    /**
     * Update an existing review
     * 
     * @param reviewId Review ID
     * @param userId User ID (for authorization)
     * @param rating Updated rating
     * @param title Updated title
     * @param reviewText Updated review text
     * @param isStaff Whether the user is staff/admin
     * @return ReviewOperationResult
     */
    public ReviewOperationResult updateReview(int reviewId, int userId, Integer rating, 
                                             String title, String reviewText, boolean isStaff) throws SQLException {
        ReviewOperationResult result = new ReviewOperationResult();
        
        // 1. Get existing review
        Review review = reviewDAO.getReviewById(reviewId);
        if (review == null) {
            result.setSuccess(false);
            result.setErrorMessage("Review not found");
            return result;
        }
        
        // 2. Verify ownership or staff privileges
        if (review.getUserId() != userId && !isStaff) {
            result.setSuccess(false);
            result.setErrorMessage("You do not have permission to update this review");
            return result;
        }
        
        // 3. Update fields
        if (rating != null && rating >= 1 && rating <= 5) {
            review.setRating(rating);
        }
        
        if (title != null && !title.trim().isEmpty()) {
            review.setTitle(title.trim());
        }
        
        if (reviewText != null && !reviewText.trim().isEmpty()) {
            if (reviewText.length() < 50) {
                result.setSuccess(false);
                result.setErrorMessage("Review text must be at least 50 characters");
                return result;
            }
            if (reviewText.length() > 2000) {
                result.setSuccess(false);
                result.setErrorMessage("Review text must not exceed 2000 characters");
                return result;
            }
            review.setComment(reviewText.trim());
        }
        
        review.setUpdatedAt(LocalDateTime.now());
        
        // 4. If customer updated, reset verification status
        if (!isStaff) {
            review.setVerified(false);
        }
        
        reviewDAO.updateReview(review);
        
        result.setSuccess(true);
        result.setReview(review);
        result.setMessage("Review updated successfully");
        
        return result;
    }
    
    /**
     * Delete a review
     * 
     * @param reviewId Review ID
     * @param userId User ID (for authorization)
     * @param isStaff Whether the user is staff/admin
     * @return ReviewOperationResult
     */
    public ReviewOperationResult deleteReview(int reviewId, int userId, boolean isStaff) throws SQLException {
        ReviewOperationResult result = new ReviewOperationResult();
        
        Review review = reviewDAO.getReviewById(reviewId);
        if (review == null) {
            result.setSuccess(false);
            result.setErrorMessage("Review not found");
            return result;
        }
        
        // Verify ownership or staff privileges
        if (review.getUserId() != userId && !isStaff) {
            result.setSuccess(false);
            result.setErrorMessage("You do not have permission to delete this review");
            return result;
        }
        
        reviewDAO.deleteReview(reviewId);
        
        result.setSuccess(true);
        result.setMessage("Review deleted successfully");
        
        return result;
    }
    
    /**
     * Get product reviews with statistics
     * 
     * @param productId Product ID
     * @param verifiedOnly Whether to return only verified reviews
     * @return ProductReviewStatistics
     */
    public ProductReviewStatistics getProductReviewStatistics(int productId, boolean verifiedOnly) throws SQLException {
        ProductReviewStatistics stats = new ProductReviewStatistics();
        
        List<Review> reviews;
        if (verifiedOnly) {
            reviews = reviewDAO.getReviewsByProductId(productId).stream()
                .filter(Review::isVerified)
                .collect(Collectors.toList());
        } else {
            reviews = reviewDAO.getReviewsByProductId(productId);
        }
        
        stats.setTotalReviews(reviews.size());
        stats.setAverageRating(reviewDAO.getAverageRatingByProductId(productId));
        
        // Calculate rating distribution
        Map<Integer, Integer> ratingDistribution = new HashMap<>();
        for (int i = 1; i <= 5; i++) {
            ratingDistribution.put(i, 0);
        }
        
        for (Review review : reviews) {
            int rating = review.getRating();
            ratingDistribution.put(rating, ratingDistribution.get(rating) + 1);
        }
        
        stats.setRatingDistribution(ratingDistribution);
        stats.setReviews(reviews);
        
        return stats;
    }
    
    /**
     * Verify a review (staff/admin only)
     * 
     * @param reviewId Review ID
     * @return ReviewOperationResult
     */
    public ReviewOperationResult verifyReview(int reviewId) throws SQLException {
        ReviewOperationResult result = new ReviewOperationResult();
        
        Review review = reviewDAO.getReviewById(reviewId);
        if (review == null) {
            result.setSuccess(false);
            result.setErrorMessage("Review not found");
            return result;
        }
        
        review.setVerified(true);
        review.setUpdatedAt(LocalDateTime.now());
        reviewDAO.updateReview(review);
        
        result.setSuccess(true);
        result.setReview(review);
        result.setMessage("Review verified successfully");
        
        return result;
    }
    
    /**
     * Get reviews pending moderation
     * 
     * @return List of unverified reviews
     */
    public List<Review> getPendingModerationReviews() throws SQLException {
        return reviewDAO.getAllReviews().stream()
            .filter(review -> !review.isVerified())
            .collect(Collectors.toList());
    }
    
    /**
     * Inner class for review operation results
     */
    public static class ReviewOperationResult {
        private boolean success;
        private String message;
        private String errorMessage;
        private Review review;
        
        public boolean isSuccess() {
            return success;
        }
        
        public void setSuccess(boolean success) {
            this.success = success;
        }
        
        public String getMessage() {
            return message;
        }
        
        public void setMessage(String message) {
            this.message = message;
        }
        
        public String getErrorMessage() {
            return errorMessage;
        }
        
        public void setErrorMessage(String errorMessage) {
            this.errorMessage = errorMessage;
        }
        
        public Review getReview() {
            return review;
        }
        
        public void setReview(Review review) {
            this.review = review;
        }
    }
    
    /**
     * Inner class for product review statistics
     */
    public static class ProductReviewStatistics {
        private int totalReviews;
        private double averageRating;
        private Map<Integer, Integer> ratingDistribution;
        private List<Review> reviews;
        
        public int getTotalReviews() {
            return totalReviews;
        }
        
        public void setTotalReviews(int totalReviews) {
            this.totalReviews = totalReviews;
        }
        
        public double getAverageRating() {
            return averageRating;
        }
        
        public void setAverageRating(double averageRating) {
            this.averageRating = averageRating;
        }
        
        public Map<Integer, Integer> getRatingDistribution() {
            return ratingDistribution;
        }
        
        public void setRatingDistribution(Map<Integer, Integer> ratingDistribution) {
            this.ratingDistribution = ratingDistribution;
        }
        
        public List<Review> getReviews() {
            return reviews;
        }
        
        public void setReviews(List<Review> reviews) {
            this.reviews = reviews;
        }
    }
}

