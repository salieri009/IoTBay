package dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import model.CartItem;

public class CartItemDAO {
    private final Connection connection;

    public CartItemDAO(Connection connection) {
        this.connection = connection;
    }

    // CREATE: Add item to cart
    public int addCartItem(CartItem cartItem) throws SQLException {
        // Check if item already exists in cart
        CartItem existing = getCartItem(cartItem.getUserId(), cartItem.getProductId());
        if (existing != null) {
            // Update quantity if item already exists
            updateCartItemQuantity(cartItem.getUserId(), cartItem.getProductId(), 
                existing.getQuantity() + cartItem.getQuantity());
            return existing.getId();
        }
        
        String query = "INSERT INTO cart_items (user_id, product_id, quantity, price, added_at, updated_at) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            statement.setInt(1, cartItem.getUserId());
            statement.setInt(2, cartItem.getProductId());
            statement.setInt(3, cartItem.getQuantity());
            statement.setBigDecimal(4, cartItem.getPrice());
            statement.setObject(5, cartItem.getAddedAt());
            statement.setObject(6, LocalDateTime.now());
            
            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
            throw new SQLException("Creating cart item failed, no ID obtained.");
        }
    }

    // READ: Get all items in a user's cart
    public List<CartItem> getCartItemsByUserId(int userId) throws SQLException {
        String query = "SELECT id, user_id, product_id, quantity, price, added_at, updated_at FROM cart_items WHERE user_id = ? ORDER BY added_at DESC";
        List<CartItem> cartItems = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem();
                    item.setId(rs.getInt("id"));
                    item.setUserId(rs.getInt("user_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setPrice(rs.getBigDecimal("price"));
                    item.setAddedAt(rs.getObject("added_at", LocalDateTime.class));
                    item.setUpdatedAt(rs.getObject("updated_at", LocalDateTime.class));
                    cartItems.add(item);
                }
            }
        }
        return cartItems;
    }

    // READ: Get specific item in user's cart
    public CartItem getCartItem(int userId, int productId) throws SQLException {
        String query = "SELECT id, user_id, product_id, quantity, price, added_at, updated_at FROM cart_items WHERE user_id = ? AND product_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);
            statement.setInt(2, productId);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    CartItem item = new CartItem();
                    item.setId(rs.getInt("id"));
                    item.setUserId(rs.getInt("user_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setPrice(rs.getBigDecimal("price"));
                    item.setAddedAt(rs.getObject("added_at", LocalDateTime.class));
                    item.setUpdatedAt(rs.getObject("updated_at", LocalDateTime.class));
                    return item;
                }
            }
        }
        return null;
    }

    // READ: Get cart item by ID
    public CartItem getCartItemById(int id) throws SQLException {
        String query = "SELECT id, user_id, product_id, quantity, price, added_at, updated_at FROM cart_items WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, id);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    CartItem item = new CartItem();
                    item.setId(rs.getInt("id"));
                    item.setUserId(rs.getInt("user_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setPrice(rs.getBigDecimal("price"));
                    item.setAddedAt(rs.getObject("added_at", LocalDateTime.class));
                    item.setUpdatedAt(rs.getObject("updated_at", LocalDateTime.class));
                    return item;
                }
            }
        }
        return null;
    }

    // UPDATE: Update quantity of a product in the user's cart
    public void updateCartItemQuantity(int userId, int productId, int quantity) throws SQLException {
        if (quantity <= 0) {
            deleteCartItem(userId, productId);
            return;
        }
        
        String query = "UPDATE cart_items SET quantity = ?, updated_at = ? WHERE user_id = ? AND product_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, quantity);
            statement.setObject(2, LocalDateTime.now());
            statement.setInt(3, userId);
            statement.setInt(4, productId);
            statement.executeUpdate();
        }
    }

    // UPDATE: Update cart item
    public void updateCartItem(CartItem cartItem) throws SQLException {
        String query = "UPDATE cart_items SET quantity = ?, price = ?, updated_at = ? WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, cartItem.getQuantity());
            statement.setBigDecimal(2, cartItem.getPrice());
            statement.setObject(3, LocalDateTime.now());
            statement.setInt(4, cartItem.getId());
            statement.executeUpdate();
        }
    }

    // DELETE: Remove a specific product from the user's cart
    public void deleteCartItem(int userId, int productId) throws SQLException {
        String query = "DELETE FROM cart_items WHERE user_id = ? AND product_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);
            statement.setInt(2, productId);
            statement.executeUpdate();
        }
    }

    // DELETE: Remove cart item by ID
    public void deleteCartItemById(int id) throws SQLException {
        String query = "DELETE FROM cart_items WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, id);
            statement.executeUpdate();
        }
    }

    // DELETE ALL: Clear cart for a specific user
    public void clearCartByUserId(int userId) throws SQLException {
        String query = "DELETE FROM cart_items WHERE user_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);
            statement.executeUpdate();
        }
    }

    // GET: Calculate total amount for user's cart
    public BigDecimal getCartTotal(int userId) throws SQLException {
        String query = "SELECT SUM(quantity * price) as total FROM cart_items WHERE user_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    BigDecimal total = rs.getBigDecimal("total");
                    return total != null ? total : BigDecimal.ZERO;
                }
            }
        }
        return BigDecimal.ZERO;
    }

    // GET: Get count of items in user's cart
    public int getCartItemCount(int userId) throws SQLException {
        String query = "SELECT SUM(quantity) as count FROM cart_items WHERE user_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("count");
                }
            }
        }
        return 0;
    }

    // GET: Check if product is in user's cart
    public boolean isProductInCart(int userId, int productId) throws SQLException {
        String query = "SELECT COUNT(*) as count FROM cart_items WHERE user_id = ? AND product_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);
            statement.setInt(2, productId);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("count") > 0;
                }
            }
        }
        return false;
    }

    // UPDATE: Update cart item prices (for when product prices change)
    public void updateCartItemPrices(int userId) throws SQLException {
        String query = "UPDATE cart_items SET price = p.price, updated_at = ? " +
                      "FROM product p WHERE cart_items.product_id = p.id AND cart_items.user_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setObject(1, LocalDateTime.now());
            statement.setInt(2, userId);
            statement.executeUpdate();
        }
    }
}