package utils;

import org.junit.Test;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import db.DBConnection;
import config.AppConfig;

public class DatabaseTest {

    @Test
    public void testDatabaseInitialization() {
        try {
            System.out.println("=== Starting Database Test ===");

            // 1. Initialize Database
            System.out.println("Initializing database...");
            DatabaseInitializer.initialize();

            // 2. Verify Connection
            System.out.println("Verifying connection...");
            try (Connection conn = DBConnection.getConnection()) {
                System.out.println("Connection successful: " + conn.getMetaData().getURL());

                // 3. Verify Tables
                String[] tables = { "categories", "products", "Users" };
                for (String table : tables) {
                    verifyTableExists(conn, table);
                }

                // 4. Verify Data
                verifyData(conn, "categories");
                verifyData(conn, "products");
                verifyData(conn, "Users");
            }

            System.out.println("=== Database Test Completed Successfully ===");

        } catch (Exception e) {
            System.err.println("=== Database Test FAILED ===");
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    private void verifyTableExists(Connection conn, String tableName) throws Exception {
        String query = "SELECT name FROM sqlite_master WHERE type='table' AND name='" + tableName + "'";
        try (Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                System.out.println("Table '" + tableName + "' exists.");
            } else {
                throw new RuntimeException("Table '" + tableName + "' does NOT exist!");
            }
        }
    }

    private void verifyData(Connection conn, String tableName) throws Exception {
        String query = "SELECT COUNT(*) FROM " + tableName;
        try (Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("Table '" + tableName + "' has " + count + " rows.");
                if (count == 0) {
                    System.err.println("WARNING: Table '" + tableName + "' is empty!");
                }
            }
        }
    }
}
