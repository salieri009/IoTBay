package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import config.DIContainer;

/**
 * Utility to insert test users into the database
 */
public class InsertTestUsers {

    public static void main(String[] args) {
        try {
            Connection conn = DIContainer.getConnection();

            System.out.println("=== Inserting Test Users ===\n");

            // Test user data
            String[][] users = {
                    { "customer@iotbay.com", "6ZvrBCHRNlbPXhAo7mfiVA==$6oMRVQgjsIOfKTAdViTk9P8LvovzqWgcJcDvtsSRdAc=",
                            "John", "Doe", "+1-555-0101", "10001", "123 Main Street", "New York", "NY", "US",
                            "1990-01-15", "Credit Card", "customer" },
                    { "staff@iotbay.com", "JNFcWlULWtVEp8W1CQAj/Q==$cNFmDPjy/aoVxG7iKSUnyatXdCVUNumJE52UktDfiFU=",
                            "Jane", "Smith", "+1-555-0102", "10002", "456 Oak Avenue", "Brooklyn", "NY", "US",
                            "1985-05-20", "Debit Card", "staff" },
                    { "admin@iotbay.com", "AHumHVDk29IxboBBSXbjJQ==$YmURXvUmOkWR5mF5Vb2RZvws9q36RMFbr8UuwUxVGUY=",
                            "Alice", "Johnson", "+1-555-0103", "10003", "789 Pine Road", "Manhattan", "NY", "US",
                            "1980-12-10", "PayPal", "admin" }
            };

            String insertSQL = "INSERT INTO User (email, password, firstName, lastName, phoneNumber, postalCode, " +
                    "addressLine1, city, state, country, dateOfBirth, paymentMethod, role, isActive) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 1)";

            PreparedStatement pstmt = conn.prepareStatement(insertSQL);

            for (String[] user : users) {
                try {
                    pstmt.setString(1, user[0]); // email
                    pstmt.setString(2, user[1]); // password
                    pstmt.setString(3, user[2]); // firstName
                    pstmt.setString(4, user[3]); // lastName
                    pstmt.setString(5, user[4]); // phoneNumber
                    pstmt.setString(6, user[5]); // postalCode
                    pstmt.setString(7, user[6]); // addressLine1
                    pstmt.setString(8, user[7]); // city
                    pstmt.setString(9, user[8]); // state
                    pstmt.setString(10, user[9]); // country
                    pstmt.setString(11, user[10]); // dateOfBirth
                    pstmt.setString(12, user[11]); // paymentMethod
                    pstmt.setString(13, user[12]); // role

                    pstmt.executeUpdate();
                    System.out.println("✓ Created user: " + user[0] + " (role: " + user[12] + ")");
                } catch (SQLException e) {
                    if (e.getMessage().contains("UNIQUE constraint failed")) {
                        System.out.println("⚠ User already exists: " + user[0]);
                    } else {
                        System.err.println("✗ Error creating user " + user[0] + ": " + e.getMessage());
                    }
                }
            }

            pstmt.close();

            // Verify the insertions
            System.out.println("\n=== Verifying Users ===\n");
            String selectSQL = "SELECT id, email, firstName, lastName, role, isActive, createdAt " +
                    "FROM User " +
                    "WHERE email IN ('customer@iotbay.com', 'staff@iotbay.com', 'admin@iotbay.com')";

            PreparedStatement selectStmt = conn.prepareStatement(selectSQL);
            ResultSet rs = selectStmt.executeQuery();

            while (rs.next()) {
                System.out.println("ID: " + rs.getInt("id") +
                        ", Email: " + rs.getString("email") +
                        ", Name: " + rs.getString("firstName") + " " + rs.getString("lastName") +
                        ", Role: " + rs.getString("role") +
                        ", Active: " + rs.getBoolean("isActive"));
            }

            rs.close();
            selectStmt.close();
            conn.close();

            System.out.println("\n=== Test User Credentials ===");
            System.out.println("Customer: customer@iotbay.com / Customer123!");
            System.out.println("Staff:    staff@iotbay.com / Staff123!");
            System.out.println("Admin:    admin@iotbay.com / Admin123!");

        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
