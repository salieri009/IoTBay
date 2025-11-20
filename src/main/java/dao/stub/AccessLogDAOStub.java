package dao.stub;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import dao.interfaces.AccessLogDAO;
import model.AccessLog;

public class AccessLogDAOStub implements AccessLogDAO {
    private final List<AccessLog> logs = new ArrayList<>();

    public AccessLogDAOStub() {
        // Comprehensive test data with 20+ test cases covering various scenarios
        // Test case 1-3: Basic login/logout sequences
        logs.add(new AccessLog(1, 1, "LOGIN", LocalDateTime.now().minusDays(1)));
        logs.add(new AccessLog(2, 2, "LOGOUT", LocalDateTime.now()));
        logs.add(new AccessLog(3, 1, "LOGIN", LocalDateTime.now().minusDays(3).withHour(8)));
        
        // Test case 4-6: Multiple login/logout in same day
        logs.add(new AccessLog(4, 1, "LOGOUT", LocalDateTime.now().minusDays(3).withHour(9)));
        logs.add(new AccessLog(5, 2, "LOGIN", LocalDateTime.now().minusDays(2).withHour(10)));
        logs.add(new AccessLog(6, 2, "LOGOUT", LocalDateTime.now().minusDays(2).withHour(11)));
        
        // Test case 7-9: Different users with varied access patterns
        logs.add(new AccessLog(7, 3, "LOGIN", LocalDateTime.now().minusDays(4).withHour(7)));
        logs.add(new AccessLog(8, 3, "LOGOUT", LocalDateTime.now().minusDays(4).withHour(8)));
        logs.add(new AccessLog(9, 1, "LOGIN", LocalDateTime.now().minusDays(5).withHour(8)));
        
        // Test case 10-12: Long session durations
        logs.add(new AccessLog(10, 1, "LOGOUT", LocalDateTime.now().minusDays(5).withHour(17)));
        logs.add(new AccessLog(11, 2, "LOGIN", LocalDateTime.now().minusDays(6).withHour(10)));
        logs.add(new AccessLog(12, 2, "LOGOUT", LocalDateTime.now().minusDays(6).withHour(16)));
        
        // Test case 13-15: Product view actions
        logs.add(new AccessLog(13, 3, "VIEW_PRODUCT", LocalDateTime.now().minusDays(7).withHour(7)));
        logs.add(new AccessLog(14, 3, "ADD_TO_CART", LocalDateTime.now().minusDays(7).withHour(8)));
        logs.add(new AccessLog(15, 1, "CHECKOUT", LocalDateTime.now().minusDays(8).withHour(8)));
        
        // Test case 16-18: Admin operations
        logs.add(new AccessLog(16, 1, "ADMIN_LOGIN", LocalDateTime.now().minusDays(8).withHour(9)));
        logs.add(new AccessLog(17, 2, "ADMIN_CREATE_USER", LocalDateTime.now().minusDays(9).withHour(10)));
        logs.add(new AccessLog(18, 2, "ADMIN_EDIT_PRODUCT", LocalDateTime.now().minusDays(9).withHour(11)));
        
        // Test case 19-21: Staff operations
        logs.add(new AccessLog(19, 3, "STAFF_LOGIN", LocalDateTime.now().minusDays(10).withHour(7)));
        logs.add(new AccessLog(20, 3, "STAFF_VIEW_ORDERS", LocalDateTime.now().minusDays(10).withHour(8)));
        logs.add(new AccessLog(21, 1, "PROFILE_UPDATE", LocalDateTime.now().minusDays(11).withHour(14)));
        
        // Test case 22-24: Error and security-related actions
        logs.add(new AccessLog(22, 2, "LOGIN_FAILED", LocalDateTime.now().minusDays(11).withHour(15)));
        logs.add(new AccessLog(23, 3, "UNAUTHORIZED_ACCESS_ATTEMPT", LocalDateTime.now().minusDays(12).withHour(9)));
        logs.add(new AccessLog(24, 1, "PASSWORD_CHANGED", LocalDateTime.now().minusDays(12).withHour(10)));
        
        // Test case 25-27: Export and data management operations
        logs.add(new AccessLog(25, 2, "EXPORT_DATA", LocalDateTime.now().minusDays(13).withHour(11)));
        logs.add(new AccessLog(26, 3, "VIEW_REPORTS", LocalDateTime.now().minusDays(13).withHour(12)));
        logs.add(new AccessLog(27, 1, "MANAGE_USERS", LocalDateTime.now().minusDays(14).withHour(8)));
        
        // Test case 28-30: Extended history
        logs.add(new AccessLog(28, 2, "LOGIN", LocalDateTime.now().minusDays(14).withHour(9)));
        logs.add(new AccessLog(29, 3, "LOGOUT", LocalDateTime.now().minusDays(15).withHour(17)));
        logs.add(new AccessLog(30, 1, "ADMIN_DELETE_PRODUCT", LocalDateTime.now().minusDays(15).withHour(10)));
    }

    private int getNextId() {
        return logs.isEmpty() ? 1 : logs.get(logs.size() - 1).getId() + 1;
    }

    @Override
    public void createAccessLog(AccessLog log) throws SQLException {
        AccessLog newLog = new AccessLog(
            getNextId(),
            log.getUserId(),
            log.getAction(),
            log.getTimestamp()
        );
        logs.add(newLog);
    }

    @Override
    public AccessLog getAccessLogById(int id) throws SQLException {
        return logs.stream()
                .filter(log -> log.getId() == id)
                .findFirst()
                .orElse(null);
    }

    @Override
    public List<AccessLog> getAccessLogsByUserId(int userId) throws SQLException {
        List<AccessLog> result = new ArrayList<>();
        for (AccessLog log : logs) {
            if (log.getUserId() == userId) {
                result.add(log);
            }
        }
        return result;
    }

    @Override
    public List<AccessLog> getAllAccessLogs() throws SQLException {
        return new ArrayList<>(logs);
    }

    @Override
    public void deleteAccessLog(int id) throws SQLException {
        logs.removeIf(log -> log.getId() == id);
    }

    @Override
    public List<AccessLog> getAccessLogsByUserIdAndDateRange(int userId, LocalDate startDate, LocalDate endDate) throws SQLException {
        List<AccessLog> result = new ArrayList<>();
        for (AccessLog log : logs) {
            if (log.getUserId() == userId) {
                LocalDate logDate = log.getTimestamp().toLocalDate();
                if ((logDate.isEqual(startDate) || logDate.isAfter(startDate)) &&
                    (logDate.isEqual(endDate) || logDate.isBefore(endDate))) {
                    result.add(log);
                }
            }
        }
        return result;
    }

    @Override
    public List<AccessLog> getAccessLogsByDateRange(LocalDate startDate, LocalDate endDate) throws SQLException {
        List<AccessLog> result = new ArrayList<>();
        for (AccessLog log : logs) {
            if (log.getTimestamp() != null) {
                LocalDate logDate = log.getTimestamp().toLocalDate();
                if ((logDate.isEqual(startDate) || logDate.isAfter(startDate)) &&
                    (logDate.isEqual(endDate) || logDate.isBefore(endDate))) {
                    result.add(log);
                }
            }
        }
        return result;
    }
}
