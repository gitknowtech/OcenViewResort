package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/checkUser")
public class CheckUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            HttpSession session = request.getSession(false);
            
            // Check session first
            if (session != null && Boolean.TRUE.equals(session.getAttribute("isLoggedIn"))) {
                Integer userId = (Integer) session.getAttribute("userId");
                String userEmail = (String) session.getAttribute("userEmail");
                String firstName = (String) session.getAttribute("firstName");
                
                String displayName = firstName != null ? firstName : userEmail.split("@")[0];
                
                out.print("{\"loggedIn\":true,\"user\":{\"id\":" + userId + ",\"email\":\"" + userEmail + "\",\"name\":\"" + displayName + "\"}}");
                return;
            }
            
            // Check remember me cookie
            Cookie[] cookies = request.getCookies();
            String rememberToken = null;
            
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("oceanview_remember".equals(cookie.getName())) {
                        rememberToken = cookie.getValue();
                        break;
                    }
                }
            }
            
            if (rememberToken != null) {
                // Validate remember token
                String url = "jdbc:mysql://localhost:3306/oceanview?useSSL=false&serverTimezone=UTC";
                String dbUser = "root";
                String dbPassword = "";

                Class.forName("com.mysql.cj.jdbc.Driver");
                
                try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword)) {
                    String query = "SELECT u.id, u.email, u.first_name, u.last_name FROM user_sessions s " +
                                  "JOIN users u ON s.user_id = u.id " +
                                  "WHERE s.session_id = ? AND s.expires_at > ? AND s.is_remember_me = TRUE";
                    
                    try (PreparedStatement stmt = conn.prepareStatement(query)) {
                        stmt.setString(1, rememberToken);
                        stmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
                        
                        try (ResultSet rs = stmt.executeQuery()) {
                            if (rs.next()) {
                                // Auto login from remember me
                                int userId = rs.getInt("id");
                                String userEmail = rs.getString("email");
                                String firstName = rs.getString("first_name");
                                String lastName = rs.getString("last_name");
                                
                                // Create new session
                                HttpSession newSession = request.getSession();
                                newSession.setAttribute("userId", userId);
                                newSession.setAttribute("userEmail", userEmail);
                                newSession.setAttribute("firstName", firstName);
                                newSession.setAttribute("lastName", lastName);
                                newSession.setAttribute("isLoggedIn", true);
                                
                                String displayName = firstName != null ? firstName : userEmail.split("@")[0];
                                
                                out.print("{\"loggedIn\":true,\"autoLogin\":true,\"user\":{\"id\":" + userId + ",\"email\":\"" + userEmail + "\",\"name\":\"" + displayName + "\"}}");
                                return;
                            }
                        }
                    }
                }
            }
            
            // Not logged in
            out.print("{\"loggedIn\":false}");
            
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"loggedIn\":false,\"error\":\"" + e.getMessage() + "\"}");
        }
    }
}
