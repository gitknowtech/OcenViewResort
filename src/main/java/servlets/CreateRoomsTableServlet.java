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

@WebServlet("/createRoomsTables")
public class CreateRoomsTableServlet extends HttpServlet {
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
                System.out.println("Dropping old rooms table if exists...");
                try {
                    stmt.execute("DROP TABLE IF EXISTS rooms");
                    System.out.println("✅ Old table dropped");
                } catch (Exception e) {
                    System.out.println("⚠️ No old table to drop");
                }

                // ✅ CREATE ROOMS TABLE - UPDATED booking_status ENUM
                String createRoomsTable =
                        "CREATE TABLE rooms ("
                                + "id INT AUTO_INCREMENT PRIMARY KEY, "
                                + "room_number VARCHAR(50) UNIQUE NOT NULL, "
                                + "status ENUM('active', 'inactive') DEFAULT 'active', "
                                + "maintenance ENUM('maintenance', 'non-maintenance') DEFAULT 'non-maintenance', "
                                + "booking_status ENUM('available', 'booked') DEFAULT 'available', "
                                + "room_type VARCHAR(100) DEFAULT 'Standard', "
                                + "capacity INT DEFAULT 2, "
                                + "price_per_night DECIMAL(10, 2) DEFAULT 0.00, "
                                + "description TEXT, "
                                + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                                + "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, "
                                + "INDEX idx_room_number (room_number), "
                                + "INDEX idx_booking_status (booking_status)"
                                + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci";

                System.out.println("Creating rooms table...");
                stmt.execute(createRoomsTable);

                System.out.println("✅ Rooms table created successfully!");

                // Success message
                out.println("<!DOCTYPE html>");
                out.println("<html><head><title>Rooms Table Created</title>");
                out.println("<style>");
                out.println("body { font-family: Arial, sans-serif; margin: 40px; background: #f5f5f5; }");
                out.println(".container { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); max-width: 900px; margin: 0 auto; }");
                out.println("h2 { color: #10b981; margin-bottom: 20px; }");
                out.println(".success { color: #10b981; font-size: 18px; margin-bottom: 20px; background: #f0fdf4; padding: 15px; border-radius: 8px; border-left: 4px solid #10b981; }");
                out.println(".table-info { background: #f8fafc; padding: 20px; border-radius: 8px; margin: 15px 0; border-left: 4px solid #3b82f6; }");
                out.println(".table-name { color: #1f2937; font-weight: bold; font-size: 16px; margin-bottom: 10px; }");
                out.println("ul { margin: 10px 0; padding-left: 20px; }");
                out.println("li { margin: 8px 0; font-size: 14px; line-height: 1.6; }");
                out.println(".required { color: #dc2626; font-weight: bold; }");
                out.println(".enum { color: #8b5cf6; font-weight: bold; }");
                out.println(".default { color: #f59e0b; font-weight: bold; }");
                out.println(".note { background: #fef3c7; padding: 15px; border-radius: 8px; border-left: 4px solid #f59e0b; margin-top: 20px; }");
                out.println(".code { background: #1f2937; color: #10b981; padding: 15px; border-radius: 8px; font-family: monospace; overflow-x: auto; margin: 10px 0; }");
                out.println(".highlight { background: #fef3c7; padding: 2px 6px; border-radius: 4px; }");
                out.println("</style></head><body>");
                
                out.println("<div class='container'>");
                out.println("<h2>✅ Rooms Table Created Successfully!</h2>");
                
                out.println("<div class='success'>");
                out.println("<strong>🎉 Room management table is ready for production!</strong>");
                out.println("</div>");

                out.println("<div class='table-info'>");
                out.println("<div class='table-name'>🚪 ROOMS TABLE STRUCTURE</div>");
                out.println("<strong>Columns:</strong>");
                out.println("<ul>");
                out.println("<li><span class='required'>id</span> - Auto-generated primary key</li>");
                out.println("<li><span class='required'>room_number</span> - Unique room number (e.g., '001', '002')</li>");
                out.println("<li><span class='enum'>status</span> - Room status: <span class='highlight'>active</span> | <span class='highlight'>inactive</span> (default: active)</li>");
                out.println("<li><span class='enum'>maintenance</span> - Maintenance: <span class='highlight'>maintenance</span> | <span class='highlight'>non-maintenance</span> (default: non-maintenance)</li>");
                out.println("<li><span class='enum'>booking_status</span> - Booking: <span class='highlight'>available</span> | <span class='highlight'>booked</span> (default: available)</li>");
                out.println("<li><span class='default'>room_type</span> - Room type (e.g., 'Deluxe', 'Standard')</li>");
                out.println("<li><span class='default'>capacity</span> - Guest capacity (default: 2)</li>");
                out.println("<li><span class='default'>price_per_night</span> - Price per night in LKR (default: 0.00)</li>");
                out.println("<li><span class='default'>description</span> - Room description/features</li>");
                out.println("<li><span class='default'>created_at</span> - Auto timestamp when created</li>");
                out.println("<li><span class='default'>updated_at</span> - Auto timestamp when updated</li>");
                out.println("</ul>");
                out.println("</div>");

                out.println("<div class='note'>");
                out.println("<strong>⚠️ IMPORTANT - booking_status VALUES:</strong>");
                out.println("<ul>");
                out.println("<li>✅ <span class='highlight'>available</span> - Room is available for booking</li>");
                out.println("<li>✅ <span class='highlight'>booked</span> - Room is currently booked</li>");
                out.println("<li>❌ <strong>DO NOT USE:</strong> 'non-booked', 'available_for_booking', etc.</li>");
                out.println("<li>✅ When booking is <strong>cancelled</strong>, set to <span class='highlight'>available</span></li>");
                out.println("<li>✅ When booking is <strong>confirmed</strong>, set to <span class='highlight'>booked</span></li>");
                out.println("</ul>");
                out.println("</div>");

                out.println("<div class='table-info'>");
                out.println("<strong>Example Room Records:</strong>");
                out.println("<div class='code'>");
                out.println("INSERT INTO rooms (room_number, room_type, capacity, price_per_night, booking_status)<br/>");
                out.println("VALUES<br/>");
                out.println("('001', 'Deluxe', 2, 1500.00, 'available'),<br/>");
                out.println("('002', 'Standard', 2, 1000.00, 'available'),<br/>");
                out.println("('003', 'Suite', 4, 2500.00, 'booked');");
                out.println("</div>");
                out.println("</div>");

                out.println("<div class='table-info'>");
                out.println("<strong>Update Room Status (Booking Confirmed):</strong>");
                out.println("<div class='code'>");
                out.println("UPDATE rooms SET booking_status = 'booked' WHERE id = 1;");
                out.println("</div>");
                out.println("</div>");

                out.println("<div class='table-info'>");
                out.println("<strong>Update Room Status (Booking Cancelled):</strong>");
                out.println("<div class='code'>");
                out.println("UPDATE rooms SET booking_status = 'available' WHERE id = 1;");
                out.println("</div>");
                out.println("</div>");

                out.println("<div class='table-info'>");
                out.println("<strong>Verify Table:</strong>");
                out.println("<div class='code'>");
                out.println("DESCRIBE rooms;<br/>");
                out.println("SELECT * FROM rooms;");
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
