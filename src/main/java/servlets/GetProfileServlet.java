package servlets;  // ← ADD THIS LINE

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/getProfile")
public class GetProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("userId") == null) {
                out.print("{\"success\":false,\"message\":\"Not logged in\"}");
                return;
            }

            int userId = (Integer) session.getAttribute("userId");
            System.out.println("📊 Getting profile for user ID: " + userId);

            String url = "jdbc:mysql://localhost:3306/oceanview?useSSL=false&serverTimezone=UTC";
            String dbUser = "root";
            String dbPassword = "";

            Class.forName("com.mysql.cj.jdbc.Driver");
            
            try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword)) {
                
                String sql = "SELECT id, username, email, first_name, last_name, phone, phone2, " +
                           "national_id, date_of_birth, address, city, country, created_at, last_login " +
                           "FROM users WHERE id = ?";
                
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, userId);
                    
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            StringBuilder json = new StringBuilder();
                            json.append("{\"success\":true,\"user\":{");
                            json.append("\"id\":").append(rs.getInt("id")).append(",");
                            json.append("\"username\":\"").append(escapeJson(rs.getString("username"))).append("\",");
                            json.append("\"email\":\"").append(escapeJson(rs.getString("email"))).append("\",");
                            json.append("\"firstName\":\"").append(escapeJson(rs.getString("first_name"))).append("\",");
                            json.append("\"lastName\":\"").append(escapeJson(rs.getString("last_name"))).append("\",");
                            json.append("\"phone\":\"").append(escapeJson(rs.getString("phone"))).append("\",");
                            json.append("\"phone2\":\"").append(escapeJson(rs.getString("phone2"))).append("\",");
                            json.append("\"nationalId\":\"").append(escapeJson(rs.getString("national_id"))).append("\",");
                            json.append("\"dateOfBirth\":\"").append(escapeJson(rs.getString("date_of_birth"))).append("\",");
                            json.append("\"address\":\"").append(escapeJson(rs.getString("address"))).append("\",");
                            json.append("\"city\":\"").append(escapeJson(rs.getString("city"))).append("\",");
                            json.append("\"country\":\"").append(escapeJson(rs.getString("country"))).append("\",");
                            json.append("\"createdAt\":\"").append(escapeJson(rs.getString("created_at"))).append("\",");
                            json.append("\"lastLogin\":\"").append(escapeJson(rs.getString("last_login"))).append("\"");
                            json.append("}}");
                            
                            System.out.println("✅ Profile data retrieved for: " + rs.getString("username"));
                            out.print(json.toString());
                            
                        } else {
                            out.print("{\"success\":false,\"message\":\"User not found\"}");
                        }
                    }
                }
            }
            
        } catch (Exception e) {
            System.out.println("❌ Get Profile Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"Server error occurred\"}");
        }
    }

    private String escapeJson(String value) {
        if (value == null) return "";
        return value.replace("\"", "\\\"")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\\", "\\\\");
    }
}
