package Clasess;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Get username from request
        String username = request.getParameter("username");
        
        // Don't allow deleting the current user
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        if (currentUser != null && username.equals(currentUser.getUsername())) {
            response.sendRedirect("admin.jsp");
            return;
        }
        
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
        
        response.sendRedirect("admin.jsp");
    }
}
