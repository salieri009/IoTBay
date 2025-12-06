package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import model.Review;
import config.DIContainer;

public class ReviewDAO {

    public ReviewDAO() {
        // No-args constructor
    }

    // Create
    public int createReview(Review review) throws SQLException {
        String query = "INSERT INTO reviews (user_id, product_id, rating, comment, title, reviewed_at, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            statement.setInt(1, review.getUserId());
            statement.setInt(2, review.getProductId());
            statement.setInt(3, review.getRating());
            statement.setString(4, review.getComment());
            statement.setString(5, review.getTitle());
            statement.setObject(6, review.getReviewedAt());
            statement.setObject(7, LocalDateTime.now());
            statement.setObject(8, LocalDateTime.now());

            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
            throw new SQLException("Creating review failed, no ID obtained.");
        }
    }

    // Read
    public Review getReviewById(int id) throws SQLException {
        String query = "SELECT * FROM reviews WHERE id = ?";
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, id);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    Review review = new Review();
                    review.setId(rs.getInt("id"));
                    review.setUserId(rs.getInt("user_id"));
                    review.setProductId(rs.getInt("product_id"));
                    review.setRating(rs.getInt("rating"));
                    review.setComment(rs.getString("comment"));
                    review.setTitle(rs.getString("title"));
                    review.setReviewedAt(rs.getObject("reviewed_at", LocalDateTime.class));
                    review.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                    review.setUpdatedAt(rs.getObject("updated_at", LocalDateTime.class));
                    return review;
                }
            }
        }
        return null;
    }

    public List<Review> getReviewsByProductId(int productId) throws SQLException {
        String query = "SELECT * FROM reviews WHERE product_id = ? ORDER BY reviewed_at DESC";
        List<Review> reviews = new ArrayList<>();
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, productId);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    Review review = new Review();
                    review.setId(rs.getInt("id"));
                    review.setUserId(rs.getInt("user_id"));
                    review.setProductId(rs.getInt("product_id"));
                    review.setRating(rs.getInt("rating"));
                    review.setComment(rs.getString("comment"));
                    review.setTitle(rs.getString("title"));
                    review.setReviewedAt(rs.getObject("reviewed_at", LocalDateTime.class));
                    review.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                    review.setUpdatedAt(rs.getObject("updated_at", LocalDateTime.class));
                    reviews.add(review);
                }
            }
        }
        return reviews;
    }

    public List<Review> getReviewsByUserId(int userId) throws SQLException {
        String query = "SELECT * FROM reviews WHERE user_id = ? ORDER BY reviewed_at DESC";
        List<Review> reviews = new ArrayList<>();
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    Review review = new Review();
                    review.setId(rs.getInt("id"));
                    review.setUserId(rs.getInt("user_id"));
                    review.setProductId(rs.getInt("product_id"));
                    review.setRating(rs.getInt("rating"));
                    review.setComment(rs.getString("comment"));
                    review.setTitle(rs.getString("title"));
                    review.setReviewedAt(rs.getObject("reviewed_at", LocalDateTime.class));
                    review.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                    review.setUpdatedAt(rs.getObject("updated_at", LocalDateTime.class));
                    reviews.add(review);
                }
            }
        }
        return reviews;
    }

    public List<Review> getAllReviews() throws SQLException {
        String query = "SELECT * FROM reviews ORDER BY reviewed_at DESC";
        List<Review> reviews = new ArrayList<>();
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query);
                ResultSet rs = statement.executeQuery()) {
            while (rs.next()) {
                Review review = new Review();
                review.setId(rs.getInt("id"));
                review.setUserId(rs.getInt("user_id"));
                review.setProductId(rs.getInt("product_id"));
                review.setRating(rs.getInt("rating"));
                review.setComment(rs.getString("comment"));
                review.setTitle(rs.getString("title"));
                review.setReviewedAt(rs.getObject("reviewed_at", LocalDateTime.class));
                review.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                review.setUpdatedAt(rs.getObject("updated_at", LocalDateTime.class));
                reviews.add(review);
            }
        }
        return reviews;
    }

    // Update
    public void updateReview(Review review) throws SQLException {
        String query = "UPDATE reviews SET rating = ?, comment = ?, title = ?, reviewed_at = ?, updated_at = ? WHERE id = ?";
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, review.getRating());
            statement.setString(2, review.getComment());
            statement.setString(3, review.getTitle());
            statement.setObject(4, review.getReviewedAt());
            statement.setObject(5, LocalDateTime.now());
            statement.setInt(6, review.getId());
            statement.executeUpdate();
        }
    }

    // Delete
    public void deleteReview(int id) throws SQLException {
        String query = "DELETE FROM reviews WHERE id = ?";
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, id);
            statement.executeUpdate();
        }
    }

    // Additional methods
    public double getAverageRatingByProductId(int productId) throws SQLException {
        String query = "SELECT AVG(rating::numeric) as avg_rating FROM reviews WHERE product_id = ?";
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, productId);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("avg_rating");
                }
            }
        }
        return 0.0;
    }

    public int getReviewCountByProductId(int productId) throws SQLException {
        String query = "SELECT COUNT(*) as review_count FROM reviews WHERE product_id = ?";
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, productId);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("review_count");
                }
            }
        }
        return 0;
    }

    public List<Review> getReviewsByRating(int rating) throws SQLException {
        String query = "SELECT * FROM reviews WHERE rating = ? ORDER BY reviewed_at DESC";
        List<Review> reviews = new ArrayList<>();
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, rating);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    Review review = new Review();
                    review.setId(rs.getInt("id"));
                    review.setUserId(rs.getInt("user_id"));
                    review.setProductId(rs.getInt("product_id"));
                    review.setRating(rs.getInt("rating"));
                    review.setComment(rs.getString("comment"));
                    review.setTitle(rs.getString("title"));
                    review.setReviewedAt(rs.getObject("reviewed_at", LocalDateTime.class));
                    review.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                    review.setUpdatedAt(rs.getObject("updated_at", LocalDateTime.class));
                    reviews.add(review);
                }
            }
        }
        return reviews;
    }

    public boolean hasUserReviewedProduct(int userId, int productId) throws SQLException {
        String query = "SELECT COUNT(*) as review_count FROM reviews WHERE user_id = ? AND product_id = ?";
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);
            statement.setInt(2, productId);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("review_count") > 0;
                }
            }
        }
        return false;
    }

    public List<Review> searchReviews(String searchTerm) throws SQLException {
        String query = "SELECT * FROM reviews WHERE comment ILIKE ? OR title ILIKE ? ORDER BY reviewed_at DESC";
        List<Review> reviews = new ArrayList<>();
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            String searchPattern = "%" + searchTerm + "%";
            statement.setString(1, searchPattern);
            statement.setString(2, searchPattern);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    Review review = new Review();
                    review.setId(rs.getInt("id"));
                    review.setUserId(rs.getInt("user_id"));
                    review.setProductId(rs.getInt("product_id"));
                    review.setRating(rs.getInt("rating"));
                    review.setComment(rs.getString("comment"));
                    review.setTitle(rs.getString("title"));
                    review.setReviewedAt(rs.getObject("reviewed_at", LocalDateTime.class));
                    review.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                    review.setUpdatedAt(rs.getObject("updated_at", LocalDateTime.class));
                    reviews.add(review);
                }
            }
        }
        return reviews;
    }

    // Additional methods for controller compatibility
    public void create(Review review) throws SQLException {
        createReview(review);
    }

    public Review findById(Integer id) throws SQLException {
        return getReviewById(id);
    }

    public void update(Review review) throws SQLException {
        updateReview(review);
    }

    public void delete(Integer id) throws SQLException {
        deleteReview(id);
    }

    public List<Review> findAll() throws SQLException {
        return getAllReviews();
    }

    public List<Review> findByUserId(int userId) throws SQLException {
        return getReviewsByUserId(userId);
    }

    public List<Review> findByUserId(Integer userId) throws SQLException {
        return getReviewsByUserId(userId);
    }

    public List<Review> findByProductIdVerified(Integer productId) throws SQLException {
        return getReviewsByProductId(productId); // Assume all are verified for now
    }

    public double getAverageRating(Integer productId) throws SQLException {
        String query = "SELECT AVG(rating) FROM reviews WHERE product_id = ?";
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, productId);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble(1);
                }
            }
        }
        return 0.0;
    }
}
