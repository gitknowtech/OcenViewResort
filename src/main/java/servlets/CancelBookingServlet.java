package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/cancelBooking")
public class CancelBookingServlet extends HttpServlet {
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

        if (bookingId == null || bookingId.isEmpty()) {
            sendJsonResponse(out, false, "Booking ID is required");
            return;
        }

        Connection conn = null;
        try {
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            System.out.println("\n╔════════════════════════════════════════╗");
            System.out.println("║  🔄 CANCELLING BOOKING                 ║");
            System.out.println("╚════════════════════════════════════════╝");
            System.out.println("📋 Booking ID: " + bookingId);

            // ✅ GET BOOKING DETAILS
            String getBookingSQL = "SELECT room_id, room_number FROM bookings WHERE id = ?";
            PreparedStatement getStmt = conn.prepareStatement(getBookingSQL);
            getStmt.setInt(1, Integer.parseInt(bookingId));
            
            ResultSet rs = getStmt.executeQuery();
            if (!rs.next()) {
                System.out.println("❌ Booking not found");
                sendJsonResponse(out, false, "Booking not found");
                rs.close();
                getStmt.close();
                return;
            }

            int roomId = rs.getInt("room_id");
            String roomNumber = rs.getString("room_number");
            rs.close();
            getStmt.close();

            System.out.println("✅ Booking found:");
            System.out.println("   - Room ID: " + roomId);
            System.out.println("   - Room Number: " + roomNumber);

            // ✅ UPDATE BOOKING STATUS TO CANCELLED
            System.out.println("\n📝 Step 1: Updating booking status...");
            String updateBookingSQL = "UPDATE bookings SET booking_status = 'cancelled' WHERE id = ?";
            PreparedStatement updateBooking = conn.prepareStatement(updateBookingSQL);
            updateBooking.setInt(1, Integer.parseInt(bookingId));
            
            int bookingRows = updateBooking.executeUpdate();
            updateBooking.close();
            
            System.out.println("   - Rows affected: " + bookingRows);
            if (bookingRows > 0) {
                System.out.println("   ✅ Booking status set to 'cancelled'");
            }

            // ✅ UPDATE ROOM STATUS TO AVAILABLE
            System.out.println("\n📝 Step 2: Updating room status...");
            String updateRoomSQL = "UPDATE rooms SET booking_status = 'available' WHERE id = ?";
            PreparedStatement updateRoom = conn.prepareStatement(updateRoomSQL);
            updateRoom.setInt(1, roomId);
            
            int roomRows = updateRoom.executeUpdate();
            updateRoom.close();
            
            System.out.println("   - Rows affected: " + roomRows);
            if (roomRows > 0) {
                System.out.println("   ✅ Room status set to 'available'");
            }

            System.out.println("\n═══════════════════════════════════════════");

            if (bookingRows > 0 && roomRows > 0) {
                System.out.println("✅ CANCELLATION SUCCESSFUL");
                System.out.println("   - Booking #" + bookingId + " cancelled");
                System.out.println("   - Room #" + roomNumber + " now available");
                sendJsonResponse(out, true, "✅ Booking cancelled successfully! Room #" + roomNumber + " is now available.");
            } else {
                System.out.println("❌ CANCELLATION FAILED");
                System.out.println("   - Booking rows: " + bookingRows);
                System.out.println("   - Room rows: " + roomRows);
                sendJsonResponse(out, false, "Failed to cancel booking. Please try again.");
            }

        } catch (NumberFormatException e) {
            System.out.println("❌ Invalid booking ID format: " + bookingId);
            sendJsonResponse(out, false, "Invalid booking ID");
        } catch (Exception e) {
            System.out.println("❌ ERROR: " + e.getMessage());
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

    // ✅ SEND JSON RESPONSE
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
