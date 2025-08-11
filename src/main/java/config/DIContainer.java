package config;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.concurrent.ConcurrentHashMap;

import dao.*;
import dao.interfaces.*;
import db.DBConnection;

/**
 * Dependency Injection Container (Simple Implementation)
 * 최신 트렌드: IoC Container 패턴
 */
public class DIContainer {
    private static final ConcurrentHashMap<Class<?>, Object> instances = new ConcurrentHashMap<>();
    private static Connection connection;
    
    static {
        try {
            connection = DBConnection.getConnection();
            initializeDAOs();
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException("Failed to initialize DI Container", e);
        }
    }
    
    private static void initializeDAOs() {
        // DAO 인스턴스들을 한 번만 생성하여 재사용 (Singleton 패턴)
        register(UserDAO.class, new UserDAOImpl(connection));
        register(ProductDAO.class, new ProductDAOImpl(connection));
        register(AccessLogDAO.class, new AccessLogDAOImpl(connection));
        register(OrderDAO.class, new OrderDAO(connection));
        register(CartItemDAO.class, new CartItemDAO(connection));
    }
    
    @SuppressWarnings("unchecked")
    public static <T> T get(Class<T> clazz) {
        return (T) instances.get(clazz);
    }
    
    public static <T> void register(Class<T> clazz, T instance) {
        instances.put(clazz, instance);
    }
    
    public static Connection getConnection() {
        return connection;
    }
}
