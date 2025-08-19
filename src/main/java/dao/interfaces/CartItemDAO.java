package dao.interfaces;

import java.sql.SQLException;
import java.util.List;

import model.CartItem;

public interface CartItemDAO {
    void createCartItem(CartItem cartItem) throws SQLException;
    CartItem getCartItemById(int id) throws SQLException;
    List<CartItem> getCartItemsByUserId(int userId) throws SQLException;
    void updateCartItem(int id, CartItem cartItem) throws SQLException;
    void deleteCartItem(int id) throws SQLException;
    void deleteCartItemsByUserId(int userId) throws SQLException;
    List<CartItem> getAllCartItems() throws SQLException;
}
