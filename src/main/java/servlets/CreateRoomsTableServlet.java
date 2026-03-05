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

                // ✅ CREATE ROOMS TABLE
                String createRoomsTable =
                        "CREATE TABLE IF NOT EXISTS rooms ("
                                + "id INT AUTO_INCREMENT PRIMARY KEY, "
                                + "room_number VARCHAR(50) UNIQUE NOT NULL, "
                                + "status ENUM('active', 'inactive') DEFAULT 'active', "
                                + "maintenance ENUM('maintenance', 'non-maintenance') DEFAULT 'non-maintenance', "
                                + "booking_status ENUM('booked', 'non-booked') DEFAULT 'non-booked', "
                                + "room_type VARCHAR(100) DEFAULT 'Standard', "
                                + "capacity INT DEFAULT 2, "
                                + "price_per_night DECIMAL(10, 2) DEFAULT 0.00, "
                                + "description TEXT, "
                                + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                                + "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"
                                + ") ENGINE=InnoDB";

                System.out.println("Creating rooms table...");
                stmt.execute(createRoomsTable);

                System.out.println("✅ Rooms table created successfully!");

                // Success message
                out.println("<!DOCTYPE html>");
                out.println("<html><head><title>Rooms Table Created</title>");
                out.println("<style>");
                out.println("body { font-family: Arial, sans-serif; margin: 40px; background: #f5f5f5; }");
                out.println(".container { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); max-width: 700px; }");
                out.println("h2 { color: #10b981; margin-bottom: 20px; }");
                out.println(".success { color: #10b981; font-size: 18px; margin-bottom: 20px; background: #f0fdf4; padding: 15px; border-radius: 8px; border-left: 4px solid #10b981; }");
                out.println(".table-info { background: #f8fafc; padding: 20px; border-radius: 8px; margin: 15px 0; border-left: 4px solid #3b82f6; }");
                out.println(".table-name { color: #1f2937; font-weight: bold; font-size: 16px; margin-bottom: 10px; }");
                out.println("ul { margin: 10px 0; padding-left: 20px; }");
                out.println("li { margin: 8px 0; font-size: 14px; }");
                out.println(".required { color: #dc2626; font-weight: bold; }");
                out.println(".default { color: #f59e0b; font-weight: bold; }");
                out.println(".enum { color: #8b5cf6; font-weight: bold; }");
                out.println("</style></head><body>");
                
                out.println("<div class='container'>");
                out.println("<h2>✅ Rooms Table Created Successfully!</h2>");
                
                out.println("<div class='success'>");
                out.println("<strong>🎉 Room management table is ready!</strong>");
                out.println("</div>");

                out.println("<div class='table-info'>");
                out.println("<div class='table-name'>🚪 ROOMS TABLE</div>");
                out.println("<strong>Fields:</strong>");
                out.println("<ul>");
                out.println("<li><span class='required'>id</span> - Auto-generated primary key</li>");
                out.println("<li><span class='required'>room_number</span> - Unique room number (required)</li>");
                out.println("<li><span class='enum'>status</span> - Room status: <strong>active</strong> | <strong>inactive</strong> (default: active)</li>");
                out.println("<li><span class='enum'>maintenance</span> - Maintenance status: <strong>maintenance</strong> | <strong>non-maintenance</strong> (default: non-maintenance)</li>");
                out.println("<li><span class='enum'>booking_status</span> - Booking status: <strong>booked</strong> | <strong>non-booked</strong> (default: non-booked)</li>");
                out.println("<li><span class='default'>room_type</span> - Type of room (default: 'Standard')</li>");
                out.println("<li><span class='default'>capacity</span> - Guest capacity (default: 2)</li>");
                out.println("<li><span class='default'>price_per_night</span> - Price per night (default: 0.00)</li>");
                out.println("<li><span class='default'>description</span> - Room description</li>");
                out.println("<li><span class='default'>created_at</span> - Auto timestamp</li>");
                out.println("<li><span class='default'>updated_at</span> - Auto timestamp</li>");
                out.println("</ul>");
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
            out.println("</div>");
            out.println("</body></html>");
            
            e.printStackTrace();
        }
    }
}
