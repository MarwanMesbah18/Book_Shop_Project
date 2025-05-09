package Clasess;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get the book name from request
        String bookName = request.getParameter("bookName");
        
        // Get the session and shopping cart
        HttpSession session = request.getSession();
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
        
        // Create shopping cart if it doesn't exist
        if (cart == null) {
            cart = new ShoppingCart();
            session.setAttribute("cart", cart);
        }
        
        // Find the book in the database
        List<Books> booksList = DB.getAllBooks();
        Books selectedBook = null;
        
        for (Books book : booksList) {
            if (book.getName().equals(bookName)) {
                selectedBook = book;
                break;
            }
        }
        
        // Add to cart if book was found
        if (selectedBook != null && selectedBook.getQuantity() > 0) {
            // Default quantity is 1, could be changed to get from request
            cart.addItem(selectedBook, 1);
            
            // Could update book quantity in database here if needed
        }
        
        // Redirect back to home page
        response.sendRedirect("home.jsp");
    }
}