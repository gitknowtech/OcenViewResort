package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/createReservation")
public class CreateReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Get form data
            String guestName = request.getParameter("guestName");
            String email = request.getParameter("email");
            String contactNumber = request.getParameter("contactNumber");
            String country = request.getParameter("country");
            String roomType = request.getParameter("roomType");
            String guests = request.getParameter("guests");
            String checkInDate = request.getParameter("checkInDate");
            String checkOutDate = request.getParameter("checkOutDate");
            String checkInTime = request.getParameter("checkInTime");
            String checkOutTime = request.getParameter("checkOutTime");
            String specialRequests = request.getParameter("specialRequests");
            String roomPrice = request.getParameter("roomPrice");
            String packageCategory = request.getParameter("packageCategory");

            System.out.println("📦 Creating reservation...");
            System.out.println("   Guest: " + guestName);
            System.out.println("   Email: " + email);
            System.out.println("   Room: " + roomType);
            System.out.println("   Check-in: " + checkInDate + " " + checkInTime);
            System.out.println("   Check-out: " + checkOutDate + " " + checkOutTime);

            // Validation
            if (guestName == null || guestName.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Guest name is required\"}");
                return;
            }

            if (email == null || email.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Email is required\"}");
                return;
            }

            if (contactNumber == null || contactNumber.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Contact number is required\"}");
                return;
            }

            // Generate reservation number
            String reservationNumber = generateReservationNumber();
            System.out.println("   Reservation Number: " + reservationNumber);

            // Calculate total price
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date checkIn = sdf.parse(checkInDate);
            Date checkOut = sdf.parse(checkOutDate);
            long nights = (checkOut.getTime() - checkIn.getTime()) / (1000 * 60 * 60 * 24);
            double totalPrice = Double.parseDouble(roomPrice != null ? roomPrice : "0") * nights;

            System.out.println("   Nights: " + nights);
            System.out.println("   Total Price: " + totalPrice);

            // Database connection
            String url = "jdbc:mysql://localhost:3306/oceanview?useSSL=false&serverTimezone=UTC";
            String dbUser = "root";
            String dbPassword = "";

            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword)) {

                // Get user ID if logged in
                HttpSession session = request.getSession(false);
                Integer userId = null;
                if (session != null && session.getAttribute("userId") != null) {
                    userId = (Integer) session.getAttribute("userId");
                    System.out.println("   User ID: " + userId);
                }

                // Insert reservation into database
                String insertSQL = "INSERT INTO reservations (reservationNumber, userId, guestName, email, contactNumber, country, roomType, numberOfGuests, checkInDate, checkOutDate, checkInTime, checkOutTime, specialRequests, roomPrice, totalPrice, packageCategory, status, createdAt) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";

                try (PreparedStatement insertStmt = conn.prepareStatement(insertSQL)) {
                    insertStmt.setString(1, reservationNumber);
                    insertStmt.setObject(2, userId);
                    insertStmt.setString(3, guestName.trim());
                    insertStmt.setString(4, email.trim());
                    insertStmt.setString(5, contactNumber.trim());
                    insertStmt.setString(6, country != null ? country : "");
                    insertStmt.setString(7, roomType != null ? roomType : "");
                    insertStmt.setInt(8, Integer.parseInt(guests != null ? guests : "1"));
                    insertStmt.setString(9, checkInDate);
                    insertStmt.setString(10, checkOutDate);
                    insertStmt.setString(11, checkInTime != null ? checkInTime : "14:00");
                    insertStmt.setString(12, checkOutTime != null ? checkOutTime : "12:00");
                    insertStmt.setString(13, specialRequests != null ? specialRequests : "");
                    insertStmt.setDouble(14, Double.parseDouble(roomPrice != null ? roomPrice : "0"));
                    insertStmt.setDouble(15, totalPrice);
                    insertStmt.setString(16, packageCategory != null ? packageCategory : "night");
                    insertStmt.setString(17, "confirmed");

                    int rowsInserted = insertStmt.executeUpdate();

                    if (rowsInserted > 0) {
                        System.out.println("✅ Reservation created successfully");

                        out.print("{\"success\":true,\"message\":\"Reservation created successfully\",\"reservationNumber\":\"" + reservationNumber + "\"}");

                    } else {
                        System.out.println("❌ Failed to insert reservation");
                        out.print("{\"success\":false,\"message\":\"Failed to create reservation\"}");
                    }
                }
            }

        } catch (Exception e) {
            System.out.println("❌ Create Reservation Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"Server error occurred\"}");
        }
    }

    // Generate unique reservation number
    private String generateReservationNumber() {
        String prefix = "RES";
        String timestamp = String.valueOf(System.currentTimeMillis()).substring(6);
        String random = String.format("%04d", new Random().nextInt(10000));
        return prefix + timestamp + random;
    }
}
