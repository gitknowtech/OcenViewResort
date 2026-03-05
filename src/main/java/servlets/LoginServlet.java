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
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String remember = request.getParameter("remember");
            
            if (email == null || email.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Email is required\"}");
                return;
            }
            
            if (password == null || password.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Password is required\"}");
                return;
            }

            email = email.trim().toLowerCase();
            String hashedPassword = sha256(password);
            boolean rememberMe = "on".equals(remember) || "true".equals(remember);

            String url = "jdbc:mysql://localhost:3306/oceanview?useSSL=false&serverTimezone=UTC";
            String dbUser = "root";
            String dbPassword = "";

            Class.forName("com.mysql.cj.jdbc.Driver");
            
            try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword)) {
                
                // Check credentials
                String query = "SELECT id, email, first_name, last_name FROM users WHERE email = ? AND password = ?";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, email);
                    stmt.setString(2, hashedPassword);
                    
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            // LOGIN SUCCESS
                            int userId = rs.getInt("id");
                            String userEmail = rs.getString("email");
                            String firstName = rs.getString("first_name");
                            String lastName = rs.getString("last_name");
                            
                            // Create session
                            HttpSession session = request.getSession();
                            session.setAttribute("userId", userId);
                            session.setAttribute("userEmail", userEmail);
                            session.setAttribute("firstName", firstName);
                            session.setAttribute("lastName", lastName);
                            session.setAttribute("isLoggedIn", true);
                            
                            // Update last login
                            try (PreparedStatement updateStmt = conn.prepareStatement(
                                    "UPDATE users SET last_login = ? WHERE id = ?")) {
                                updateStmt.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
                                updateStmt.setInt(2, userId);
                                updateStmt.executeUpdate();
                            }
                            
                            // Record login
                            try (PreparedStatement loginStmt = conn.prepareStatement(
                                    "INSERT INTO user_logins (user_id, ip_address, user_agent) VALUES (?, ?, ?)")) {
                                loginStmt.setInt(1, userId);
                                loginStmt.setString(2, request.getRemoteAddr());
                                loginStmt.setString(3, request.getHeader("User-Agent"));
                                loginStmt.executeUpdate();
                            }
                            
                            // Handle Remember Me
                            if (rememberMe) {
                                String sessionToken = UUID.randomUUID().toString();
                                Timestamp expiresAt = new Timestamp(System.currentTimeMillis() + (30L * 24 * 60 * 60 * 1000)); // 30 days
                                
                                // Save session token
                                try (PreparedStatement sessionStmt = conn.prepareStatement(
                                        "INSERT INTO user_sessions (session_id, user_id, expires_at, is_remember_me) VALUES (?, ?, ?, ?)")) {
                                    sessionStmt.setString(1, sessionToken);
                                    sessionStmt.setInt(2, userId);
                                    sessionStmt.setTimestamp(3, expiresAt);
                                    sessionStmt.setBoolean(4, true);
                                    sessionStmt.executeUpdate();
                                }
                                
                                // Set cookie
                                Cookie rememberCookie = new Cookie("oceanview_remember", sessionToken);
                                rememberCookie.setMaxAge(30 * 24 * 60 * 60); // 30 days
                                rememberCookie.setPath("/");
                                response.addCookie(rememberCookie);
                            }
                            
                            String displayName = firstName != null ? firstName : userEmail.split("@")[0];
                            out.print("{\"success\":true,\"message\":\"Login successful! Welcome back, " + displayName + "\",\"user\":{\"id\":" + userId + ",\"email\":\"" + userEmail + "\",\"name\":\"" + displayName + "\"}}");
                            
                        } else {
                            // LOGIN FAILED
                            out.print("{\"success\":false,\"message\":\"Invalid email or password\"}");
                        }
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"Server error: " + e.getMessage() + "\"}");
        }
    }
    
    private String sha256(String input) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(input.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception e) {
            return input;
        }
    }
}
