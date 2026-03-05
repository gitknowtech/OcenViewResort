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

                // 1. USERS TABLE - Simple Version
                String createUsersTable =
                        "CREATE TABLE IF NOT EXISTS users ("
                                + "id INT AUTO_INCREMENT PRIMARY KEY, "
                                + "username VARCHAR(50) UNIQUE NOT NULL, "           // Username (compulsory & unique)
                                + "email VARCHAR(255) UNIQUE NOT NULL, "             // Email (unique)
                                + "password VARCHAR(64) NOT NULL, "                  // Password (hashed)
                                + "first_name VARCHAR(100) NOT NULL, "               // First name (compulsory)
                                + "last_name VARCHAR(100) NOT NULL, "                // Last name (compulsory)
                                + "phone VARCHAR(20) NOT NULL, "                     // Primary phone (compulsory)
                                + "phone2 VARCHAR(20), "                             // Secondary phone (optional)
                                + "national_id VARCHAR(20) UNIQUE, "                 // National ID (unique, optional)
                                + "date_of_birth DATE, "                             // Date of birth (optional)
                                + "address TEXT, "                                   // Address (optional)
                                + "city VARCHAR(100), "                             // City (optional)
                                + "country VARCHAR(100) DEFAULT 'Sri Lanka', "      // Country (default: Sri Lanka)
                                + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                                + "last_login TIMESTAMP NULL DEFAULT NULL"
                                + ") ENGINE=InnoDB";

                // 2. USER SESSIONS TABLE - Simple Version
                String createSessionsTable =
                        "CREATE TABLE IF NOT EXISTS user_sessions ("
                                + "session_id VARCHAR(255) PRIMARY KEY, "            // Unique session token
                                + "user_id INT NOT NULL, "                           // User reference
                                + "ip_address VARCHAR(45), "                         // IP address
                                + "user_agent TEXT, "                               // Browser info
                                + "is_remember_me BOOLEAN DEFAULT FALSE, "          // Remember me flag
                                + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                                + "expires_at TIMESTAMP NULL DEFAULT NULL, "        // Session expiry
                                + "CONSTRAINT fk_sessions_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE"
                                + ") ENGINE=InnoDB";

                // 3. USER LOGINS TABLE - Simple Version
                String createLoginsTable =
                        "CREATE TABLE IF NOT EXISTS user_logins ("
                                + "login_id INT AUTO_INCREMENT PRIMARY KEY, "
                                + "user_id INT NOT NULL, "                           // User reference
                                + "login_method VARCHAR(20) DEFAULT 'EMAIL', "      // LOGIN method (EMAIL/USERNAME)
                                + "login_status VARCHAR(20) DEFAULT 'SUCCESS', "    // Login result (SUCCESS/FAILED)
                                + "ip_address VARCHAR(45), "                        // IP address
                                + "user_agent TEXT, "                              // Browser info
                                + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                                + "CONSTRAINT fk_user_logins_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE"
                                + ") ENGINE=InnoDB";

                // Execute table creation
                System.out.println("Creating users table...");
                stmt.execute(createUsersTable);
                
                System.out.println("Creating user_sessions table...");
                stmt.execute(createSessionsTable);
                
                System.out.println("Creating user_logins table...");
                stmt.execute(createLoginsTable);

                System.out.println("All tables created successfully!");

            }

            // Success message with simple styling
            out.println("<!DOCTYPE html>");
            out.println("<html><head><title>Simple Tables Created</title>");
            out.println("<style>");
            out.println("body { font-family: Arial, sans-serif; margin: 40px; background: #f5f5f5; }");
            out.println(".container { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); max-width: 800px; }");
            out.println("h2 { color: #10b981; margin-bottom: 20px; }");
            out.println(".success { color: #10b981; font-size: 18px; margin-bottom: 20px; background: #f0fdf4; padding: 15px; border-radius: 8px; border-left: 4px solid #10b981; }");
            out.println(".table-info { background: #f8fafc; padding: 20px; border-radius: 8px; margin: 15px 0; border-left: 4px solid #3b82f6; }");
            out.println(".table-name { color: #1f2937; font-weight: bold; font-size: 16px; margin-bottom: 10px; }");
            out.println("ul { margin: 10px 0; padding-left: 20px; }");
            out.println("li { margin: 5px 0; font-size: 14px; }");
            out.println(".required { color: #dc2626; font-weight: bold; }");
            out.println(".optional { color: #059669; }");
            out.println(".unique { color: #7c3aed; font-weight: bold; }");
            out.println(".next-steps { background: #eff6ff; padding: 20px; border-radius: 8px; margin: 20px 0; border-left: 4px solid #3b82f6; }");
            out.println("</style></head><body>");
            
            out.println("<div class='container'>");
            out.println("<h2>✅ Simple User Tables Created Successfully!</h2>");
            
            out.println("<div class='success'>");
            out.println("<strong>🎉 3 basic tables have been created!</strong><br>");
            out.println("Simple user authentication system is ready.");
            out.println("</div>");

            // Table 1: Users
            out.println("<div class='table-info'>");
            out.println("<div class='table-name'>👤 1. USERS TABLE</div>");
            out.println("<strong>Basic user information:</strong>");
            out.println("<ul>");
            out.println("<li><span class='unique'>id</span> - Auto increment primary key</li>");
            out.println("<li><span class='required unique'>username</span> - Unique username (required)</li>");
            out.println("<li><span class='required unique'>email</span> - Unique email address (required)</li>");
            out.println("<li><span class='required'>password</span> - Hashed password (required)</li>");
            out.println("<li><span class='required'>first_name</span> - First name (required)</li>");
            out.println("<li><span class='required'>last_name</span> - Last name (required)</li>");
            out.println("<li><span class='required'>phone</span> - Primary phone (required)</li>");
            out.println("<li><span class='optional'>phone2</span> - Secondary phone (optional)</li>");
            out.println("<li><span class='optional unique'>national_id</span> - National ID (optional)</li>");
            out.println("<li><span class='optional'>date_of_birth</span> - Date of birth (optional)</li>");
            out.println("<li><span class='optional'>address</span> - Address (optional)</li>");
            out.println("<li><span class='optional'>city</span> - City (optional)</li>");
            out.println("<li><span class='optional'>country</span> - Country (default: Sri Lanka)</li>");
            out.println("<li><span class='optional'>created_at</span> - Account creation time</li>");
            out.println("<li><span class='optional'>last_login</span> - Last login time</li>");
            out.println("</ul>");
            out.println("</div>");

            // Table 2: Sessions
            out.println("<div class='table-info'>");
            out.println("<div class='table-name'>🔐 2. USER_SESSIONS TABLE</div>");
            out.println("<strong>Session management:</strong>");
            out.println("<ul>");
            out.println("<li><span class='unique'>session_id</span> - Unique session token</li>");
            out.println("<li><span class='required'>user_id</span> - User reference</li>");
            out.println("<li><span class='optional'>ip_address</span> - Login IP address</li>");
            out.println("<li><span class='optional'>user_agent</span> - Browser information</li>");
            out.println("<li><span class='optional'>is_remember_me</span> - Remember me flag</li>");
            out.println("<li><span class='optional'>created_at</span> - Session start time</li>");
            out.println("<li><span class='optional'>expires_at</span> - Session expiry time</li>");
            out.println("</ul>");
            out.println("</div>");

            // Table 3: Logins
            out.println("<div class='table-info'>");
            out.println("<div class='table-name'>📊 3. USER_LOGINS TABLE</div>");
            out.println("<strong>Login history:</strong>");
            out.println("<ul>");
            out.println("<li><span class='unique'>login_id</span> - Auto increment primary key</li>");
            out.println("<li><span class='required'>user_id</span> - User reference</li>");
            out.println("<li><span class='optional'>login_method</span> - EMAIL or USERNAME</li>");
            out.println("<li><span class='optional'>login_status</span> - SUCCESS or FAILED</li>");
            out.println("<li><span class='optional'>ip_address</span> - Login IP address</li>");
            out.println("<li><span class='optional'>user_agent</span> - Browser information</li>");
            out.println("<li><span class='optional'>created_at</span> - Login time</li>");
            out.println("</ul>");
            out.println("</div>");

            out.println("<div class='next-steps'>");
            out.println("<h4>🎯 What's Next:</h4>");
            out.println("<ol>");
            out.println("<li><strong>Create Signup Form:</strong> Build user registration form</li>");
            out.println("<li><strong>Create Login Form:</strong> Build user login form</li>");
            out.println("<li><strong>Test Registration:</strong> Add new users</li>");
            out.println("<li><strong>Test Login:</strong> Verify login works</li>");
            out.println("</ol>");
            out.println("</div>");
            
            out.println("<div style='text-align: center; margin-top: 30px;'>");
            out.println("<p><a href='#login/signup' onclick='if(typeof loadPage === \"function\") loadPage(\"login/signup\"); return false;' style='background: #10b981; color: white; padding: 12px 24px; text-decoration: none; border-radius: 6px; margin: 5px;'>📝 Create Signup</a></p>");
            out.println("<p><a href='#login/login' onclick='if(typeof loadPage === \"function\") loadPage(\"login/login\"); return false;' style='background: #3b82f6; color: white; padding: 12px 24px; text-decoration: none; border-radius: 6px; margin: 5px;'>🔐 Test Login</a></p>");
            out.println("</div>");
            
            out.println("</div>");
            out.println("</body></html>");

        } catch (Exception e) {
            out.println("<!DOCTYPE html>");
            out.println("<html><head><title>Database Error</title>");
            out.println("<style>body{font-family:Arial;margin:40px;} .error{color:#ef4444;background:#fef2f2;padding:20px;border-radius:8px; border-left: 4px solid #ef4444;}</style>");
            out.println("</head><body>");
            out.println("<div class='error'>");
            out.println("<h2>❌ Error Creating Tables</h2>");
            out.println("<p><strong>Error:</strong> " + e.getMessage() + "</p>");
            out.println("<h4>Solutions:</h4>");
            out.println("<ul>");
            out.println("<li>Check MySQL server is running</li>");
            out.println("<li>Create database: <code>CREATE DATABASE oceanview;</code></li>");
            out.println("<li>Check username/password</li>");
            out.println("</ul>");
            out.println("</div>");
            out.println("</body></html>");
            
            e.printStackTrace();
        }
    }
}
