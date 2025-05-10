package Clasess;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get parameters
        String bookName = request.getParameter("bookName");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        
        // Get the session and shopping cart
        HttpSession session = request.getSession();
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
        
        if (cart != null && bookName != null && !bookName.isEmpty()) {
            // Update cart item quantity
            cart.updateItemQuantity(bookName, quantity);
        }
        
        // Redirect back to cart page
        response.sendRedirect("cart.jsp");
    }
}
