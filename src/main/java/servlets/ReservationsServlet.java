package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/reservations")
public class ReservationsServlet extends HttpServlet {
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
                getAllReservations(out);
            } else if ("getById".equals(action)) {
                String id = request.getParameter("id");
                getReservationById(out, id);
            } else if ("getByUser".equals(action)) {
                String userId = request.getParameter("user_id");
                getReservationsByUser(out, userId);
            } else if ("getAvailableRooms".equals(action)) {
                String date = request.getParameter("date");
                String time = request.getParameter("time");
                getAvailableRooms(out, date, time);
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
                addReservation(request, out);
            } else if ("update".equals(action)) {
                updateReservation(request, out);
            } else if ("cancel".equals(action)) {
                cancelReservation(request, out);
            } else if ("delete".equals(action)) {
                deleteReservation(request, out);
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

    private void getAllReservations(PrintWriter out) {
        Connection conn = null;
        try {
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            String sql = "SELECT r.id, r.user_id, r.room_id, u.first_name, u.last_name, rm.room_number, r.check_in_date, r.check_in_time, r.check_out_time, r.hours, r.hourly_rate, r.total_amount, r.status, r.payment_status FROM reservations r JOIN users u ON r.user_id = u.id JOIN rooms rm ON r.room_id = rm.id ORDER BY r.check_in_date DESC";
            
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            StringBuilder json = new StringBuilder("[");
            boolean first = true;
            int count = 0;
            
            while (rs.next()) {
                count++;
                if (!first) json.append(",");
                
                json.append("{")
                    .append("\"id\":").append(rs.getInt("id")).append(",")
                    .append("\"user_id\":").append(rs.getInt("user_id")).append(",")
                    .append("\"room_id\":").append(rs.getInt("room_id")).append(",")
                    .append("\"customer_name\":\"").append(escapeJson(rs.getString("first_name") + " " + rs.getString("last_name"))).append("\",")
                    .append("\"room_number\":\"").append(escapeJson(rs.getString("room_number"))).append("\",")
                    .append("\"check_in_date\":\"").append(escapeJson(rs.getString("check_in_date"))).append("\",")
                    .append("\"check_in_time\":\"").append(escapeJson(rs.getString("check_in_time"))).append("\",")
                    .append("\"check_out_time\":\"").append(escapeJson(rs.getString("check_out_time"))).append("\",")
                    .append("\"hours\":").append(rs.getInt("hours")).append(",")
                    .append("\"hourly_rate\":").append(rs.getDouble("hourly_rate")).append(",")
                    .append("\"total_amount\":").append(rs.getDouble("total_amount")).append(",")
                    .append("\"status\":\"").append(escapeJson(rs.getString("status"))).append("\",")
                    .append("\"payment_status\":\"").append(escapeJson(rs.getString("payment_status"))).append("\"")
                    .append("}");
                
                first = false;
            }
            
            json.append("]");
            System.out.println("✅ getAllReservations: Returning " + count + " records");
            out.print(json.toString());
            
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.out.println("❌ getAllReservations Error: " + e.getMessage());
            e.printStackTrace();
            out.print("[]");
        } finally {
            closeConnection(conn);
        }
    }

    private void getReservationById(PrintWriter out, String reservationId) {
        Connection conn = null;
        try {
            if (reservationId == null || reservationId.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Reservation ID is required\"}");
                return;
            }
            
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            String sql = "SELECT * FROM reservations WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(reservationId));
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                StringBuilder json = new StringBuilder();
                json.append("{\"success\":true,\"reservation\":{")
                    .append("\"id\":").append(rs.getInt("id")).append(",")
                    .append("\"user_id\":").append(rs.getInt("user_id")).append(",")
                    .append("\"room_id\":").append(rs.getInt("room_id")).append(",")
                    .append("\"check_in_date\":\"").append(escapeJson(rs.getString("check_in_date"))).append("\",")
                    .append("\"check_in_time\":\"").append(escapeJson(rs.getString("check_in_time"))).append("\",")
                    .append("\"check_out_time\":\"").append(escapeJson(rs.getString("check_out_time"))).append("\",")
                    .append("\"hours\":").append(rs.getInt("hours")).append(",")
                    .append("\"hourly_rate\":").append(rs.getDouble("hourly_rate")).append(",")
                    .append("\"total_amount\":").append(rs.getDouble("total_amount")).append(",")
                    .append("\"status\":\"").append(escapeJson(rs.getString("status"))).append("\",")
                    .append("\"payment_status\":\"").append(escapeJson(rs.getString("payment_status"))).append("\",")
                    .append("\"notes\":\"").append(escapeJson(rs.getString("notes"))).append("\"")
                    .append("}}");
                
                System.out.println("✅ getReservationById: Found reservation ID " + reservationId);
                out.print(json.toString());
            } else {
                out.print("{\"success\":false,\"message\":\"Reservation not found\"}");
            }
            
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.out.println("❌ getReservationById Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"" + escapeJson(e.getMessage()) + "\"}");
        } finally {
            closeConnection(conn);
        }
    }

    private void getReservationsByUser(PrintWriter out, String userId) {
        Connection conn = null;
        try {
            if (userId == null || userId.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"User ID is required\"}");
                return;
            }
            
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            String sql = "SELECT r.*, rm.room_number FROM reservations r JOIN rooms rm ON r.room_id = rm.id WHERE r.user_id = ? ORDER BY r.check_in_date DESC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(userId));
            
            ResultSet rs = stmt.executeQuery();
            
            StringBuilder json = new StringBuilder("[");
            boolean first = true;
            
            while (rs.next()) {
                if (!first) json.append(",");
                
                json.append("{")
                    .append("\"id\":").append(rs.getInt("id")).append(",")
                    .append("\"room_number\":\"").append(escapeJson(rs.getString("room_number"))).append("\",")
                    .append("\"check_in_date\":\"").append(escapeJson(rs.getString("check_in_date"))).append("\",")
                    .append("\"check_in_time\":\"").append(escapeJson(rs.getString("check_in_time"))).append("\",")
                    .append("\"check_out_time\":\"").append(escapeJson(rs.getString("check_out_time"))).append("\",")
                    .append("\"hours\":").append(rs.getInt("hours")).append(",")
                    .append("\"total_amount\":").append(rs.getDouble("total_amount")).append(",")
                    .append("\"status\":\"").append(escapeJson(rs.getString("status"))).append("\",")
                    .append("\"payment_status\":\"").append(escapeJson(rs.getString("payment_status"))).append("\"")
                    .append("}");
                
                first = false;
            }
            
            json.append("]");
            out.print(json.toString());
            
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.out.println("❌ getReservationsByUser Error: " + e.getMessage());
            e.printStackTrace();
            out.print("[]");
        } finally {
            closeConnection(conn);
        }
    }

    private void getAvailableRooms(PrintWriter out, String date, String time) {
        Connection conn = null;
        try {
            if (date == null || date.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Date is required\"}");
                return;
            }
            
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            String sql = "SELECT r.* FROM rooms r WHERE r.id NOT IN (SELECT DISTINCT room_id FROM reservations WHERE check_in_date = ? AND status != 'cancelled')";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, date);
            
            ResultSet rs = stmt.executeQuery();
            
            StringBuilder json = new StringBuilder("[");
            boolean first = true;
            
            while (rs.next()) {
                if (!first) json.append(",");
                
                json.append("{")
                    .append("\"id\":").append(rs.getInt("id")).append(",")
                    .append("\"room_number\":\"").append(escapeJson(rs.getString("room_number"))).append("\",")
                    .append("\"room_type\":\"").append(escapeJson(rs.getString("room_type"))).append("\",")
                    .append("\"room_price\":").append(rs.getDouble("room_price")).append(",")
                    .append("\"capacity\":").append(rs.getInt("capacity")).append("\"")
                    .append("}");
                
                first = false;
            }
            
            json.append("]");
            out.print(json.toString());
            
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.out.println("❌ getAvailableRooms Error: " + e.getMessage());
            e.printStackTrace();
            out.print("[]");
        } finally {
            closeConnection(conn);
        }
    }

    private void addReservation(HttpServletRequest request, PrintWriter out) {
        Connection conn = null;
        try {
            String userId = request.getParameter("user_id");
            String roomId = request.getParameter("room_id");
            String checkInDate = request.getParameter("check_in_date");
            String checkInTime = request.getParameter("check_in_time");
            String hoursStr = request.getParameter("hours");
            String hourlyRateStr = request.getParameter("hourly_rate");
            String notes = request.getParameter("notes");
            
            System.out.println("========== ADD RESERVATION ==========");
            System.out.println("user_id: " + userId);
            System.out.println("room_id: " + roomId);
            System.out.println("check_in_date: " + checkInDate);
            System.out.println("check_in_time: " + checkInTime);
            System.out.println("hours: " + hoursStr);
            System.out.println("hourly_rate: " + hourlyRateStr);
            System.out.println("=====================================");
            
            if (userId == null || userId.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"User ID is required\"}");
                return;
            }
            if (roomId == null || roomId.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Room ID is required\"}");
                return;
            }
            if (checkInDate == null || checkInDate.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Check-in date is required\"}");
                return;
            }
            if (checkInTime == null || checkInTime.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Check-in time is required\"}");
                return;
            }
            if (hoursStr == null || hoursStr.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Hours is required\"}");
                return;
            }
            if (hourlyRateStr == null || hourlyRateStr.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Hourly rate is required\"}");
                return;
            }
            
            int hours = Integer.parseInt(hoursStr);
            if (hours < 1 || hours > 6) {
                out.print("{\"success\":false,\"message\":\"Hours must be between 1 and 6\"}");
                return;
            }
            
            double hourlyRate = Double.parseDouble(hourlyRateStr);
            double totalAmount = hours * hourlyRate;
            
            // Calculate check-out time
            String[] timeParts = checkInTime.split(":");
            int hour = Integer.parseInt(timeParts[0]);
            int minute = Integer.parseInt(timeParts[1]);
            
            hour += hours;
            if (hour >= 24) {
                hour = hour % 24;
            }
            
            String checkOutTime = String.format("%02d:%02d:00", hour, minute);
            
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            // Check if room is available
            String checkSql = "SELECT id FROM reservations WHERE room_id = ? AND check_in_date = ? AND status != 'cancelled'";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setInt(1, Integer.parseInt(roomId));
            checkStmt.setString(2, checkInDate);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {
                out.print("{\"success\":false,\"message\":\"Room is not available on this date\"}");
                rs.close();
                checkStmt.close();
                return;
            }
            rs.close();
            checkStmt.close();
            
            // Insert reservation
            String sql = "INSERT INTO reservations (user_id, room_id, check_in_date, check_in_time, check_out_time, hours, hourly_rate, total_amount, notes) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, Integer.parseInt(userId));
            stmt.setInt(2, Integer.parseInt(roomId));
            stmt.setString(3, checkInDate);
            stmt.setString(4, checkInTime);
            stmt.setString(5, checkOutTime);
            stmt.setInt(6, hours);
            stmt.setDouble(7, hourlyRate);
            stmt.setDouble(8, totalAmount);
            stmt.setString(9, notes != null ? notes.trim() : "");
            
            stmt.executeUpdate();
            
            rs = stmt.getGeneratedKeys();
            int reservationId = -1;
            if (rs.next()) {
                reservationId = rs.getInt(1);
            }
            
            if (reservationId > 0) {
                System.out.println("✅ Reservation added with ID: " + reservationId);
                out.print("{\"success\":true,\"message\":\"✅ Reservation created successfully!\",\"id\":" + reservationId + ",\"total_amount\":" + totalAmount + "}");
            } else {
                out.print("{\"success\":false,\"message\":\"Failed to create reservation\"}");
            }
            
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.out.println("❌ addReservation Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"" + escapeJson(e.getMessage()) + "\"}");
        } finally {
            closeConnection(conn);
        }
    }

    private void updateReservation(HttpServletRequest request, PrintWriter out) {
        Connection conn = null;
        try {
            String idStr = request.getParameter("id");
            String status = request.getParameter("status");
            String paymentStatus = request.getParameter("payment_status");
            String notes = request.getParameter("notes");
            
            if (idStr == null || idStr.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Reservation ID is required\"}");
                return;
            }
            
            int id = Integer.parseInt(idStr);
            
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            String sql = "UPDATE reservations SET status=?, payment_status=?, notes=? WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, status);
            stmt.setString(2, paymentStatus);
            stmt.setString(3, notes != null ? notes.trim() : "");
            stmt.setInt(4, id);
            
            stmt.executeUpdate();
            stmt.close();
            
            System.out.println("✅ Reservation updated");
            out.print("{\"success\":true,\"message\":\"✅ Reservation updated successfully!\"}");
        } catch (Exception e) {
            System.out.println("❌ updateReservation Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"" + escapeJson(e.getMessage()) + "\"}");
        } finally {
            closeConnection(conn);
        }
    }

    private void cancelReservation(HttpServletRequest request, PrintWriter out) {
        Connection conn = null;
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Reservation ID is required\"}");
                return;
            }
            
            int id = Integer.parseInt(idStr);
            
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            String sql = "UPDATE reservations SET status='cancelled' WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.executeUpdate();
            stmt.close();
            
            System.out.println("✅ Reservation cancelled");
            out.print("{\"success\":true,\"message\":\"✅ Reservation cancelled successfully!\"}");
        } catch (Exception e) {
            System.out.println("❌ cancelReservation Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"" + escapeJson(e.getMessage()) + "\"}");
        } finally {
            closeConnection(conn);
        }
    }

    private void deleteReservation(HttpServletRequest request, PrintWriter out) {
        Connection conn = null;
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Reservation ID is required\"}");
                return;
            }
            
            int id = Integer.parseInt(idStr);
            
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            String sql = "DELETE FROM reservations WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.executeUpdate();
            stmt.close();
            
            System.out.println("✅ Reservation deleted");
            out.print("{\"success\":true,\"message\":\"✅ Reservation deleted successfully!\"}");
        } catch (Exception e) {
            System.out.println("❌ deleteReservation Error: " + e.getMessage());
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
