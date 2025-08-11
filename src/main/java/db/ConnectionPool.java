package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;

import config.AppConfig;

/**
 * 최신 트렌드: Connection Pool Pattern
 * Database Connection Pool for Better Performance
 */
public class ConnectionPool {
    private static final int POOL_SIZE = 10;
    private static ConnectionPool instance;
    private BlockingQueue<Connection> connectionQueue;
    
    private ConnectionPool() throws SQLException, ClassNotFoundException {
        String url = AppConfig.getProperty("db.url", "jdbc:sqlite:iotbay.db");
        String driver = AppConfig.getProperty("db.driver", "org.sqlite.JDBC");
        
        Class.forName(driver);
        
        connectionQueue = new ArrayBlockingQueue<>(POOL_SIZE);
        
        // Initialize pool with connections
        for (int i = 0; i < POOL_SIZE; i++) {
            Connection connection = DriverManager.getConnection(url);
            connectionQueue.offer(connection);
        }
    }
    
    public static synchronized ConnectionPool getInstance() throws SQLException, ClassNotFoundException {
        if (instance == null) {
            instance = new ConnectionPool();
        }
        return instance;
    }
    
    public Connection getConnection() throws InterruptedException {
        return connectionQueue.take(); // Blocks if no connection available
    }
    
    public void releaseConnection(Connection connection) {
        if (connection != null) {
            connectionQueue.offer(connection);
        }
    }
    
    public int getAvailableConnections() {
        return connectionQueue.size();
    }
    
    public void shutdown() throws SQLException {
        while (!connectionQueue.isEmpty()) {
            Connection connection = connectionQueue.poll();
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        }
    }
}
