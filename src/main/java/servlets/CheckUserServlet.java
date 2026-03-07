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
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/oceanview?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            System.out.println("\n╔════════════════════════════════════╗");
            System.out.println("║    CHECK USER SERVLET CALLED       ║");
            System.out.println("╚════════════════════════════════════╝");
            
            // ✅ STEP 1: CHECK ACTIVE SESSION
            System.out.println("\n🔍 STEP 1: Checking active session...");
            HttpSession session = request.getSession(false);
            
            if (session != null && Boolean.TRUE.equals(session.getAttribute("isLoggedIn"))) {
                System.out.println("✅ Active session found!");
                
                Integer userId = (Integer) session.getAttribute("userId");
                String username = (String) session.getAttribute("username");
                String userEmail = (String) session.getAttribute("userEmail");
                String firstName = (String) session.getAttribute("firstName");
                String lastName = (String) session.getAttribute("lastName");
                String phone = (String) session.getAttribute("phone");
                Object isAdminObj = session.getAttribute("isAdmin");
                
                boolean isAdmin = isAdminObj instanceof Boolean ? (Boolean) isAdminObj : false;
                
                System.out.println("   User ID: " + userId);
                System.out.println("   Username: " + username);
                System.out.println("   Email: " + userEmail);
                System.out.println("   Is Admin: " + isAdmin);
                
                String displayName = getDisplayName(firstName, userEmail);
                
                String jsonResponse = buildUserResponse(true, userId, username, userEmail, displayName, 
                                                       firstName, lastName, phone, isAdmin, false);
                
                System.out.println("✅ Returning active session user\n");
                out.print(jsonResponse);
                return;
            }
            
            System.out.println("❌ No active session found");
            
            // ✅ STEP 2: CHECK REMEMBER ME COOKIES
            System.out.println("\n🔍 STEP 2: Checking remember me cookies...");
            
            String rememberToken = getCookieValue(request, "oceanview_remember");
            String userIdCookie = getCookieValue(request, "oceanview_userId");
            String usernameCookie = getCookieValue(request, "oceanview_username");
            String emailCookie = getCookieValue(request, "oceanview_email");
            String isAdminCookie = getCookieValue(request, "oceanview_isAdmin");
            
            if (rememberToken != null && userIdCookie != null) {
                System.out.println("🍪 Remember me cookies found!");
                System.out.println("   Token: " + rememberToken.substring(0, 8) + "...");
                System.out.println("   User ID: " + userIdCookie);
                System.out.println("   Username: " + usernameCookie);
                
                // ✅ VALIDATE TOKEN IN DATABASE
                if (validateRememberMeToken(rememberToken, Integer.parseInt(userIdCookie))) {
                    System.out.println("✅ Token is valid - Auto-login successful!");
                    
                    // Recreate session
                    HttpSession newSession = request.getSession(true);
                    int userId = Integer.parseInt(userIdCookie);
                    boolean isAdmin = Boolean.parseBoolean(isAdminCookie);
                    
                    newSession.setAttribute("userId", userId);
                    newSession.setAttribute("username", usernameCookie);
                    newSession.setAttribute("userEmail", emailCookie);
                    newSession.setAttribute("email", emailCookie);
                    newSession.setAttribute("firstName", usernameCookie);
                    newSession.setAttribute("lastName", "");
                    newSession.setAttribute("isAdmin", isAdmin);
                    newSession.setAttribute("isLoggedIn", true);
                    newSession.setAttribute("role", isAdmin ? "STAFF" : "USER");
                    newSession.setMaxInactiveInterval(30 * 60); // 30 minutes
                    
                    System.out.println("✅ New session created from remember me cookie");
                    System.out.println("   Session ID: " + newSession.getId());
                    
                    String displayName = getDisplayName(usernameCookie, emailCookie);
                    String jsonResponse = buildUserResponse(true, userId, usernameCookie, emailCookie, 
                                                           displayName, usernameCookie, "", "", isAdmin, true);
                    
                    System.out.println("✅ Returning auto-logged-in user\n");
                    out.print(jsonResponse);
                    return;
                } else {
                    System.out.println("❌ Token is invalid or expired - Clearing cookies");
                    clearRememberMeCookies(request, response);
                }
            }
            
            System.out.println("❌ No valid remember me cookies\n");
            
            // ✅ STEP 3: NOT LOGGED IN
            System.out.println("📝 User is not logged in\n");
            out.print("{\"loggedIn\":false,\"user\":null}");
            
        } catch (Exception e) {
            System.out.println("❌ CheckUserServlet Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"loggedIn\":false,\"error\":\"" + e.getMessage() + "\"}");
        }
    }

    // ✅ VALIDATE REMEMBER ME TOKEN IN DATABASE
    private boolean validateRememberMeToken(String token, int userId) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                
                // Check if token exists and is not expired
                String query = "SELECT id FROM user_sessions WHERE session_id = ? AND user_id = ? AND expires_at > NOW() AND is_remember_me = TRUE LIMIT 1";
                
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, token);
                    stmt.setInt(2, userId);
                    
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            System.out.println("   ✅ Token validated in database");
                            return true;
                        }
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("   ⚠️ Error validating token: " + e.getMessage());
        }
        
        System.out.println("   ❌ Token not found or expired");
        return false;
    }

    // ✅ GET COOKIE VALUE
    private String getCookieValue(HttpServletRequest request, String cookieName) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookieName.equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }

    // ✅ CLEAR ALL REMEMBER ME COOKIES
    private void clearRememberMeCookies(HttpServletRequest request, HttpServletResponse response) {
        String[] cookieNames = {
            "oceanview_remember",
            "oceanview_userId",
            "oceanview_username",
            "oceanview_email",
            "oceanview_isAdmin"
        };

        for (String cookieName : cookieNames) {
            Cookie cookie = new Cookie(cookieName, "");
            cookie.setMaxAge(0);
            cookie.setPath("/OceanViewResort");
            cookie.setHttpOnly(true);
            response.addCookie(cookie);
            System.out.println("   🗑️ Cookie cleared: " + cookieName);
        }
    }

    // ✅ GET DISPLAY NAME
    private String getDisplayName(String firstName, String email) {
        if (firstName != null && !firstName.trim().isEmpty()) {
            return firstName;
        }
        if (email != null && email.contains("@")) {
            return email.split("@")[0];
        }
        return "User";
    }

    // ✅ BUILD USER RESPONSE JSON
    private String buildUserResponse(boolean loggedIn, int userId, String username, String email, 
                                     String displayName, String firstName, String lastName, 
                                     String phone, boolean isAdmin, boolean autoLogin) {
        
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"loggedIn\":").append(loggedIn).append(",");
        json.append("\"autoLogin\":").append(autoLogin).append(",");
        json.append("\"user\":{");
        json.append("\"id\":").append(userId).append(",");
        json.append("\"username\":\"").append(escapeJson(username)).append("\",");
        json.append("\"email\":\"").append(escapeJson(email)).append("\",");
        json.append("\"name\":\"").append(escapeJson(displayName)).append("\",");
        json.append("\"firstName\":\"").append(escapeJson(firstName != null ? firstName : "")).append("\",");
        json.append("\"lastName\":\"").append(escapeJson(lastName != null ? lastName : "")).append("\",");
        json.append("\"phone\":\"").append(escapeJson(phone != null ? phone : "")).append("\",");
        json.append("\"isAdmin\":").append(isAdmin);
        json.append("}");
        json.append("}");
        
        return json.toString();
    }

    // ✅ ESCAPE JSON SPECIAL CHARACTERS
    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}
