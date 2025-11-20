package dao.stub;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import dao.interfaces.CartItemDAO;
import model.CartItem;

public class CartItemDAOStub implements CartItemDAO {
    private final List<CartItem> cartItems = new ArrayList<>();

    public CartItemDAOStub() {
        // Comprehensive test data with 20+ test cases covering various scenarios
        // Test case 1-3: Cart items for user 1
        cartItems.add(new CartItem(1, 1, 1, 1, BigDecimal.valueOf(199.99), LocalDateTime.now().minusHours(2), LocalDateTime.now().minusHours(1)));
        cartItems.add(new CartItem(2, 1, 2, 2, BigDecimal.valueOf(49.98), LocalDateTime.now().minusHours(1), LocalDateTime.now().minusMinutes(30)));
        cartItems.add(new CartItem(3, 1, 3, 1, BigDecimal.valueOf(149.99), LocalDateTime.now().minusMinutes(45), LocalDateTime.now().minusMinutes(30)));

        // Test case 4-6: Cart items for user 2
        cartItems.add(new CartItem(4, 2, 4, 3, BigDecimal.valueOf(299.97), LocalDateTime.now().minusHours(3), LocalDateTime.now().minusHours(2)));
        cartItems.add(new CartItem(5, 2, 5, 1, BigDecimal.valueOf(79.99), LocalDateTime.now().minusHours(2), LocalDateTime.now().minusHours(1)));
        cartItems.add(new CartItem(6, 2, 6, 5, BigDecimal.valueOf(249.95), LocalDateTime.now().minusHours(1), LocalDateTime.now().minusMinutes(30)));

        // Test case 7-9: Cart items for user 3
        cartItems.add(new CartItem(7, 3, 7, 2, BigDecimal.valueOf(79.98), LocalDateTime.now().minusHours(4), LocalDateTime.now().minusHours(3)));
        cartItems.add(new CartItem(8, 3, 8, 1, BigDecimal.valueOf(69.99), LocalDateTime.now().minusHours(3), LocalDateTime.now().minusHours(2)));
        cartItems.add(new CartItem(9, 3, 9, 4, BigDecimal.valueOf(119.96), LocalDateTime.now().minusHours(2), LocalDateTime.now().minusHours(1)));

        // Test case 10-12: High quantity items
        cartItems.add(new CartItem(10, 1, 11, 10, BigDecimal.valueOf(199.90), LocalDateTime.now().minusHours(5), LocalDateTime.now().minusHours(4)));
        cartItems.add(new CartItem(11, 2, 12, 8, BigDecimal.valueOf(799.92), LocalDateTime.now().minusHours(4), LocalDateTime.now().minusHours(3)));
        cartItems.add(new CartItem(12, 3, 13, 15, BigDecimal.valueOf(149.85), LocalDateTime.now().minusHours(3), LocalDateTime.now().minusHours(2)));

        // Test case 13-15: Low quantity items
        cartItems.add(new CartItem(13, 1, 14, 1, BigDecimal.valueOf(29.99), LocalDateTime.now().minusMinutes(60), LocalDateTime.now().minusMinutes(30)));
        cartItems.add(new CartItem(14, 2, 15, 1, BigDecimal.valueOf(44.99), LocalDateTime.now().minusMinutes(50), LocalDateTime.now().minusMinutes(40)));
        cartItems.add(new CartItem(15, 3, 16, 1, BigDecimal.valueOf(129.99), LocalDateTime.now().minusMinutes(40), LocalDateTime.now().minusMinutes(20)));

        // Test case 16-18: Recently added items
        cartItems.add(new CartItem(16, 1, 17, 2, BigDecimal.valueOf(29.98), LocalDateTime.now().minusMinutes(20), LocalDateTime.now().minusMinutes(15)));
        cartItems.add(new CartItem(17, 2, 18, 3, BigDecimal.valueOf(44.97), LocalDateTime.now().minusMinutes(15), LocalDateTime.now().minusMinutes(10)));
        cartItems.add(new CartItem(18, 3, 19, 1, BigDecimal.valueOf(34.99), LocalDateTime.now().minusMinutes(10), LocalDateTime.now().minusMinutes(5)));

        // Test case 19-21: Bulk order items
        cartItems.add(new CartItem(19, 1, 20, 20, BigDecimal.valueOf(999.80), LocalDateTime.now().minusDays(1), LocalDateTime.now().minusHours(12)));
        cartItems.add(new CartItem(20, 2, 21, 25, BigDecimal.valueOf(749.75), LocalDateTime.now().minusDays(1), LocalDateTime.now().minusHours(10)));
        cartItems.add(new CartItem(21, 3, 22, 30, BigDecimal.valueOf(1499.70), LocalDateTime.now().minusDays(1), LocalDateTime.now().minusHours(8)));

        // Test case 22-24: Items with different prices
        cartItems.add(new CartItem(22, 1, 23, 2, BigDecimal.valueOf(79.98), LocalDateTime.now().minusHours(6), LocalDateTime.now().minusHours(5)));
        cartItems.add(new CartItem(23, 2, 24, 1, BigDecimal.valueOf(89.99), LocalDateTime.now().minusHours(5), LocalDateTime.now().minusHours(4)));
        cartItems.add(new CartItem(24, 3, 25, 5, BigDecimal.valueOf(99.95), LocalDateTime.now().minusHours(4), LocalDateTime.now().minusHours(3)));

        // Test case 25-27: Items added at different times
        cartItems.add(new CartItem(25, 1, 1, 3, BigDecimal.valueOf(599.97), LocalDateTime.now().minusDays(2), LocalDateTime.now().minusDays(1)));
        cartItems.add(new CartItem(26, 2, 2, 2, BigDecimal.valueOf(49.98), LocalDateTime.now().minusDays(2), LocalDateTime.now().minusDays(1).plusHours(2)));
        cartItems.add(new CartItem(27, 3, 3, 4, BigDecimal.valueOf(599.96), LocalDateTime.now().minusDays(2), LocalDateTime.now().minusDays(1).plusHours(4)));

        // Test case 28-30: Mixed price points
        cartItems.add(new CartItem(28, 1, 11, 1, BigDecimal.valueOf(19.99), LocalDateTime.now().minusHours(8), LocalDateTime.now().minusHours(7)));
        cartItems.add(new CartItem(29, 2, 12, 2, BigDecimal.valueOf(199.98), LocalDateTime.now().minusHours(7), LocalDateTime.now().minusHours(6)));
        cartItems.add(new CartItem(30, 3, 13, 1, BigDecimal.valueOf(9.99), LocalDateTime.now().minusHours(6), LocalDateTime.now().minusHours(5)));
    }

    private int getNextId() {
        return cartItems.isEmpty() ? 1 : cartItems.get(cartItems.size() - 1).getId() + 1;
    }

    @Override
    public void createCartItem(CartItem cartItem) throws SQLException {
        CartItem newCartItem = new CartItem(
            getNextId(),
            cartItem.getUserId(),
            cartItem.getProductId(),
            cartItem.getQuantity(),
            cartItem.getPrice(),
            LocalDateTime.now(),
            LocalDateTime.now()
        );
        cartItems.add(newCartItem);
    }

    @Override
    public CartItem getCartItemById(int id) throws SQLException {
        return cartItems.stream()
                .filter(item -> item.getId() == id)
                .findFirst()
                .orElse(null);
    }

    @Override
    public List<CartItem> getCartItemsByUserId(int userId) throws SQLException {
        List<CartItem> result = new ArrayList<>();
        for (CartItem item : cartItems) {
            if (item.getUserId() == userId) {
                result.add(item);
            }
        }
        return result;
    }

    @Override
    public void updateCartItem(int id, CartItem updatedItem) throws SQLException {
        for (int i = 0; i < cartItems.size(); i++) {
            if (cartItems.get(i).getId() == id) {
                CartItem newItem = new CartItem(
                    id,
                    updatedItem.getUserId(),
                    updatedItem.getProductId(),
                    updatedItem.getQuantity(),
                    updatedItem.getPrice(),
                    cartItems.get(i).getAddedAt(),
                    LocalDateTime.now()
                );
                cartItems.set(i, newItem);
                return;
            }
        }
    }

    @Override
    public void deleteCartItem(int id) throws SQLException {
        cartItems.removeIf(item -> item.getId() == id);
    }

    @Override
    public void deleteCartItemsByUserId(int userId) throws SQLException {
        cartItems.removeIf(item -> item.getUserId() == userId);
    }

    @Override
    public List<CartItem> getAllCartItems() throws SQLException {
        return new ArrayList<>(cartItems);
    }
}
