package servlets;

import dao.UserDAO;
import models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.regex.Pattern;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
    private UserDAO userDAO;
    private static final Pattern EMAIL_PATTERN = 
            Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            // Get form parameters
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
            String terms = request.getParameter("terms");
            
            // Validate input
            if (email == null || email.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\": false, \"message\": \"Email is required\"}");
                return;
            }
            
            if (!EMAIL_PATTERN.matcher(email.trim()).matches()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\": false, \"message\": \"Please enter a valid email address\"}");
                return;
            }
            
            if (password == null || password.length() < 8) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\": false, \"message\": \"Password must be at least 8 characters long\"}");
                return;
            }
            
            if (!password.equals(confirmPassword)) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\": false, \"message\": \"Passwords do not match\"}");
                return;
            }
            
            if (!"on".equals(terms)) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\": false, \"message\": \"Please accept the Terms of Service\"}");
                return;
            }
            
            // Check if email already exists
            if (userDAO.emailExists(email.trim())) {
                response.setStatus(HttpServletResponse.SC_CONFLICT);
                out.print("{\"success\": false, \"message\": \"Email address is already registered\"}");
                return;
            }
            
            // Create new user
            User newUser = new User(email.trim(), password);
            
            if (userDAO.createUser(newUser)) {
                // Registration successful
                HttpSession session = request.getSession();
                session.setAttribute("user", newUser);
                session.setAttribute("userId", newUser.getId());
                session.setAttribute("userEmail", newUser.getEmail());
                session.setMaxInactiveInterval(30 * 60); // 30 minutes
                
                response.setStatus(HttpServletResponse.SC_CREATED);
                out.print("{\"success\": true, \"message\": \"Account created successfully\", \"redirect\": \"dashboard\"}");
                
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.print("{\"success\": false, \"message\": \"Failed to create account. Please try again.\"}");
            }
            
        } catch (Exception e) {
            System.err.println("❌ Signup error: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\": false, \"message\": \"Server error occurred\"}");
        } finally {
            out.flush();
            out.close();
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect("dashboard");
            return;
        }
        
        // Forward to signup page
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
