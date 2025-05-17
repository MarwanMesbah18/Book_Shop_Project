package Clasess;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get the book name and quantity from request
        String bookName = request.getParameter("bookName");
        int quantity = 1; // Default quantity is 1
        
        // If quantity parameter exists, parse it
        if (request.getParameter("quantity") != null) {
            try {
                quantity = Integer.parseInt(request.getParameter("quantity"));
                if (quantity < 1) quantity = 1;
            } catch (NumberFormatException e) {
                quantity = 1;
            }
        }
        
        // Get the book details from database
        Books book = null;
        List<Books> booksList = DB.getAllBooks();
        for (Books b : booksList) {
            if (b.getName().equals(bookName)) {
                book = b;
                break;
            }
        }
        
        // Get the shopping cart from session
        HttpSession session = request.getSession();
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
        
        if (cart == null) {
            cart = new ShoppingCart();
            session.setAttribute("cart", cart);
        }
        
        // Check stock availability
        if (book != null) {
            // Get current quantity in cart (if any)
            int cartQuantity = 0;
            for (CartItem item : cart.getItems()) {
                if (item.getBook().getName().equals(bookName)) {
                    cartQuantity = item.getQuantity();
                    break;
                }
            }
            
            // Check if adding this quantity would exceed stock
            if (cartQuantity + quantity > book.getQuantity()) {
                // Redirect with error message
                response.sendRedirect("home.jsp?error=stock&bookName=" + 
                    java.net.URLEncoder.encode(bookName, "UTF-8") + 
                    "&available=" + book.getQuantity());
                return;
            }
            
            // If stock is sufficient, add to cart
            cart.addItem(book, quantity);
        }
        
        // Redirect back to previous page or home
        String referer = request.getHeader("Referer");
        if (referer != null && !referer.isEmpty()) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect("home.jsp");
        }
    }
}
