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
            String loginField = request.getParameter("loginField");
            String password = request.getParameter("password");
            String remember = request.getParameter("remember");

            System.out.println("\n╔════════════════════════════════════╗");
            System.out.println("║     LOGIN REQUEST RECEIVED         ║");
            System.out.println("╚════════════════════════════════════╝");
            System.out.println("Login Field: " + loginField);
            System.out.println("Remember: " + remember);

            if (loginField == null || loginField.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Username or email is required\"}");
                return;
            }
            
            if (password == null || password.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Password is required\"}");
                return;
            }

            loginField = loginField.trim();
            boolean isRemember = "true".equals(remember);
            String hashedPassword = sha256(password);

            String url = "jdbc:mysql://localhost:3306/oceanview?useSSL=false&serverTimezone=UTC";
            String dbUser = "root";
            String dbPassword = "";

            Class.forName("com.mysql.cj.jdbc.Driver");
            
            try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword)) {
                
                // ✅ STEP 1: CHECK USERS TABLE
                System.out.println("\n🔍 STEP 1: Checking USERS table...");
                String userSql = "SELECT id, username, email, password, first_name, last_name, phone FROM users WHERE (LOWER(username) = ? OR LOWER(email) = ?) AND password = ?";
                
                try (PreparedStatement userStmt = conn.prepareStatement(userSql)) {
                    userStmt.setString(1, loginField.toLowerCase());
                    userStmt.setString(2, loginField.toLowerCase());
                    userStmt.setString(3, hashedPassword);
                    
                    try (ResultSet userRs = userStmt.executeQuery()) {
                        if (userRs.next()) {
                            System.out.println("✅ USER FOUND IN USERS TABLE!");
                            
                            int userId = userRs.getInt("id");
                            String username = userRs.getString("username");
                            String email = userRs.getString("email");
                            String firstName = userRs.getString("first_name");
                            String lastName = userRs.getString("last_name");
                            String phone = userRs.getString("phone");
                            
                            HttpSession session = request.getSession(true);
                            session.setAttribute("userId", userId);
                            session.setAttribute("username", username);
                            session.setAttribute("userEmail", email);
                            session.setAttribute("email", email);
                            session.setAttribute("firstName", firstName);
                            session.setAttribute("lastName", lastName);
                            session.setAttribute("phone", phone);
                            session.setAttribute("isAdmin", false);
                            session.setAttribute("isLoggedIn", true);  // ✅ IMPORTANT
                            session.setAttribute("role", "USER");
                            
                            System.out.println("✅ USER SESSION CREATED");
                            System.out.println("🔐 isAdmin = false");
                            System.out.println("🔐 isLoggedIn = true");
                            System.out.println("📍 REDIRECT TO: index.jsp\n");
                            
                            out.print("{\"success\":true,\"message\":\"User login successful!\",\"isAdmin\":false,\"user\":{\"id\":" + userId + ",\"username\":\"" + username + "\",\"email\":\"" + email + "\",\"firstName\":\"" + firstName + "\",\"lastName\":\"" + lastName + "\",\"isAdmin\":false}}");
                            return;
                        }
                    }
                }
                
                System.out.println("❌ User not found in USERS table\n");
                
                // ✅ STEP 2: CHECK STAFF TABLE
                System.out.println("🔍 STEP 2: Checking STAFF table...");
                String staffSql = "SELECT id, username, email, password, name, phone FROM staff WHERE (LOWER(username) = ? OR LOWER(email) = ?) AND password = ?";
                
                try (PreparedStatement staffStmt = conn.prepareStatement(staffSql)) {
                    staffStmt.setString(1, loginField.toLowerCase());
                    staffStmt.setString(2, loginField.toLowerCase());
                    staffStmt.setString(3, hashedPassword);
                    
                    try (ResultSet staffRs = staffStmt.executeQuery()) {
                        if (staffRs.next()) {
                            System.out.println("✅ STAFF FOUND IN STAFF TABLE!");
                            
                            int staffId = staffRs.getInt("id");
                            String username = staffRs.getString("username");
                            String email = staffRs.getString("email");
                            String name = staffRs.getString("name");
                            String phone = staffRs.getString("phone");
                            
                            System.out.println("Staff ID: " + staffId);
                            System.out.println("Username: " + username);
                            System.out.println("Email: " + email);
                            
                            HttpSession session = request.getSession(true);
                            session.setAttribute("staffId", staffId);
                            session.setAttribute("userId", staffId);  // Also set as userId
                            session.setAttribute("username", username);
                            session.setAttribute("userEmail", email);  // ✅ IMPORTANT - CheckUserServlet looks for this
                            session.setAttribute("email", email);
                            session.setAttribute("firstName", name);
                            session.setAttribute("lastName", "");
                            session.setAttribute("phone", phone);
                            session.setAttribute("isAdmin", true);  // ✅ IMPORTANT
                            session.setAttribute("isLoggedIn", true);  // ✅ IMPORTANT
                            session.setAttribute("role", "STAFF");
                            
                            System.out.println("✅ STAFF SESSION CREATED");
                            System.out.println("🔐 isAdmin = true");
                            System.out.println("🔐 isLoggedIn = true");
                            System.out.println("🔐 userEmail = " + email);
                            System.out.println("📍 REDIRECT TO: admin-dashboard.jsp\n");
                            
                            String jsonResponse = "{\"success\":true,\"message\":\"Staff login successful!\",\"isAdmin\":true,\"user\":{\"id\":" + staffId + ",\"username\":\"" + username + "\",\"email\":\"" + email + "\",\"firstName\":\"" + name + "\",\"lastName\":\"\",\"isAdmin\":true}}";
                            
                            System.out.println("JSON Response: " + jsonResponse);
                            out.print(jsonResponse);
                            return;
                        }
                    }
                }
                
                System.out.println("❌ Staff not found in STAFF table\n");
                
                // ✅ STEP 3: CHECK HARDCODED ADMIN
                System.out.println("🔍 STEP 3: Checking hardcoded ADMIN...");
                if ("ADMIN".equals(loginField) && "ADMIN@123".equals(password)) {
                    System.out.println("✅ HARDCODED ADMIN LOGIN!");
                    
                    HttpSession session = request.getSession(true);
                    session.setAttribute("staffId", 999);
                    session.setAttribute("userId", 999);
                    session.setAttribute("username", "ADMIN");
                    session.setAttribute("userEmail", "admin@oceanview.lk");
                    session.setAttribute("email", "admin@oceanview.lk");
                    session.setAttribute("firstName", "Admin");
                    session.setAttribute("lastName", "User");
                    session.setAttribute("phone", "+94 77 123 4567");
                    session.setAttribute("isAdmin", true);
                    session.setAttribute("isLoggedIn", true);  // ✅ IMPORTANT
                    session.setAttribute("role", "ADMIN");
                    
                    System.out.println("✅ ADMIN SESSION CREATED");
                    System.out.println("🔐 isAdmin = true");
                    System.out.println("🔐 isLoggedIn = true");
                    System.out.println("📍 REDIRECT TO: admin-dashboard.jsp\n");
                    
                    out.print("{\"success\":true,\"message\":\"Admin login successful!\",\"isAdmin\":true,\"user\":{\"id\":999,\"username\":\"ADMIN\",\"email\":\"admin@oceanview.lk\",\"firstName\":\"Admin\",\"lastName\":\"User\",\"isAdmin\":true}}");
                    return;
                }
                
                System.out.println("❌ LOGIN FAILED - INVALID CREDENTIALS\n");
                out.print("{\"success\":false,\"message\":\"Invalid username/email or password\",\"isAdmin\":false}");
                
            }
            
        } catch (Exception e) {
            System.out.println("❌ Login Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"Server error: " + e.getMessage() + "\",\"isAdmin\":false}");
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
