package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
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
            System.out.println("🔵 Dashboard GET: action=" + action);
            
            if ("getStats".equals(action)) {
                getStats(out);
            } else if ("getReservationChart".equals(action)) {
                getReservationChart(out);
            } else if ("getRoomOccupancy".equals(action)) {
                getRoomOccupancy(out);
            } else if ("getRevenueChart".equals(action)) {
                getRevenueChart(out);
            } else if ("getPaymentStatus".equals(action)) {
                getPaymentStatus(out);
            } else {
                out.print("{\"success\":false,\"message\":\"Invalid action\"}");
            }
            out.flush();
        } catch (Exception e) {
            System.out.println("❌ Dashboard Error: " + e.getMessage());
            e.printStackTrace();
            try {
                out.print("{\"success\":false,\"message\":\"" + escapeJson(e.getMessage()) + "\"}");
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            out.flush();
        }
    }

    private void getStats(PrintWriter out) {
        Connection conn = null;
        try {
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            int totalReservations = 0;
            int confirmedReservations = 0;
            int totalUsers = 0;
            int totalRooms = 0;
            int availableRooms = 0;
            int totalStaff = 0;
            double totalRevenue = 0.0;
            int pendingPayments = 0;
            
            // Total Reservations
            String sql1 = "SELECT COUNT(*) as count FROM reservations";
            PreparedStatement stmt1 = conn.prepareStatement(sql1);
            ResultSet rs1 = stmt1.executeQuery();
            if (rs1.next()) {
                totalReservations = rs1.getInt("count");
            }
            rs1.close();
            stmt1.close();
            
            // Confirmed Reservations
            String sql2 = "SELECT COUNT(*) as count FROM reservations WHERE status = 'confirmed'";
            PreparedStatement stmt2 = conn.prepareStatement(sql2);
            ResultSet rs2 = stmt2.executeQuery();
            if (rs2.next()) {
                confirmedReservations = rs2.getInt("count");
            }
            rs2.close();
            stmt2.close();
            
            // Total Users
            String sql3 = "SELECT COUNT(*) as count FROM users";
            PreparedStatement stmt3 = conn.prepareStatement(sql3);
            ResultSet rs3 = stmt3.executeQuery();
            if (rs3.next()) {
                totalUsers = rs3.getInt("count");
            }
            rs3.close();
            stmt3.close();
            
            // Total Rooms
            String sql4 = "SELECT COUNT(*) as count FROM rooms";
            PreparedStatement stmt4 = conn.prepareStatement(sql4);
            ResultSet rs4 = stmt4.executeQuery();
            if (rs4.next()) {
                totalRooms = rs4.getInt("count");
            }
            rs4.close();
            stmt4.close();
            
            // Available Rooms
            String sql5 = "SELECT COUNT(*) as count FROM rooms WHERE status = 'active' AND booking_status = 'non-booked'";
            PreparedStatement stmt5 = conn.prepareStatement(sql5);
            ResultSet rs5 = stmt5.executeQuery();
            if (rs5.next()) {
                availableRooms = rs5.getInt("count");
            }
            rs5.close();
            stmt5.close();
            
            // Total Staff
            String sql6 = "SELECT COUNT(*) as count FROM staff";
            PreparedStatement stmt6 = conn.prepareStatement(sql6);
            ResultSet rs6 = stmt6.executeQuery();
            if (rs6.next()) {
                totalStaff = rs6.getInt("count");
            }
            rs6.close();
            stmt6.close();
            
            // Total Revenue
            String sql7 = "SELECT SUM(total_amount) as total FROM reservations WHERE payment_status = 'paid'";
            PreparedStatement stmt7 = conn.prepareStatement(sql7);
            ResultSet rs7 = stmt7.executeQuery();
            if (rs7.next()) {
                Double revenue = rs7.getDouble("total");
                totalRevenue = (revenue != null && !rs7.wasNull()) ? revenue : 0.0;
            }
            rs7.close();
            stmt7.close();
            
            // Pending Payments
            String sql8 = "SELECT COUNT(*) as count FROM reservations WHERE payment_status = 'unpaid'";
            PreparedStatement stmt8 = conn.prepareStatement(sql8);
            ResultSet rs8 = stmt8.executeQuery();
            if (rs8.next()) {
                pendingPayments = rs8.getInt("count");
            }
            rs8.close();
            stmt8.close();
            
            // Build JSON manually
            StringBuilder json = new StringBuilder();
            json.append("{")
                .append("\"success\":true,")
                .append("\"totalReservations\":").append(totalReservations).append(",")
                .append("\"confirmedReservations\":").append(confirmedReservations).append(",")
                .append("\"totalUsers\":").append(totalUsers).append(",")
                .append("\"totalRooms\":").append(totalRooms).append(",")
                .append("\"availableRooms\":").append(availableRooms).append(",")
                .append("\"totalStaff\":").append(totalStaff).append(",")
                .append("\"totalRevenue\":").append(String.format("%.2f", totalRevenue)).append(",")
                .append("\"pendingPayments\":").append(pendingPayments)
                .append("}");
            
            System.out.println("✅ getStats: Returning stats");
            out.print(json.toString());
            
        } catch (Exception e) {
            System.out.println("❌ getStats Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"" + escapeJson(e.getMessage()) + "\"}");
        } finally {
            closeConnection(conn);
        }
    }

    private void getReservationChart(PrintWriter out) {
        Connection conn = null;
        try {
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            String sql = "SELECT status, COUNT(*) as count FROM reservations GROUP BY status";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            StringBuilder labels = new StringBuilder("[");
            StringBuilder data = new StringBuilder("[");
            StringBuilder colors = new StringBuilder("[");
            
            java.util.Map<String, String> colorMap = new java.util.HashMap<>();
            colorMap.put("pending", "#f59e0b");
            colorMap.put("confirmed", "#10b981");
            colorMap.put("checked-in", "#3b82f6");
            colorMap.put("checked-out", "#8b5cf6");
            colorMap.put("cancelled", "#ef4444");
            
            boolean first = true;
            int count = 0;
            
            while (rs.next()) {
                count++;
                String status = rs.getString("status");
                int statusCount = rs.getInt("count");
                
                if (!first) {
                    labels.append(",");
                    data.append(",");
                    colors.append(",");
                }
                
                labels.append("\"").append(status.toUpperCase()).append("\"");
                data.append(statusCount);
                colors.append("\"").append(colorMap.getOrDefault(status, "#6b7280")).append("\"");
                
                first = false;
            }
            
            labels.append("]");
            data.append("]");
            colors.append("]");
            
            StringBuilder response = new StringBuilder();
            response.append("{")
                .append("\"success\":true,")
                .append("\"labels\":").append(labels).append(",")
                .append("\"data\":").append(data).append(",")
                .append("\"colors\":").append(colors)
                .append("}");
            
            System.out.println("✅ getReservationChart: Returning " + count + " statuses");
            out.print(response.toString());
            
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.out.println("❌ getReservationChart Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"" + escapeJson(e.getMessage()) + "\"}");
        } finally {
            closeConnection(conn);
        }
    }

    private void getRoomOccupancy(PrintWriter out) {
        Connection conn = null;
        try {
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            String sql = "SELECT booking_status, COUNT(*) as count FROM rooms GROUP BY booking_status";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            StringBuilder labels = new StringBuilder("[");
            StringBuilder data = new StringBuilder("[");
            
            boolean first = true;
            
            while (rs.next()) {
                String status = rs.getString("booking_status");
                int count = rs.getInt("count");
                
                if (!first) {
                    labels.append(",");
                    data.append(",");
                }
                
                String displayStatus = status.equals("booked") ? "Booked" : "Available";
                labels.append("\"").append(displayStatus).append("\"");
                data.append(count);
                
                first = false;
            }
            
            labels.append("]");
            data.append("]");
            
            StringBuilder response = new StringBuilder();
            response.append("{")
                .append("\"success\":true,")
                .append("\"labels\":").append(labels).append(",")
                .append("\"data\":").append(data).append(",")
                .append("\"colors\":[\"#10b981\",\"#ef4444\"]")
                .append("}");
            
            System.out.println("✅ getRoomOccupancy: Returning room occupancy");
            out.print(response.toString());
            
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.out.println("❌ getRoomOccupancy Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"" + escapeJson(e.getMessage()) + "\"}");
        } finally {
            closeConnection(conn);
        }
    }

    private void getRevenueChart(PrintWriter out) {
        Connection conn = null;
        try {
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            String sql = "SELECT DATE(check_in_date) as date, SUM(total_amount) as revenue FROM reservations WHERE payment_status = 'paid' GROUP BY DATE(check_in_date) ORDER BY date DESC LIMIT 7";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            java.util.List<String> dateList = new java.util.ArrayList<>();
            java.util.List<Double> revenueList = new java.util.ArrayList<>();
            
            while (rs.next()) {
                dateList.add(0, rs.getString("date"));
                revenueList.add(0, rs.getDouble("revenue"));
            }
            
            StringBuilder labels = new StringBuilder("[");
            StringBuilder data = new StringBuilder("[");
            
            boolean first = true;
            for (String date : dateList) {
                if (!first) labels.append(",");
                labels.append("\"").append(date).append("\"");
                first = false;
            }
            labels.append("]");
            
            first = true;
            for (Double revenue : revenueList) {
                if (!first) data.append(",");
                data.append(String.format("%.2f", revenue));
                first = false;
            }
            data.append("]");
            
            StringBuilder response = new StringBuilder();
            response.append("{")
                .append("\"success\":true,")
                .append("\"labels\":").append(labels).append(",")
                .append("\"data\":").append(data)
                .append("}");
            
            System.out.println("✅ getRevenueChart: Returning revenue data");
            out.print(response.toString());
            
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.out.println("❌ getRevenueChart Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"" + escapeJson(e.getMessage()) + "\"}");
        } finally {
            closeConnection(conn);
        }
    }

    private void getPaymentStatus(PrintWriter out) {
        Connection conn = null;
        try {
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            String sql = "SELECT payment_status, COUNT(*) as count FROM reservations GROUP BY payment_status";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            StringBuilder labels = new StringBuilder("[");
            StringBuilder data = new StringBuilder("[");
            StringBuilder colors = new StringBuilder("[");
            
            java.util.Map<String, String> colorMap = new java.util.HashMap<>();
            colorMap.put("paid", "#10b981");
            colorMap.put("partial", "#f59e0b");
            colorMap.put("unpaid", "#ef4444");
            
            boolean first = true;
            int count = 0;
            
            while (rs.next()) {
                count++;
                String status = rs.getString("payment_status");
                int statusCount = rs.getInt("count");
                
                if (!first) {
                    labels.append(",");
                    data.append(",");
                    colors.append(",");
                }
                
                labels.append("\"").append(status.toUpperCase()).append("\"");
                data.append(statusCount);
                colors.append("\"").append(colorMap.getOrDefault(status, "#6b7280")).append("\"");
                
                first = false;
            }
            
            labels.append("]");
            data.append("]");
            colors.append("]");
            
            StringBuilder response = new StringBuilder();
            response.append("{")
                .append("\"success\":true,")
                .append("\"labels\":").append(labels).append(",")
                .append("\"data\":").append(data).append(",")
                .append("\"colors\":").append(colors)
                .append("}");
            
            System.out.println("✅ getPaymentStatus: Returning " + count + " payment statuses");
            out.print(response.toString());
            
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.out.println("❌ getPaymentStatus Error: " + e.getMessage());
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
