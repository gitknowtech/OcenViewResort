package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Get simple parameters
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String mobile = request.getParameter("mobile");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");

            System.out.println("=== SIMPLE SIGNUP REQUEST ===");
            System.out.println("Username: " + username);
            System.out.println("Email: " + email);
            System.out.println("Mobile: " + mobile);

            // Validation - Required fields only
            if (username == null || username.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Username is required\"}");
                return;
            }
            
            if (email == null || email.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Email is required\"}");
                return;
            }
            
            if (mobile == null || mobile.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Mobile number is required\"}");
                return;
            }
            
            if (password == null || password.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Password is required\"}");
                return;
            }
            
            if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Confirm password is required\"}");
                return;
            }
            
            if (!password.equals(confirmPassword)) {
                out.print("{\"success\":false,\"message\":\"Passwords do not match\"}");
                return;
            }
            
            if (password.length() < 8) {
                out.print("{\"success\":false,\"message\":\"Password must be at least 8 characters\"}");
                return;
            }

            // Clean data
            username = username.trim().toLowerCase();
            email = email.trim().toLowerCase();
            mobile = mobile.trim();

            // Database connection
            String url = "jdbc:mysql://localhost:3306/oceanview?useSSL=false&serverTimezone=UTC";
            String dbUser = "root";
            String dbPassword = "";

            Class.forName("com.mysql.cj.jdbc.Driver");
            
            try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword)) {
                
                // Check if username exists
                try (PreparedStatement checkUsername = conn.prepareStatement("SELECT id FROM users WHERE username = ?")) {
                    checkUsername.setString(1, username);
                    try (ResultSet rs = checkUsername.executeQuery()) {
                        if (rs.next()) {
                            out.print("{\"success\":false,\"message\":\"Username already taken. Please choose another.\"}");
                            return;
                        }
                    }
                }
                
                // Check if email exists
                try (PreparedStatement checkEmail = conn.prepareStatement("SELECT id FROM users WHERE email = ?")) {
                    checkEmail.setString(1, email);
                    try (ResultSet rs = checkEmail.executeQuery()) {
                        if (rs.next()) {
                            out.print("{\"success\":false,\"message\":\"Email already registered. Please use another email.\"}");
                            return;
                        }
                    }
                }

                // Hash password
                String hashedPassword = sha256(password);

                // Insert user with simple fields - Set default values for required fields
                String insertSQL = "INSERT INTO users (username, email, password, first_name, last_name, phone) VALUES (?, ?, ?, ?, ?, ?)";
                
                try (PreparedStatement insert = conn.prepareStatement(insertSQL, Statement.RETURN_GENERATED_KEYS)) {
                    insert.setString(1, username);
                    insert.setString(2, email);
                    insert.setString(3, hashedPassword);
                    insert.setString(4, "User");        // Default first name
                    insert.setString(5, "Name");        // Default last name
                    insert.setString(6, mobile);
                    
                    int rows = insert.executeUpdate();
                    
                    if (rows > 0) {
                        try (ResultSet generatedKeys = insert.getGeneratedKeys()) {
                            if (generatedKeys.next()) {
                                int userId = generatedKeys.getInt(1);
                                System.out.println("✅ User created successfully: ID=" + userId + ", Username=" + username + ", Email=" + email);
                                out.print("{\"success\":true,\"message\":\"Account created successfully!\"}");
                            }
                        }
                    } else {
                        out.print("{\"success\":false,\"message\":\"Failed to create account. Please try again.\"}");
                    }
                }
            }
            
        } catch (Exception e) {
            System.out.println("❌ Signup Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"Server error occurred. Please try again later.\"}");
        }
    }

    private String sha256(String input) throws Exception {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hash = digest.digest(input.getBytes(StandardCharsets.UTF_8));
        
        StringBuilder sb = new StringBuilder();
        for (byte b : hash) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) sb.append('0');
            sb.append(hex);
        }
        return sb.toString();
    }
}
