package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Get parameters - now using loginField instead of email
            String loginField = request.getParameter("loginField");  // Can be username or email
            String password = request.getParameter("password");
            String remember = request.getParameter("remember");

            System.out.println("=== LOGIN REQUEST ===");
            System.out.println("Login Field: " + loginField);
            System.out.println("Remember: " + remember);

            // Validation
            if (loginField == null || loginField.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Username or email is required\"}");
                return;
            }
            
            if (password == null || password.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Password is required\"}");
                return;
            }

            loginField = loginField.trim().toLowerCase();
            boolean isRemember = "true".equals(remember);

            // Database connection
            String url = "jdbc:mysql://localhost:3306/oceanview?useSSL=false&serverTimezone=UTC";
            String dbUser = "root";
            String dbPassword = "";

            Class.forName("com.mysql.cj.jdbc.Driver");
            
            try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword)) {
                
                // Hash password for comparison
                String hashedPassword = sha256(password);
                
                // UPDATED: Check both username and email
                String sql = "SELECT id, username, email, password, first_name, last_name, phone FROM users WHERE (username = ? OR email = ?) AND password = ?";
                
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, loginField);  // Check username
                    stmt.setString(2, loginField);  // Check email
                    stmt.setString(3, hashedPassword);
                    
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            // Login successful
                            int userId = rs.getInt("id");
                            String username = rs.getString("username");
                            String email = rs.getString("email");
                            String firstName = rs.getString("first_name");
                            String lastName = rs.getString("last_name");
                            String phone = rs.getString("phone");
                            
                            System.out.println("✅ Login successful for user: " + username + " (" + email + ")");
                            
                            // Create session
                            HttpSession session = request.getSession(true);
                            session.setAttribute("userId", userId);
                            session.setAttribute("username", username);
                            session.setAttribute("email", email);
                            session.setAttribute("firstName", firstName);
                            session.setAttribute("lastName", lastName);
                            session.setAttribute("phone", phone);
                            session.setAttribute("loginTime", System.currentTimeMillis());
                            
                            // Update last login
                            try (PreparedStatement updateStmt = conn.prepareStatement("UPDATE users SET last_login = NOW() WHERE id = ?")) {
                                updateStmt.setInt(1, userId);
                                updateStmt.executeUpdate();
                            }
                            
                            // Handle remember me
                            if (isRemember) {
                                String rememberToken = UUID.randomUUID().toString();
                                
                                // Save to database
                                try (PreparedStatement rememberStmt = conn.prepareStatement(
                                        "INSERT INTO user_sessions (session_id, user_id, ip_address, user_agent, is_remember_me, expires_at) VALUES (?, ?, ?, ?, ?, ?)")) {
                                    rememberStmt.setString(1, rememberToken);
                                    rememberStmt.setInt(2, userId);
                                    rememberStmt.setString(3, request.getRemoteAddr());
                                    rememberStmt.setString(4, request.getHeader("User-Agent"));
                                    rememberStmt.setBoolean(5, true);
                                    // 30 days from now
                                    rememberStmt.setTimestamp(6, new Timestamp(System.currentTimeMillis() + (30L * 24 * 60 * 60 * 1000)));
                                    rememberStmt.executeUpdate();
                                }
                                
                                // Set cookie
                                Cookie rememberCookie = new Cookie("oceanview_remember", rememberToken);
                                rememberCookie.setMaxAge(30 * 24 * 60 * 60); // 30 days
                                rememberCookie.setPath("/");
                                rememberCookie.setHttpOnly(true);
                                response.addCookie(rememberCookie);
                                
                                System.out.println("✅ Remember me token created: " + rememberToken);
                            }
                            
                            // Log successful login
                            try (PreparedStatement logStmt = conn.prepareStatement(
                                    "INSERT INTO user_logins (user_id, login_method, login_status, ip_address, user_agent) VALUES (?, ?, ?, ?, ?)")) {
                                logStmt.setInt(1, userId);
                                logStmt.setString(2, loginField.contains("@") ? "EMAIL" : "USERNAME");
                                logStmt.setString(3, "SUCCESS");
                                logStmt.setString(4, request.getRemoteAddr());
                                logStmt.setString(5, request.getHeader("User-Agent"));
                                logStmt.executeUpdate();
                            }
                            
                            // Return success with user data
                            String displayName = firstName != null && !firstName.equals("User") ? firstName : username;
                            String loginMethod = loginField.contains("@") ? "email" : "username";
                            
                            out.print("{\"success\":true,\"message\":\"Welcome back, " + displayName + "! Logged in via " + loginMethod + ".\",\"user\":{" +
                                    "\"id\":" + userId + "," +
                                    "\"username\":\"" + username + "\"," +
                                    "\"email\":\"" + email + "\"," +
                                    "\"firstName\":\"" + firstName + "\"," +
                                    "\"lastName\":\"" + lastName + "\"," +
                                    "\"phone\":\"" + phone + "\"" +
                                    "}}");
                            
                        } else {
                            // Login failed - check if user exists
                            String checkUserSql = "SELECT id FROM users WHERE username = ? OR email = ?";
                            try (PreparedStatement checkStmt = conn.prepareStatement(checkUserSql)) {
                                checkStmt.setString(1, loginField);
                                checkStmt.setString(2, loginField);
                                
                                try (ResultSet checkRs = checkStmt.executeQuery()) {
                                    if (checkRs.next()) {
                                        // User exists but password wrong
                                        System.out.println("❌ Wrong password for: " + loginField);
                                        
                                        // Log failed login
                                        int userId = checkRs.getInt("id");
                                        try (PreparedStatement logStmt = conn.prepareStatement(
                                                "INSERT INTO user_logins (user_id, login_method, login_status, ip_address, user_agent) VALUES (?, ?, ?, ?, ?)")) {
                                            logStmt.setInt(1, userId);
                                            logStmt.setString(2, loginField.contains("@") ? "EMAIL" : "USERNAME");
                                            logStmt.setString(3, "FAILED");
                                            logStmt.setString(4, request.getRemoteAddr());
                                            logStmt.setString(5, request.getHeader("User-Agent"));
                                            logStmt.executeUpdate();
                                        }
                                        
                                        out.print("{\"success\":false,\"message\":\"Incorrect password. Please try again.\"}");
                                    } else {
                                        // User doesn't exist
                                        System.out.println("❌ User not found: " + loginField);
                                        out.print("{\"success\":false,\"message\":\"No account found with this username or email.\"}");
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
        } catch (Exception e) {
            System.out.println("❌ Login Error: " + e.getMessage());
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
