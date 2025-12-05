import java.sql.*;

public class CheckDB {
    public static void main(String[] args) {
        String url = "jdbc:sqlite:D:/UTS/IoTBayPersonnel/IoTBay/iotbay.db";
        System.out.println("Checking DB at: " + url);

        try (Connection conn = DriverManager.getConnection(url)) {
            DatabaseMetaData meta = conn.getMetaData();
            ResultSet tables = meta.getTables(null, null, "%", new String[] { "TABLE" });

            boolean categoriesFound = false;
            boolean productsFound = false;

            System.out.println("Tables found:");
            while (tables.next()) {
                String tableName = tables.getString("TABLE_NAME");
                System.out.println(" - " + tableName);
                if ("categories".equalsIgnoreCase(tableName))
                    categoriesFound = true;
                if ("products".equalsIgnoreCase(tableName))
                    productsFound = true;
            }

            System.out.println("\nStatus:");
            System.out.println("Categories table: " + (categoriesFound ? "FOUND" : "MISSING"));
            System.out.println("Products table: " + (productsFound ? "FOUND" : "MISSING"));

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
