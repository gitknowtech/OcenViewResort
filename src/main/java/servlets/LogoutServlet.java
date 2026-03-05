package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Get session
            HttpSession session = request.getSession(false);
            
            // Clear remember me cookie and database
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("oceanview_remember".equals(cookie.getName())) {
                        String rememberToken = cookie.getValue();
                        
                        // Remove from database
                        try {
                            String url = "jdbc:mysql://localhost:3306/oceanview?useSSL=false&serverTimezone=UTC";
                            String dbUser = "root";
                            String dbPassword = "";

                            Class.forName("com.mysql.cj.jdbc.Driver");
                            
                            try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);
                                 PreparedStatement stmt = conn.prepareStatement("DELETE FROM user_sessions WHERE session_id = ?")) {
                                stmt.setString(1, rememberToken);
                                stmt.executeUpdate();
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        
                        // Clear cookie
                        Cookie clearCookie = new Cookie("oceanview_remember", "");
                        clearCookie.setMaxAge(0);
                        clearCookie.setPath("/");
                        response.addCookie(clearCookie);
                        break;
                    }
                }
            }
            
            // Invalidate session
            if (session != null) {
                session.invalidate();
            }
            
            out.print("{\"success\":true,\"message\":\"Logged out successfully\"}");
            
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"Error during logout\"}");
        }
    }
}
