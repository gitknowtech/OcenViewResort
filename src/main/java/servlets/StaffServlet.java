package servlets;

import java.io.IOException;
import java.io.PrintWriter;
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
import utils.PasswordUtils;

@WebServlet("/staff")
public class StaffServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // ✅ DATABASE CONFIG
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
                getAllStaff(out);
            } else if ("getById".equals(action)) {
                String id = request.getParameter("id");
                getStaffById(out, id);
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
                addStaff(request, out);
            } else if ("update".equals(action)) {
                updateStaff(request, out);
            } else if ("delete".equals(action)) {
                deleteStaff(request, out);
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

    // ✅ OPTIONS for CORS
    @Override
    protected void doOptions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        response.setStatus(HttpServletResponse.SC_OK);
    }

    // ✅ GET ALL STAFF
    private void getAllStaff(PrintWriter out) {
        Connection conn = null;
        try {
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
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
            System.out.println("✅ getAllStaff: Returning " + (first ? 0 : 1) + " records");
            out.print(json.toString());
            
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.out.println("❌ getAllStaff Error: " + e.getMessage());
            e.printStackTrace();
            out.print("[]");
        } finally {
            closeConnection(conn);
        }
    }

    // ✅ GET STAFF BY ID
    private void getStaffById(PrintWriter out, String staffId) {
        Connection conn = null;
        try {
            if (staffId == null || staffId.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Staff ID is required\"}");
                return;
            }
            
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
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
                
                System.out.println("✅ getStaffById: Found staff ID " + staffId);
                out.print(json.toString());
            } else {
                out.print("{\"success\":false,\"message\":\"Staff not found\"}");
            }
            
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.out.println("❌ getStaffById Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"" + escapeJson(e.getMessage()) + "\"}");
        } finally {
            closeConnection(conn);
        }
    }

    // ✅ ADD STAFF
    private void addStaff(HttpServletRequest request, PrintWriter out) {
        Connection conn = null;
        try {
            String name = request.getParameter("name");
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String phone = request.getParameter("phone");
            
            System.out.println("========== ADD STAFF DEBUG ==========");
            System.out.println("name: " + name);
            System.out.println("username: " + username);
            System.out.println("email: " + email);
            System.out.println("phone: " + phone);
            System.out.println("====================================");
            
            // ✅ VALIDATION
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
            
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            // Check username
            String checkUserSql = "SELECT id FROM staff WHERE username = ?";
            PreparedStatement checkUser = conn.prepareStatement(checkUserSql);
            checkUser.setString(1, username.trim());
            ResultSet rs = checkUser.executeQuery();
            if (rs.next()) {
                out.print("{\"success\":false,\"message\":\"Username already exists\"}");
                rs.close();
                checkUser.close();
                return;
            }
            rs.close();
            checkUser.close();
            
            // Check email
            String checkEmailSql = "SELECT id FROM staff WHERE email = ?";
            PreparedStatement checkEmail = conn.prepareStatement(checkEmailSql);
            checkEmail.setString(1, email.trim());
            rs = checkEmail.executeQuery();
            if (rs.next()) {
                out.print("{\"success\":false,\"message\":\"Email already exists\"}");
                rs.close();
                checkEmail.close();
                return;
            }
            rs.close();
            checkEmail.close();
            
            // Hash password
            String hashedPassword = PasswordUtils.hashPassword(password);
            
            // Insert staff
            String sql = "INSERT INTO staff (name, username, email, password, phone, position) VALUES (?, ?, ?, ?, ?, 'Staff')";
            PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, name.trim());
            stmt.setString(2, username.trim());
            stmt.setString(3, email.trim());
            stmt.setString(4, hashedPassword);
            stmt.setString(5, phone.trim());
            
            stmt.executeUpdate();
            
            rs = stmt.getGeneratedKeys();
            int staffId = -1;
            if (rs.next()) {
                staffId = rs.getInt(1);
            }
            
            if (staffId > 0) {
                System.out.println("✅ Staff added with ID: " + staffId);
                out.print("{\"success\":true,\"message\":\"✅ Staff added successfully!\",\"id\":" + staffId + "}");
            } else {
                out.print("{\"success\":false,\"message\":\"Failed to add staff\"}");
            }
            
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.out.println("❌ addStaff Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"" + escapeJson(e.getMessage()) + "\"}");
        } finally {
            closeConnection(conn);
        }
    }

    // ✅ UPDATE STAFF
    private void updateStaff(HttpServletRequest request, PrintWriter out) {
        Connection conn = null;
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Staff ID is required\"}");
                return;
            }
            
            int id = Integer.parseInt(idStr);
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");
            
            System.out.println("========== UPDATE STAFF DEBUG ==========");
            System.out.println("id: " + id);
            System.out.println("name: " + name);
            System.out.println("email: " + email);
            System.out.println("phone: " + phone);
            System.out.println("========================================");
            
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
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
            stmt.close();
            
            System.out.println("✅ Staff updated");
            out.print("{\"success\":true,\"message\":\"✅ Staff updated successfully!\"}");
        } catch (Exception e) {
            System.out.println("❌ updateStaff Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"" + escapeJson(e.getMessage()) + "\"}");
        } finally {
            closeConnection(conn);
        }
    }

    // ✅ DELETE STAFF
    private void deleteStaff(HttpServletRequest request, PrintWriter out) {
        Connection conn = null;
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Staff ID is required\"}");
                return;
            }
            
            int id = Integer.parseInt(idStr);
            
            System.out.println("========== DELETE STAFF DEBUG ==========");
            System.out.println("id: " + id);
            System.out.println("========================================");
            
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            String sql = "DELETE FROM staff WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.executeUpdate();
            stmt.close();
            
            System.out.println("✅ Staff deleted");
            out.print("{\"success\":true,\"message\":\"✅ Staff deleted successfully!\"}");
        } catch (Exception e) {
            System.out.println("❌ deleteStaff Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"" + escapeJson(e.getMessage()) + "\"}");
        } finally {
            closeConnection(conn);
        }
    }

    // ✅ ESCAPE JSON
    private String escapeJson(String value) {
        if (value == null) return "";
        return value.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t");
    }

    // ✅ CLOSE CONNECTION
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
