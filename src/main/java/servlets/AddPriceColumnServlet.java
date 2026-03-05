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

@WebServlet("/addPriceColumn")
public class AddPriceColumnServlet extends HttpServlet {
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

                // ✅ ADD PRICE COLUMN IF NOT EXISTS
                String addPriceColumn = "ALTER TABLE rooms ADD COLUMN IF NOT EXISTS room_price DECIMAL(10, 2) DEFAULT 0.00";

                System.out.println("Adding price column to rooms table...");
                stmt.execute(addPriceColumn);

                System.out.println("✅ Price column added successfully!");

                // Success message
                out.println("<!DOCTYPE html>");
                out.println("<html><head><title>Price Column Added</title>");
                out.println("<style>");
                out.println("body { font-family: Arial, sans-serif; margin: 40px; background: #f5f5f5; }");
                out.println(".container { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); max-width: 700px; }");
                out.println("h2 { color: #10b981; margin-bottom: 20px; }");
                out.println(".success { color: #10b981; font-size: 18px; margin-bottom: 20px; background: #f0fdf4; padding: 15px; border-radius: 8px; border-left: 4px solid #10b981; }");
                out.println("</style></head><body>");
                
                out.println("<div class='container'>");
                out.println("<h2>✅ Price Column Added Successfully!</h2>");
                out.println("<div class='success'>");
                out.println("<strong>🎉 Column 'room_price' has been added to rooms table!</strong>");
                out.println("</div>");
                out.println("<p>You can now use the Rooms management system with pricing.</p>");
                out.println("</div>");
                out.println("</body></html>");

            }

        } catch (Exception e) {
            out.println("<!DOCTYPE html>");
            out.println("<html><head><title>Database Error</title>");
            out.println("<style>body{font-family:Arial;margin:40px;} .error{color:#ef4444;background:#fef2f2;padding:20px;border-radius:8px; border-left: 4px solid #ef4444;}</style>");
            out.println("</head><body>");
            out.println("<div class='error'>");
            out.println("<h2>❌ Error Adding Column</h2>");
            out.println("<p><strong>Error:</strong> " + e.getMessage() + "</p>");
            out.println("</div>");
            out.println("</body></html>");
            
            e.printStackTrace();
        }
    }
}
