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
                        "role TEXT NOT NULL CHECK(role IN ('customer', 'staff')) DEFAULT 'customer', " +
                        "isActive BOOLEAN NOT NULL DEFAULT 1" +
                        ")";

                try (Statement createStmt = connection.createStatement()) {
                    createStmt.execute(createTableQuery);
                    System.out.println("[DatabaseInitializer] Users table created successfully.");
                    logger.log(Level.INFO, "Users table created");
                }
            } else {
                System.out.println("[DatabaseInitializer] Users table already exists.");
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

    public static void main(String[] args) {
        initialize();
    }
}
