package Clasess;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Get form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Verify credentials
        DB db = new DB();
        User user = db.verifyLogin(username, password);
        
        if (user != null) {
            // Successful login - store user in session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            // Redirect to appropriate page based on user type
            if ("admin".equals(user.getUserType())) {
                response.sendRedirect("admin.jsp");
            } else {
                response.sendRedirect("home.jsp");
            }
        } else {
            // Failed login - return to login page with error
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}