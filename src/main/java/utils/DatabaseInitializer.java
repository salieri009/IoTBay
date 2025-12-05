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
            System.out.println("[DatabaseInitializer] Already initialized, skipping.");
            return;
        }

        try {
            System.out.println("[DatabaseInitializer] Starting database initialization...");
            Connection connection = DBConnection.getConnection();
            System.out.println("[DatabaseInitializer] Got connection to: " + connection.getMetaData().getURL());

            // Create Users table if it doesn't exist
            System.out.println("[DatabaseInitializer] Creating Users table...");
            createUsersTable(connection);

            // Create Categories table if it doesn't exist
            System.out.println("[DatabaseInitializer] Creating Categories table...");
            createCategoriesTable(connection);

            // Create Products table if it doesn't exist
            System.out.println("[DatabaseInitializer] Creating Products table...");
            createProductsTable(connection);

            // Seed test users if they don't exist
            System.out.println("[DatabaseInitializer] Seeding test users...");
            seedTestUsers(connection);

            // Seed default categories if they don't exist
            System.out.println("[DatabaseInitializer] Seeding categories...");
            seedCategories(connection);

            // Seed sample products if they don't exist
            System.out.println("[DatabaseInitializer] Seeding products...");
            seedProducts(connection);

            initialized = true;
            System.out.println("[DatabaseInitializer] Database initialized successfully!");
            logger.log(Level.INFO, "Database initialized successfully");
        } catch (Exception e) {
            System.err.println("[DatabaseInitializer] FAILED: " + e.getMessage());
            e.printStackTrace();
            logger.log(Level.SEVERE, "Failed to initialize database: " + e.getMessage(), e);
            throw new RuntimeException("Database initialization failed", e);
        }
    }

    private static void createCategoriesTable(Connection connection) throws SQLException {
        String checkTableQuery = "SELECT name FROM sqlite_master WHERE type='table' AND name='categories'";
        try (Statement stmt = connection.createStatement();
                ResultSet rs = stmt.executeQuery(checkTableQuery)) {

            if (!rs.next()) {
                String createTableQuery = "CREATE TABLE categories (" +
                        "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                        "name TEXT NOT NULL UNIQUE, " +
                        "description TEXT, " +
                        "slug TEXT UNIQUE, " +
                        "is_active INTEGER NOT NULL DEFAULT 1, " +
                        "sort_order INTEGER NOT NULL DEFAULT 0" +
                        ")";

                try (Statement createStmt = connection.createStatement()) {
                    createStmt.execute(createTableQuery);
                    logger.log(Level.INFO, "Categories table created");
                }
            }
        }
    }

    private static void createProductsTable(Connection connection) throws SQLException {
        String checkTableQuery = "SELECT name FROM sqlite_master WHERE type='table' AND name='products'";
        try (Statement stmt = connection.createStatement();
                ResultSet rs = stmt.executeQuery(checkTableQuery)) {

            if (!rs.next()) {
                String createTableQuery = "CREATE TABLE products (" +
                        "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                        "category_id INTEGER NOT NULL, " +
                        "name TEXT NOT NULL, " +
                        "description TEXT, " +
                        "price REAL NOT NULL DEFAULT 0, " +
                        "stock_quantity INTEGER NOT NULL DEFAULT 0, " +
                        "image_url TEXT, " +
                        "is_active INTEGER NOT NULL DEFAULT 1, " +
                        "created_at TEXT NOT NULL DEFAULT (datetime('now')), " +
                        "updated_at TEXT NOT NULL DEFAULT (datetime('now')), " +
                        "FOREIGN KEY (category_id) REFERENCES categories(id)" +
                        ")";

                try (Statement createStmt = connection.createStatement()) {
                    createStmt.execute(createTableQuery);
                    logger.log(Level.INFO, "Products table created");
                }
            }
        }
    }

    private static void seedCategories(Connection connection) throws SQLException {
        String[][] defaultCategories = {
                { "Smart Home", "Smart home automation and IoT devices", "smarthome", "1" },
                { "Industrial", "Industrial IoT solutions and sensors", "industrial", "2" },
                { "Agriculture", "Smart agriculture and farming solutions", "agriculture", "3" },
                { "Warehouse", "Warehouse management and logistics IoT", "warehouse", "4" },
                { "Healthcare", "Healthcare IoT devices and monitoring", "healthcare", "5" },
                { "Energy", "Smart energy management solutions", "energy", "6" }
        };

        String checkQuery = "SELECT COUNT(*) FROM categories";
        try (Statement stmt = connection.createStatement();
                ResultSet rs = stmt.executeQuery(checkQuery)) {
            if (rs.next() && rs.getInt(1) > 0) {
                return; // Categories already seeded
            }
        }

        String insertQuery = "INSERT INTO categories (name, description, slug, sort_order, is_active) VALUES (?, ?, ?, ?, 1)";
        for (String[] cat : defaultCategories) {
            try (PreparedStatement insertStmt = connection.prepareStatement(insertQuery)) {
                insertStmt.setString(1, cat[0]);
                insertStmt.setString(2, cat[1]);
                insertStmt.setString(3, cat[2]);
                insertStmt.setInt(4, Integer.parseInt(cat[3]));
                insertStmt.executeUpdate();
                logger.log(Level.INFO, "Category seeded: " + cat[0]);
            }
        }
    }

    private static void seedProducts(Connection connection) throws SQLException {
        String checkQuery = "SELECT COUNT(*) FROM products";
        try (Statement stmt = connection.createStatement();
                ResultSet rs = stmt.executeQuery(checkQuery)) {
            if (rs.next() && rs.getInt(1) > 0) {
                return; // Products already seeded
            }
        }

        // Sample products for each category
        String[][] sampleProducts = {
                // Smart Home (category_id = 1)
                { "1", "Smart Hub Pro", "Central hub for smart home automation", "299.99", "50",
                        "/images/products/smart-hub.jpg" },
                { "1", "Smart Thermostat", "Wi-Fi enabled temperature control", "149.99", "100",
                        "/images/products/thermostat.jpg" },
                { "1", "Smart Light Bulb", "Color-changing LED smart bulb", "29.99", "200",
                        "/images/products/lightbulb.jpg" },
                // Industrial (category_id = 2)
                { "2", "Industrial Sensor Kit", "Temperature and humidity sensors for factories", "499.99", "30",
                        "/images/products/sensor-kit.jpg" },
                { "2", "PLC Controller", "Programmable logic controller", "899.99", "20", "/images/products/plc.jpg" },
                // Agriculture (category_id = 3)
                { "3", "Soil Moisture Monitor", "IoT soil monitoring system", "199.99", "75",
                        "/images/products/soil-monitor.jpg" },
                { "3", "Smart Irrigation System", "Automated watering system", "399.99", "40",
                        "/images/products/irrigation.jpg" },
                // Warehouse (category_id = 4)
                { "4", "RFID Scanner", "Handheld RFID inventory scanner", "249.99", "60", "/images/products/rfid.jpg" },
                { "4", "Warehouse Robot", "Automated inventory robot", "4999.99", "5", "/images/products/robot.jpg" },
                // Healthcare (category_id = 5)
                { "5", "Heart Rate Monitor", "Wearable heart rate tracker", "99.99", "150",
                        "/images/products/heart-monitor.jpg" },
                // Energy (category_id = 6)
                { "6", "Smart Meter", "Real-time energy monitoring", "179.99", "80",
                        "/images/products/smart-meter.jpg" }
        };

        String insertQuery = "INSERT INTO products (category_id, name, description, price, stock_quantity, image_url) VALUES (?, ?, ?, ?, ?, ?)";
        for (String[] prod : sampleProducts) {
            try (PreparedStatement insertStmt = connection.prepareStatement(insertQuery)) {
                insertStmt.setInt(1, Integer.parseInt(prod[0]));
                insertStmt.setString(2, prod[1]);
                insertStmt.setString(3, prod[2]);
                insertStmt.setDouble(4, Double.parseDouble(prod[3]));
                insertStmt.setInt(5, Integer.parseInt(prod[4]));
                insertStmt.setString(6, prod[5]);
                insertStmt.executeUpdate();
            }
        }
        logger.log(Level.INFO, "Sample products seeded: " + sampleProducts.length + " products");
    }

    private static void createUsersTable(Connection connection) throws SQLException {
        // Check if table exists
        String checkTableQuery = "SELECT name FROM sqlite_master WHERE type='table' AND name='Users'";
        try (Statement stmt = connection.createStatement();
                ResultSet rs = stmt.executeQuery(checkTableQuery)) {

            if (!rs.next()) {
                // Table doesn't exist, create it
                String createTableQuery = "CREATE TABLE Users (" +
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
                { "customer@iotbay.com", "password123", "Customer", "User", "+61 400 000 001", "2000", "1 George St",
                        "Sydney NSW", "1990-01-01", "Card", "customer" },
                { "staff@iotbay.com", "staff123", "Staff", "User", "+61 400 000 002", "2001", "2 Pitt St", "Sydney NSW",
                        "1992-05-15", "PayPal", "staff" },
                { "staff123@iotbay.com", "staff123", "Staff", "User", "+61 400 000 005", "2001", "2 Pitt St",
                        "Sydney NSW", "1992-05-15", "PayPal", "staff" }
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
            String insertQuery = "INSERT INTO Users (email, password, firstName, lastName, phoneNumber, postalCode, addressLine1, addressLine2, dateOfBirth, paymentMethod, createdAt, updatedAt, role, isActive) "
                    +
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

    public static void main(String[] args) {
        initialize();
    }
}
