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
                        // Initialize database (create tables and seed test data)
                        utils.DatabaseInitializer.initialize();

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
        // DAOs now manage their own connections via DIContainer.getConnection()
        register(UserDAO.class, new UserDAOImpl());
        register(ProductDAO.class, new ProductDAOImpl());
        register(AccessLogDAO.class, new AccessLogDAOImpl());
        register(OrderDAO.class, new OrderDAOImpl());
        register(CartItemDAO.class, new CartItemDAOImpl());
        register(dao.ReviewDAO.class, new dao.ReviewDAO());
        register(dao.interfaces.SupplierDAO.class, new dao.SupplierDAOImpl());
        register(dao.ShipmentDAO.class, new dao.ShipmentDAO());
    }

    @SuppressWarnings("unchecked")
    public static <T> T get(Class<T> clazz) {
        ensureInitialized();
        return (T) instances.get(clazz);
    }

    public static <T> void register(Class<T> clazz, T instance) {
        instances.put(clazz, instance);
    }

    /**
     * Returns a FRESH database connection on every call.
     *
     * DAOs wrap this in try-with-resources, which closes the connection when the
     * method returns. A single shared static connection therefore caused a
     * concurrency race: one request (e.g. the header's cart-count API) would
     * close the shared connection while another (the /cart page query) was still
     * using it, surfacing as "database connection closed". Handing out a new
     * connection per call gives each try-with-resources its own connection to
     * close, eliminating the race. The DB is file-backed (iotbay.db), so data
     * persists across connections.
     */
    public static Connection getConnection() {
        ensureInitialized();
        try {
            return DBConnection.getConnection();
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException("Failed to open database connection", e);
        }
    }
}
