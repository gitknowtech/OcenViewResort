package integration;

import config.DatabaseConfig;
import dao.UserDAO;
import models.User;
import org.junit.jupiter.api.*;
import static org.junit.jupiter.api.Assertions.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@DisplayName("Database Integration Tests")
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class DatabaseIntegrationTest {
    
    private UserDAO userDAO;
    private Connection connection;
    
    @BeforeAll
    @DisplayName("Setup integration tests")
    void setUp() {
        System.out.println("🔧 Setting up database integration tests...");
        userDAO = new UserDAO();
    }
    
    @Test
    @DisplayName("Test complete user workflow")
    void testCompleteUserWorkflow() {
        System.out.println("🧪 Testing complete user workflow...");
        
        String testEmail = "integration.test@oceanview.com";
        String testPassword = "integrationtest123";
        
        assertDoesNotThrow(() -> {
            // Step 1: Create user
            boolean created = userDAO.createUser(testEmail, testPassword);
            assertTrue(created, "User should be created");
            
            // Step 2: Verify user exists
            boolean exists = userDAO.userExists(testEmail);
            assertTrue(exists, "User should exist after creation");
            
            // Step 3: Authenticate user
            User authenticatedUser = userDAO.authenticateUser(testEmail, testPassword);
            assertNotNull(authenticatedUser, "User should be authenticated");
            assertEquals(testEmail, authenticatedUser.getEmail(), "Email should match");
            
            // Step 4: Get all users and verify our user is included
            var allUsers = userDAO.getAllUsers();
            boolean userInList = allUsers.stream()
                .anyMatch(user -> testEmail.equals(user.getEmail()));
            assertTrue(userInList, "User should be in the all users list");
            
            // Step 5: Test wrong password
            User wrongAuth = userDAO.authenticateUser(testEmail, "wrongpassword");
            assertNull(wrongAuth, "Authentication should fail with wrong password");
            
            // Cleanup
            connection = DatabaseConfig.getConnection();
            PreparedStatement cleanup = connection.prepareStatement("DELETE FROM users WHERE email = ?");
            cleanup.setString(1, testEmail);
            cleanup.executeUpdate();
            cleanup.close();
            connection.close();
        });
        
        System.out.println("✅ Complete user workflow test passed!");
    }
    
    @Test
    @DisplayName("Test database schema integrity")
    void testDatabaseSchema() {
        System.out.println("🧪 Testing database schema integrity...");
        
        assertDoesNotThrow(() -> {
            connection = DatabaseConfig.getConnection();
            
            // Test users table structure
            PreparedStatement stmt = connection.prepareStatement("DESCRIBE users");
            ResultSet rs = stmt.executeQuery();
            
            boolean hasId = false, hasEmail = false, hasPassword = false, hasRegisteredTime = false;
            
            while (rs.next()) {
                String columnName = rs.getString("Field");
                switch (columnName) {
                    case "id":
                        hasId = true;
                        assertEquals("int", rs.getString("Type").toLowerCase().substring(0, 3), 
                                   "ID should be integer type");
                        assertEquals("PRI", rs.getString("Key"), "ID should be primary key");
                        break;
                    case "email":
                        hasEmail = true;
                        assertTrue(rs.getString("Type").toLowerCase().contains("varchar"), 
                                 "Email should be varchar type");
                        assertEquals("UNI", rs.getString("Key"), "Email should be unique");
                        break;
                    case "password":
                        hasPassword = true;
                        assertTrue(rs.getString("Type").toLowerCase().contains("varchar"), 
                                 "Password should be varchar type");
                        break;
                    case "registered_time":
                        hasRegisteredTime = true;
                        assertTrue(rs.getString("Type").toLowerCase().contains("timestamp"), 
                                 "Registered time should be timestamp type");
                        break;
                }
            }
            
            assertTrue(hasId, "Users table should have id column");
            assertTrue(hasEmail, "Users table should have email column");
            assertTrue(hasPassword, "Users table should have password column");
            assertTrue(hasRegisteredTime, "Users table should have registered_time column");
            
            rs.close();
            stmt.close();
            connection.close();
        });
        
        System.out.println("✅ Database schema integrity test passed!");
    }
    
    @Test
    @DisplayName("Test database performance")
    void testDatabasePerformance() {
        System.out.println("🧪 Testing database performance...");
        
        assertDoesNotThrow(() -> {
            long startTime = System.currentTimeMillis();
            
            // Test connection time
            connection = DatabaseConfig.getConnection();
            long connectionTime = System.currentTimeMillis() - startTime;
            
            assertTrue(connectionTime < 5000, "Connection should be established within 5 seconds");
            System.out.println("⏱️ Connection time: " + connectionTime + "ms");
            
            // Test query performance
            startTime = System.currentTimeMillis();
            PreparedStatement stmt = connection.prepareStatement("SELECT COUNT(*) FROM users");
            ResultSet rs = stmt.executeQuery();
            rs.next();
            int userCount = rs.getInt(1);
            long queryTime = System.currentTimeMillis() - startTime;
            
            assertTrue(queryTime < 1000, "Simple query should complete within 1 second");
            System.out.println("⏱️ Query time: " + queryTime + "ms");
            System.out.println("📊 Total users: " + userCount);
            
            rs.close();
            stmt.close();
            connection.close();
        });
        
        System.out.println("✅ Database performance test passed!");
    }
}
