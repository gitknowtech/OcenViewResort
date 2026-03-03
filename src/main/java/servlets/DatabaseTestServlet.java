package servlets;

import config.DatabaseConfig;
import dao.UserDAO;
import models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.List;

@WebServlet("/test-db")
public class DatabaseTestServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<!DOCTYPE html>");
        out.println("<html><head><title>Database Test</title></head><body>");
        out.println("<h1>Ocean View Resort - Database Connection Test</h1>");
        
        try {
            // Test database connection
            out.println("<h2>1. Testing Database Connection...</h2>");
            
            if (DatabaseConfig.testConnection()) {
                out.println("<p style='color: green;'>✅ Database connection successful!</p>");
                
                // Test UserDAO
                out.println("<h2>2. Testing UserDAO...</h2>");
                UserDAO userDAO = new UserDAO();
                
                // Get all users
                List<User> users = userDAO.getAllUsers();
                out.println("<p>📊 Total users in database: " + users.size() + "</p>");
                
                if (!users.isEmpty()) {
                    out.println("<h3>Registered Users:</h3>");
                    out.println("<table border='1' style='border-collapse: collapse;'>");
                    out.println("<tr><th>ID</th><th>Email</th><th>Registered Time</th></tr>");
                    
                    for (User user : users) {
                        out.println("<tr>");
                        out.println("<td>" + user.getId() + "</td>");
                        out.println("<td>" + user.getEmail() + "</td>");
                        out.println("<td>" + user.getRegisteredTime() + "</td>");
                        out.println("</tr>");
                    }
                    out.println("</table>");
                }
                
                // Test authentication with sample user
                out.println("<h2>3. Testing Authentication...</h2>");
                User testUser = userDAO.authenticateUser("test@oceanview.com", "password123");
                if (testUser != null) {
                    out.println("<p style='color: green;'>✅ Test user authentication successful!</p>");
                    out.println("<p>Test User: " + testUser.getEmail() + " (ID: " + testUser.getId() + ")</p>");
                } else {
                    out.println("<p style='color: orange;'>⚠️ Test user not found or authentication failed</p>");
                }
                
            } else {
                out.println("<p style='color: red;'>❌ Database connection failed!</p>");
            }
            
        } catch (Exception e) {
            out.println("<p style='color: red;'>❌ Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
        
        out.println("<br><hr>");
        out.println("<p><a href='index.jsp'>← Back to Home</a></p>");
        out.println("</body></html>");
    }
}
