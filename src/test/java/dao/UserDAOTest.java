package dao;

import models.User;
import org.junit.jupiter.api.*;
import static org.junit.jupiter.api.Assertions.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

@DisplayName("UserDAO Tests")
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class UserDAOTest {
    
    private static UserDAO userDAO;
    private static final String TEST_EMAIL = "junit.test@oceanview.com";
    private static final String TEST_PASSWORD = "testpassword123";
    
    @BeforeAll
    @DisplayName("Setup UserDAO tests")
    static void setUpClass() {
        System.out.println("🔧 Setting up UserDAO tests...");
        userDAO = new UserDAO();
        
        // Clean up any existing test data
        cleanupTestData();
    }
    
    @AfterAll
    @DisplayName("Cleanup UserDAO tests")
    static void tearDownClass() {
        System.out.println("🧹 Cleaning up UserDAO tests...");
        cleanupTestData();
    }
    
    private static void cleanupTestData() {
        try {
            Connection conn = config.DatabaseConfig.getConnection();
            PreparedStatement stmt = conn.prepareStatement("DELETE FROM users WHERE email = ?");
            stmt.setString(1, TEST_EMAIL);
            stmt.executeUpdate();
            stmt.close();
            conn.close();
            System.out.println("🗑️ Test data cleaned up");
        } catch (Exception e) {
            System.err.println("⚠️ Error cleaning test data: " + e.getMessage());
        }
    }
    
    @Test
    @Order(1)
    @DisplayName("Test user creation")
    void testCreateUser() {
        System.out.println("🧪 Testing user creation...");
        
        assertDoesNotThrow(() -> {
            boolean created = userDAO.createUser(TEST_EMAIL, TEST_PASSWORD);
            assertTrue(created, "User should be created successfully");
        });
        
        System.out.println("✅ User creation test passed!");
    }
    
    @Test
    @Order(2)
    @DisplayName("Test duplicate user creation")
    void testDuplicateUserCreation() {
        System.out.println("🧪 Testing duplicate user creation...");
        
        assertDoesNotThrow(() -> {
            // Try to create the same user again
            boolean created = userDAO.createUser(TEST_EMAIL, TEST_PASSWORD);
            assertFalse(created, "Duplicate user should not be created");
        });
        
        System.out.println("✅ Duplicate user creation test passed!");
    }
    
    @Test
    @Order(3)
    @DisplayName("Test user authentication - valid credentials")
    void testValidAuthentication() {
        System.out.println("🧪 Testing valid user authentication...");
        
        assertDoesNotThrow(() -> {
            User user = userDAO.authenticateUser(TEST_EMAIL, TEST_PASSWORD);
            assertNotNull(user, "User should be authenticated");
            assertEquals(TEST_EMAIL, user.getEmail(), "Email should match");
            assertTrue(user.getId() > 0, "User ID should be positive");
            assertNotNull(user.getRegisteredTime(), "Registration time should not be null");
        });
        
        System.out.println("✅ Valid authentication test passed!");
    }
    
    @Test
    @Order(4)
    @DisplayName("Test user authentication - invalid password")
    void testInvalidPasswordAuthentication() {
        System.out.println("🧪 Testing invalid password authentication...");
        
        assertDoesNotThrow(() -> {
            User user = userDAO.authenticateUser(TEST_EMAIL, "wrongpassword");
            assertNull(user, "User should not be authenticated with wrong password");
        });
        
        System.out.println("✅ Invalid password authentication test passed!");
    }
    
    @Test
    @Order(5)
    @DisplayName("Test user authentication - non-existent user")
    void testNonExistentUserAuthentication() {
        System.out.println("🧪 Testing non-existent user authentication...");
        
        assertDoesNotThrow(() -> {
            User user = userDAO.authenticateUser("nonexistent@test.com", TEST_PASSWORD);
            assertNull(user, "Non-existent user should not be authenticated");
        });
        
        System.out.println("✅ Non-existent user authentication test passed!");
    }
    
    @Test
    @Order(6)
    @DisplayName("Test get all users")
    void testGetAllUsers() {
        System.out.println("🧪 Testing get all users...");
        
        assertDoesNotThrow(() -> {
            List<User> users = userDAO.getAllUsers();
            assertNotNull(users, "Users list should not be null");
            assertTrue(users.size() >= 1, "Should have at least our test user");
            
            // Check if our test user is in the list
            boolean testUserFound = users.stream()
                .anyMatch(user -> TEST_EMAIL.equals(user.getEmail()));
            assertTrue(testUserFound, "Test user should be in the users list");
        });
        
        System.out.println("✅ Get all users test passed!");
    }
    
    @Test
    @Order(7)
    @DisplayName("Test user exists")
    void testUserExists() {
        System.out.println("🧪 Testing user exists check...");
        
        assertDoesNotThrow(() -> {
            boolean exists = userDAO.userExists(TEST_EMAIL);
            assertTrue(exists, "Test user should exist");
            
            boolean notExists = userDAO.userExists("nonexistent@test.com");
            assertFalse(notExists, "Non-existent user should not exist");
        });
        
        System.out.println("✅ User exists test passed!");
    }
    
    @Test
    @Order(8)
    @DisplayName("Test invalid email formats")
    void testInvalidEmailFormats() {
        System.out.println("🧪 Testing invalid email formats...");
        
        String[] invalidEmails = {
            "invalid-email",
            "@domain.com",
            "user@",
            "user..name@domain.com",
            "",
            null
        };
        
        for (String email : invalidEmails) {
            assertDoesNotThrow(() -> {
                boolean created = userDAO.createUser(email, TEST_PASSWORD);
                // Depending on your validation, this might return false or throw exception
                // Adjust assertion based on your implementation
            }, "Should handle invalid email: " + email);
        }
        
        System.out.println("✅ Invalid email formats test passed!");
    }
}
