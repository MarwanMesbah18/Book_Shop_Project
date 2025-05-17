package Clasess;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/EditProfileServlet")
public class EditProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Get session and current user
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Store original username for reference
        String originalUsername = currentUser.getUsername();
        
        // Get form parameters
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String userType = request.getParameter("userType");
        
        // Validate inputs
        if (username == null || username.isEmpty() || 
            email == null || email.isEmpty() || 
            password == null || password.isEmpty()) {
            response.sendRedirect("profile.jsp?error=missingFields");
            return;
        }
        
        try {
            // Create updated user object
            User updatedUser = new User(username, email, password, phoneNumber, address, userType);
            
            // Update user in database
            boolean success = DB.updateUser(originalUsername, updatedUser);
            
            if (success) {
                // Update session
                session.setAttribute("user", updatedUser);
                response.sendRedirect("profile.jsp?updated=true");
            } else {
                response.sendRedirect("profile.jsp?error=updateFailed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("profile.jsp?error=true");
        }
    }
}
