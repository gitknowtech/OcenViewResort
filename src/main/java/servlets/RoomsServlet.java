package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/rooms")
public class RoomsServlet extends HttpServlet {
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
                getAllRooms(out);
            } else if ("getById".equals(action)) {
                String id = request.getParameter("id");
                getRoomById(out, id);
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
                addRoom(request, out);
            } else if ("update".equals(action)) {
                updateRoom(request, out);
            } else if ("delete".equals(action)) {
                deleteRoom(request, out);
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

    private void getAllRooms(PrintWriter out) {
        Connection conn = null;
        try {
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            String sql = "SELECT id, room_number, room_type, capacity, room_price, status, maintenance, booking_status, description FROM rooms ORDER BY id DESC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            StringBuilder json = new StringBuilder("[");
            boolean first = true;
            
            while (rs.next()) {
                if (!first) json.append(",");
                
                json.append("{")
                    .append("\"id\":").append(rs.getInt("id")).append(",")
                    .append("\"room_number\":\"").append(escapeJson(rs.getString("room_number"))).append("\",")
                    .append("\"room_type\":\"").append(escapeJson(rs.getString("room_type"))).append("\",")
                    .append("\"capacity\":").append(rs.getInt("capacity")).append(",")
                    .append("\"room_price\":").append(rs.getDouble("room_price")).append(",")
                    .append("\"status\":\"").append(escapeJson(rs.getString("status"))).append("\",")
                    .append("\"maintenance\":\"").append(escapeJson(rs.getString("maintenance"))).append("\",")
                    .append("\"booking_status\":\"").append(escapeJson(rs.getString("booking_status"))).append("\",")
                    .append("\"description\":\"").append(escapeJson(rs.getString("description"))).append("\"")
                    .append("}");
                
                first = false;
            }
            
            json.append("]");
            System.out.println("✅ getAllRooms: Returning records");
            out.print(json.toString());
            
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.out.println("❌ getAllRooms Error: " + e.getMessage());
            e.printStackTrace();
            out.print("[]");
        } finally {
            closeConnection(conn);
        }
    }

    private void getRoomById(PrintWriter out, String roomId) {
        Connection conn = null;
        try {
            if (roomId == null || roomId.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Room ID is required\"}");
                return;
            }
            
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            String sql = "SELECT * FROM rooms WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(roomId));
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                StringBuilder json = new StringBuilder();
                json.append("{\"success\":true,\"room\":{")
                    .append("\"id\":").append(rs.getInt("id")).append(",")
                    .append("\"room_number\":\"").append(escapeJson(rs.getString("room_number"))).append("\",")
                    .append("\"room_type\":\"").append(escapeJson(rs.getString("room_type"))).append("\",")
                    .append("\"capacity\":").append(rs.getInt("capacity")).append(",")
                    .append("\"room_price\":").append(rs.getDouble("room_price")).append(",")
                    .append("\"status\":\"").append(escapeJson(rs.getString("status"))).append("\",")
                    .append("\"maintenance\":\"").append(escapeJson(rs.getString("maintenance"))).append("\",")
                    .append("\"booking_status\":\"").append(escapeJson(rs.getString("booking_status"))).append("\",")
                    .append("\"description\":\"").append(escapeJson(rs.getString("description"))).append("\"")
                    .append("}}");
                
                System.out.println("✅ getRoomById: Found room ID " + roomId);
                out.print(json.toString());
            } else {
                out.print("{\"success\":false,\"message\":\"Room not found\"}");
            }
            
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.out.println("❌ getRoomById Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"" + escapeJson(e.getMessage()) + "\"}");
        } finally {
            closeConnection(conn);
        }
    }

    private void addRoom(HttpServletRequest request, PrintWriter out) {
        Connection conn = null;
        try {
            String room_number = request.getParameter("room_number");
            String room_type = request.getParameter("room_type");
            String capacity = request.getParameter("capacity");
            String room_price = request.getParameter("room_price");
            String status = request.getParameter("status");
            String maintenance = request.getParameter("maintenance");
            String booking_status = request.getParameter("booking_status");
            String description = request.getParameter("description");
            
            System.out.println("========== ADD ROOM DEBUG ==========");
            System.out.println("room_number: " + room_number);
            System.out.println("room_type: " + room_type);
            System.out.println("capacity: " + capacity);
            System.out.println("room_price: " + room_price);
            System.out.println("status: " + status);
            System.out.println("maintenance: " + maintenance);
            System.out.println("booking_status: " + booking_status);
            System.out.println("====================================");
            
            if (room_number == null || room_number.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Room number is required\"}");
                return;
            }
            if (room_type == null || room_type.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Room type is required\"}");
                return;
            }
            if (capacity == null || capacity.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Capacity is required\"}");
                return;
            }
            if (room_price == null || room_price.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Room price is required\"}");
                return;
            }
            if (status == null || status.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Status is required\"}");
                return;
            }
            if (maintenance == null || maintenance.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Maintenance is required\"}");
                return;
            }
            if (booking_status == null || booking_status.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Booking status is required\"}");
                return;
            }
            
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            // Check room number
            String checkSql = "SELECT id FROM rooms WHERE room_number = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, room_number.trim());
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {
                out.print("{\"success\":false,\"message\":\"Room number already exists\"}");
                rs.close();
                checkStmt.close();
                return;
            }
            rs.close();
            checkStmt.close();
            
            // Insert room
            String sql = "INSERT INTO rooms (room_number, room_type, capacity, room_price, status, maintenance, booking_status, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, room_number.trim());
            stmt.setString(2, room_type.trim());
            stmt.setInt(3, Integer.parseInt(capacity.trim()));
            stmt.setDouble(4, Double.parseDouble(room_price.trim()));
            stmt.setString(5, status.trim());
            stmt.setString(6, maintenance.trim());
            stmt.setString(7, booking_status.trim());
            stmt.setString(8, description != null ? description.trim() : "");
            
            stmt.executeUpdate();
            
            rs = stmt.getGeneratedKeys();
            int roomId = -1;
            if (rs.next()) {
                roomId = rs.getInt(1);
            }
            
            if (roomId > 0) {
                System.out.println("✅ Room added with ID: " + roomId);
                out.print("{\"success\":true,\"message\":\"✅ Room added successfully!\",\"id\":" + roomId + "}");
            } else {
                out.print("{\"success\":false,\"message\":\"Failed to add room\"}");
            }
            
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.out.println("❌ addRoom Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"" + escapeJson(e.getMessage()) + "\"}");
        } finally {
            closeConnection(conn);
        }
    }

    private void updateRoom(HttpServletRequest request, PrintWriter out) {
        Connection conn = null;
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Room ID is required\"}");
                return;
            }
            
            int id = Integer.parseInt(idStr);
            String room_type = request.getParameter("room_type");
            String capacity = request.getParameter("capacity");
            String room_price = request.getParameter("room_price");
            String status = request.getParameter("status");
            String maintenance = request.getParameter("maintenance");
            String booking_status = request.getParameter("booking_status");
            String description = request.getParameter("description");
            
            System.out.println("========== UPDATE ROOM DEBUG ==========");
            System.out.println("id: " + id);
            System.out.println("room_type: " + room_type);
            System.out.println("capacity: " + capacity);
            System.out.println("room_price: " + room_price);
            System.out.println("status: " + status);
            System.out.println("maintenance: " + maintenance);
            System.out.println("booking_status: " + booking_status);
            System.out.println("========================================");
            
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            String sql = "UPDATE rooms SET room_type=?, capacity=?, room_price=?, status=?, maintenance=?, booking_status=?, description=? WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, room_type.trim());
            stmt.setInt(2, Integer.parseInt(capacity.trim()));
            stmt.setDouble(3, Double.parseDouble(room_price.trim()));
            stmt.setString(4, status.trim());
            stmt.setString(5, maintenance.trim());
            stmt.setString(6, booking_status.trim());
            stmt.setString(7, description != null ? description.trim() : "");
            stmt.setInt(8, id);
            
            stmt.executeUpdate();
            stmt.close();
            
            System.out.println("✅ Room updated");
            out.print("{\"success\":true,\"message\":\"✅ Room updated successfully!\"}");
        } catch (Exception e) {
            System.out.println("❌ updateRoom Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"" + escapeJson(e.getMessage()) + "\"}");
        } finally {
            closeConnection(conn);
        }
    }

    private void deleteRoom(HttpServletRequest request, PrintWriter out) {
        Connection conn = null;
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Room ID is required\"}");
                return;
            }
            
            int id = Integer.parseInt(idStr);
            
            System.out.println("========== DELETE ROOM DEBUG ==========");
            System.out.println("id: " + id);
            System.out.println("========================================");
            
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            String sql = "DELETE FROM rooms WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.executeUpdate();
            stmt.close();
            
            System.out.println("✅ Room deleted");
            out.print("{\"success\":true,\"message\":\"✅ Room deleted successfully!\"}");
        } catch (Exception e) {
            System.out.println("❌ deleteRoom Error: " + e.getMessage());
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
