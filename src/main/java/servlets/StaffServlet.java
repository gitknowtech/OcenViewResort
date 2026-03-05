package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.PasswordUtils;

@WebServlet("/staff")
public class StaffServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/oceanview?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        String action = request.getParameter("action");
        
        try {
            if ("getAll".equals(action)) {
                getAllStaff(out);
            } else if ("getById".equals(action)) {
                String staffId = request.getParameter("id");
                getStaffById(out, staffId);
            } else {
                out.print("{\"success\":false,\"message\":\"Invalid action\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"Server error: " + escapeJson(e.getMessage()) + "\"}");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        String action = request.getParameter("action");
        
        try {
            if ("add".equals(action)) {
                addStaff(request, out);
            } else if ("update".equals(action)) {
                updateStaff(request, out);
            } else if ("delete".equals(action)) {
                deleteStaff(request, out);
            } else {
                out.print("{\"success\":false,\"message\":\"Invalid action\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"Server error: " + escapeJson(e.getMessage()) + "\"}");
        }
    }

    // ✅ GET ALL STAFF
    private void getAllStaff(PrintWriter out) {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            String sql = "SELECT id, name, username, email, phone, position FROM staff ORDER BY id DESC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            StringBuilder json = new StringBuilder("[");
            boolean first = true;
            
            while (rs.next()) {
                if (!first) json.append(",");
                
                json.append("{")
                    .append("\"id\":").append(rs.getInt("id")).append(",")
                    .append("\"name\":\"").append(escapeJson(rs.getString("name"))).append("\",")
                    .append("\"username\":\"").append(escapeJson(rs.getString("username"))).append("\",")
                    .append("\"email\":\"").append(escapeJson(rs.getString("email"))).append("\",")
                    .append("\"phone\":\"").append(escapeJson(rs.getString("phone"))).append("\",")
                    .append("\"position\":\"").append(escapeJson(rs.getString("position"))).append("\"")
                    .append("}");
                
                first = false;
            }
            
            json.append("]");
            out.print(json.toString());
            
            rs.close();
            stmt.close();
            
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"" + escapeJson(e.getMessage()) + "\"}");
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // ✅ GET STAFF BY ID
    private void getStaffById(PrintWriter out, String staffId) {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            String sql = "SELECT * FROM staff WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(staffId));
            
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                StringBuilder json = new StringBuilder();
                json.append("{\"success\":true,\"staff\":{")
                    .append("\"id\":").append(rs.getInt("id")).append(",")
                    .append("\"name\":\"").append(escapeJson(rs.getString("name"))).append("\",")
                    .append("\"username\":\"").append(escapeJson(rs.getString("username"))).append("\",")
                    .append("\"email\":\"").append(escapeJson(rs.getString("email"))).append("\",")
                    .append("\"phone\":\"").append(escapeJson(rs.getString("phone"))).append("\",")
                    .append("\"position\":\"").append(escapeJson(rs.getString("position"))).append("\"")
                    .append("}}");
                
                out.print(json.toString());
            } else {
                out.print("{\"success\":false,\"message\":\"Staff not found\"}");
            }
            
            rs.close();
            stmt.close();
            
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"" + escapeJson(e.getMessage()) + "\"}");
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // ✅ ADD STAFF - FIXED
    private void addStaff(HttpServletRequest request, PrintWriter out) {
        Connection conn = null;
        try {
            String name = request.getParameter("name");
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String phone = request.getParameter("phone");
            
            System.out.println("=== ADD STAFF REQUEST ===");
            System.out.println("Name: " + name);
            System.out.println("Username: " + username);
            System.out.println("Email: " + email);
            System.out.println("Phone: " + phone);
            System.out.println("Password: " + (password != null ? "***" : "null"));
            
            // Validation
            if (name == null || name.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Name is required\"}");
                return;
            }
            
            if (username == null || username.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Username is required\"}");
                return;
            }
            
            if (email == null || email.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Email is required\"}");
                return;
            }
            
            if (password == null || password.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Password is required\"}");
                return;
            }
            
            if (phone == null || phone.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Phone is required\"}");
                return;
            }
            
            // Validate email format
            if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
                out.print("{\"success\":false,\"message\":\"Invalid email format\"}");
                return;
            }
            
            // Validate phone
            if (!phone.matches("^[0-9\\-\\+\\(\\)\\s]{7,}$")) {
                out.print("{\"success\":false,\"message\":\"Invalid phone number (minimum 7 digits)\"}");
                return;
            }
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            // Check if username exists
            if (usernameExists(conn, username)) {
                out.print("{\"success\":false,\"message\":\"❌ Username already exists\"}");
                return;
            }
            
            // Check if email exists
            if (emailExists(conn, email)) {
                out.print("{\"success\":false,\"message\":\"❌ Email already exists\"}");
                return;
            }
            
            // Hash password
            String hashedPassword = PasswordUtils.hashPassword(password);
            System.out.println("Password hashed: " + hashedPassword.substring(0, 10) + "...");
            
            String sql = "INSERT INTO staff (name, username, email, password, phone, position) VALUES (?, ?, ?, ?, ?, 'Staff')";
            
            PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            stmt.setString(1, name.trim());
            stmt.setString(2, username.trim());
            stmt.setString(3, email.trim());
            stmt.setString(4, hashedPassword);
            stmt.setString(5, phone.trim());
            
            System.out.println("Executing INSERT...");
            int affectedRows = stmt.executeUpdate();
            System.out.println("Affected rows: " + affectedRows);
            
            int staffId = -1;
            ResultSet generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                staffId = generatedKeys.getInt(1);
                System.out.println("Generated ID: " + staffId);
            }
            
            if (staffId > 0) {
                out.print("{\"success\":true,\"message\":\"✅ Staff added successfully!\",\"id\":" + staffId + "}");
                System.out.println("✅ Staff added with ID: " + staffId);
            } else {
                out.print("{\"success\":false,\"message\":\"Failed to get generated ID\"}");
            }
            
            generatedKeys.close();
            stmt.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQL Error: " + e.getMessage());
            
            if (e.getMessage().contains("Duplicate entry")) {
                if (e.getMessage().contains("username")) {
                    out.print("{\"success\":false,\"message\":\"❌ Username already exists\"}");
                } else if (e.getMessage().contains("email")) {
                    out.print("{\"success\":false,\"message\":\"❌ Email already exists\"}");
                } else {
                    out.print("{\"success\":false,\"message\":\"❌ Duplicate entry error\"}");
                }
            } else {
                out.print("{\"success\":false,\"message\":\"❌ Database error: " + escapeJson(e.getMessage()) + "\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("General Error: " + e.getMessage());
            out.print("{\"success\":false,\"message\":\"❌ Error: " + escapeJson(e.getMessage()) + "\"}");
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // ✅ UPDATE STAFF
    private void updateStaff(HttpServletRequest request, PrintWriter out) {
        Connection conn = null;
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");
            
            if (name == null || name.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                phone == null || phone.trim().isEmpty()) {
                
                out.print("{\"success\":false,\"message\":\"All fields are required\"}");
                return;
            }
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            String sql;
            PreparedStatement stmt;
            
            if (password != null && !password.trim().isEmpty()) {
                String hashedPassword = PasswordUtils.hashPassword(password);
                sql = "UPDATE staff SET name=?, email=?, phone=?, password=? WHERE id=?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, name.trim());
                stmt.setString(2, email.trim());
                stmt.setString(3, phone.trim());
                stmt.setString(4, hashedPassword);
                stmt.setInt(5, id);
            } else {
                sql = "UPDATE staff SET name=?, email=?, phone=? WHERE id=?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, name.trim());
                stmt.setString(2, email.trim());
                stmt.setString(3, phone.trim());
                stmt.setInt(4, id);
            }
            
            stmt.executeUpdate();
            out.print("{\"success\":true,\"message\":\"✅ Staff updated successfully!\"}");
            
            stmt.close();
            
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"❌ Error: " + escapeJson(e.getMessage()) + "\"}");
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // ✅ DELETE STAFF
    private void deleteStaff(HttpServletRequest request, PrintWriter out) {
        Connection conn = null;
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            String sql = "DELETE FROM staff WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            
            stmt.executeUpdate();
            out.print("{\"success\":true,\"message\":\"✅ Staff deleted successfully!\"}");
            
            stmt.close();
            
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"❌ Error: " + escapeJson(e.getMessage()) + "\"}");
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // ✅ CHECK IF USERNAME EXISTS
    private boolean usernameExists(Connection conn, String username) throws Exception {
        String sql = "SELECT id FROM staff WHERE username = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, username);
        ResultSet rs = stmt.executeQuery();
        boolean exists = rs.next();
        rs.close();
        stmt.close();
        return exists;
    }

    // ✅ CHECK IF EMAIL EXISTS
    private boolean emailExists(Connection conn, String email) throws Exception {
        String sql = "SELECT id FROM staff WHERE email = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, email);
        ResultSet rs = stmt.executeQuery();
        boolean exists = rs.next();
        rs.close();
        stmt.close();
        return exists;
    }

    // ✅ ESCAPE JSON
    private String escapeJson(String input) {
        if (input == null) return "";
        return input.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\b", "\\b")
                   .replace("\f", "\\f")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t");
    }
}
