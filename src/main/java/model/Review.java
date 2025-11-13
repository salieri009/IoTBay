package model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Review implements Serializable{
    private int id;
    private int userId;
    private int productId;
    private int rating;
    private String comment;
    private String title;
    private LocalDateTime reviewedAt;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // Default constructor
    public Review() {
        this.reviewedAt = LocalDateTime.now();
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    // Constructor with all fields
    public Review(int id, int userId, int productId, int rating, String comment, LocalDateTime reviewedAt) {
        this.id = id;
        this.userId = userId;
        this.productId = productId;
        this.rating = rating;
        this.comment = comment;
        this.reviewedAt = reviewedAt;
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    // Constructor with title
    public Review(int id, int userId, int productId, int rating, String comment, String title, LocalDateTime reviewedAt) {
        this.id = id;
        this.userId = userId;
        this.productId = productId;
        this.rating = rating;
        this.comment = comment;
        this.title = title;
        this.reviewedAt = reviewedAt;
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
        this.updatedAt = LocalDateTime.now();
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
        this.updatedAt = LocalDateTime.now();
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
        this.updatedAt = LocalDateTime.now();
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
        this.updatedAt = LocalDateTime.now();
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
        this.updatedAt = LocalDateTime.now();
    }

    public LocalDateTime getReviewedAt() {
        return reviewedAt;
    }

    public void setReviewedAt(LocalDateTime reviewedAt) {
        this.reviewedAt = reviewedAt;
        this.updatedAt = LocalDateTime.now();
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public boolean isPositive() {
        return rating >= 4;
    }

    // Additional compatibility methods
    public void setReviewText(String reviewText) {
        setComment(reviewText);
    }

    public String getReviewText() {
        return getComment();
    }

    public void setUpdatedDate(java.sql.Timestamp updatedDate) {
        if (updatedDate != null) {
            setUpdatedAt(updatedDate.toLocalDateTime());
        }
    }

    public void setVerified(boolean verified) {
        // For compatibility - could add a verified field in future
        // For now, store in title or comment
        if (verified) {
            String currentTitle = getTitle() != null ? getTitle() : "";
            setTitle(currentTitle + " [VERIFIED]");
        }
    }

    public boolean isVerified() {
        String title = getTitle();
        return title != null && title.contains("[VERIFIED]");
    }

    public void setReviewDate(java.sql.Timestamp reviewDate) {
        if (reviewDate != null) {
            setReviewedAt(reviewDate.toLocalDateTime());
        }
    }

    @Override
    public String toString() {
        return "Review{" +
                "id=" + id +
                ", userId=" + userId +
                ", productId=" + productId +
                ", rating=" + rating +
                ", comment='" + comment + '\'' +
                ", title='" + title + '\'' +
                ", reviewedAt=" + reviewedAt +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}
