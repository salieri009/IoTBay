package config;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.concurrent.ConcurrentHashMap;

import dao.AccessLogDAOImpl;
import dao.CartItemDAOImpl;
import dao.OrderDAOImpl;
import dao.ProductDAOImpl;
import dao.UserDAOImpl;
import dao.interfaces.AccessLogDAO;
import dao.interfaces.CartItemDAO;
import dao.interfaces.OrderDAO;
import dao.interfaces.ProductDAO;
import dao.interfaces.UserDAO;
import db.DBConnection;

/**
 * Dependency Injection Container (Simple Implementation)
 * 최신 트렌드: IoC Container 패턴
 */
public class DIContainer {
    private static final ConcurrentHashMap<Class<?>, Object> instances = new ConcurrentHashMap<>();
    private static Connection connection;
    private static volatile boolean initialized = false;
    private static final Object lock = new Object();
    
    private static void ensureInitialized() {
        if (!initialized) {
            synchronized (lock) {
                if (!initialized) {
                    try {
                        connection = DBConnection.getConnection();
                        initializeDAOs();
                        initialized = true;
                    } catch (SQLException | ClassNotFoundException e) {
                        throw new RuntimeException("Failed to initialize DI Container", e);
                    }
                }
            }
        }
    }
    
    private static void initializeDAOs() throws SQLException {
        // DAO 인스턴스들을 한 번만 생성하여 재사용 (Singleton 패턴)
        register(UserDAO.class, new UserDAOImpl(connection));
        register(ProductDAO.class, new ProductDAOImpl(connection));
        register(AccessLogDAO.class, new AccessLogDAOImpl(connection));
        register(OrderDAO.class, new OrderDAOImpl(connection));
        register(CartItemDAO.class, new CartItemDAOImpl(connection));
    }
    
    @SuppressWarnings("unchecked")
    public static <T> T get(Class<T> clazz) {
        ensureInitialized();
        return (T) instances.get(clazz);
    }
    
    public static <T> void register(Class<T> clazz, T instance) {
        instances.put(clazz, instance);
    }
    
    public static Connection getConnection() {
        ensureInitialized();
        return connection;
    }
}
