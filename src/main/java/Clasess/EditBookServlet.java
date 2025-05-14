package Clasess;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EditBookServlet")
public class EditBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Get book name from request
        String bookName = request.getParameter("bookName");
        
        // Get book details from database
        List<Books> booksList = DB.getAllBooks();
        Books selectedBook = null;
        
        for (Books book : booksList) {
            if (book.getName().equals(bookName)) {
                selectedBook = book;
                break;
            }
        }
        
        if (selectedBook != null) {
            // Store book in request attribute
            request.setAttribute("book", selectedBook);
            
            // Forward to edit_book.jsp
            request.getRequestDispatcher("edit_book.jsp").forward(request, response);
        } else {
            // Book not found, redirect back to admin page
            response.sendRedirect("admin.jsp");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Get form parameters
        String originalName = request.getParameter("originalName");
        String name = request.getParameter("name");
        String author = request.getParameter("author");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String genre = request.getParameter("genre");
        
        // Update book in database (need to add a method to DB class)
        // First, delete the old book
        deleteBook(originalName);
        
        // Then add the updated book
        Books updatedBook = new Books(name, price, author, quantity, genre);
        DB.add_book(updatedBook);
        
        // Redirect back to admin page
        response.sendRedirect("admin.jsp");
    }
    
    private void deleteBook(String bookName) {
        try {
            // Use the same connection logic as in DB class
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
    }
}
