package com.coderush.dao;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

public class DBConnection {
    private static final Map<String, String> envMap = new HashMap<>();

    static {
        loadEnv();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            try {
                // Fallback for older driver class name if needed
                Class.forName("com.mysql.jdbc.Driver");
            } catch (ClassNotFoundException ex) {
                System.err.println("MySQL JDBC Driver not found: " + ex.getMessage());
            }
        }
    }

    private static void loadEnv() {
        // 1. Try loading .env from classpath
        try (InputStream is = DBConnection.class.getClassLoader().getResourceAsStream(".env")) {
            if (is != null) {
                parseEnvStream(is);
                return;
            }
        } catch (Exception ignored) {
        }

        try (InputStream is = DBConnection.class.getResourceAsStream("/.env")) {
            if (is != null) {
                parseEnvStream(is);
                return;
            }
        } catch (Exception ignored) {
        }

        // 2. Try looking in candidate file system locations
        String[] candidatePaths = {
            System.getenv("DOTENV_PATH"),
            System.getProperty("dotenv.path"),
            "C:/Users/VEDANT/OneDrive/Desktop/java project/CodeRush/.env",
            ".env",
            "../.env",
            "../../.env",
            "../../../.env",
            System.getProperty("catalina.base") + "/webapps/CodeRush/.env",
            System.getProperty("user.dir") + "/.env"
        };

        for (String path : candidatePaths) {
            if (path == null) continue;
            File file = new File(path);
            if (file.exists() && file.isFile()) {
                try (InputStream fis = new FileInputStream(file)) {
                    parseEnvStream(fis);
                    return;
                } catch (Exception e) {
                    System.err.println("Failed to read .env from: " + path + " - " + e.getMessage());
                }
            }
        }
    }

    private static void parseEnvStream(InputStream is) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
            String line;
            while ((line = reader.readLine()) != null) {
                line = line.trim();
                if (line.isEmpty() || line.startsWith("#")) {
                    continue;
                }
                int eqIdx = line.indexOf('=');
                if (eqIdx > 0) {
                    String key = line.substring(0, eqIdx).trim();
                    String value = line.substring(eqIdx + 1).trim();

                    // Strip surrounding quotes if present
                    if ((value.startsWith("\"") && value.endsWith("\"")) ||
                        (value.startsWith("'") && value.endsWith("'"))) {
                        if (value.length() >= 2) {
                            value = value.substring(1, value.length() - 1);
                        }
                    }
                    envMap.put(key, value);
                }
            }
        } catch (Exception e) {
            System.err.println("Error parsing .env stream: " + e.getMessage());
        }
    }

    public static String getEnv(String key, String defaultValue) {
        // Priority: 1. System property, 2. OS Environment variable, 3. .env file, 4. Default value
        String val = System.getProperty(key);
        if (val != null && !val.trim().isEmpty()) {
            return val.trim();
        }

        val = System.getenv(key);
        if (val != null && !val.trim().isEmpty()) {
            return val.trim();
        }

        val = envMap.get(key);
        if (val != null && !val.trim().isEmpty()) {
            return val.trim();
        }

        return defaultValue;
    }

    public static Connection getConnection() throws SQLException {
        String defaultUrl = "jdbc:mysql://localhost:3306/coderush_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
        String url = getEnv("DB_URL", defaultUrl);
        String user = getEnv("DB_USER", "root");
        String password = getEnv("DB_PASSWORD", "");

        return DriverManager.getConnection(url, user, password);
    }
}
