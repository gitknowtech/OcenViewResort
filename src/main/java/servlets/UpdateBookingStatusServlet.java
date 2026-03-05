package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/updateBookingStatus")
public class UpdateBookingStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/oceanview?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "";
    private static final String DB_DRIVER = "com.mysql.cj.jdbc.Driver";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        PrintWriter out = response.getWriter();

        String bookingId = request.getParameter("bookingId");
        String newStatus = request.getParameter("status");

        if (bookingId == null || bookingId.isEmpty()) {
            sendJsonResponse(out, false, "Booking ID is required");
            return;
        }

        if (newStatus == null || newStatus.isEmpty()) {
            sendJsonResponse(out, false, "Status is required");
            return;
        }

        // ✅ VALIDATE STATUS
        if (!newStatus.equals("confirmed") && !newStatus.equals("pending") && !newStatus.equals("cancelled")) {
            sendJsonResponse(out, false, "Invalid status. Must be: confirmed, pending, or cancelled");
            return;
        }

        Connection conn = null;
        try {
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            // ✅ UPDATE BOOKING STATUS
            String updateSQL = "UPDATE bookings SET booking_status = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(updateSQL);
            stmt.setString(1, newStatus);
            stmt.setInt(2, Integer.parseInt(bookingId));
            
            int rows = stmt.executeUpdate();
            stmt.close();

            if (rows > 0) {
                System.out.println("✅ Booking " + bookingId + " status updated to: " + newStatus);
                sendJsonResponse(out, true, "Booking status updated successfully");
            } else {
                sendJsonResponse(out, false, "Booking not found");
            }

        } catch (Exception e) {
            System.out.println("❌ Error: " + e.getMessage());
            e.printStackTrace();
            sendJsonResponse(out, false, "Server error: " + e.getMessage());
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

    // ✅ SEND JSON RESPONSE USING STRINGBUILDER
    private void sendJsonResponse(PrintWriter out, boolean success, String message) {
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"success\":").append(success).append(",");
        json.append("\"message\":\"").append(escapeJson(message)).append("\"");
        json.append("}");
        
        out.print(json.toString());
        out.flush();
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
}
