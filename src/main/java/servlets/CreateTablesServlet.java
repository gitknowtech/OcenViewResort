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

@WebServlet("/createTables")
public class CreateTablesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String url = "jdbc:mysql://localhost:3306/oceanview?useSSL=false&serverTimezone=UTC";
        String username = "root";
        String password = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(url, username, password);
                 Statement stmt = conn.createStatement()) {

                // Users table
                String createUsersTable =
                        "CREATE TABLE IF NOT EXISTS users ("
                                + "id INT AUTO_INCREMENT PRIMARY KEY, "
                                + "email VARCHAR(255) UNIQUE NOT NULL, "
                                + "password VARCHAR(64) NOT NULL, "
                                + "first_name VARCHAR(100), "
                                + "last_name VARCHAR(100), "
                                + "phone VARCHAR(20), "
                                + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                                + "last_login TIMESTAMP NULL DEFAULT NULL"
                                + ") ENGINE=InnoDB";

                // User sessions table - FIXED expires_at issue
                String createSessionsTable =
                        "CREATE TABLE IF NOT EXISTS user_sessions ("
                                + "session_id VARCHAR(255) PRIMARY KEY, "
                                + "user_id INT NOT NULL, "
                                + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                                + "expires_at TIMESTAMP NULL DEFAULT NULL, "
                                + "is_remember_me BOOLEAN DEFAULT FALSE, "
                                + "CONSTRAINT fk_sessions_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE"
                                + ") ENGINE=InnoDB";

                // Login history table
                String createLoginsTable =
                        "CREATE TABLE IF NOT EXISTS user_logins ("
                                + "login_id INT AUTO_INCREMENT PRIMARY KEY, "
                                + "user_id INT NOT NULL, "
                                + "login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                                + "ip_address VARCHAR(45), "
                                + "user_agent TEXT, "
                                + "CONSTRAINT fk_user_logins_user FOREIGN KEY (user_id) REFERENCES users(id)"
                                + ") ENGINE=InnoDB";

                // Bookings table
                String createBookingsTable =
                        "CREATE TABLE IF NOT EXISTS bookings ("
                                + "booking_id INT AUTO_INCREMENT PRIMARY KEY, "
                                + "user_id INT NOT NULL, "
                                + "booking_reference VARCHAR(20) UNIQUE NOT NULL, "
                                + "room_type VARCHAR(100) NOT NULL, "
                                + "check_in DATE NOT NULL, "
                                + "check_out DATE NOT NULL, "
                                + "guests INT NOT NULL, "
                                + "total_amount DECIMAL(10,2) NOT NULL, "
                                + "booking_status ENUM('PENDING', 'CONFIRMED', 'CANCELLED') DEFAULT 'PENDING', "
                                + "special_requests TEXT, "
                                + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                                + "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, "
                                + "CONSTRAINT fk_bookings_user FOREIGN KEY (user_id) REFERENCES users(id)"
                                + ") ENGINE=InnoDB";

                // Contact messages table (bonus)
                String createContactTable =
                        "CREATE TABLE IF NOT EXISTS contact_messages ("
                                + "message_id INT AUTO_INCREMENT PRIMARY KEY, "
                                + "name VARCHAR(100) NOT NULL, "
                                + "email VARCHAR(255) NOT NULL, "
                                + "subject VARCHAR(200), "
                                + "message TEXT NOT NULL, "
                                + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                                + "is_read BOOLEAN DEFAULT FALSE"
                                + ") ENGINE=InnoDB";

                // Room types table (bonus for booking system)
                String createRoomTypesTable =
                        "CREATE TABLE IF NOT EXISTS room_types ("
                                + "room_type_id INT AUTO_INCREMENT PRIMARY KEY, "
                                + "type_name VARCHAR(100) NOT NULL, "
                                + "description TEXT, "
                                + "price_per_night DECIMAL(8,2) NOT NULL, "
                                + "max_guests INT NOT NULL, "
                                + "amenities TEXT, "
                                + "image_url VARCHAR(500), "
                                + "is_active BOOLEAN DEFAULT TRUE"
                                + ") ENGINE=InnoDB";

                // Execute all table creation
                stmt.execute(createUsersTable);
                stmt.execute(createSessionsTable);
                stmt.execute(createLoginsTable);
                stmt.execute(createBookingsTable);
                stmt.execute(createContactTable);
                stmt.execute(createRoomTypesTable);

                // Insert sample room types
                String insertRoomTypes = 
                    "INSERT IGNORE INTO room_types (type_name, description, price_per_night, max_guests, amenities, image_url) VALUES " +
                    "('Ocean View Suite', 'Luxury suite with panoramic ocean views', 15000.00, 2, 'Air conditioning, Mini bar, Ocean view balcony, King size bed', 'images/rooms/ocean-suite.jpg'), " +
                    "('Beach Villa', 'Private villa steps away from the beach', 25000.00, 4, 'Private pool, Beach access, Full kitchen, 2 bedrooms', 'images/rooms/beach-villa.jpg'), " +
                    "('Standard Room', 'Comfortable room with garden view', 8000.00, 2, 'Air conditioning, TV, Mini fridge, Garden view', 'images/rooms/standard-room.jpg'), " +
                    "('Family Room', 'Spacious room perfect for families', 12000.00, 4, 'Air conditioning, TV, Mini fridge, 2 double beds', 'images/rooms/family-room.jpg'), " +
                    "('Deluxe Room', 'Premium room with modern amenities', 10000.00, 2, 'Air conditioning, TV, Mini bar, Sea glimpse', 'images/rooms/deluxe-room.jpg')";
                
                stmt.execute(insertRoomTypes);

            }

            // Success message with styling
            out.println("<!DOCTYPE html>");
            out.println("<html><head><title>Database Setup</title>");
            out.println("<style>");
            out.println("body { font-family: Arial, sans-serif; margin: 40px; background: #f5f5f5; }");
            out.println(".container { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }");
            out.println("h2 { color: #10b981; margin-bottom: 20px; }");
            out.println("ul { list-style: none; padding: 0; }");
            out.println("li { background: #f0f9ff; padding: 10px; margin: 5px 0; border-left: 4px solid #3b82f6; }");
            out.println(".success { color: #10b981; font-size: 18px; }");
            out.println(".info { color: #6b7280; margin-top: 20px; }");
            out.println("</style></head><body>");
            
            out.println("<div class='container'>");
            out.println("<h2>✅ Database Setup Completed Successfully!</h2>");
            
            out.println("<div class='success'>All tables created and sample data inserted.</div>");
            
            out.println("<h3>📊 Created Tables:</h3>");
            out.println("<ul>");
            out.println("<li><strong>users</strong> - User accounts with authentication</li>");
            out.println("<li><strong>user_sessions</strong> - Session management & remember me</li>");
            out.println("<li><strong>user_logins</strong> - Login history tracking</li>");
            out.println("<li><strong>bookings</strong> - Hotel reservation system</li>");
            out.println("<li><strong>contact_messages</strong> - Contact form submissions</li>");
            out.println("<li><strong>room_types</strong> - Available room types with pricing</li>");
            out.println("</ul>");
            
            out.println("<div class='info'>");
            out.println("<p><strong>🎯 Next Steps:</strong></p>");
            out.println("<p>1. Test user registration: <a href='login/signup'>Signup Page</a></p>");
            out.println("<p>2. Test user login: <a href='login/login'>Login Page</a></p>");
            out.println("<p>3. Make a booking: <a href='reservation'>Booking Page</a></p>");
            out.println("</div>");
            
            out.println("</div>");
            out.println("</body></html>");

        } catch (Exception e) {
            out.println("<!DOCTYPE html>");
            out.println("<html><head><title>Database Error</title>");
            out.println("<style>body{font-family:Arial;margin:40px;} .error{color:#ef4444;background:#fef2f2;padding:20px;border-radius:8px;}</style>");
            out.println("</head><body>");
            out.println("<div class='error'>");
            out.println("<h2>❌ Error Creating Tables</h2>");
            out.println("<p><strong>Error:</strong> " + e.getMessage() + "</p>");
            out.println("<p><strong>Possible Solutions:</strong></p>");
            out.println("<ul>");
            out.println("<li>Check if MySQL server is running</li>");
            out.println("<li>Verify database 'oceanview' exists</li>");
            out.println("<li>Check MySQL username/password</li>");
            out.println("<li>Ensure MySQL JDBC driver is in classpath</li>");
            out.println("</ul>");
            out.println("</div>");
            out.println("</body></html>");
            
            e.printStackTrace();
        }
    }
}
