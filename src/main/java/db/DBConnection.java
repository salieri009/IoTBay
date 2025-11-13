package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import config.AppConfig;

public class DBConnection {
    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        String url = AppConfig.getProperty("db.url", "jdbc:sqlite:iotbay.db");
        String driver = AppConfig.getProperty("db.driver", "org.sqlite.JDBC");
        
        Class.forName(driver);
        return DriverManager.getConnection(url);
    }
}
