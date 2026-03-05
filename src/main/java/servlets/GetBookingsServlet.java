package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/getBookings")
public class GetBookingsServlet extends HttpServlet {
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
        PrintWriter out = response.getWriter();

        String userId = request.getParameter("userId");
        String bookingId = request.getParameter("bookingId");

        Connection conn = null;
        try {
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            StringBuilder json = new StringBuilder();
            json.append("[");

            if (bookingId != null && !bookingId.isEmpty()) {
                // ✅ GET SINGLE BOOKING
                String sql = "SELECT *, DATEDIFF(check_out_date, check_in_date) as nights FROM bookings WHERE id = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, Integer.parseInt(bookingId));
                
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    json.append(buildBookingJson(rs));
                }
                rs.close();
                stmt.close();

            } else if (userId != null && !userId.isEmpty()) {
                // ✅ GET USER'S BOOKINGS
                String sql = "SELECT *, DATEDIFF(check_out_date, check_in_date) as nights FROM bookings WHERE user_id = ? ORDER BY created_at DESC";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, Integer.parseInt(userId));
                
                ResultSet rs = stmt.executeQuery();
                boolean first = true;
                while (rs.next()) {
                    if (!first) json.append(",");
                    json.append(buildBookingJson(rs));
                    first = false;
                }
                rs.close();
                stmt.close();

            } else {
                // ✅ GET ALL BOOKINGS
                String sql = "SELECT *, DATEDIFF(check_out_date, check_in_date) as nights FROM bookings ORDER BY created_at DESC";
                Statement stmt = conn.createStatement();
                
                ResultSet rs = stmt.executeQuery(sql);
                boolean first = true;
                while (rs.next()) {
                    if (!first) json.append(",");
                    json.append(buildBookingJson(rs));
                    first = false;
                }
                rs.close();
                stmt.close();
            }

            json.append("]");
            out.print(json.toString());
            out.flush();

        } catch (Exception e) {
            System.out.println("❌ Error: " + e.getMessage());
            e.printStackTrace();
            
            StringBuilder error = new StringBuilder();
            error.append("{\"error\":\"").append(escapeJson(e.getMessage())).append("\"}");
            out.print(error.toString());
            out.flush();
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

    // ✅ BUILD BOOKING JSON OBJECT
    private String buildBookingJson(ResultSet rs) throws SQLException {
        StringBuilder booking = new StringBuilder();
        booking.append("{");
        booking.append("\"id\":").append(rs.getInt("id")).append(",");
        booking.append("\"userId\":").append(rs.getInt("user_id")).append(",");
        booking.append("\"username\":\"").append(escapeJson(rs.getString("username"))).append("\",");
        booking.append("\"email\":\"").append(escapeJson(rs.getString("email"))).append("\",");
        booking.append("\"roomId\":").append(rs.getInt("room_id")).append(",");
        booking.append("\"roomNumber\":\"").append(escapeJson(rs.getString("room_number"))).append("\",");
        booking.append("\"roomType\":\"").append(escapeJson(rs.getString("room_type"))).append("\",");
        booking.append("\"pricePerNight\":").append(rs.getDouble("price_per_night")).append(",");
        booking.append("\"checkInDate\":\"").append(escapeJson(rs.getString("check_in_date"))).append("\",");
        booking.append("\"checkOutDate\":\"").append(escapeJson(rs.getString("check_out_date"))).append("\",");
        booking.append("\"checkInTime\":\"").append(escapeJson(rs.getString("check_in_time"))).append("\",");
        booking.append("\"checkOutTime\":\"").append(escapeJson(rs.getString("check_out_time"))).append("\",");
        booking.append("\"numberOfGuests\":").append(rs.getInt("number_of_guests")).append(",");
        booking.append("\"totalPrice\":").append(rs.getDouble("total_price")).append(",");
        booking.append("\"nights\":").append(rs.getInt("nights")).append(",");
        booking.append("\"specialRequests\":\"").append(escapeJson(rs.getString("special_requests"))).append("\",");
        booking.append("\"bookingStatus\":\"").append(escapeJson(rs.getString("booking_status"))).append("\",");
        booking.append("\"createdAt\":\"").append(escapeJson(rs.getString("created_at"))).append("\",");
        booking.append("\"updatedAt\":\"").append(escapeJson(rs.getString("updated_at"))).append("\"");
        booking.append("}");
        return booking.toString();
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
