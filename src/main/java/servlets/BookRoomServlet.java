package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.*;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

@WebServlet("/bookRoom")
public class BookRoomServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // ✅ DATABASE CONFIGURATION
    private static final String DB_URL = "jdbc:mysql://localhost:3306/oceanview?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "";
    private static final String DB_DRIVER = "com.mysql.cj.jdbc.Driver";
    
    // ✅ EMAIL CONFIGURATION
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String SENDER_EMAIL = "arabdul0983@gmail.com";
    private static final String SENDER_PASSWORD = "soau gire rrog azta";
    private static final String RESORT_NAME = "Ocean View Beach Resort";
    private static final String RESORT_EMAIL = "bookings@oceanviewresort.lk";
    private static final String RESORT_PHONE = "+94 77 123 4567";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ SET CORS HEADERS
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        Connection conn = null;
        try {
            // ✅ GET ALL REQUEST PARAMETERS
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

            // ✅ PRINT RECEIVED DATA TO CONSOLE
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
            System.out.println("   numberOfGuests: " + numberOfGuests);

            // ✅ VALIDATION: Check userId
            if (userId == null || userId.trim().isEmpty()) {
                System.out.println("\n❌ VALIDATION FAILED: userId is NULL or EMPTY");
                sendJsonResponse(out, false, "User ID is required. Please login first.", null, null, null);
                return;
            }

            // ✅ VALIDATION: Check email
            if (email == null || email.trim().isEmpty()) {
                System.out.println("❌ VALIDATION FAILED: email is NULL or EMPTY");
                sendJsonResponse(out, false, "Email is required", null, null, null);
                return;
            }

            // ✅ VALIDATION: Check roomId
            if (roomId == null || roomId.trim().isEmpty()) {
                System.out.println("❌ VALIDATION FAILED: roomId is NULL or EMPTY");
                sendJsonResponse(out, false, "Please select a room", null, null, null);
                return;
            }

            // ✅ VALIDATION: Check dates
            if (checkInDate == null || checkInDate.trim().isEmpty() || 
                checkOutDate == null || checkOutDate.trim().isEmpty()) {
                System.out.println("❌ VALIDATION FAILED: Dates missing");
                sendJsonResponse(out, false, "Check-in and check-out dates are required", null, null, null);
                return;
            }

            // ✅ PARSE AND VALIDATE DATA TYPES
            int userIdInt;
            int guestCount;
            LocalDate checkIn, checkOut;
            double price;

            try {
                userIdInt = Integer.parseInt(userId);
                guestCount = Integer.parseInt(numberOfGuests);
                checkIn = LocalDate.parse(checkInDate);
                checkOut = LocalDate.parse(checkOutDate);
                price = Double.parseDouble(pricePerNight);

                // ✅ VALIDATE: Guest count range
                if (guestCount < 1 || guestCount > 10) {
                    sendJsonResponse(out, false, "Guest count must be between 1 and 10", null, null, null);
                    return;
                }

                // ✅ VALIDATE: Check-in date not in past
                LocalDate today = LocalDate.now();
                if (checkIn.isBefore(today)) {
                    sendJsonResponse(out, false, "Check-in date cannot be in the past", null, null, null);
                    return;
                }

                // ✅ VALIDATE: Check-out date after check-in
                if (checkOut.isBefore(checkIn) || checkOut.isEqual(checkIn)) {
                    sendJsonResponse(out, false, "Check-out date must be after check-in date", null, null, null);
                    return;
                }

                System.out.println("✅ ALL VALIDATIONS PASSED");
            } catch (NumberFormatException e) {
                System.out.println("❌ PARSE ERROR: " + e.getMessage());
                sendJsonResponse(out, false, "Invalid data format", null, null, null);
                return;
            }

            // ✅ DATABASE CONNECTION AND BOOKING PROCESS
            try {
                Class.forName(DB_DRIVER);
                conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                System.out.println("\n✅ DATABASE CONNECTED");

                // ✅ CHECK IF ROOM EXISTS AND IS AVAILABLE
                String checkRoomSQL = "SELECT id, booking_status, status FROM rooms WHERE id = ?";
                PreparedStatement checkRoom = conn.prepareStatement(checkRoomSQL);
                checkRoom.setInt(1, Integer.parseInt(roomId));
                ResultSet rs = checkRoom.executeQuery();
                
                if (!rs.next() || !rs.getString("status").equals("active") || 
                    rs.getString("booking_status").equals("booked")) {
                    System.out.println("❌ ROOM NOT AVAILABLE");
                    sendJsonResponse(out, false, "This room is not available", null, null, null);
                    rs.close();
                    checkRoom.close();
                    return;
                }

                rs.close();
                checkRoom.close();

                // ✅ CALCULATE TOTAL PRICE AND NUMBER OF NIGHTS
                long calculatedNights = ChronoUnit.DAYS.between(checkIn, checkOut);
                double calculatedTotal = price * calculatedNights;

                System.out.println("\n💰 PRICE CALCULATION:");
                System.out.println("   Nights: " + calculatedNights);
                System.out.println("   Price/Night: LKR " + price);
                System.out.println("   Total: LKR " + calculatedTotal);

                // ✅ INSERT BOOKING INTO DATABASE
                String insertBookingSQL = "INSERT INTO bookings (" +
                        "user_id, username, email, " +
                        "room_id, room_number, room_type, price_per_night, " +
                        "check_in_date, check_out_date, check_in_time, check_out_time, " +
                        "number_of_guests, total_price, special_requests, " +
                        "booking_status, created_at) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";

                PreparedStatement insertBooking = conn.prepareStatement(insertBookingSQL, Statement.RETURN_GENERATED_KEYS);
                
                insertBooking.setInt(1, userIdInt);
                insertBooking.setString(2, username);
                insertBooking.setString(3, email);
                insertBooking.setInt(4, Integer.parseInt(roomId));
                insertBooking.setString(5, roomNumber);
                insertBooking.setString(6, roomType);
                insertBooking.setDouble(7, price);
                insertBooking.setString(8, checkInDate);
                insertBooking.setString(9, checkOutDate);
                insertBooking.setString(10, checkInTime != null ? checkInTime : "14:00");
                insertBooking.setString(11, checkOutTime != null ? checkOutTime : "11:00");
                insertBooking.setInt(12, guestCount);
                insertBooking.setDouble(13, calculatedTotal);
                insertBooking.setString(14, specialRequests != null ? specialRequests : "");
                insertBooking.setString(15, "confirmed");

                System.out.println("\n📤 EXECUTING INSERT...");
                int rows = insertBooking.executeUpdate();

                if (rows > 0) {
                    rs = insertBooking.getGeneratedKeys();
                    if (rs.next()) {
                        int bookingId = rs.getInt(1);
                        System.out.println("✅ BOOKING ID GENERATED: " + bookingId);

                        // ✅ UPDATE ROOM STATUS TO BOOKED
                        String updateRoomSQL = "UPDATE rooms SET booking_status = 'booked' WHERE id = ?";
                        PreparedStatement updateRoom = conn.prepareStatement(updateRoomSQL);
                        updateRoom.setInt(1, Integer.parseInt(roomId));
                        updateRoom.executeUpdate();
                        updateRoom.close();

                        System.out.println("\n📧 SENDING CONFIRMATION EMAIL...");
                        
                        // ✅ SEND BOOKING CONFIRMATION EMAIL
                        boolean emailSent = sendBookingConfirmationEmail(
                            email, 
                            username, 
                            bookingId, 
                            roomNumber, 
                            roomType, 
                            checkInDate, 
                            checkOutDate, 
                            checkInTime, 
                            checkOutTime, 
                            guestCount, 
                            calculatedNights, 
                            price, 
                            calculatedTotal, 
                            specialRequests
                        );

                        if (emailSent) {
                            System.out.println("✅ EMAIL SENT SUCCESSFULLY");
                        } else {
                            System.out.println("⚠️ EMAIL FAILED - But booking saved");
                        }

                        // ✅ PRINT SUCCESS SUMMARY
                        System.out.println("\n╔════════════════════════════════════════════════════════════╗");
                        System.out.println("║              ✅ BOOKING COMPLETED SUCCESSFULLY              ║");
                        System.out.println("╚════════════════════════════════════════════════════════════╝");
                        System.out.println("📌 Booking ID: " + bookingId);
                        System.out.println("👤 User: " + username);
                        System.out.println("📧 Email: " + email);
                        System.out.println("🏨 Room: #" + roomNumber + " (" + roomType + ")");
                        System.out.println("📅 Check-in: " + checkInDate + " at " + checkInTime);
                        System.out.println("📅 Check-out: " + checkOutDate + " at " + checkOutTime);
                        System.out.println("👥 Guests: " + guestCount);
                        System.out.println("🌙 Nights: " + calculatedNights);
                        System.out.println("💰 Total: LKR " + String.format("%.2f", calculatedTotal));

                        // ✅ SEND SUCCESS RESPONSE
                        sendJsonResponse(out, true, "Booking confirmed successfully! Check your email for details.", 
                                       bookingId, calculatedTotal, calculatedNights);
                    }
                    rs.close();
                } else {
                    System.out.println("❌ INSERT FAILED");
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

    /**
     * ✅ SEND BOOKING CONFIRMATION EMAIL WITH PROFESSIONAL HTML BILL
     */
    private boolean sendBookingConfirmationEmail(
            String recipientEmail, String guestName, int bookingId,
            String roomNumber, String roomType, String checkInDate, String checkOutDate,
            String checkInTime, String checkOutTime, int guests, long nights,
            double pricePerNight, double totalPrice, String specialRequests) {
        
        try {
            System.out.println("\n📧 EMAIL DETAILS:");
            System.out.println("   - To: " + recipientEmail);
            System.out.println("   - Booking ID: " + bookingId);
            System.out.println("   - Total: LKR " + totalPrice);

            // ✅ CONFIGURE SMTP PROPERTIES
            Properties props = new Properties();
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.starttls.required", "true");
            props.put("mail.smtp.connectiontimeout", "5000");
            props.put("mail.smtp.timeout", "5000");

            // ✅ CREATE SESSION WITH AUTHENTICATION
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
                }
            });

            // ✅ CREATE EMAIL MESSAGE
            Message message = new MimeMessage(session);
            
            // ✅ SET FROM ADDRESS - SIMPLE AND CLEAN (NO NESTED CATCH)
            try {
                message.setFrom(new InternetAddress(SENDER_EMAIL, RESORT_NAME));
            } catch (UnsupportedEncodingException e) {
                System.out.println("⚠️ Encoding error, using email without resort name");
                message.setFrom(new InternetAddress(SENDER_EMAIL));
            }
            
            // ✅ SET RECIPIENT AND SUBJECT
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("🎉 Booking Confirmation - Booking ID: #" + bookingId);

            // ✅ CREATE PROFESSIONAL HTML EMAIL BODY
            String emailBody = createEmailBody(
                guestName, bookingId, roomNumber, roomType, 
                checkInDate, checkOutDate, checkInTime, checkOutTime,
                guests, nights, pricePerNight, totalPrice, specialRequests
            );

            // ✅ SET EMAIL CONTENT AS HTML
            MimeBodyPart mimeBodyPart = new MimeBodyPart();
            mimeBodyPart.setContent(emailBody, "text/html; charset=UTF-8");

            MimeMultipart multipart = new MimeMultipart();
            multipart.addBodyPart(mimeBodyPart);

            message.setContent(multipart);

            // ✅ SEND EMAIL
            Transport.send(message);
            System.out.println("✅ EMAIL SENT SUCCESSFULLY to " + recipientEmail);
            return true;

        } catch (MessagingException e) {
            System.out.println("❌ EMAIL ERROR: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * ✅ CREATE PROFESSIONAL HTML EMAIL BODY WITH BILLING DETAILS
     */
    private String createEmailBody(String guestName, int bookingId, String roomNumber, 
                                   String roomType, String checkInDate, String checkOutDate,
                                   String checkInTime, String checkOutTime, int guests, 
                                   long nights, double pricePerNight, double totalPrice, 
                                   String specialRequests) {
        
        return "<!DOCTYPE html>\n" +
            "<html>\n" +
            "<head>\n" +
            "    <meta charset='UTF-8'>\n" +
            "    <style>\n" +
            "        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; line-height: 1.6; color: #333; }\n" +
            "        .container { max-width: 600px; margin: 0 auto; background: #f8f9fa; padding: 20px; border-radius: 10px; }\n" +
            "        .header { background: linear-gradient(135deg, #007bff, #0056b3); color: white; padding: 30px; text-align: center; border-radius: 10px 10px 0 0; }\n" +
            "        .header h1 { margin: 0; font-size: 28px; }\n" +
            "        .header p { margin: 5px 0 0 0; opacity: 0.9; }\n" +
            "        .content { background: white; padding: 30px; border-radius: 0 0 10px 10px; }\n" +
            "        .section { margin-bottom: 25px; }\n" +
            "        .section-title { font-size: 16px; font-weight: bold; color: #007bff; border-bottom: 2px solid #007bff; padding-bottom: 10px; margin-bottom: 15px; }\n" +
            "        .info-row { display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid #e9ecef; }\n" +
            "        .info-row:last-child { border-bottom: none; }\n" +
            "        .info-label { font-weight: 600; color: #555; }\n" +
            "        .info-value { color: #333; text-align: right; }\n" +
            "        .bill-table { width: 100%; border-collapse: collapse; margin: 15px 0; }\n" +
            "        .bill-table th { background: #007bff; color: white; padding: 12px; text-align: left; font-weight: 600; }\n" +
            "        .bill-table td { padding: 12px; border-bottom: 1px solid #e9ecef; }\n" +
            "        .bill-table tr:last-child td { border-bottom: none; }\n" +
            "        .bill-row { display: flex; justify-content: space-between; padding: 10px 0; }\n" +
            "        .bill-row.total { background: #f0f9ff; padding: 15px; border-radius: 5px; font-weight: bold; font-size: 16px; color: #007bff; margin-top: 10px; }\n" +
            "        .highlight { background: #fff3cd; padding: 15px; border-radius: 5px; border-left: 4px solid #ffc107; margin: 15px 0; }\n" +
            "        .footer { background: #f8f9fa; padding: 20px; text-align: center; font-size: 12px; color: #666; border-radius: 5px; margin-top: 20px; }\n" +
            "        .contact-info { background: #e7f3ff; padding: 15px; border-radius: 5px; margin: 15px 0; }\n" +
            "        .contact-info p { margin: 5px 0; font-size: 13px; }\n" +
            "    </style>\n" +
            "</head>\n" +
            "<body>\n" +
            "    <div class='container'>\n" +
            "        <!-- HEADER -->\n" +
            "        <div class='header'>\n" +
            "            <h1>🎉 Booking Confirmed!</h1>\n" +
            "            <p>Thank you for choosing Ocean View Beach Resort</p>\n" +
            "        </div>\n" +
            "\n" +
            "        <!-- CONTENT -->\n" +
            "        <div class='content'>\n" +
            "            <!-- GREETING -->\n" +
            "            <p>Dear <strong>" + escapeHtml(guestName) + "</strong>,</p>\n" +
            "            <p>Your booking has been confirmed! We're excited to welcome you to Ocean View Beach Resort. Below are your booking details and bill.</p>\n" +
            "\n" +
            "            <!-- BOOKING DETAILS -->\n" +
            "            <div class='section'>\n" +
            "                <div class='section-title'>📌 Booking Details</div>\n" +
            "                <div class='info-row'>\n" +
            "                    <span class='info-label'>Booking ID:</span>\n" +
            "                    <span class='info-value'><strong>#" + bookingId + "</strong></span>\n" +
            "                </div>\n" +
            "                <div class='info-row'>\n" +
            "                    <span class='info-label'>Booking Status:</span>\n" +
            "                    <span class='info-value'><strong style='color: #10b981;'>✅ Confirmed</strong></span>\n" +
            "                </div>\n" +
            "            </div>\n" +
            "\n" +
            "            <!-- ROOM DETAILS -->\n" +
            "            <div class='section'>\n" +
            "                <div class='section-title'>🏨 Room Details</div>\n" +
            "                <div class='info-row'>\n" +
            "                    <span class='info-label'>Room Number:</span>\n" +
            "                    <span class='info-value'>#" + roomNumber + "</span>\n" +
            "                </div>\n" +
            "                <div class='info-row'>\n" +
            "                    <span class='info-label'>Room Type:</span>\n" +
            "                    <span class='info-value'>" + escapeHtml(roomType) + "</span>\n" +
            "                </div>\n" +
            "                <div class='info-row'>\n" +
            "                    <span class='info-label'>Number of Guests:</span>\n" +
            "                    <span class='info-value'>" + guests + " Guest" + (guests > 1 ? "s" : "") + "</span>\n" +
            "                </div>\n" +
            "            </div>\n" +
            "\n" +
            "            <!-- CHECK-IN/OUT DETAILS -->\n" +
            "            <div class='section'>\n" +
            "                <div class='section-title'>📅 Check-in & Check-out</div>\n" +
            "                <div class='info-row'>\n" +
            "                    <span class='info-label'>Check-in Date:</span>\n" +
            "                    <span class='info-value'>" + checkInDate + " at " + checkInTime + "</span>\n" +
            "                </div>\n" +
            "                <div class='info-row'>\n" +
            "                    <span class='info-label'>Check-out Date:</span>\n" +
            "                    <span class='info-value'>" + checkOutDate + " at " + checkOutTime + "</span>\n" +
            "                </div>\n" +
            "                <div class='info-row'>\n" +
            "                    <span class='info-label'>Number of Nights:</span>\n" +
            "                    <span class='info-value'><strong>" + nights + " Night" + (nights > 1 ? "s" : "") + "</strong></span>\n" +
            "                </div>\n" +
            "            </div>\n" +
            "\n" +
            "            <!-- BILL/INVOICE -->\n" +
            "            <div class='section'>\n" +
            "                <div class='section-title'>💰 Billing Summary</div>\n" +
            "                <table class='bill-table'>\n" +
            "                    <thead>\n" +
            "                        <tr>\n" +
            "                            <th>Description</th>\n" +
            "                            <th style='text-align: right;'>Amount</th>\n" +
            "                        </tr>\n" +
            "                    </thead>\n" +
            "                    <tbody>\n" +
            "                        <tr>\n" +
            "                            <td>" + escapeHtml(roomType) + " x " + nights + " Night" + (nights > 1 ? "s" : "") + "</td>\n" +
            "                            <td style='text-align: right;'>LKR " + String.format("%.2f", pricePerNight * nights) + "</td>\n" +
            "                        </tr>\n" +
            "                    </tbody>\n" +
            "                </table>\n" +
            "                <div class='bill-row total'>\n" +
            "                    <span>Total Amount Due:</span>\n" +
            "                    <span>LKR " + String.format("%.2f", totalPrice) + "</span>\n" +
            "                </div>\n" +
            "            </div>\n" +
            "\n" +
            (specialRequests != null && !specialRequests.trim().isEmpty() ? 
            "            <!-- SPECIAL REQUESTS -->\n" +
            "            <div class='section'>\n" +
            "                <div class='section-title'>📝 Special Requests</div>\n" +
            "                <p>" + escapeHtml(specialRequests) + "</p>\n" +
            "            </div>\n" : "") +
            "\n" +
            "            <!-- IMPORTANT NOTICE -->\n" +
            "            <div class='highlight'>\n" +
            "                <strong>⏰ Important:</strong> Please arrive 15 minutes before your check-in time. If you'll be arriving late, please contact us immediately.\n" +
            "            </div>\n" +
            "\n" +
            "            <!-- CONTACT INFORMATION -->\n" +
            "            <div class='contact-info'>\n" +
            "                <strong>📞 Need Help?</strong>\n" +
            "                <p>Phone: " + RESORT_PHONE + "</p>\n" +
            "                <p>Email: " + RESORT_EMAIL + "</p>\n" +
            "                <p>Address: Kalpitiya, Sri Lanka</p>\n" +
            "            </div>\n" +
            "\n" +
            "            <!-- FOOTER -->\n" +
            "            <div class='footer'>\n" +
            "                <p><strong>Ocean View Beach Resort</strong></p>\n" +
            "                <p>Experience luxury and adventure in beautiful Kalpitiya, Sri Lanka</p>\n" +
            "                <p style='margin-top: 15px; color: #999;'>This is an automated email. Please do not reply to this email.</p>\n" +
            "            </div>\n" +
            "        </div>\n" +
            "    </div>\n" +
            "</body>\n" +
            "</html>";
    }

    /**
     * ✅ ESCAPE HTML SPECIAL CHARACTERS TO PREVENT INJECTION
     */
    private String escapeHtml(String text) {
        if (text == null) return "";
        return text.replace("&", "&amp;")
                   .replace("<", "&lt;")
                   .replace(">", "&gt;")
                   .replace("\"", "&quot;")
                   .replace("'", "&#39;");
    }

    /**
     * ✅ SEND JSON RESPONSE TO CLIENT
     */
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

    /**
     * ✅ ESCAPE JSON SPECIAL CHARACTERS TO PREVENT INJECTION
     */
    private String escapeJson(String value) {
        if (value == null) return "";
        return value.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t");
    }
}
