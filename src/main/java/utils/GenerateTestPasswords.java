package utils;

/**
 * Utility to generate password hashes for test users
 * Run this to get the hashed passwords, then use them in the SQL insert
 * statements
 */
public class GenerateTestPasswords {

    public static void main(String[] args) {
        String[] passwords = {
                "Customer123!",
                "Staff123!",
                "Admin123!"
        };

        String[] accounts = {
                "customer@iotbay.com",
                "staff@iotbay.com",
                "admin@iotbay.com"
        };

        System.out.println("=== IoTBay Test User Password Hashes ===\n");

        for (int i = 0; i < passwords.length; i++) {
            try {
                String hash = PasswordUtil.hashPassword(passwords[i]);
                System.out.println(accounts[i]);
                System.out.println("Password: " + passwords[i]);
                System.out.println("Hash: " + hash);
                System.out.println();
            } catch (Exception e) {
                System.err.println("Error hashing password for " + accounts[i] + ": " + e.getMessage());
            }
        }

        System.out.println("\n=== SQL INSERT Statements ===\n");
        System.out.println("Copy the hashes above and update the SQL script,");
        System.out.println("or run the SQL commands with the generated hashes.");
    }
}
