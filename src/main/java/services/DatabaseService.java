package services;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseService {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/oceanview?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";
    private static final String DRIVER_CLASS = "com.mysql.cj.jdbc.Driver";

    /**
     * Get database connection
     */
    public Connection getConnection() throws Exception {
        Class.forName(DRIVER_CLASS);
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    /**
     * Validate database connection
     */
    public boolean validateConnection() {
        try {
            Connection conn = getConnection();
            boolean isValid = conn.isValid(2);
            conn.close();
            return isValid;
        } catch (Exception e) {
            System.err.println("Connection validation failed: " + e.getMessage());
            return false;
        }
    }
}
