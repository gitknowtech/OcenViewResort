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

    private void getAllUsers(PrintWriter out) {
        Connection conn = null;
        try {
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            String sql = "SELECT id, name, email, phone, address, city, country, status FROM users ORDER BY id DESC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            StringBuilder json = new StringBuilder("[");
            boolean first = true;
            
            while (rs.next()) {
                if (!first) json.append(",");
                
                json.append("{")
                    .append("\"id\":").append(rs.getInt("id")).append(",")
                    .append("\"name\":\"").append(escapeJson(rs.getString("name"))).append("\",")
                    .append("\"email\":\"").append(escapeJson(rs.getString("email"))).append("\",")
                    .append("\"phone\":\"").append(escapeJson(rs.getString("phone"))).append("\",")
                    .append("\"address\":\"").append(escapeJson(rs.getString("address"))).append("\",")
                    .append("\"city\":\"").append(escapeJson(rs.getString("city"))).append("\",")
                    .append("\"country\":\"").append(escapeJson(rs.getString("country"))).append("\",")
                    .append("\"status\":\"").append(escapeJson(rs.getString("status"))).append("\"")
                    .append("}");
                
                first = false;
            }
            
            json.append("]");
            System.out.println("✅ getAllUsers: Returning records");
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
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                StringBuilder json = new StringBuilder();
                json.append("{\"success\":true,\"user\":{")
                    .append("\"id\":").append(rs.getInt("id")).append(",")
                    .append("\"name\":\"").append(escapeJson(rs.getString("name"))).append("\",")
                    .append("\"email\":\"").append(escapeJson(rs.getString("email"))).append("\",")
                    .append("\"phone\":\"").append(escapeJson(rs.getString("phone"))).append("\",")
                    .append("\"address\":\"").append(escapeJson(rs.getString("address"))).append("\",")
                    .append("\"city\":\"").append(escapeJson(rs.getString("city"))).append("\",")
                    .append("\"country\":\"").append(escapeJson(rs.getString("country"))).append("\",")
                    .append("\"status\":\"").append(escapeJson(rs.getString("status"))).append("\"")
                    .append("}}");
                
                System.out.println("✅ getUserById: Found user ID " + userId);
                out.print(json.toString());
            } else {
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

    private void addUser(HttpServletRequest request, PrintWriter out) {
        Connection conn = null;
        try {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String country = request.getParameter("country");
            String status = request.getParameter("status");
            
            System.out.println("========== ADD USER DEBUG ==========");
            System.out.println("name: " + name);
            System.out.println("email: " + email);
            System.out.println("phone: " + phone);
            System.out.println("address: " + address);
            System.out.println("city: " + city);
            System.out.println("country: " + country);
            System.out.println("status: " + status);
            System.out.println("====================================");
            
            if (name == null || name.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Name is required\"}");
                return;
            }
            if (email == null || email.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Email is required\"}");
                return;
            }
            if (phone == null || phone.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Phone is required\"}");
                return;
            }
            if (status == null || status.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Status is required\"}");
                return;
            }
            
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            // Check email
            String checkSql = "SELECT id FROM users WHERE email = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, email.trim());
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {
                out.print("{\"success\":false,\"message\":\"Email already exists\"}");
                rs.close();
                checkStmt.close();
                return;
            }
            rs.close();
            checkStmt.close();
            
            // Insert user
            String sql = "INSERT INTO users (name, email, phone, address, city, country, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, name.trim());
            stmt.setString(2, email.trim());
            stmt.setString(3, phone.trim());
            stmt.setString(4, address != null ? address.trim() : "");
            stmt.setString(5, city != null ? city.trim() : "");
            stmt.setString(6, country != null ? country.trim() : "");
            stmt.setString(7, status.trim());
            
            stmt.executeUpdate();
            
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

    private void updateUser(HttpServletRequest request, PrintWriter out) {
        Connection conn = null;
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"User ID is required\"}");
                return;
            }
            
            int id = Integer.parseInt(idStr);
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String country = request.getParameter("country");
            String status = request.getParameter("status");
            
            System.out.println("========== UPDATE USER DEBUG ==========");
            System.out.println("id: " + id);
            System.out.println("name: " + name);
            System.out.println("phone: " + phone);
            System.out.println("address: " + address);
            System.out.println("city: " + city);
            System.out.println("country: " + country);
            System.out.println("status: " + status);
            System.out.println("========================================");
            
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            String sql = "UPDATE users SET name=?, phone=?, address=?, city=?, country=?, status=? WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name.trim());
            stmt.setString(2, phone.trim());
            stmt.setString(3, address != null ? address.trim() : "");
            stmt.setString(4, city != null ? city.trim() : "");
            stmt.setString(5, country != null ? country.trim() : "");
            stmt.setString(6, status.trim());
            stmt.setInt(7, id);
            
            stmt.executeUpdate();
            stmt.close();
            
            System.out.println("✅ User updated");
            out.print("{\"success\":true,\"message\":\"✅ User updated successfully!\"}");
        } catch (Exception e) {
            System.out.println("❌ updateUser Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"" + escapeJson(e.getMessage()) + "\"}");
        } finally {
            closeConnection(conn);
        }
    }

    private void deleteUser(HttpServletRequest request, PrintWriter out) {
        Connection conn = null;
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"User ID is required\"}");
                return;
            }
            
            int id = Integer.parseInt(idStr);
            
            System.out.println("========== DELETE USER DEBUG ==========");
            System.out.println("id: " + id);
            System.out.println("========================================");
            
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            String sql = "DELETE FROM users WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.executeUpdate();
            stmt.close();
            
            System.out.println("✅ User deleted");
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
