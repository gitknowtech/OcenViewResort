package servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;

@WebServlet("/simple-test")
public class SimpleDBTest extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<h1>Simple Database Test</h1>");
        
        try {
            // Load driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Connect to database
            String url = "jdbc:mysql://localhost:3306/oceanviewresort?useSSL=false&serverTimezone=UTC";
            String username = "root"; // Change this
            String password = "";     // Change this
            
            Connection conn = DriverManager.getConnection(url, username, password);
            
            if (conn != null) {
                out.println("<p style='color: green;'>✅ Database Connected Successfully!</p>");
                out.println("<p>Connection: " + conn.toString() + "</p>");
                conn.close();
            } else {
                out.println("<p style='color: red;'>❌ Connection Failed!</p>");
            }
            
        } catch (Exception e) {
            out.println("<p style='color: red;'>❌ Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    }
}
