package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import config.AppConfig;

public class DBConnection {
    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        String url = AppConfig.getProperty("db.url", "jdbc:sqlite:iotbay.db");
        String driver = AppConfig.getProperty("db.driver", "org.sqlite.JDBC");

        System.out.println("[DBConnection] Connecting to URL: " + url);
        System.out.println("[DBConnection] Using driver: " + driver);
        // Print absolute path if it's a file URL
        if (url.startsWith("jdbc:sqlite:")) {
            String path = url.substring("jdbc:sqlite:".length());
            java.io.File dbFile = new java.io.File(path);
            System.out.println("[DBConnection] Database file absolute path: " + dbFile.getAbsolutePath());
            System.out.println("[DBConnection] Database file exists: " + dbFile.exists());
        }

        Class.forName(driver);
        return DriverManager.getConnection(url);
    }
}
