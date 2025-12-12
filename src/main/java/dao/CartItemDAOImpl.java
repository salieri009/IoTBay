package dao;

import dao.interfaces.CartItemDAO;
import model.CartItem;
import config.DIContainer;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.time.LocalDateTime;

public class CartItemDAOImpl implements CartItemDAO {

    public CartItemDAOImpl() {
        // No-args constructor
    }

    @Override
    public void createCartItem(CartItem cartItem) throws SQLException {
        String query = "INSERT INTO cart_items (user_id, product_id, quantity, price, added_at, updated_at) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, cartItem.getUserId());
            pstmt.setInt(2, cartItem.getProductId());
            pstmt.setInt(3, cartItem.getQuantity());
            pstmt.setBigDecimal(4, cartItem.getPrice());
            pstmt.setTimestamp(5, Timestamp.valueOf(cartItem.getAddedAt()));
            pstmt.setTimestamp(6, Timestamp.valueOf(cartItem.getUpdatedAt()));
            pstmt.executeUpdate();
        }
    }

    @Override
    public CartItem getCartItemById(int id) throws SQLException {
        String query = "SELECT * FROM cart_items WHERE id = ?";
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return createCartItemFromResultSet(rs);
                }
            }
        }
        return null;
    }

    @Override
    public List<CartItem> getCartItemsByUserId(int userId) throws SQLException {
        String query = "SELECT * FROM cart_items WHERE user_id = ?";
        List<CartItem> cartItems = new ArrayList<>();
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    cartItems.add(createCartItemFromResultSet(rs));
                }
            }
        }
        return cartItems;
    }

    @Override
    public void updateCartItem(int id, CartItem cartItem) throws SQLException {
        String query = "UPDATE cart_items SET quantity = ?, price = ?, updated_at = ? WHERE id = ?";
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, cartItem.getQuantity());
            pstmt.setBigDecimal(2, cartItem.getPrice());
            pstmt.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now()));
            pstmt.setInt(4, id);
            pstmt.executeUpdate();
        }
    }

    @Override
    public void deleteCartItem(int id) throws SQLException {
        String query = "DELETE FROM cart_items WHERE id = ?";
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        }
    }

    @Override
    public void deleteCartItemsByUserId(int userId) throws SQLException {
        String query = "DELETE FROM cart_items WHERE user_id = ?";
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            pstmt.executeUpdate();
        }
    }

    @Override
    public List<CartItem> getAllCartItems() throws SQLException {
        String query = "SELECT * FROM cart_items";
        List<CartItem> cartItems = new ArrayList<>();
        try (Connection connection = DIContainer.getConnection();
                PreparedStatement pstmt = connection.prepareStatement(query)) {
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    cartItems.add(createCartItemFromResultSet(rs));
                }
            }
        }
        return cartItems;
    }

    private CartItem createCartItemFromResultSet(ResultSet rs) throws SQLException {
        CartItem cartItem = new CartItem();
        cartItem.setId(rs.getInt("id"));
        cartItem.setUserId(rs.getInt("user_id"));
        cartItem.setProductId(rs.getInt("product_id"));
        cartItem.setQuantity(rs.getInt("quantity"));
        cartItem.setPrice(rs.getBigDecimal("price"));
        java.sql.Timestamp addedAt = rs.getTimestamp("added_at");
        cartItem.setAddedAt(addedAt != null ? addedAt.toLocalDateTime() : null);
        java.sql.Timestamp updatedAt = rs.getTimestamp("updated_at");
        cartItem.setUpdatedAt(updatedAt != null ? updatedAt.toLocalDateTime() : null);
        return cartItem;
    }
}
