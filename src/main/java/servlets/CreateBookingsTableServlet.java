package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/createBookingsTables")
public class CreateBookingsTableServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String url = "jdbc:mysql://localhost:3306/oceanview?useSSL=false&serverTimezone=UTC";
        String dbUser = "root";
        String dbPassword = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);
                 Statement stmt = conn.createStatement()) {

                // ✅ DROP OLD TABLE IF EXISTS
                System.out.println("Dropping old bookings table if exists...");
                try {
                    stmt.execute("DROP TABLE IF EXISTS bookings");
                    System.out.println("✅ Old table dropped");
                } catch (Exception e) {
                    System.out.println("⚠️ No old table to drop");
                }

                // ✅ CREATE BOOKINGS TABLE - CORRECT SCHEMA (NO 'nights' column)
                String createBookingsTable =
                        "CREATE TABLE bookings ("
                                + "id INT AUTO_INCREMENT PRIMARY KEY, "
                                + "user_id INT NOT NULL, "
                                + "username VARCHAR(100) NOT NULL, "
                                + "email VARCHAR(150) NOT NULL, "
                                + "room_id INT NOT NULL, "
                                + "room_number VARCHAR(50) NOT NULL, "
                                + "room_type VARCHAR(100) NOT NULL, "
                                + "price_per_night DECIMAL(10, 2) NOT NULL, "
                                + "check_in_date DATE NOT NULL, "
                                + "check_out_date DATE NOT NULL, "
                                + "check_in_time TIME DEFAULT '14:00', "
                                + "check_out_time TIME DEFAULT '11:00', "
                                + "number_of_guests INT DEFAULT 1, "
                                + "total_price DECIMAL(10, 2) NOT NULL, "
                                + "special_requests TEXT, "
                                + "booking_status ENUM('confirmed', 'pending', 'cancelled') DEFAULT 'confirmed', "
                                + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                                + "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, "
                                + "FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE, "
                                + "FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE CASCADE, "
                                + "INDEX idx_user_id (user_id), "
                                + "INDEX idx_room_id (room_id), "
                                + "INDEX idx_booking_status (booking_status)"
                                + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci";

                System.out.println("Creating bookings table...");
                stmt.execute(createBookingsTable);
                System.out.println("✅ Bookings table created successfully!");

                // Success message
                out.println("<!DOCTYPE html>");
                out.println("<html><head><title>Bookings Table Created</title>");
                out.println("<style>");
                out.println("body { font-family: Arial, sans-serif; margin: 40px; background: #f5f5f5; }");
                out.println(".container { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); max-width: 900px; margin: 0 auto; }");
                out.println("h2 { color: #10b981; margin-bottom: 20px; }");
                out.println(".success { color: #10b981; font-size: 18px; margin-bottom: 20px; background: #f0fdf4; padding: 15px; border-radius: 8px; border-left: 4px solid #10b981; }");
                out.println(".table-info { background: #f8fafc; padding: 20px; border-radius: 8px; margin: 15px 0; border-left: 4px solid #3b82f6; }");
                out.println(".table-name { color: #1f2937; font-weight: bold; font-size: 16px; margin-bottom: 10px; }");
                out.println("ul { margin: 10px 0; padding-left: 20px; }");
                out.println("li { margin: 8px 0; font-size: 14px; line-height: 1.6; }");
                out.println(".col { display: inline-block; width: 45%; vertical-align: top; margin-right: 5%; }");
                out.println(".col:last-child { margin-right: 0; }");
                out.println(".required { color: #dc2626; font-weight: bold; }");
                out.println(".fk { color: #8b5cf6; font-weight: bold; }");
                out.println(".note { background: #fef3c7; padding: 15px; border-radius: 8px; border-left: 4px solid #f59e0b; margin-top: 20px; }");
                out.println(".code { background: #1f2937; color: #10b981; padding: 15px; border-radius: 8px; font-family: monospace; overflow-x: auto; margin: 10px 0; }");
                out.println("</style></head><body>");
                
                out.println("<div class='container'>");
                out.println("<h2>✅ Bookings Table Created Successfully!</h2>");
                
                out.println("<div class='success'>");
                out.println("<strong>🎉 Booking management table is ready for production!</strong>");
                out.println("</div>");

                out.println("<div class='table-info'>");
                out.println("<div class='table-name'>📅 BOOKINGS TABLE STRUCTURE</div>");
                out.println("<strong>Columns:</strong>");
                out.println("<ul>");
                out.println("<li><span class='required'>id</span> - Auto-generated primary key</li>");
                out.println("<li><span class='fk'>user_id</span> - Foreign key to users(id)</li>");
                out.println("<li><span class='required'>username</span> - Username of person booking</li>");
                out.println("<li><span class='required'>email</span> - Email of person booking</li>");
                out.println("<li><span class='fk'>room_id</span> - Foreign key to rooms(id)</li>");
                out.println("<li><span class='required'>room_number</span> - Room number (e.g., '001')</li>");
                out.println("<li><span class='required'>room_type</span> - Room type (e.g., 'Deluxe')</li>");
                out.println("<li><span class='required'>price_per_night</span> - Price per night in LKR</li>");
                out.println("<li><span class='required'>check_in_date</span> - Check-in date (YYYY-MM-DD)</li>");
                out.println("<li><span class='required'>check_out_date</span> - Check-out date (YYYY-MM-DD)</li>");
                out.println("<li>check_in_time - Check-in time (default: 14:00)</li>");
                out.println("<li>check_out_time - Check-out time (default: 11:00)</li>");
                out.println("<li>number_of_guests - Number of guests (1-10)</li>");
                out.println("<li><span class='required'>total_price</span> - Total booking price</li>");
                out.println("<li>special_requests - Special requests or notes</li>");
                out.println("<li>booking_status - 'confirmed' | 'pending' | 'cancelled'</li>");
                out.println("<li>created_at - Auto timestamp when created</li>");
                out.println("<li>updated_at - Auto timestamp when updated</li>");
                out.println("</ul>");
                out.println("</div>");

                out.println("<div class='note'>");
                out.println("<strong>⚠️ Important Notes:</strong>");
                out.println("<ul>");
                out.println("<li>✅ <strong>NO 'nights' column</strong> - Calculate from check_in_date and check_out_date using DATEDIFF()</li>");
                out.println("<li>✅ <strong>NO 'first_name' or 'last_name' columns</strong> - Use username instead</li>");
                out.println("<li>✅ <strong>Indexes created</strong> on user_id, room_id, booking_status for fast queries</li>");
                out.println("<li>✅ <strong>Foreign keys enforced</strong> - Deletes cascade from users/rooms</li>");
                out.println("<li>✅ <strong>UTF-8 charset</strong> - Supports all languages</li>");
                out.println("</ul>");
                out.println("</div>");

                out.println("<div class='table-info'>");
                out.println("<strong>Example Booking Record:</strong>");
                out.println("<div class='code'>");
                out.println("INSERT INTO bookings (user_id, username, email, room_id, room_number, room_type,<br/>");
                out.println("price_per_night, check_in_date, check_out_date, number_of_guests, total_price,<br/>");
                out.println("booking_status) VALUES (1, 'john_doe', 'john@example.com', 4, '004', 'Deluxe',<br/>");
                out.println("1500.00, '2026-03-15', '2026-03-20', 2, 7500.00, 'confirmed');");
                out.println("</div>");
                out.println("</div>");

                out.println("<div class='table-info'>");
                out.println("<strong>Calculate Nights in SQL:</strong>");
                out.println("<div class='code'>");
                out.println("SELECT *, DATEDIFF(check_out_date, check_in_date) as nights FROM bookings;");
                out.println("</div>");
                out.println("</div>");

                out.println("<div class='table-info'>");
                out.println("<strong>Verify Table:</strong>");
                out.println("<div class='code'>");
                out.println("DESCRIBE bookings;<br/>");
                out.println("SELECT * FROM bookings LIMIT 1;");
                out.println("</div>");
                out.println("</div>");
                
                out.println("</div>");
                out.println("</body></html>");

            }

        } catch (Exception e) {
            out.println("<!DOCTYPE html>");
            out.println("<html><head><title>Database Error</title>");
            out.println("<style>body{font-family:Arial;margin:40px;} .error{color:#ef4444;background:#fef2f2;padding:20px;border-radius:8px; border-left: 4px solid #ef4444;}</style>");
            out.println("</head><body>");
            out.println("<div class='error'>");
            out.println("<h2>❌ Error Creating Table</h2>");
            out.println("<p><strong>Error:</strong> " + e.getMessage() + "</p>");
            out.println("<p><strong>Stack Trace:</strong></p>");
            out.println("<pre>");
            e.printStackTrace(out);
            out.println("</pre>");
            out.println("</div>");
            out.println("</body></html>");
            
            e.printStackTrace();
        }
    }
}
