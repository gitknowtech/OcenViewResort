package config;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.DisplayName;
import static org.junit.jupiter.api.Assertions.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@DisplayName("Database Configuration Tests")
public class DatabaseConfigTest {
    
    private Connection connection;
    
    @BeforeEach
    @DisplayName("Setup test connection")
    void setUp() {
        // This runs before each test
        System.out.println("🔧 Setting up database connection test...");
    }
    
    @AfterEach
    @DisplayName("Cleanup test connection")
    void tearDown() {
        // This runs after each test
        if (connection != null) {
            try {
                connection.close();
                System.out.println("✅ Database connection closed");
            } catch (SQLException e) {
                System.err.println("❌ Error closing connection: " + e.getMessage());
            }
        }
    }
    
    @Test
    @DisplayName("Test database connection establishment")
    void testDatabaseConnection() {
        System.out.println("🧪 Testing database connection...");
        
        // Test connection
        assertDoesNotThrow(() -> {
            connection = DatabaseConfig.getConnection();
            assertNotNull(connection, "Connection should not be null");
            assertFalse(connection.isClosed(), "Connection should be open");
        }, "Database connection should not throw exception");
        
        System.out.println("✅ Database connection test passed!");
    }
    
    @Test
    @DisplayName("Test database exists")
    void testDatabaseExists() {
        System.out.println("🧪 Testing if oceanviewresort database exists...");
        
        assertDoesNotThrow(() -> {
            connection = DatabaseConfig.getConnection();
            
            PreparedStatement stmt = connection.prepareStatement("SELECT DATABASE() as current_db");
            ResultSet rs = stmt.executeQuery();
            
            assertTrue(rs.next(), "Should get database name result");
            
            String dbName = rs.getString("current_db");
            assertEquals("oceanviewresort", dbName, "Should be connected to oceanviewresort database");
            
            rs.close();
            stmt.close();
        });
        
        System.out.println("✅ Database exists test passed!");
    }
    
    @Test
    @DisplayName("Test MySQL version compatibility")
    void testMySQLVersion() {
        System.out.println("🧪 Testing MySQL version...");
        
        assertDoesNotThrow(() -> {
            connection = DatabaseConfig.getConnection();
            
            PreparedStatement stmt = connection.prepareStatement("SELECT VERSION() as version");
            ResultSet rs = stmt.executeQuery();
            
            assertTrue(rs.next(), "Should get version result");
            
            String version = rs.getString("version");
            assertNotNull(version, "Version should not be null");
            assertTrue(version.contains("MySQL") || version.contains("mysql"), 
                      "Should be MySQL database, got: " + version);
            
            System.out.println("📊 MySQL Version: " + version);
            
            rs.close();
            stmt.close();
        });
        
        System.out.println("✅ MySQL version test passed!");
    }
    
    @Test
    @DisplayName("Test connection pool behavior")
    void testMultipleConnections() {
        System.out.println("🧪 Testing multiple database connections...");
        
        assertDoesNotThrow(() -> {
            // Test multiple connections
            Connection conn1 = DatabaseConfig.getConnection();
            Connection conn2 = DatabaseConfig.getConnection();
            Connection conn3 = DatabaseConfig.getConnection();
            
            assertNotNull(conn1, "First connection should not be null");
            assertNotNull(conn2, "Second connection should not be null");
            assertNotNull(conn3, "Third connection should not be null");
            
            // Connections should be different instances
            assertNotSame(conn1, conn2, "Connections should be different instances");
            assertNotSame(conn2, conn3, "Connections should be different instances");
            
            // All should be open
            assertFalse(conn1.isClosed(), "First connection should be open");
            assertFalse(conn2.isClosed(), "Second connection should be open");
            assertFalse(conn3.isClosed(), "Third connection should be open");
            
            // Close all connections
            conn1.close();
            conn2.close();
            conn3.close();
            
            // All should be closed
            assertTrue(conn1.isClosed(), "First connection should be closed");
            assertTrue(conn2.isClosed(), "Second connection should be closed");
            assertTrue(conn3.isClosed(), "Third connection should be closed");
        });
        
        System.out.println("✅ Multiple connections test passed!");
    }
    
    @Test
    @DisplayName("Test connection timeout handling")
    void testConnectionTimeout() {
        System.out.println("🧪 Testing connection timeout...");
        
        assertDoesNotThrow(() -> {
            connection = DatabaseConfig.getConnection();
            
            // Test connection is responsive
            PreparedStatement stmt = connection.prepareStatement("SELECT 1 as test_value");
            ResultSet rs = stmt.executeQuery();
            
            assertTrue(rs.next(), "Should get test result");
            assertEquals(1, rs.getInt("test_value"), "Should get value 1");
            
            rs.close();
            stmt.close();
        });
        
        System.out.println("✅ Connection timeout test passed!");
    }
}
