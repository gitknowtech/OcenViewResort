package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import utils.PasswordUtils;

@WebServlet("/changePassword")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Check if user is logged in
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("userId") == null) {
                System.out.println("❌ User not logged in");
                out.print("{\"success\":false,\"message\":\"Not logged in\"}");
                return;
            }

            int userId = (Integer) session.getAttribute("userId");
            String newPassword = request.getParameter("newPassword");

            System.out.println("🔐 Changing password for user ID: " + userId);
            System.out.println("📝 New password received: " + (newPassword != null ? "Yes" : "No"));

            // Validation
            if (newPassword == null || newPassword.trim().isEmpty()) {
                System.out.println("❌ Password is empty");
                out.print("{\"success\":false,\"message\":\"Password is required\"}");
                return;
            }

            newPassword = newPassword.trim();

            // Validate password strength
            if (newPassword.length() < 8) {
                System.out.println("❌ Password too short");
                out.print("{\"success\":false,\"message\":\"Password must be at least 8 characters\"}");
                return;
            }

            if (!newPassword.matches(".*[A-Z].*")) {
                System.out.println("❌ No uppercase");
                out.print("{\"success\":false,\"message\":\"Password must contain uppercase letter\"}");
                return;
            }

            if (!newPassword.matches(".*[a-z].*")) {
                System.out.println("❌ No lowercase");
                out.print("{\"success\":false,\"message\":\"Password must contain lowercase letter\"}");
                return;
            }

            if (!newPassword.matches(".*[0-9].*")) {
                System.out.println("❌ No number");
                out.print("{\"success\":false,\"message\":\"Password must contain number\"}");
                return;
            }

            if (!newPassword.matches(".*[!@#$%^&*].*")) {
                System.out.println("❌ No special character");
                out.print("{\"success\":false,\"message\":\"Password must contain special character\"}");
                return;
            }

            // ✅ USE PasswordUtils - HEXADECIMAL ENCODING
            String hashedPassword = PasswordUtils.hashPassword(newPassword);
            System.out.println("✅ Password hashed using PasswordUtils");
            System.out.println("🔐 Hashed password: " + hashedPassword);

            // Database connection
            String url = "jdbc:mysql://localhost:3306/oceanview?useSSL=false&serverTimezone=UTC";
            String dbUser = "root";
            String dbPassword = "";

            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("✅ Database driver loaded");

            try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword)) {
                System.out.println("✅ Database connected");

                // Update password in database
                String updateSQL = "UPDATE users SET password = ? WHERE id = ?";

                try (PreparedStatement updateStmt = conn.prepareStatement(updateSQL)) {
                    updateStmt.setString(1, hashedPassword);
                    updateStmt.setInt(2, userId);

                    int rowsUpdated = updateStmt.executeUpdate();

                    if (rowsUpdated > 0) {
                        System.out.println("✅ Password changed successfully for user ID: " + userId);
                        System.out.println("✅ Database updated with new hashed password");

                        out.print("{\"success\":true,\"message\":\"Password changed successfully!\"}");

                    } else {
                        System.out.println("❌ No rows updated - User ID not found: " + userId);
                        out.print("{\"success\":false,\"message\":\"Failed to update password\"}");
                    }
                }
            }

        } catch (Exception e) {
            System.out.println("❌ Change Password Error: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"Server error occurred\"}");
        }
    }
}
