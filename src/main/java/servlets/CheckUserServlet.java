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
            
            // Check if user is logged in via session
            if (session != null && Boolean.TRUE.equals(session.getAttribute("isLoggedIn"))) {
                Integer userId = (Integer) session.getAttribute("userId");
                String userEmail = (String) session.getAttribute("userEmail");
                String firstName = (String) session.getAttribute("firstName");
                String lastName = (String) session.getAttribute("lastName");
                String phone = (String) session.getAttribute("phone");
                
                String displayName = firstName != null && !firstName.trim().isEmpty() 
                    ? firstName 
                    : userEmail.split("@")[0];
                
                String jsonResponse = "{\"loggedIn\":true,\"user\":{\"id\":" + userId + ",\"email\":\"" + userEmail + "\",\"name\":\"" + displayName + "\",\"firstName\":\"" + (firstName != null ? firstName : "") + "\",\"lastName\":\"" + (lastName != null ? lastName : "") + "\",\"phone\":\"" + (phone != null ? phone : "") + "\"},\"autoLogin\":false}";
                out.print(jsonResponse);
                return;
            }
            
            // Check remember me cookie
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("oceanview_remember".equals(cookie.getName())) {
                        String sessionToken = cookie.getValue();
                        
                        // Check if token is valid and not expired
                        String url = "jdbc:mysql://localhost:3306/oceanview?useSSL=false&serverTimezone=UTC";
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        
                        try (Connection conn = DriverManager.getConnection(url, "root", "")) {
                            String query = "SELECT us.user_id, u.email, u.first_name, u.last_name, u.phone " +
                                         "FROM user_sessions us " +
                                         "JOIN users u ON us.user_id = u.id " +
                                         "WHERE us.session_id = ? AND us.expires_at > ? AND us.is_remember_me = TRUE";
                            
                            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                                stmt.setString(1, sessionToken);
                                stmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
                                
                                try (ResultSet rs = stmt.executeQuery()) {
                                    if (rs.next()) {
                                        // Auto login successful
                                        int userId = rs.getInt("user_id");
                                        String userEmail = rs.getString("email");
                                        String firstName = rs.getString("first_name");
                                        String lastName = rs.getString("last_name");
                                        String phone = rs.getString("phone");
                                        
                                        // Create new session
                                        HttpSession newSession = request.getSession();
                                        newSession.setAttribute("userId", userId);
                                        newSession.setAttribute("userEmail", userEmail);
                                        newSession.setAttribute("firstName", firstName);
                                        newSession.setAttribute("lastName", lastName);
                                        newSession.setAttribute("phone", phone);
                                        newSession.setAttribute("isLoggedIn", true);
                                        
                                        String displayName = firstName != null && !firstName.trim().isEmpty() 
                                            ? firstName 
                                            : userEmail.split("@")[0];
                                        
                                        String jsonResponse = "{\"loggedIn\":true,\"user\":{\"id\":" + userId + ",\"email\":\"" + userEmail + "\",\"name\":\"" + displayName + "\",\"firstName\":\"" + (firstName != null ? firstName : "") + "\",\"lastName\":\"" + (lastName != null ? lastName : "") + "\",\"phone\":\"" + (phone != null ? phone : "") + "\"},\"autoLogin\":true}";
                                        out.print(jsonResponse);
                                        return;
                                    }
                                }
                            }
                        }
                        break;
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
