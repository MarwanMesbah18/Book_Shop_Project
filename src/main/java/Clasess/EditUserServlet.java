package Clasess;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@WebServlet("/EditUserServlet")
public class EditUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Get username from request
        String username = request.getParameter("username");
        
        // Get user details from database
        List<User> usersList = DB.getAllUsers();
        User selectedUser = null;
        
        for (User u : usersList) {
            if (u.getUsername().equals(username)) {
                selectedUser = u;
                break;
            }
        }
        
        if (selectedUser != null) {
            // Store user in request attribute
            request.setAttribute("editUser", selectedUser);
            
            // Forward to edit_user.jsp
            request.getRequestDispatcher("edit_user.jsp").forward(request, response);
        } else {
            // User not found, redirect back to admin page
            response.sendRedirect("admin.jsp");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Get form parameters
        String originalUsername = request.getParameter("originalUsername");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String userType = request.getParameter("userType");
        
        // Delete old user record
        deleteUser(originalUsername);
        
        // Add updated user
        User updatedUser = new User(username, email, password, phoneNumber, address, userType);
        DB.add_user(updatedUser);
        
        // Update session if current user is being edited
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        if (currentUser != null && originalUsername.equals(currentUser.getUsername())) {
            session.setAttribute("user", updatedUser);
        }
        
        // Redirect back to admin page
        response.sendRedirect("admin.jsp");
    }
    
    private void deleteUser(String username) {
        try {
            Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
            java.sql.Connection con = java.sql.DriverManager.getConnection(
                "jdbc:derby:" + System.getProperty("catalina.base", System.getProperty("user.home")) + 
                "/bookshop_db" + ";create=true");
            
            java.sql.PreparedStatement pst = con.prepareStatement("DELETE FROM USERS WHERE username=?");
            pst.setString(1, username);
            pst.executeUpdate();
            
            pst.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
