package Clasess;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddUserServlet")
public class AddUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Get form parameters
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String userType = request.getParameter("userType");
        
        // Create user object
        User user = new User(username, email, password, phoneNumber, address, userType);
        
        // Add user to database
        int result = DB.add_user(user);
        
        if (result > 0) {
            // Success - redirect to admin page
            response.sendRedirect("admin.jsp");
        } else {
            // Failed - return to add user page with error
            request.setAttribute("errorMessage", "User creation failed. Username may already exist.");
            request.getRequestDispatcher("add_user.jsp").forward(request, response);
        }
    }
}
