package dao.interfaces;

import java.sql.SQLException;
import java.util.List;

import model.User;

public interface UserDAO {
    void createUser(User user) throws SQLException;
    User getUserById(int id) throws SQLException;
    List<User> getAllUsers() throws SQLException;
    List<User> getUsersByEmail(String email) throws SQLException;
    User getUserByEmail(String email) throws SQLException;
    void updateUser(int id, User user) throws SQLException;
    void deleteUser(int id) throws SQLException;
    boolean isEmailExists(String email) throws SQLException;
    int getTotalUserCount() throws SQLException;

    // Search / filter
    List<User> searchUsers(String nameQuery, String phoneQuery) throws SQLException;
    List<User> getCustomers() throws SQLException;
    List<User> searchCustomers(String name, String type) throws SQLException;
    List<User> getStaff() throws SQLException;
    List<User> searchStaff(String name, String position) throws SQLException;
    int bulkCreateUsers(List<User> users) throws SQLException;
}
