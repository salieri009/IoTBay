package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;

import db.DBConnection;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 * Database initialization utility
 * Creates tables and seeds test data if they don't exist
 */
public class DatabaseInitializer {
    private static final Logger logger = Logger.getLogger(DatabaseInitializer.class.getName());
    private static boolean initialized = false;
    
    public static synchronized void initialize() {
        if (initialized) {
            return;
        }
        
        try {
            Connection connection = DBConnection.getConnection();
            
            // Create Users table if it doesn't exist
            createUsersTable(connection);
            
            // Seed test users if they don't exist
            seedTestUsers(connection);
            
            initialized = true;
            logger.log(Level.INFO, "Database initialized successfully");
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Failed to initialize database: " + e.getMessage(), e);
            throw new RuntimeException("Database initialization failed", e);
        }
    }
    
    private static void createUsersTable(Connection connection) throws SQLException {
        // Check if table exists
        String checkTableQuery = "SELECT name FROM sqlite_master WHERE type='table' AND name='Users'";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(checkTableQuery)) {
            
            if (!rs.next()) {
                // Table doesn't exist, create it
                String createTableQuery = 
                    "CREATE TABLE Users (" +
                    "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                    "email TEXT NOT NULL UNIQUE, " +
                    "password TEXT NOT NULL, " +
                    "firstName TEXT NOT NULL, " +
                    "lastName TEXT NOT NULL, " +
                    "phoneNumber TEXT, " +
                    "postalCode TEXT, " +
                    "addressLine1 TEXT, " +
                    "addressLine2 TEXT, " +
                    "dateOfBirth TEXT, " +
                    "paymentMethod TEXT, " +
                    "createdAt TEXT NOT NULL, " +
                    "updatedAt TEXT NOT NULL, " +
                    "role TEXT NOT NULL CHECK(role IN ('customer', 'staff')) DEFAULT 'customer', " +
                    "isActive BOOLEAN NOT NULL DEFAULT 1" +
                    ")";
                
                try (Statement createStmt = connection.createStatement()) {
                    createStmt.execute(createTableQuery);
                    logger.log(Level.INFO, "Users table created");
                }
            }
        }
    }
    
    private static void seedTestUsers(Connection connection) throws SQLException {
        LocalDateTime now = LocalDateTime.now();
        // Use DB format: "yyyy-MM-dd HH:mm:ss" instead of ISO format
        String nowStr = now.format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        
        // Test users to seed
        String[][] testUsers = {
            {"customer@iotbay.com", "password123", "Customer", "User", "+61 400 000 001", "2000", "1 George St", "Sydney NSW", "1990-01-01", "Card", "customer"},
            {"staff@iotbay.com", "staff123", "Staff", "User", "+61 400 000 002", "2001", "2 Pitt St", "Sydney NSW", "1992-05-15", "PayPal", "staff"},
            {"staff123@iotbay.com", "staff123", "Staff", "User", "+61 400 000 005", "2001", "2 Pitt St", "Sydney NSW", "1992-05-15", "PayPal", "staff"}
        };
        
        for (String[] userData : testUsers) {
            String email = userData[0];
            
            // Check if user already exists
            String checkQuery = "SELECT COUNT(*) FROM Users WHERE email = ?";
            try (PreparedStatement checkStmt = connection.prepareStatement(checkQuery)) {
                checkStmt.setString(1, email);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        // User already exists, skip
                        continue;
                    }
                }
            }
            
            // Insert test user
            String insertQuery = 
                "INSERT INTO Users (email, password, firstName, lastName, phoneNumber, postalCode, addressLine1, addressLine2, dateOfBirth, paymentMethod, createdAt, updatedAt, role, isActive) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            try (PreparedStatement insertStmt = connection.prepareStatement(insertQuery)) {
                insertStmt.setString(1, userData[0]); // email
                insertStmt.setString(2, userData[1]); // password (plain text for now)
                insertStmt.setString(3, userData[2]); // firstName
                insertStmt.setString(4, userData[3]); // lastName
                insertStmt.setString(5, userData[4]); // phoneNumber
                insertStmt.setString(6, userData[5]); // postalCode
                insertStmt.setString(7, userData[6]); // addressLine1
                insertStmt.setString(8, userData[7]); // addressLine2
                insertStmt.setString(9, userData[8]); // dateOfBirth
                insertStmt.setString(10, userData[9]); // paymentMethod
                insertStmt.setString(11, nowStr); // createdAt
                insertStmt.setString(12, nowStr); // updatedAt
                insertStmt.setString(13, userData[10]); // role
                insertStmt.setBoolean(14, true); // isActive
                
                insertStmt.executeUpdate();
                logger.log(Level.INFO, "Test user seeded: " + email);
            }
        }
    }
}

