package Clasess;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteBookServlet")
public class DeleteBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Get book name from request
        String bookName = request.getParameter("bookName");
        
        // Delete book from database
        try {
            // Use the same connection logic as in DB class
            Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
            java.sql.Connection con = java.sql.DriverManager.getConnection(
                "jdbc:derby:" + System.getProperty("catalina.base", System.getProperty("user.home")) + 
                "/bookshop_db" + ";create=true");
            
            java.sql.PreparedStatement pst = con.prepareStatement("DELETE FROM BOOKS WHERE name=?");
            pst.setString(1, bookName);
            pst.executeUpdate();
            
            pst.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        // Redirect back to admin page
        response.sendRedirect("admin.jsp");
    }
}
