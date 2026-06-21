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
            String dbUrl = connection.getMetaData().getURL();
            System.out.println("[DatabaseInitializer] Got connection to: " + dbUrl);
            logger.log(Level.INFO, "Connected to database: {0}", dbUrl);

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

            // Seed orders, payments, access logs
            System.out.println("[DatabaseInitializer] Seeding orders...");
            seedOrders(connection);
            System.out.println("[DatabaseInitializer] Seeding payments...");
            seedPayments(connection);
            System.out.println("[DatabaseInitializer] Seeding access logs...");
            seedAccessLogs(connection);

            // Create additional tables required by newer DAO implementations
            System.out.println("[DatabaseInitializer] Creating orders table (plural)...");
            createOrdersTable(connection);
            System.out.println("[DatabaseInitializer] Creating suppliers table...");
            createSuppliersTable(connection);
            System.out.println("[DatabaseInitializer] Creating access_logs table (plural)...");
            createAccessLogsTable(connection);
            System.out.println("[DatabaseInitializer] Creating shipment table...");
            createShipmentTable(connection);
            System.out.println("[DatabaseInitializer] Creating cart_items table...");
            createCartItemsTable(connection);
            System.out.println("[DatabaseInitializer] Creating payment tables...");
            createPaymentTables(connection);
            System.out.println("[DatabaseInitializer] Creating order_product table...");
            createOrderProductTable(connection);

            // Seed additional tables
            System.out.println("[DatabaseInitializer] Seeding orders (plural table)...");
            seedOrdersTable(connection);
            System.out.println("[DatabaseInitializer] Seeding suppliers...");
            seedSuppliersTable(connection);
            System.out.println("[DatabaseInitializer] Seeding access_logs (plural table)...");
            seedAccessLogsTable(connection);
            System.out.println("[DatabaseInitializer] Seeding shipments...");
            seedShipments(connection);

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
                    System.out.println("[DatabaseInitializer] Categories table created successfully.");
                    logger.log(Level.INFO, "Categories table created");
                }
            } else {
                System.out.println("[DatabaseInitializer] Categories table already exists.");
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
                    System.out.println("[DatabaseInitializer] Products table created successfully.");
                    logger.log(Level.INFO, "Products table created");
                }
            } else {
                System.out.println("[DatabaseInitializer] Products table already exists.");
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

        // Sample products for each category (25 total)
        String[][] sampleProducts = {
            // Smart Home (category_id = 1) — 5 products
            {"1","Smart Hub Pro","Central hub for smart home automation","299.99","50","/images/products/smart-hub.jpg"},
            {"1","Smart Thermostat","Wi-Fi enabled temperature control","149.99","100","/images/products/thermostat.jpg"},
            {"1","Smart Light Bulb","Color-changing LED smart bulb","29.99","200","/images/products/lightbulb.jpg"},
            {"1","Smart Door Lock","Keyless entry with smartphone control","189.99","80","/images/products/door-lock.jpg"},
            {"1","Smart Security Camera","1080p indoor security camera with AI","129.99","120","/images/products/camera.jpg"},
            // Industrial (category_id = 2) — 5 products
            {"2","Industrial Sensor Kit","Temperature and humidity sensors for factories","499.99","30","/images/products/sensor-kit.jpg"},
            {"2","PLC Controller","Programmable logic controller","899.99","20","/images/products/plc.jpg"},
            {"2","Industrial Gateway","IoT protocol gateway for factory networks","349.99","25","/images/products/gateway.jpg"},
            {"2","Vibration Sensor","Predictive maintenance vibration sensor","219.99","40","/images/products/vibration.jpg"},
            {"2","Machine Vision System","AI-powered quality inspection camera","1299.99","10","/images/products/machine-vision.jpg"},
            // Agriculture (category_id = 3) — 4 products
            {"3","Soil Moisture Monitor","IoT soil monitoring system","199.99","75","/images/products/soil-monitor.jpg"},
            {"3","Smart Irrigation System","Automated watering system","399.99","40","/images/products/irrigation.jpg"},
            {"3","Weather Station","Farm-grade IoT weather monitoring","279.99","35","/images/products/weather-station.jpg"},
            {"3","Drone Crop Monitor","Autonomous crop scouting drone","2499.99","8","/images/products/drone.jpg"},
            // Warehouse (category_id = 4) — 4 products
            {"4","RFID Scanner","Handheld RFID inventory scanner","249.99","60","/images/products/rfid.jpg"},
            {"4","Warehouse Robot","Automated inventory robot","4999.99","5","/images/products/robot.jpg"},
            {"4","Smart Shelf System","Weight-based inventory tracking shelf","599.99","15","/images/products/shelf.jpg"},
            {"4","Barcode Printer","Industrial IoT barcode label printer","389.99","30","/images/products/printer.jpg"},
            // Healthcare (category_id = 5) — 4 products
            {"5","Heart Rate Monitor","Wearable heart rate tracker","99.99","150","/images/products/heart-monitor.jpg"},
            {"5","Blood Pressure Monitor","Connected blood pressure cuff","139.99","90","/images/products/bp-monitor.jpg"},
            {"5","Smart Pill Dispenser","Automated medication reminder device","179.99","55","/images/products/pill-dispenser.jpg"},
            {"5","Patient Tracker","Real-time patient location badge","89.99","200","/images/products/tracker.jpg"},
            // Energy (category_id = 6) — 3 products
            {"6","Smart Meter","Real-time energy monitoring","179.99","80","/images/products/smart-meter.jpg"},
            {"6","Solar Controller","IoT solar panel monitoring system","249.99","45","/images/products/solar.jpg"},
            {"6","EV Charging Station","Smart electric vehicle charger","799.99","20","/images/products/ev-charger.jpg"}
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
                        "role TEXT NOT NULL DEFAULT 'customer', " +
                        "isActive BOOLEAN NOT NULL DEFAULT 1, " +
                        "customerType TEXT DEFAULT 'individual', " +
                        "position TEXT DEFAULT NULL" +
                        ")";

                try (Statement createStmt = connection.createStatement()) {
                    createStmt.execute(createTableQuery);
                    System.out.println("[DatabaseInitializer] Users table created successfully.");
                    logger.log(Level.INFO, "Users table created");
                }
            } else {
                System.out.println("[DatabaseInitializer] Users table already exists.");
                // Add new columns if they don't exist (safe ALTER TABLE for SQLite)
                addColumnIfNotExists(connection, "Users", "customerType", "TEXT DEFAULT 'individual'");
                addColumnIfNotExists(connection, "Users", "position", "TEXT DEFAULT NULL");
            }
        }
        // Create shipment table if it doesn't exist
        createShipmentTable(connection);
    }

    private static void addColumnIfNotExists(Connection connection, String table, String column, String definition) {
        try {
            String checkCol = "SELECT " + column + " FROM " + table + " LIMIT 1";
            try (Statement s = connection.createStatement()) {
                s.execute(checkCol); // If this succeeds, column already exists
            }
        } catch (SQLException e) {
            // Column doesn't exist, add it
            try (Statement s = connection.createStatement()) {
                s.execute("ALTER TABLE " + table + " ADD COLUMN " + column + " " + definition);
                System.out.println("[DatabaseInitializer] Added column " + column + " to " + table);
            } catch (SQLException ex) {
                System.err.println("[DatabaseInitializer] Warning: Could not add column " + column + ": " + ex.getMessage());
            }
        }
    }

    private static void createShipmentTable(Connection connection) throws SQLException {
        String checkTableQuery = "SELECT name FROM sqlite_master WHERE type='table' AND name='shipment'";
        try (Statement stmt = connection.createStatement();
                ResultSet rs = stmt.executeQuery(checkTableQuery)) {
            if (!rs.next()) {
                String createSql = "CREATE TABLE IF NOT EXISTS shipment (" +
                        "shipment_id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                        "order_id INTEGER NOT NULL, " +
                        "address_id INTEGER, " +
                        "shipping_date TEXT, " +
                        "delivery_date TEXT, " +
                        "shipping_status TEXT DEFAULT 'PENDING', " +
                        "tracking_number TEXT, " +
                        "carrier TEXT, " +
                        "notes TEXT, " +
                        "created_at TEXT, " +
                        "updated_at TEXT, " +
                        "FOREIGN KEY (order_id) REFERENCES \"order\"(order_id)" +
                        ")";
                try (Statement createStmt = connection.createStatement()) {
                    createStmt.execute(createSql);
                    System.out.println("[DatabaseInitializer] Shipment table created successfully.");
                    logger.log(Level.INFO, "Shipment table created");
                }
            } else {
                System.out.println("[DatabaseInitializer] Shipment table already exists.");
            }
        }
    }

    private static void seedOrders(Connection connection) throws SQLException {
        // Check if "order" table exists
        String checkTable = "SELECT name FROM sqlite_master WHERE type='table' AND name='order'";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(checkTable)) {
            if (!rs.next()) return; // table doesn't exist yet
        }
        String checkQuery = "SELECT COUNT(*) FROM \"order\"";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(checkQuery)) {
            if (rs.next() && rs.getInt(1) > 0) return;
        }
        // Sample orders: user_id 1 (customer) and 2 (staff test), various statuses
        String[][] orders = {
            {"1","2025-01-10 09:00:00","Pending","299.99"},
            {"1","2025-01-15 10:30:00","Processing","149.99"},
            {"1","2025-02-01 14:00:00","Shipped","529.98"},
            {"1","2025-02-14 16:00:00","Delivered","29.99"},
            {"1","2025-03-01 08:00:00","cancelled","499.99"},
            {"1","2025-03-15 11:00:00","Pending","899.99"},
            {"1","2025-04-01 13:00:00","Processing","199.99"},
            {"1","2025-04-20 09:30:00","Delivered","399.99"},
            {"1","2025-05-01 15:00:00","Pending","249.99"},
            {"1","2025-05-10 10:00:00","Shipped","4999.99"},
            {"2","2025-01-20 09:00:00","Delivered","99.99"},
            {"2","2025-02-05 11:00:00","Pending","179.99"},
            {"2","2025-02-20 14:30:00","Processing","349.98"},
            {"2","2025-03-10 08:30:00","Shipped","149.99"},
            {"2","2025-03-25 16:00:00","cancelled","299.99"},
            {"2","2025-04-05 10:00:00","Delivered","899.99"},
            {"2","2025-04-15 12:00:00","Pending","199.99"},
            {"2","2025-05-05 09:00:00","Processing","499.99"},
            {"2","2025-05-12 14:00:00","Shipped","179.99"},
            {"2","2025-05-18 11:00:00","Pending","599.99"}
        };
        String insertSql = "INSERT INTO \"order\" (user_id, order_date, status, total_amount, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?)";
        for (String[] o : orders) {
            try (PreparedStatement ps = connection.prepareStatement(insertSql)) {
                ps.setInt(1, Integer.parseInt(o[0]));
                ps.setString(2, o[1]);
                ps.setString(3, o[2]);
                ps.setDouble(4, Double.parseDouble(o[3]));
                ps.setString(5, o[1]);
                ps.setString(6, o[1]);
                ps.executeUpdate();
            }
        }
        logger.log(Level.INFO, "Sample orders seeded: " + orders.length);
    }

    private static void seedPayments(Connection connection) throws SQLException {
        String checkTable = "SELECT name FROM sqlite_master WHERE type='table' AND name='payment'";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(checkTable)) {
            if (!rs.next()) return;
        }
        String checkQuery = "SELECT COUNT(*) FROM payment";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(checkQuery)) {
            if (rs.next() && rs.getInt(1) > 0) return;
        }
        String[][] payments = {
            {"1","1","299.99","Credit Card","COMPLETED","2025-01-10 09:05:00"},
            {"1","2","149.99","PayPal","COMPLETED","2025-01-15 10:35:00"},
            {"1","3","529.98","Credit Card","COMPLETED","2025-02-01 14:05:00"},
            {"1","4","29.99","Debit Card","COMPLETED","2025-02-14 16:05:00"},
            {"1","6","899.99","Credit Card","PENDING","2025-03-15 11:05:00"},
            {"1","7","199.99","PayPal","PENDING","2025-04-01 13:05:00"},
            {"1","8","399.99","Credit Card","COMPLETED","2025-04-20 09:35:00"},
            {"1","9","249.99","Debit Card","PENDING","2025-05-01 15:05:00"},
            {"1","10","4999.99","Credit Card","PENDING","2025-05-10 10:05:00"},
            {"1","11","99.99","Credit Card","COMPLETED","2025-01-20 09:05:00"},
            {"2","12","179.99","PayPal","PENDING","2025-02-05 11:05:00"},
            {"2","13","349.98","Credit Card","PENDING","2025-02-20 14:35:00"},
            {"2","14","149.99","Debit Card","COMPLETED","2025-03-10 08:35:00"},
            {"2","16","899.99","Credit Card","COMPLETED","2025-04-05 10:05:00"},
            {"2","17","199.99","PayPal","PENDING","2025-04-15 12:05:00"},
            {"2","18","499.99","Credit Card","PENDING","2025-05-05 09:05:00"},
            {"2","19","179.99","Debit Card","PENDING","2025-05-12 14:05:00"},
            {"2","20","599.99","Credit Card","PENDING","2025-05-18 11:05:00"},
            {"1","1","299.99","PayPal","COMPLETED","2025-01-10 09:10:00"},
            {"2","11","99.99","Debit Card","COMPLETED","2025-01-20 09:10:00"}
        };
        String insertSql = "INSERT INTO payment (user_id, order_id, amount, payment_method, status, payment_date) VALUES (?, ?, ?, ?, ?, ?)";
        for (String[] p : payments) {
            try (PreparedStatement ps = connection.prepareStatement(insertSql)) {
                ps.setInt(1, Integer.parseInt(p[0]));
                ps.setInt(2, Integer.parseInt(p[1]));
                ps.setDouble(3, Double.parseDouble(p[2]));
                ps.setString(4, p[3]);
                ps.setString(5, p[4]);
                ps.setString(6, p[5]);
                ps.executeUpdate();
            } catch (SQLException e) {
                // Skip if payment table schema differs
                logger.log(Level.WARNING, "Could not seed payment: " + e.getMessage());
            }
        }
        logger.log(Level.INFO, "Sample payments seeded");
    }

    private static void seedAccessLogs(Connection connection) throws SQLException {
        String checkTable = "SELECT name FROM sqlite_master WHERE type='table' AND name='access_log'";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(checkTable)) {
            if (!rs.next()) return;
        }
        String checkQuery = "SELECT COUNT(*) FROM access_log";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(checkQuery)) {
            if (rs.next() && rs.getInt(1) > 0) return;
        }
        String[][] logs = {
            {"1","2025-01-10 09:00:00","2025-01-10 09:45:00"},
            {"1","2025-01-15 10:30:00","2025-01-15 11:00:00"},
            {"1","2025-02-01 14:00:00","2025-02-01 14:30:00"},
            {"1","2025-02-14 16:00:00","2025-02-14 16:20:00"},
            {"1","2025-03-01 08:00:00","2025-03-01 08:50:00"},
            {"1","2025-03-15 11:00:00","2025-03-15 11:30:00"},
            {"1","2025-04-01 13:00:00","2025-04-01 13:45:00"},
            {"1","2025-04-20 09:30:00","2025-04-20 10:00:00"},
            {"1","2025-05-01 15:00:00","2025-05-01 15:30:00"},
            {"1","2025-05-10 10:00:00","2025-05-10 10:45:00"},
            {"1","2025-05-15 09:00:00","2025-05-15 09:30:00"},
            {"1","2025-05-20 14:00:00","2025-05-20 14:25:00"},
            {"2","2025-01-20 09:00:00","2025-01-20 09:30:00"},
            {"2","2025-02-05 11:00:00","2025-02-05 11:45:00"},
            {"2","2025-02-20 14:30:00","2025-02-20 15:00:00"},
            {"2","2025-03-10 08:30:00","2025-03-10 09:00:00"},
            {"2","2025-03-25 16:00:00","2025-03-25 16:30:00"},
            {"2","2025-04-05 10:00:00","2025-04-05 10:45:00"},
            {"2","2025-04-15 12:00:00","2025-04-15 12:30:00"},
            {"2","2025-05-05 09:00:00","2025-05-05 09:45:00"},
            {"2","2025-05-12 14:00:00","2025-05-12 14:30:00"},
            {"2","2025-05-18 11:00:00","2025-05-18 11:45:00"},
            {"3","2025-04-01 09:00:00","2025-04-01 09:20:00"},
            {"3","2025-05-01 10:00:00","2025-05-01 10:30:00"},
            {"3","2025-05-20 15:00:00","2025-05-20 15:20:00"}
        };
        String insertSql = "INSERT INTO access_log (user_id, login_time, logout_time) VALUES (?, ?, ?)";
        for (String[] l : logs) {
            try (PreparedStatement ps = connection.prepareStatement(insertSql)) {
                ps.setInt(1, Integer.parseInt(l[0]));
                ps.setString(2, l[1]);
                ps.setString(3, l[2]);
                ps.executeUpdate();
            } catch (SQLException e) {
                logger.log(Level.WARNING, "Could not seed access log: " + e.getMessage());
            }
        }
        logger.log(Level.INFO, "Sample access logs seeded");
    }

    private static void seedTestUsers(Connection connection) throws SQLException {
        LocalDateTime now = LocalDateTime.now();
        // Use DB format: "yyyy-MM-dd HH:mm:ss" instead of ISO format
        String nowStr = now.format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        // Test users to seed (22 users: 15 customers, 5 staff, 2 admin)
        String[][] testUsers = {
            {"customer@iotbay.com","password123","Customer","User","+61 400 000 001","2000","1 George St","Sydney NSW","1990-01-01","Card","customer"},
            {"staff@iotbay.com","staff123","Staff","User","+61 400 000 002","2001","2 Pitt St","Sydney NSW","1992-05-15","PayPal","staff"},
            {"staff123@iotbay.com","staff123","Staff","Member","+61 400 000 005","2001","2 Pitt St","Sydney NSW","1992-05-15","PayPal","staff"},
            {"alice.smith@example.com","pass1234","Alice","Smith","+61 411 111 001","2010","10 Park Rd","Melbourne VIC","1988-03-22","Card","customer"},
            {"bob.jones@example.com","pass1234","Bob","Jones","+61 411 111 002","2011","20 Queen St","Brisbane QLD","1975-07-14","PayPal","customer"},
            {"carol.white@example.com","pass1234","Carol","White","+61 411 111 003","2012","30 King Ave","Perth WA","1995-11-05","Debit","customer"},
            {"david.brown@example.com","pass1234","David","Brown","+61 411 111 004","2013","40 Main Blvd","Adelaide SA","1982-04-18","Card","customer"},
            {"emma.davis@example.com","pass1234","Emma","Davis","+61 411 111 005","2014","50 River Dr","Hobart TAS","1993-09-30","PayPal","customer"},
            {"frank.wilson@example.com","pass1234","Frank","Wilson","+61 411 111 006","2015","60 Hill St","Darwin NT","1970-12-01","Card","customer"},
            {"grace.moore@example.com","pass1234","Grace","Moore","+61 411 111 007","2016","70 Bay Rd","Canberra ACT","1998-02-14","Debit","customer"},
            {"harry.taylor@example.com","pass1234","Harry","Taylor","+61 411 111 008","2017","80 Ocean Ave","Sydney NSW","1985-06-25","Card","customer"},
            {"iris.anderson@example.com","pass1234","Iris","Anderson","+61 411 111 009","2018","90 Forest Ln","Melbourne VIC","1991-08-09","PayPal","customer"},
            {"jack.thomas@example.com","pass1234","Jack","Thomas","+61 411 111 010","2019","100 Desert Rd","Alice Springs NT","1978-01-20","Card","customer"},
            {"karen.jackson@example.com","pass1234","Karen","Jackson","+61 411 111 011","2020","110 Lake Dr","Geelong VIC","1987-10-03","Debit","customer"},
            {"liam.harris@example.com","pass1234","Liam","Harris","+61 411 111 012","2021","120 Mountain St","Cairns QLD","1994-05-16","Card","customer"},
            {"mia.martin@example.com","pass1234","Mia","Martin","+61 411 111 013","2022","130 Valley Rd","Townsville QLD","2000-03-28","PayPal","customer"},
            {"noah.garcia@example.com","pass1234","Noah","Garcia","+61 411 111 014","2023","140 Coast Blvd","Gold Coast QLD","1996-07-11","Card","customer"},
            {"olivia.lee@example.com","pass1234","Olivia","Lee","+61 411 111 015","2000","150 Suburb St","Wollongong NSW","1999-12-24","Debit","customer"},
            {"staff2@iotbay.com","staff123","Senior","Staff","+61 422 000 001","2001","5 Tech Park","Sydney NSW","1980-04-10","PayPal","staff"},
            {"staff3@iotbay.com","staff123","Tech","Support","+61 422 000 002","2002","6 IT Blvd","Sydney NSW","1985-08-22","Card","staff"},
            {"admin@iotbay.com","admin123","System","Admin","+61 499 000 001","2000","1 Admin Hq","Sydney NSW","1975-01-01","Card","staff"},
            {"admin2@iotbay.com","admin123","Deputy","Admin","+61 499 000 002","2000","2 Admin Hq","Sydney NSW","1978-06-15","PayPal","staff"}
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

    // ─── New table creation methods (plural names used by newer DAOs) ───────────

    /** Creates 'orders' table (plural) used by OrderDAOImpl. */
    private static void createOrdersTable(Connection connection) throws SQLException {
        String sql = "CREATE TABLE IF NOT EXISTS orders (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "user_id INTEGER NOT NULL, " +
                "total_amount REAL NOT NULL DEFAULT 0, " +
                "order_date TEXT DEFAULT (datetime('now')), " +
                "status TEXT NOT NULL DEFAULT 'pending', " +
                "shipping_address TEXT, " +
                "payment_method TEXT, " +
                "created_at TEXT DEFAULT (datetime('now')), " +
                "updated_at TEXT DEFAULT (datetime('now'))" +
                ")";
        try (Statement stmt = connection.createStatement()) {
            stmt.execute(sql);
            logger.log(Level.INFO, "orders table created/verified");
        }
    }

    /** Creates 'order_product' line-item table used by OrderProductDAO (was missing). */
    private static void createOrderProductTable(Connection connection) throws SQLException {
        String sql = "CREATE TABLE IF NOT EXISTS order_product (" +
                "orderID INTEGER NOT NULL, " +
                "productID INTEGER NOT NULL, " +
                "quantity INTEGER NOT NULL DEFAULT 1, " +
                "priceAtOrderTime REAL NOT NULL DEFAULT 0, " +
                "PRIMARY KEY (orderID, productID), " +
                "FOREIGN KEY (orderID) REFERENCES orders(id), " +
                "FOREIGN KEY (productID) REFERENCES products(id)" +
                ")";
        try (Statement stmt = connection.createStatement()) {
            stmt.execute(sql);
            logger.log(Level.INFO, "order_product table created/verified");
        }
    }

    /** Creates 'payment' and 'payment_detail' tables used by the checkout flow (were missing). */
    private static void createPaymentTables(Connection connection) throws SQLException {
        String payment = "CREATE TABLE IF NOT EXISTS payment (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "user_id INTEGER NOT NULL, " +
                "order_id INTEGER, " +
                "payment_date TEXT DEFAULT (datetime('now')), " +
                "amount REAL NOT NULL DEFAULT 0, " +
                "payment_method TEXT, " +
                "status TEXT NOT NULL DEFAULT 'completed', " +
                "created_at TEXT DEFAULT (datetime('now')), " +
                "updated_at TEXT DEFAULT (datetime('now'))" +
                ")";
        String detail = "CREATE TABLE IF NOT EXISTS payment_detail (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "payment_id INTEGER, " +
                "user_id INTEGER, " +
                "card_holder_name TEXT, " +
                "card_number TEXT, " +
                "expiry_date TEXT, " +
                "card_type TEXT, " +
                "is_default INTEGER DEFAULT 0, " +
                "created_at TEXT DEFAULT (datetime('now')), " +
                "updated_at TEXT DEFAULT (datetime('now'))" +
                ")";
        try (Statement stmt = connection.createStatement()) {
            stmt.execute(payment);
            stmt.execute(detail);
            logger.log(Level.INFO, "payment / payment_detail tables created/verified");
        }
    }

    /** Creates 'cart_items' table used by CartItemDAOImpl (was previously missing). */
    private static void createCartItemsTable(Connection connection) throws SQLException {
        String sql = "CREATE TABLE IF NOT EXISTS cart_items (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "user_id INTEGER NOT NULL, " +
                "product_id INTEGER NOT NULL, " +
                "quantity INTEGER NOT NULL DEFAULT 1, " +
                "price REAL NOT NULL DEFAULT 0, " +
                "added_at TEXT DEFAULT (datetime('now')), " +
                "updated_at TEXT DEFAULT (datetime('now')), " +
                "FOREIGN KEY (user_id) REFERENCES Users(id), " +
                "FOREIGN KEY (product_id) REFERENCES products(id)" +
                ")";
        try (Statement stmt = connection.createStatement()) {
            stmt.execute(sql);
            logger.log(Level.INFO, "cart_items table created/verified");
        }
    }

    /** Creates 'suppliers' table used by SupplierDAOImpl. */
    private static void createSuppliersTable(Connection connection) throws SQLException {
        String sql = "CREATE TABLE IF NOT EXISTS suppliers (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "contact_name TEXT, " +
                "company_name TEXT NOT NULL, " +
                "email TEXT, " +
                "phone_number TEXT, " +
                "address_line1 TEXT, " +
                "address_line2 TEXT, " +
                "city TEXT, " +
                "state TEXT, " +
                "postal_code TEXT, " +
                "country TEXT, " +
                "website TEXT, " +
                "supplier_type TEXT DEFAULT 'general', " +
                "is_active INTEGER DEFAULT 1, " +
                "created_at TEXT DEFAULT (datetime('now')), " +
                "updated_at TEXT DEFAULT (datetime('now'))" +
                ")";
        try (Statement stmt = connection.createStatement()) {
            stmt.execute(sql);
            logger.log(Level.INFO, "suppliers table created/verified");
        }
    }

    /** Creates 'access_logs' table (plural) used by AccessLogDAOImpl. */
    private static void createAccessLogsTable(Connection connection) throws SQLException {
        String sql = "CREATE TABLE IF NOT EXISTS access_logs (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "user_id INTEGER, " +
                "action TEXT, " +
                "timestamp TEXT DEFAULT (datetime('now'))" +
                ")";
        try (Statement stmt = connection.createStatement()) {
            stmt.execute(sql);
            logger.log(Level.INFO, "access_logs table created/verified");
        }
    }

    /** Seeds sample rows into the 'orders' (plural) table. */
    private static void seedOrdersTable(Connection connection) throws SQLException {
        String checkQuery = "SELECT COUNT(*) FROM orders";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(checkQuery)) {
            if (rs.next() && rs.getInt(1) > 0) return; // already seeded
        }
        String[][] rows = {
            {"1","2025-01-10 09:00:00","pending","299.99","123 Main St","Credit Card"},
            {"1","2025-02-01 14:00:00","shipped","529.98","123 Main St","Credit Card"},
            {"1","2025-03-01 08:00:00","cancelled","499.99","123 Main St","PayPal"},
            {"1","2025-04-20 09:30:00","delivered","399.99","123 Main St","Debit Card"},
            {"1","2025-05-01 15:00:00","pending","249.99","123 Main St","Credit Card"},
            {"2","2025-01-20 09:00:00","delivered","99.99","456 King St","PayPal"},
            {"2","2025-02-05 11:00:00","pending","179.99","456 King St","Credit Card"},
            {"2","2025-04-05 10:00:00","delivered","899.99","456 King St","Credit Card"},
        };
        String insertSql = "INSERT INTO orders (user_id, order_date, status, total_amount, shipping_address, payment_method) VALUES (?, ?, ?, ?, ?, ?)";
        for (String[] r : rows) {
            try (PreparedStatement ps = connection.prepareStatement(insertSql)) {
                ps.setInt(1, Integer.parseInt(r[0]));
                ps.setString(2, r[1]);
                ps.setString(3, r[2]);
                ps.setDouble(4, Double.parseDouble(r[3]));
                ps.setString(5, r[4]);
                ps.setString(6, r[5]);
                ps.executeUpdate();
            } catch (SQLException e) {
                logger.log(Level.WARNING, "Could not seed orders row: " + e.getMessage());
            }
        }
        logger.log(Level.INFO, "Sample orders seeded into 'orders' table");
    }

    /** Seeds sample rows into the 'suppliers' table. */
    private static void seedSuppliersTable(Connection connection) throws SQLException {
        String checkQuery = "SELECT COUNT(*) FROM suppliers";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(checkQuery)) {
            if (rs.next() && rs.getInt(1) > 0) return;
        }
        String[][] rows = {
            {"Tech Supplies Co","John Smith","john@techsupplies.com","+61 2 9000 1111","manufacturer"},
            {"IoT Components Ltd","Jane Doe","jane@iotcomponents.com","+61 2 9000 2222","distributor"},
            {"Smart Systems Pty","Bob Lee","bob@smartsystems.com","+61 2 9000 3333","wholesaler"},
        };
        String insertSql = "INSERT INTO suppliers (company_name, contact_name, email, phone_number, supplier_type) VALUES (?, ?, ?, ?, ?)";
        for (String[] r : rows) {
            try (PreparedStatement ps = connection.prepareStatement(insertSql)) {
                ps.setString(1, r[0]);
                ps.setString(2, r[1]);
                ps.setString(3, r[2]);
                ps.setString(4, r[3]);
                ps.setString(5, r[4]);
                ps.executeUpdate();
            } catch (SQLException e) {
                logger.log(Level.WARNING, "Could not seed supplier row: " + e.getMessage());
            }
        }
        logger.log(Level.INFO, "Sample suppliers seeded");
    }

    /** Seeds sample rows into the 'access_logs' (plural) table. */
    private static void seedAccessLogsTable(Connection connection) throws SQLException {
        String checkQuery = "SELECT COUNT(*) FROM access_logs";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(checkQuery)) {
            if (rs.next() && rs.getInt(1) > 0) return;
        }
        String[][] rows = {
            {"1","LOGIN","2025-05-01 09:00:00"},
            {"1","LOGOUT","2025-05-01 09:45:00"},
            {"1","LOGIN","2025-05-10 10:00:00"},
            {"1","LOGOUT","2025-05-10 10:30:00"},
            {"2","LOGIN","2025-05-01 08:00:00"},
            {"2","LOGOUT","2025-05-01 08:50:00"},
            {"2","LOGIN","2025-05-15 14:00:00"},
            {"2","LOGOUT","2025-05-15 14:30:00"},
        };
        String insertSql = "INSERT INTO access_logs (user_id, action, timestamp) VALUES (?, ?, ?)";
        for (String[] r : rows) {
            try (PreparedStatement ps = connection.prepareStatement(insertSql)) {
                ps.setInt(1, Integer.parseInt(r[0]));
                ps.setString(2, r[1]);
                ps.setString(3, r[2]);
                ps.executeUpdate();
            } catch (SQLException e) {
                logger.log(Level.WARNING, "Could not seed access_logs row: " + e.getMessage());
            }
        }
        logger.log(Level.INFO, "Sample access_logs seeded");
    }

    /** Seeds 20 sample shipment records into the shipment table. */
    private static void seedShipments(Connection connection) throws SQLException {
        String checkTable = "SELECT name FROM sqlite_master WHERE type='table' AND name='shipment'";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(checkTable)) {
            if (!rs.next()) return;
        }
        String checkCount = "SELECT COUNT(*) FROM shipment";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(checkCount)) {
            if (rs.next() && rs.getInt(1) > 0) return; // already seeded
        }
        // order_id, tracking_number, carrier, shipping_status, shipping_date, delivery_date, notes
        String[][] shipments = {
            {"1", "TRK-AUS-001", "Australia Post", "DELIVERED",  "2025-01-12", "2025-01-15", "Delivered on time"},
            {"2", "TRK-AUS-002", "FedEx",          "DELIVERED",  "2025-01-13", "2025-01-16", "Standard delivery"},
            {"3", "TRK-AUS-003", "DHL",             "SHIPPED",    "2025-01-20", null,          "In transit"},
            {"4", "TRK-AUS-004", "Australia Post",  "SHIPPED",    "2025-01-21", null,          "Express post"},
            {"5", "TRK-AUS-005", "StarTrack",       "PREPARING",  "2025-01-25", null,          "Packing in progress"},
            {"6", "TRK-AUS-006", "FedEx",           "DELIVERED",  "2025-02-01", "2025-02-04", "Left at door"},
            {"7", "TRK-AUS-007", "DHL",             "DELIVERED",  "2025-02-03", "2025-02-06", "Signature required"},
            {"8", "TRK-AUS-008", "Australia Post",  "SHIPPED",    "2025-02-10", null,          "On the way"},
            {"9", "TRK-AUS-009", "FedEx",           "PREPARING",  "2025-02-15", null,          "Processing order"},
            {"10","TRK-AUS-010", "StarTrack",        "DELIVERED",  "2025-02-18", "2025-02-21", "Delivered to reception"},
            {"11","TRK-AUS-011", "DHL",              "DELIVERED",  "2025-03-01", "2025-03-04", "Next day delivery"},
            {"12","TRK-AUS-012", "Australia Post",   "SHIPPED",    "2025-03-05", null,          "Estimated 3 days"},
            {"13","TRK-AUS-013", "FedEx",            "DELIVERED",  "2025-03-10", "2025-03-13", "Priority mail"},
            {"14","TRK-AUS-014", "StarTrack",        "PREPARING",  "2025-03-15", null,          "Awaiting dispatch"},
            {"15","TRK-AUS-015", "DHL",              "SHIPPED",    "2025-03-20", null,          "International transit"},
            {"16","TRK-AUS-016", "Australia Post",   "DELIVERED",  "2025-04-01", "2025-04-03", "Collected by customer"},
            {"17","TRK-AUS-017", "FedEx",            "DELIVERED",  "2025-04-05", "2025-04-07", "Weekend delivery"},
            {"18","TRK-AUS-018", "StarTrack",        "SHIPPED",    "2025-04-10", null,          "Regional delivery"},
            {"19","TRK-AUS-019", "DHL",              "PREPARING",  "2025-04-15", null,          "Fragile items - handle carefully"},
            {"20","TRK-AUS-020", "Australia Post",   "DELIVERED",  "2025-04-20", "2025-04-22", "Last mile completed"},
        };
        String sql = "INSERT INTO shipment (order_id, tracking_number, carrier, shipping_status, shipping_date, delivery_date, notes, created_at, updated_at) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, datetime('now'), datetime('now'))";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            for (String[] s : shipments) {
                try {
                    ps.setInt(1, Integer.parseInt(s[0]));
                    ps.setString(2, s[1]);
                    ps.setString(3, s[2]);
                    ps.setString(4, s[3]);
                    ps.setString(5, s[4]);
                    ps.setString(6, s[5]); // may be null
                    ps.setString(7, s[6]);
                    ps.executeUpdate();
                } catch (SQLException e) {
                    logger.log(Level.WARNING, "Could not seed shipment row: " + e.getMessage());
                }
            }
        }
        logger.log(Level.INFO, "Sample shipments seeded: 20 records");
    }

    public static void main(String[] args) {
        initialize();
    }
}
