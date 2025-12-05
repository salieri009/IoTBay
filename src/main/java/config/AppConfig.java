package config;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class AppConfig {
    private static final Properties properties = new Properties();

    static {
        try (InputStream input = AppConfig.class.getClassLoader()
                .getResourceAsStream("application.properties")) {
            if (input != null) {
                properties.load(input);
                System.out.println("[AppConfig] Loaded application.properties successfully.");
            } else {
                System.err.println("[AppConfig] application.properties not found in classpath!");
            }
        } catch (IOException e) {
            System.err.println("[AppConfig] Failed to load application.properties: " + e.getMessage());
            throw new RuntimeException("Failed to load application.properties", e);
        }
    }

    public static String getProperty(String key) {
        return properties.getProperty(key);
    }

    public static String getProperty(String key, String defaultValue) {
        return properties.getProperty(key, defaultValue);
    }

    public static int getIntProperty(String key, int defaultValue) {
        String value = properties.getProperty(key);
        try {
            return value != null ? Integer.parseInt(value) : defaultValue;
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }
}
