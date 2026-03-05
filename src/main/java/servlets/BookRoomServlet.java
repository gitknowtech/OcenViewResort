package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/bookRoom")
public class BookRoomServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/oceanview?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "";
    private static final String DB_DRIVER = "com.mysql.cj.jdbc.Driver";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        Connection conn = null;
        try {
            // ✅ GET ALL PARAMETERS
            String userId = request.getParameter("userId");
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String roomId = request.getParameter("roomId");
            String roomNumber = request.getParameter("roomNumber");
            String roomType = request.getParameter("roomType");
            String pricePerNight = request.getParameter("pricePerNight");
            String checkInDate = request.getParameter("checkInDate");
            String checkOutDate = request.getParameter("checkOutDate");
            String checkInTime = request.getParameter("checkInTime");
            String checkOutTime = request.getParameter("checkOutTime");
            String numberOfGuests = request.getParameter("numberOfGuests");
            String specialRequests = request.getParameter("specialRequests");

            System.out.println("\n╔════════════════════════════════════════════════════════════╗");
            System.out.println("║           🏨 BOOKING REQUEST RECEIVED                      ║");
            System.out.println("╚════════════════════════════════════════════════════════════╝");
            System.out.println("\n📥 RECEIVED PARAMETERS:");
            System.out.println("   userId: " + userId);
            System.out.println("   username: " + username);
            System.out.println("   email: " + email);
            System.out.println("   roomId: " + roomId);
            System.out.println("   roomNumber: " + roomNumber);
            System.out.println("   roomType: " + roomType);
            System.out.println("   pricePerNight: " + pricePerNight);
            System.out.println("   checkInDate: " + checkInDate);
            System.out.println("   checkOutDate: " + checkOutDate);
            System.out.println("   checkInTime: " + checkInTime);
            System.out.println("   checkOutTime: " + checkOutTime);
            System.out.println("   numberOfGuests: " + numberOfGuests);
            System.out.println("   specialRequests: " + specialRequests);

            // ✅ VALIDATION - USER ID (CRITICAL)
            if (userId == null || userId.trim().isEmpty()) {
                System.out.println("\n❌ VALIDATION FAILED: userId is NULL or EMPTY");
                sendJsonResponse(out, false, "User ID is required. Please login first.", null, null, null);
                return;
            }

            if (username == null || username.trim().isEmpty()) {
                System.out.println("❌ VALIDATION FAILED: username is NULL or EMPTY");
                sendJsonResponse(out, false, "Username is required", null, null, null);
                return;
            }

            if (email == null || email.trim().isEmpty()) {
                System.out.println("❌ VALIDATION FAILED: email is NULL or EMPTY");
                sendJsonResponse(out, false, "Email is required", null, null, null);
                return;
            }

            if (roomId == null || roomId.trim().isEmpty()) {
                System.out.println("❌ VALIDATION FAILED: roomId is NULL or EMPTY");
                sendJsonResponse(out, false, "Please select a room", null, null, null);
                return;
            }

            if (checkInDate == null || checkInDate.trim().isEmpty()) {
                System.out.println("❌ VALIDATION FAILED: checkInDate is NULL or EMPTY");
                sendJsonResponse(out, false, "Check-in date is required", null, null, null);
                return;
            }

            if (checkOutDate == null || checkOutDate.trim().isEmpty()) {
                System.out.println("❌ VALIDATION FAILED: checkOutDate is NULL or EMPTY");
                sendJsonResponse(out, false, "Check-out date is required", null, null, null);
                return;
            }

            if (numberOfGuests == null || numberOfGuests.trim().isEmpty()) {
                System.out.println("❌ VALIDATION FAILED: numberOfGuests is NULL or EMPTY");
                sendJsonResponse(out, false, "Number of guests is required", null, null, null);
                return;
            }

            System.out.println("\n✅ ALL REQUIRED FIELDS PRESENT");

            // ✅ PARSE AND VALIDATE USER ID
            int userIdInt;
            try {
                userIdInt = Integer.parseInt(userId);
                System.out.println("✅ User ID parsed: " + userIdInt);
            } catch (NumberFormatException e) {
                System.out.println("❌ USER ID PARSE ERROR: " + e.getMessage());
                sendJsonResponse(out, false, "Invalid user ID format", null, null, null);
                return;
            }

            // ✅ VALIDATE GUEST COUNT
            int guestCount;
            try {
                guestCount = Integer.parseInt(numberOfGuests);
                if (guestCount < 1 || guestCount > 10) {
                    System.out.println("❌ GUEST COUNT OUT OF RANGE: " + guestCount);
                    sendJsonResponse(out, false, "Guest count must be between 1 and 10", null, null, null);
                    return;
                }
                System.out.println("✅ Guest count valid: " + guestCount);
            } catch (NumberFormatException e) {
                System.out.println("❌ GUEST COUNT PARSE ERROR: " + e.getMessage());
                sendJsonResponse(out, false, "Invalid guest count", null, null, null);
                return;
            }

            // ✅ VALIDATE DATES
            LocalDate checkIn, checkOut;
            try {
                checkIn = LocalDate.parse(checkInDate);
                checkOut = LocalDate.parse(checkOutDate);
                LocalDate today = LocalDate.now();

                if (checkIn.isBefore(today)) {
                    System.out.println("❌ CHECK-IN DATE IN PAST");
                    sendJsonResponse(out, false, "Check-in date cannot be in the past", null, null, null);
                    return;
                }

                if (checkOut.isBefore(checkIn) || checkOut.isEqual(checkIn)) {
                    System.out.println("❌ CHECK-OUT DATE INVALID");
                    sendJsonResponse(out, false, "Check-out date must be after check-in date", null, null, null);
                    return;
                }

                System.out.println("✅ DATES VALID");
            } catch (Exception e) {
                System.out.println("❌ DATE PARSE ERROR: " + e.getMessage());
                sendJsonResponse(out, false, "Invalid date format", null, null, null);
                return;
            }

            // ✅ DATABASE CONNECTION
            try {
                Class.forName(DB_DRIVER);
                conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                System.out.println("\n✅ DATABASE CONNECTED");

                // ✅ CHECK IF ROOM EXISTS
                String checkRoomSQL = "SELECT id, booking_status, status FROM rooms WHERE id = ?";
                PreparedStatement checkRoom = conn.prepareStatement(checkRoomSQL);
                checkRoom.setInt(1, Integer.parseInt(roomId));
                ResultSet rs = checkRoom.executeQuery();
                
                if (!rs.next()) {
                    System.out.println("❌ ROOM NOT FOUND");
                    sendJsonResponse(out, false, "Room not found", null, null, null);
                    rs.close();
                    checkRoom.close();
                    return;
                }

                String bookingStatus = rs.getString("booking_status");
                String roomStatus = rs.getString("status");

                System.out.println("✅ ROOM FOUND - Status: " + roomStatus + ", Booking: " + bookingStatus);

                if (!roomStatus.equals("active")) {
                    System.out.println("❌ ROOM NOT ACTIVE");
                    sendJsonResponse(out, false, "This room is not available", null, null, null);
                    rs.close();
                    checkRoom.close();
                    return;
                }

                if (bookingStatus.equals("booked")) {
                    System.out.println("❌ ROOM ALREADY BOOKED");
                    sendJsonResponse(out, false, "This room is already booked", null, null, null);
                    rs.close();
                    checkRoom.close();
                    return;
                }

                rs.close();
                checkRoom.close();

                // ✅ CALCULATE TOTAL PRICE AND NIGHTS
                long calculatedNights = ChronoUnit.DAYS.between(checkIn, checkOut);
                double price = Double.parseDouble(pricePerNight);
                double calculatedTotal = price * calculatedNights;

                System.out.println("\n💰 PRICE CALCULATION:");
                System.out.println("   Nights: " + calculatedNights);
                System.out.println("   Price/Night: " + price);
                System.out.println("   Total: " + calculatedTotal);

                // ✅ INSERT BOOKING - CORRECT COLUMNS ONLY (NO 'nights' column)
                String insertBookingSQL = "INSERT INTO bookings (" +
                        "user_id, username, email, " +
                        "room_id, room_number, room_type, price_per_night, " +
                        "check_in_date, check_out_date, check_in_time, check_out_time, " +
                        "number_of_guests, total_price, special_requests, " +
                        "booking_status, created_at) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";

                PreparedStatement insertBooking = conn.prepareStatement(insertBookingSQL, Statement.RETURN_GENERATED_KEYS);
                
                System.out.println("\n📝 SETTING PREPARED STATEMENT PARAMETERS:");
                insertBooking.setInt(1, userIdInt);
                System.out.println("   1. user_id = " + userIdInt);
                
                insertBooking.setString(2, username);
                System.out.println("   2. username = " + username);
                
                insertBooking.setString(3, email);
                System.out.println("   3. email = " + email);
                
                insertBooking.setInt(4, Integer.parseInt(roomId));
                System.out.println("   4. room_id = " + roomId);
                
                insertBooking.setString(5, roomNumber);
                System.out.println("   5. room_number = " + roomNumber);
                
                insertBooking.setString(6, roomType);
                System.out.println("   6. room_type = " + roomType);
                
                insertBooking.setDouble(7, price);
                System.out.println("   7. price_per_night = " + price);
                
                insertBooking.setString(8, checkInDate);
                System.out.println("   8. check_in_date = " + checkInDate);
                
                insertBooking.setString(9, checkOutDate);
                System.out.println("   9. check_out_date = " + checkOutDate);
                
                insertBooking.setString(10, checkInTime != null ? checkInTime : "14:00");
                System.out.println("   10. check_in_time = " + (checkInTime != null ? checkInTime : "14:00"));
                
                insertBooking.setString(11, checkOutTime != null ? checkOutTime : "11:00");
                System.out.println("   11. check_out_time = " + (checkOutTime != null ? checkOutTime : "11:00"));
                
                insertBooking.setInt(12, guestCount);
                System.out.println("   12. number_of_guests = " + guestCount);
                
                insertBooking.setDouble(13, calculatedTotal);
                System.out.println("   13. total_price = " + calculatedTotal);
                
                insertBooking.setString(14, specialRequests != null ? specialRequests : "");
                System.out.println("   14. special_requests = " + (specialRequests != null ? specialRequests : ""));
                
                insertBooking.setString(15, "confirmed");
                System.out.println("   15. booking_status = confirmed");

                System.out.println("\n📤 EXECUTING INSERT...");
                int rows = insertBooking.executeUpdate();
                System.out.println("✅ ROWS INSERTED: " + rows);

                if (rows > 0) {
                    rs = insertBooking.getGeneratedKeys();
                    if (rs.next()) {
                        int bookingId = rs.getInt(1);
                        System.out.println("✅ BOOKING ID GENERATED: " + bookingId);

                        // ✅ UPDATE ROOM STATUS TO BOOKED
                        String updateRoomSQL = "UPDATE rooms SET booking_status = 'booked' WHERE id = ?";
                        PreparedStatement updateRoom = conn.prepareStatement(updateRoomSQL);
                        updateRoom.setInt(1, Integer.parseInt(roomId));
                        
                        System.out.println("\n📝 UPDATING ROOM STATUS...");
                        int updateRows = updateRoom.executeUpdate();
                        System.out.println("✅ ROOM UPDATED: " + updateRows + " rows");
                        updateRoom.close();

                        System.out.println("\n╔════════════════════════════════════════════════════════════╗");
                        System.out.println("║              ✅ BOOKING SAVED SUCCESSFULLY                  ║");
                        System.out.println("╚════════════════════════════════════════════════════════════╝");
                        System.out.println("📌 Booking ID: " + bookingId);
                        System.out.println("👤 User: " + username + " (" + email + ")");
                        System.out.println("🏨 Room: #" + roomNumber);
                        System.out.println("📅 Dates: " + checkInDate + " to " + checkOutDate);
                        System.out.println("👥 Guests: " + guestCount);
                        System.out.println("🌙 Nights: " + calculatedNights);
                        System.out.println("💰 Total: LKR " + calculatedTotal);

                        sendJsonResponse(out, true, "Booking confirmed successfully!", bookingId, calculatedTotal, calculatedNights);
                    }
                    rs.close();
                } else {
                    System.out.println("❌ INSERT FAILED - NO ROWS AFFECTED");
                    sendJsonResponse(out, false, "Failed to create booking", null, null, null);
                }

                insertBooking.close();

            } catch (SQLException e) {
                System.out.println("❌ SQL ERROR: " + e.getMessage());
                e.printStackTrace();
                sendJsonResponse(out, false, "Database error: " + e.getMessage(), null, null, null);
            }

        } catch (Exception e) {
            System.out.println("❌ UNEXPECTED ERROR: " + e.getMessage());
            e.printStackTrace();
            sendJsonResponse(out, false, "Server error: " + e.getMessage(), null, null, null);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                    System.out.println("✅ DATABASE CONNECTION CLOSED");
                } catch (SQLException e) {
                    System.out.println("⚠️ Error closing connection: " + e.getMessage());
                }
            }
        }
    }

    // ✅ SEND JSON RESPONSE USING STRINGBUILDER
    private void sendJsonResponse(PrintWriter out, boolean success, String message, 
                                 Integer bookingId, Double totalPrice, Long nights) {
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"success\":").append(success).append(",");
        json.append("\"message\":\"").append(escapeJson(message)).append("\"");
        
        if (success && bookingId != null) {
            json.append(",\"bookingId\":").append(bookingId);
            json.append(",\"totalPrice\":").append(totalPrice);
            json.append(",\"nights\":").append(nights);
        }
        
        json.append("}");
        
        String response = json.toString();
        System.out.println("\n📤 SENDING RESPONSE: " + response);
        out.print(response);
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
