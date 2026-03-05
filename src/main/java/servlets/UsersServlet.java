package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/users")
public class UsersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/oceanview?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "";
    private static final String DB_DRIVER = "com.mysql.cj.jdbc.Driver";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json;charset=UTF-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        
        PrintWriter out = response.getWriter();

        try {
            String action = request.getParameter("action");
            System.out.println("🔵 GET: action=" + action);
            
            if ("getAll".equals(action)) {
                getAllUsers(out);
            } else if ("getById".equals(action)) {
                String id = request.getParameter("id");
                getUserById(out, id);
            } else {
                out.print("{\"success\":false,\"message\":\"Invalid action\"}");
            }
            out.flush();
        } catch (Exception e) {
            System.out.println("❌ GET ERROR: " + e.getMessage());
            e.printStackTrace();
            try {
                out.print("{\"success\":false,\"message\":\"" + escapeJson(e.getMessage()) + "\"}");
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            out.flush();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json;charset=UTF-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        
        PrintWriter out = response.getWriter();

        try {
            String action = request.getParameter("action");
            System.out.println("🔵 POST: action=" + action);
            
            if ("add".equals(action)) {
                addUser(request, out);
            } else if ("update".equals(action)) {
                updateUser(request, out);
            } else if ("delete".equals(action)) {
                deleteUser(request, out);
            } else {
                out.print("{\"success\":false,\"message\":\"Invalid action\"}");
            }
            out.flush();
        } catch (Exception e) {
            System.out.println("❌ POST ERROR: " + e.getMessage());
            e.printStackTrace();
            try {
                out.print("{\"success\":false,\"message\":\"" + escapeJson(e.getMessage()) + "\"}");
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            out.flush();
        }
    }

    @Override
    protected void doOptions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        response.setStatus(HttpServletResponse.SC_OK);
    }

    // ✅ GET ALL USERS - MATCHES YOUR ACTUAL TABLE STRUCTURE
    private void getAllUsers(PrintWriter out) {
        Connection conn = null;
        try {
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            System.out.println("✅ Database connection successful");
            
            String sql = "SELECT id, username, email, first_name, last_name, phone, city, country, created_at FROM users ORDER BY id DESC";
            System.out.println("📋 Executing SQL: " + sql);
            
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            StringBuilder json = new StringBuilder("[");
            boolean first = true;
            int count = 0;
            
            while (rs.next()) {
                count++;
                if (!first) json.append(",");
                
                int id = rs.getInt("id");
                String username = rs.getString("username");
                String email = rs.getString("email");
                String firstName = rs.getString("first_name");
                String lastName = rs.getString("last_name");
                String phone = rs.getString("phone");
                String city = rs.getString("city");
                String country = rs.getString("country");
                String createdAt = rs.getString("created_at");
                
                System.out.println("📝 User " + count + ": " + firstName + " " + lastName + " (" + email + ")");
                
                json.append("{")
                    .append("\"id\":").append(id).append(",")
                    .append("\"username\":\"").append(escapeJson(username)).append("\",")
                    .append("\"email\":\"").append(escapeJson(email)).append("\",")
                    .append("\"first_name\":\"").append(escapeJson(firstName)).append("\",")
                    .append("\"last_name\":\"").append(escapeJson(lastName)).append("\",")
                    .append("\"phone\":\"").append(escapeJson(phone)).append("\",")
                    .append("\"city\":\"").append(escapeJson(city)).append("\",")
                    .append("\"country\":\"").append(escapeJson(country)).append("\",")
                    .append("\"created_at\":\"").append(escapeJson(createdAt)).append("\"")
                    .append("}");
                
                first = false;
            }
            
            json.append("]");
            System.out.println("✅ getAllUsers: Returning " + count + " records");
            out.print(json.toString());
            
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.out.println("❌ getAllUsers Error: " + e.getMessage());
            e.printStackTrace();
            out.print("[]");
        } finally {
            closeConnection(conn);
        }
    }

    // ✅ GET USER BY ID
    private void getUserById(PrintWriter out, String userId) {
        Connection conn = null;
        try {
            if (userId == null || userId.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"User ID is required\"}");
                return;
            }
            
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            String sql = "SELECT * FROM users WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(userId));
            
            System.out.println("📋 Executing: SELECT user ID " + userId);
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                StringBuilder json = new StringBuilder();
                json.append("{\"success\":true,\"user\":{")
                    .append("\"id\":").append(rs.getInt("id")).append(",")
                    .append("\"username\":\"").append(escapeJson(rs.getString("username"))).append("\",")
                    .append("\"email\":\"").append(escapeJson(rs.getString("email"))).append("\",")
                    .append("\"first_name\":\"").append(escapeJson(rs.getString("first_name"))).append("\",")
                    .append("\"last_name\":\"").append(escapeJson(rs.getString("last_name"))).append("\",")
                    .append("\"phone\":\"").append(escapeJson(rs.getString("phone"))).append("\",")
                    .append("\"phone2\":\"").append(escapeJson(rs.getString("phone2"))).append("\",")
                    .append("\"national_id\":\"").append(escapeJson(rs.getString("national_id"))).append("\",")
                    .append("\"date_of_birth\":\"").append(escapeJson(rs.getString("date_of_birth"))).append("\",")
                    .append("\"address\":\"").append(escapeJson(rs.getString("address"))).append("\",")
                    .append("\"city\":\"").append(escapeJson(rs.getString("city"))).append("\",")
                    .append("\"country\":\"").append(escapeJson(rs.getString("country"))).append("\",")
                    .append("\"created_at\":\"").append(escapeJson(rs.getString("created_at"))).append("\"")
                    .append("}}");
                
                System.out.println("✅ getUserById: Found user ID " + userId);
                out.print(json.toString());
            } else {
                System.out.println("⚠️ User ID " + userId + " not found");
                out.print("{\"success\":false,\"message\":\"User not found\"}");
            }
            
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.out.println("❌ getUserById Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"" + escapeJson(e.getMessage()) + "\"}");
        } finally {
            closeConnection(conn);
        }
    }

    // ✅ ADD USER
    private void addUser(HttpServletRequest request, PrintWriter out) {
        Connection conn = null;
        try {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String firstName = request.getParameter("first_name");
            String lastName = request.getParameter("last_name");
            String phone = request.getParameter("phone");
            String phone2 = request.getParameter("phone2");
            String nationalId = request.getParameter("national_id");
            String dateOfBirth = request.getParameter("date_of_birth");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String country = request.getParameter("country");
            
            System.out.println("========== ADD USER ==========");
            System.out.println("username: " + username);
            System.out.println("email: " + email);
            System.out.println("first_name: " + firstName);
            System.out.println("last_name: " + lastName);
            System.out.println("phone: " + phone);
            System.out.println("=============================");
            
            if (username == null || username.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Username is required\"}");
                return;
            }
            if (email == null || email.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Email is required\"}");
                return;
            }
            if (firstName == null || firstName.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"First Name is required\"}");
                return;
            }
            if (lastName == null || lastName.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Last Name is required\"}");
                return;
            }
            if (phone == null || phone.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Phone is required\"}");
                return;
            }
            
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            // Check username
            String checkSql = "SELECT id FROM users WHERE username = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, username.trim());
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {
                out.print("{\"success\":false,\"message\":\"Username already exists\"}");
                rs.close();
                checkStmt.close();
                return;
            }
            rs.close();
            checkStmt.close();
            
            // Check email
            checkSql = "SELECT id FROM users WHERE email = ?";
            checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, email.trim());
            rs = checkStmt.executeQuery();
            if (rs.next()) {
                out.print("{\"success\":false,\"message\":\"Email already exists\"}");
                rs.close();
                checkStmt.close();
                return;
            }
            rs.close();
            checkStmt.close();
            
            // Insert user
            String sql = "INSERT INTO users (username, email, password, first_name, last_name, phone, phone2, national_id, date_of_birth, address, city, country) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, username.trim());
            stmt.setString(2, email.trim());
            stmt.setString(3, "default123"); // Default password - should be hashed in production
            stmt.setString(4, firstName.trim());
            stmt.setString(5, lastName.trim());
            stmt.setString(6, phone.trim());
            stmt.setString(7, phone2 != null ? phone2.trim() : "");
            stmt.setString(8, nationalId != null ? nationalId.trim() : "");
            stmt.setString(9, dateOfBirth != null ? dateOfBirth.trim() : null);
            stmt.setString(10, address != null ? address.trim() : "");
            stmt.setString(11, city != null ? city.trim() : "");
            stmt.setString(12, country != null ? country.trim() : "Sri Lanka");
            
            int rows = stmt.executeUpdate();
            System.out.println("✅ Rows inserted: " + rows);
            
            rs = stmt.getGeneratedKeys();
            int userId = -1;
            if (rs.next()) {
                userId = rs.getInt(1);
            }
            
            if (userId > 0) {
                System.out.println("✅ User added with ID: " + userId);
                out.print("{\"success\":true,\"message\":\"✅ User added successfully!\",\"id\":" + userId + "}");
            } else {
                out.print("{\"success\":false,\"message\":\"Failed to add user\"}");
            }
            
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.out.println("❌ addUser Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"" + escapeJson(e.getMessage()) + "\"}");
        } finally {
            closeConnection(conn);
        }
    }

    // ✅ UPDATE USER
    private void updateUser(HttpServletRequest request, PrintWriter out) {
        Connection conn = null;
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"User ID is required\"}");
                return;
            }
            
            int id = Integer.parseInt(idStr);
            String firstName = request.getParameter("first_name");
            String lastName = request.getParameter("last_name");
            String phone = request.getParameter("phone");
            String phone2 = request.getParameter("phone2");
            String nationalId = request.getParameter("national_id");
            String dateOfBirth = request.getParameter("date_of_birth");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String country = request.getParameter("country");
            
            System.out.println("========== UPDATE USER ==========");
            System.out.println("id: " + id);
            System.out.println("first_name: " + firstName);
            System.out.println("last_name: " + lastName);
            System.out.println("================================");
            
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            String sql = "UPDATE users SET first_name=?, last_name=?, phone=?, phone2=?, national_id=?, date_of_birth=?, address=?, city=?, country=? WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, firstName.trim());
            stmt.setString(2, lastName.trim());
            stmt.setString(3, phone.trim());
            stmt.setString(4, phone2 != null ? phone2.trim() : "");
            stmt.setString(5, nationalId != null ? nationalId.trim() : "");
            stmt.setString(6, dateOfBirth != null ? dateOfBirth.trim() : null);
            stmt.setString(7, address != null ? address.trim() : "");
            stmt.setString(8, city != null ? city.trim() : "");
            stmt.setString(9, country != null ? country.trim() : "Sri Lanka");
            stmt.setInt(10, id);
            
            int rows = stmt.executeUpdate();
            System.out.println("✅ Rows updated: " + rows);
            stmt.close();
            
            out.print("{\"success\":true,\"message\":\"✅ User updated successfully!\"}");
        } catch (Exception e) {
            System.out.println("❌ updateUser Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"" + escapeJson(e.getMessage()) + "\"}");
        } finally {
            closeConnection(conn);
        }
    }

    // ✅ DELETE USER
    private void deleteUser(HttpServletRequest request, PrintWriter out) {
        Connection conn = null;
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"User ID is required\"}");
                return;
            }
            
            int id = Integer.parseInt(idStr);
            
            System.out.println("========== DELETE USER ==========");
            System.out.println("id: " + id);
            System.out.println("================================");
            
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            String sql = "DELETE FROM users WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            int rows = stmt.executeUpdate();
            System.out.println("✅ Rows deleted: " + rows);
            stmt.close();
            
            out.print("{\"success\":true,\"message\":\"✅ User deleted successfully!\"}");
        } catch (Exception e) {
            System.out.println("❌ deleteUser Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"" + escapeJson(e.getMessage()) + "\"}");
        } finally {
            closeConnection(conn);
        }
    }

    private String escapeJson(String value) {
        if (value == null) return "";
        return value.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t");
    }

    private void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (Exception e) {
                System.out.println("⚠️ Error closing connection: " + e.getMessage());
            }
        }
    }
}
