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

@WebServlet("/createReservationTable")
public class CreateReservationTableServlet extends HttpServlet {
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

                // ✅ CREATE RESERVATIONS TABLE (HOURLY BOOKING)
                String createReservationsTable =
                        "CREATE TABLE IF NOT EXISTS reservations ("
                                + "id INT AUTO_INCREMENT PRIMARY KEY, "
                                + "user_id INT NOT NULL, "
                                + "room_id INT NOT NULL, "
                                + "check_in_date DATE NOT NULL, "
                                + "check_in_time TIME NOT NULL, "
                                + "check_out_time TIME NOT NULL, "
                                + "hours INT NOT NULL, "
                                + "hourly_rate DECIMAL(10, 2) NOT NULL, "
                                + "total_amount DECIMAL(10, 2) NOT NULL, "
                                + "status ENUM('pending', 'confirmed', 'checked-in', 'checked-out', 'cancelled') DEFAULT 'pending', "
                                + "payment_status ENUM('unpaid', 'paid', 'partial') DEFAULT 'unpaid', "
                                + "notes TEXT, "
                                + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                                + "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, "
                                + "FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE, "
                                + "FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE CASCADE"
                                + ") ENGINE=InnoDB";

                System.out.println("Creating reservations table...");
                stmt.execute(createReservationsTable);

                System.out.println("✅ Reservations table created successfully!");

                // Success message
                out.println("<!DOCTYPE html>");
                out.println("<html><head><title>Reservation Table Created</title>");
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
                out.println(".code { background: #f3f4f6; padding: 15px; border-radius: 8px; font-family: monospace; margin: 15px 0; overflow-x: auto; font-size: 12px; }");
                out.println("</style></head><body>");
                
                out.println("<div class='container'>");
                out.println("<h2>✅ Reservations Table Created Successfully!</h2>");
                
                out.println("<div class='success'>");
                out.println("<strong>🎉 Hourly room reservation system is ready!</strong>");
                out.println("</div>");

                out.println("<div class='table-info'>");
                out.println("<div class='table-name'>📅 RESERVATIONS TABLE</div>");
                out.println("<strong>Fields:</strong>");
                out.println("<ul>");
                out.println("<li><span class='required'>id</span> - Auto-generated primary key</li>");
                out.println("<li><span class='required'>user_id</span> - Customer ID (Foreign Key)</li>");
                out.println("<li><span class='required'>room_id</span> - Room ID (Foreign Key)</li>");
                out.println("<li><span class='required'>check_in_date</span> - Reservation date</li>");
                out.println("<li><span class='required'>check_in_time</span> - Check-in time (HH:MM:SS)</li>");
                out.println("<li><span class='required'>check_out_time</span> - Check-out time (HH:MM:SS)</li>");
                out.println("<li><span class='required'>hours</span> - Duration in hours (1-6 hours max)</li>");
                out.println("<li><span class='required'>hourly_rate</span> - Price per hour</li>");
                out.println("<li><span class='required'>total_amount</span> - Total cost (hours × hourly_rate)</li>");
                out.println("<li><span class='default'>status</span> - pending, confirmed, checked-in, checked-out, cancelled</li>");
                out.println("<li><span class='default'>payment_status</span> - unpaid, paid, partial</li>");
                out.println("<li><span class='default'>notes</span> - Additional notes</li>");
                out.println("<li><span class='default'>created_at</span> - Auto timestamp</li>");
                out.println("<li><span class='default'>updated_at</span> - Auto timestamp</li>");
                out.println("</ul>");
                out.println("</div>");

                out.println("<div class='table-info'>");
                out.println("<strong>SQL Query:</strong>");
                out.println("<div class='code'>");
                out.println("CREATE TABLE reservations (<br>");
                out.println("&nbsp;&nbsp;id INT AUTO_INCREMENT PRIMARY KEY,<br>");
                out.println("&nbsp;&nbsp;user_id INT NOT NULL,<br>");
                out.println("&nbsp;&nbsp;room_id INT NOT NULL,<br>");
                out.println("&nbsp;&nbsp;check_in_date DATE NOT NULL,<br>");
                out.println("&nbsp;&nbsp;check_in_time TIME NOT NULL,<br>");
                out.println("&nbsp;&nbsp;check_out_time TIME NOT NULL,<br>");
                out.println("&nbsp;&nbsp;hours INT NOT NULL,<br>");
                out.println("&nbsp;&nbsp;hourly_rate DECIMAL(10, 2) NOT NULL,<br>");
                out.println("&nbsp;&nbsp;total_amount DECIMAL(10, 2) NOT NULL,<br>");
                out.println("&nbsp;&nbsp;status ENUM('pending','confirmed','checked-in','checked-out','cancelled'),<br>");
                out.println("&nbsp;&nbsp;payment_status ENUM('unpaid','paid','partial'),<br>");
                out.println("&nbsp;&nbsp;notes TEXT,<br>");
                out.println("&nbsp;&nbsp;created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,<br>");
                out.println("&nbsp;&nbsp;updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,<br>");
                out.println("&nbsp;&nbsp;FOREIGN KEY (user_id) REFERENCES users(id),<br>");
                out.println("&nbsp;&nbsp;FOREIGN KEY (room_id) REFERENCES rooms(id)<br>");
                out.println(") ENGINE=InnoDB;");
                out.println("</div>");
                out.println("</div>");

                out.println("<div class='table-info'>");
                out.println("<strong>⏰ Hour Options:</strong>");
                out.println("<ul>");
                out.println("<li>1 hour</li>");
                out.println("<li>2 hours</li>");
                out.println("<li>3 hours</li>");
                out.println("<li>4 hours</li>");
                out.println("<li>5 hours</li>");
                out.println("<li>6 hours (Maximum)</li>");
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
