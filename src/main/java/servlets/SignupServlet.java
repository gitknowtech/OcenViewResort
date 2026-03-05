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

@WebServlet("/signup")  // <-- මේක තියෙනවද බලන්න
public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // CORS headers add කරන්න
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");

            System.out.println("=== SIGNUP REQUEST ===");
            System.out.println("Email: " + email);
            System.out.println("Password: " + (password != null ? "received" : "null"));

            // Validation
            if (email == null || email.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Email is required\"}");
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

            email = email.trim().toLowerCase();

            // Database
            String url = "jdbc:mysql://localhost:3306/oceanview?useSSL=false&serverTimezone=UTC";
            String dbUser = "root";
            String dbPassword = "";

            Class.forName("com.mysql.cj.jdbc.Driver");
            
            try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword)) {
                
                // Check email exists
                try (PreparedStatement check = conn.prepareStatement("SELECT id FROM users WHERE email = ?")) {
                    check.setString(1, email);
                    try (ResultSet rs = check.executeQuery()) {
                        if (rs.next()) {
                            out.print("{\"success\":false,\"message\":\"Email already registered\"}");
                            return;
                        }
                    }
                }

                // Hash password
                String hashedPassword = sha256(password);

                // Insert user
                try (PreparedStatement insert = conn.prepareStatement(
                        "INSERT INTO users (email, password) VALUES (?, ?)", 
                        Statement.RETURN_GENERATED_KEYS)) {
                    
                    insert.setString(1, email);
                    insert.setString(2, hashedPassword);
                    
                    int rows = insert.executeUpdate();
                    
                    if (rows > 0) {
                        System.out.println("✅ User created: " + email);
                        out.print("{\"success\":true,\"message\":\"Account created successfully!\"}");
                    } else {
                        out.print("{\"success\":false,\"message\":\"Failed to create account\"}");
                    }
                }
            }
            
        } catch (Exception e) {
            System.out.println("❌ Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"Server error\"}");
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
