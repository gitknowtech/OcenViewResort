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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json;charset=UTF-8");
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
            out.print("{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
            out.flush();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json;charset=UTF-8");
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
            out.print("{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
            out.flush();
        }
    }

    // ✅ GET ALL STAFF
    private void getAllStaff(PrintWriter out) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/oceanview?useSSL=false&serverTimezone=UTC", 
                "root", 
                "")) {
                
                String sql = "SELECT id, name, username, email, phone, position FROM staff ORDER BY id DESC";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    try (ResultSet rs = stmt.executeQuery()) {
                        
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
                        System.out.println("✅ getAllStaff: Returning data");
                        out.print(json.toString());
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("❌ getAllStaff Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
        }
    }

    // ✅ GET STAFF BY ID
    private void getStaffById(PrintWriter out, String staffId) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/oceanview?useSSL=false&serverTimezone=UTC", 
                "root", 
                "")) {
                
                String sql = "SELECT * FROM staff WHERE id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, Integer.parseInt(staffId));
                    
                    try (ResultSet rs = stmt.executeQuery()) {
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
                            
                            System.out.println("✅ getStaffById: Found staff");
                            out.print(json.toString());
                        } else {
                            out.print("{\"success\":false,\"message\":\"Staff not found\"}");
                        }
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("❌ getStaffById Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
        }
    }

    // ✅ ADD STAFF
    private void addStaff(HttpServletRequest request, PrintWriter out) {
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
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/oceanview?useSSL=false&serverTimezone=UTC", 
                "root", 
                "")) {
                
                // Check username
                try (PreparedStatement checkUser = conn.prepareStatement("SELECT id FROM staff WHERE username = ?")) {
                    checkUser.setString(1, username.trim());
                    try (ResultSet rs = checkUser.executeQuery()) {
                        if (rs.next()) {
                            out.print("{\"success\":false,\"message\":\"Username already exists\"}");
                            return;
                        }
                    }
                }
                
                // Check email
                try (PreparedStatement checkEmail = conn.prepareStatement("SELECT id FROM staff WHERE email = ?")) {
                    checkEmail.setString(1, email.trim());
                    try (ResultSet rs = checkEmail.executeQuery()) {
                        if (rs.next()) {
                            out.print("{\"success\":false,\"message\":\"Email already exists\"}");
                            return;
                        }
                    }
                }
                
                // Hash password
                String hashedPassword = PasswordUtils.hashPassword(password);
                
                // Insert staff
                String sql = "INSERT INTO staff (name, username, email, password, phone, position) VALUES (?, ?, ?, ?, ?, 'Staff')";
                try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                    stmt.setString(1, name.trim());
                    stmt.setString(2, username.trim());
                    stmt.setString(3, email.trim());
                    stmt.setString(4, hashedPassword);
                    stmt.setString(5, phone.trim());
                    
                    stmt.executeUpdate();
                    
                    try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                        int staffId = -1;
                        if (generatedKeys.next()) {
                            staffId = generatedKeys.getInt(1);
                        }
                        
                        if (staffId > 0) {
                            System.out.println("✅ Staff added with ID: " + staffId);
                            out.print("{\"success\":true,\"message\":\"✅ Staff added successfully!\",\"id\":" + staffId + "}");
                        } else {
                            out.print("{\"success\":false,\"message\":\"Failed to add staff\"}");
                        }
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("❌ addStaff Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
        }
    }

    // ✅ UPDATE STAFF
    private void updateStaff(HttpServletRequest request, PrintWriter out) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
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
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/oceanview?useSSL=false&serverTimezone=UTC", 
                "root", 
                "")) {
                
                String sql;
                if (password != null && !password.trim().isEmpty()) {
                    String hashedPassword = PasswordUtils.hashPassword(password);
                    sql = "UPDATE staff SET name=?, email=?, phone=?, password=? WHERE id=?";
                    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                        stmt.setString(1, name.trim());
                        stmt.setString(2, email.trim());
                        stmt.setString(3, phone.trim());
                        stmt.setString(4, hashedPassword);
                        stmt.setInt(5, id);
                        stmt.executeUpdate();
                    }
                } else {
                    sql = "UPDATE staff SET name=?, email=?, phone=? WHERE id=?";
                    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                        stmt.setString(1, name.trim());
                        stmt.setString(2, email.trim());
                        stmt.setString(3, phone.trim());
                        stmt.setInt(4, id);
                        stmt.executeUpdate();
                    }
                }
                
                System.out.println("✅ Staff updated");
                out.print("{\"success\":true,\"message\":\"✅ Staff updated successfully!\"}");
            }
        } catch (Exception e) {
            System.out.println("❌ updateStaff Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
        }
    }

    // ✅ DELETE STAFF
    private void deleteStaff(HttpServletRequest request, PrintWriter out) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            System.out.println("========== DELETE STAFF DEBUG ==========");
            System.out.println("id: " + id);
            System.out.println("========================================");
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/oceanview?useSSL=false&serverTimezone=UTC", 
                "root", 
                "")) {
                
                String sql = "DELETE FROM staff WHERE id=?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, id);
                    stmt.executeUpdate();
                }
                
                System.out.println("✅ Staff deleted");
                out.print("{\"success\":true,\"message\":\"✅ Staff deleted successfully!\"}");
            }
        } catch (Exception e) {
            System.out.println("❌ deleteStaff Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
        }
    }

    // ✅ ESCAPE JSON
    private String escapeJson(String value) {
        if (value == null) return "";
        return value.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r");
    }
}
