package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/updateProfile")
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("userId") == null) {
                out.print("{\"success\":false,\"message\":\"Not logged in\"}");
                return;
            }

            int userId = (Integer) session.getAttribute("userId");
            
            // ✅ DEBUG: Print all parameters received
            System.out.println("========== UPDATE PROFILE DEBUG ==========");
            System.out.println("User ID: " + userId);
            
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String phone2 = request.getParameter("phone2");
            String nationalId = request.getParameter("nationalId");
            String dateOfBirth = request.getParameter("dateOfBirth");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String country = request.getParameter("country");
            
            System.out.println("firstName: " + firstName);
            System.out.println("lastName: " + lastName);
            System.out.println("username: " + username);
            System.out.println("email: " + email);
            System.out.println("phone: " + phone);
            System.out.println("phone2: " + phone2);
            System.out.println("========================================");

            // Validation with debug
            if (firstName == null || firstName.trim().isEmpty()) {
                System.out.println("❌ Validation failed: firstName is null or empty");
                out.print("{\"success\":false,\"message\":\"First name is required\"}");
                return;
            }
            
            if (lastName == null || lastName.trim().isEmpty()) {
                System.out.println("❌ Validation failed: lastName is null or empty");
                out.print("{\"success\":false,\"message\":\"Last name is required\"}");
                return;
            }
            
            if (username == null || username.trim().isEmpty()) {
                System.out.println("❌ Validation failed: username is null or empty");
                out.print("{\"success\":false,\"message\":\"Username is required\"}");
                return;
            }
            
            if (email == null || email.trim().isEmpty()) {
                System.out.println("❌ Validation failed: email is null or empty");
                out.print("{\"success\":false,\"message\":\"Email is required\"}");
                return;
            }
            
            if (phone == null || phone.trim().isEmpty()) {
                System.out.println("❌ Validation failed: phone is null or empty");
                out.print("{\"success\":false,\"message\":\"Phone number is required\"}");
                return;
            }

            // Clean data
            firstName = firstName.trim();
            lastName = lastName.trim();
            username = username.trim().toLowerCase();
            email = email.trim().toLowerCase();
            phone = phone.trim();
            phone2 = (phone2 != null && !phone2.trim().isEmpty()) ? phone2.trim() : null;
            nationalId = (nationalId != null && !nationalId.trim().isEmpty()) ? nationalId.trim() : null;
            dateOfBirth = (dateOfBirth != null && !dateOfBirth.trim().isEmpty()) ? dateOfBirth.trim() : null;
            address = (address != null && !address.trim().isEmpty()) ? address.trim() : null;
            city = (city != null && !city.trim().isEmpty()) ? city.trim() : null;
            country = (country != null && !country.trim().isEmpty()) ? country.trim() : "Sri Lanka";

            String url = "jdbc:mysql://localhost:3306/oceanview?useSSL=false&serverTimezone=UTC";
            String dbUser = "root";
            String dbPassword = "";

            Class.forName("com.mysql.cj.jdbc.Driver");
            
            try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword)) {
                
                // Check if username is taken by another user
                try (PreparedStatement checkUsername = conn.prepareStatement("SELECT id FROM users WHERE username = ? AND id != ?")) {
                    checkUsername.setString(1, username);
                    checkUsername.setInt(2, userId);
                    try (ResultSet rs = checkUsername.executeQuery()) {
                        if (rs.next()) {
                            out.print("{\"success\":false,\"message\":\"Username already taken by another user\"}");
                            return;
                        }
                    }
                }
                
                // Check if email is taken by another user
                try (PreparedStatement checkEmail = conn.prepareStatement("SELECT id FROM users WHERE email = ? AND id != ?")) {
                    checkEmail.setString(1, email);
                    checkEmail.setInt(2, userId);
                    try (ResultSet rs = checkEmail.executeQuery()) {
                        if (rs.next()) {
                            out.print("{\"success\":false,\"message\":\"Email already taken by another user\"}");
                            return;
                        }
                    }
                }

                // Update user profile
                String updateSQL = "UPDATE users SET first_name = ?, last_name = ?, username = ?, email = ?, " +
                                 "phone = ?, phone2 = ?, national_id = ?, date_of_birth = ?, address = ?, " +
                                 "city = ?, country = ? WHERE id = ?";
                
                try (PreparedStatement updateStmt = conn.prepareStatement(updateSQL)) {
                    updateStmt.setString(1, firstName);
                    updateStmt.setString(2, lastName);
                    updateStmt.setString(3, username);
                    updateStmt.setString(4, email);
                    updateStmt.setString(5, phone);
                    updateStmt.setString(6, phone2);
                    updateStmt.setString(7, nationalId);
                    updateStmt.setString(8, dateOfBirth);
                    updateStmt.setString(9, address);
                    updateStmt.setString(10, city);
                    updateStmt.setString(11, country);
                    updateStmt.setInt(12, userId);
                    
                    int rowsUpdated = updateStmt.executeUpdate();
                    
                    if (rowsUpdated > 0) {
                        session.setAttribute("firstName", firstName);
                        session.setAttribute("lastName", lastName);
                        session.setAttribute("username", username);
                        session.setAttribute("email", email);
                        session.setAttribute("phone", phone);
                        
                        System.out.println("✅ Profile updated successfully for user: " + username);
                        
                        out.print("{\"success\":true,\"message\":\"Profile updated successfully!\",\"user\":{" +
                                "\"firstName\":\"" + firstName + "\"," +
                                "\"lastName\":\"" + lastName + "\"," +
                                "\"username\":\"" + username + "\"," +
                                "\"email\":\"" + email + "\"," +
                                "\"phone\":\"" + phone + "\"" +
                                "}}");
                        
                    } else {
                        out.print("{\"success\":false,\"message\":\"Failed to update profile\"}");
                    }
                }
            }
            
        } catch (Exception e) {
            System.out.println("❌ Update Profile Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"Server error: " + e.getMessage() + "\"}");
        }
    }

}
