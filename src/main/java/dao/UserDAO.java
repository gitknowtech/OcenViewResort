package dao;

import config.DatabaseConfig;
import models.User;
import utils.PasswordUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    
    /**
     * Create a new user
     * @param user User object
     * @return true if user created successfully
     */
    public boolean createUser(User user) {
        String sql = "INSERT INTO users (email, password, registered_time) VALUES (?, ?, NOW())";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, user.getEmail());
            stmt.setString(2, PasswordUtils.hashPassword(user.getPassword()));
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                // Get generated ID
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        user.setId(generatedKeys.getInt(1));
                    }
                }
                System.out.println("✅ User created successfully: " + user.getEmail());
                return true;
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Error creating user: " + e.getMessage());
        }
        
        return false;
    }
    
    /**
     * Authenticate user login
     * @param email User email
     * @param password Plain text password
     * @return User object if authentication successful, null otherwise
     */
    public User authenticateUser(String email, String password) {
        String sql = "SELECT id, email, password, registered_time FROM users WHERE email = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String storedPassword = rs.getString("password");
                    
                    // Verify password
                    if (PasswordUtils.verifyPassword(password, storedPassword)) {
                        User user = new User();
                        user.setId(rs.getInt("id"));
                        user.setEmail(rs.getString("email"));
                        user.setPassword(storedPassword);
                        user.setRegisteredTime(rs.getTimestamp("registered_time"));
                        
                        System.out.println("✅ User authenticated successfully: " + email);
                        return user;
                    } else {
                        System.out.println("❌ Invalid password for user: " + email);
                    }
                } else {
                    System.out.println("❌ User not found: " + email);
                }
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Error authenticating user: " + e.getMessage());
        }
        
        return null;
    }
    
    /**
     * Check if email already exists
     * @param email User email
     * @return true if email exists
     */
    public boolean emailExists(String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Error checking email existence: " + e.getMessage());
        }
        
        return false;
    }
    
    /**
     * Get user by ID
     * @param userId User ID
     * @return User object or null
     */
    public User getUserById(int userId) {
        String sql = "SELECT id, email, password, registered_time FROM users WHERE id = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setRegisteredTime(rs.getTimestamp("registered_time"));
                    
                    return user;
                }
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Error getting user by ID: " + e.getMessage());
        }
        
        return null;
    }
    
    /**
     * Get all users (for admin purposes)
     * @return List of users
     */
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT id, email, registered_time FROM users ORDER BY registered_time DESC";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setRegisteredTime(rs.getTimestamp("registered_time"));
                users.add(user);
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Error getting all users: " + e.getMessage());
        }
        
        return users;
    }
}
