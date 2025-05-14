package Clasess;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ConfirmOrderServlet")
public class ConfirmOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
        String paymentMethod = request.getParameter("paymentMethod");
        
        if (user == null || cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect("home.jsp");
            return;
        }
        
        try {
            // Generate receipt email content
            String emailSubject = "Order Confirmation - Book Shop";
            String emailBody = generateReceiptEmail(user, cart, paymentMethod);
            
            // Send email
            EmailUtility.sendEmail(user.getEmail(), emailSubject, emailBody);
            
            // Update book quantities in database
            for (CartItem item : cart.getItems()) {
                Books book = item.getBook();
                int newQuantity = book.getQuantity() - item.getQuantity();
                DB.updateBookQuantity(book.getName(), newQuantity);
            }
            
            // Clear the cart
            session.removeAttribute("cart");
            
            // Set attributes for confirmation page
            session.setAttribute("orderConfirmed", true);
            session.setAttribute("paymentMethod", paymentMethod);
            
            // Redirect to confirmation page
            response.sendRedirect("confirmation.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to process order: " + e.getMessage());
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        }
    }
    
    private String generateReceiptEmail(User user, ShoppingCart cart, String paymentMethod) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy HH:mm:ss");
        String currentDate = dateFormat.format(new Date());
        
        StringBuilder receipt = new StringBuilder();
        receipt.append("<html><body>");
        receipt.append("<h2>Book Shop - Order Confirmation</h2>");
        receipt.append("<p>Dear ").append(user.getUsername()).append(",</p>");
        receipt.append("<p>Thank you for your order. Your purchase has been confirmed.</p>");
        
        receipt.append("<h3>Order Details</h3>");
        receipt.append("<p><strong>Order Date:</strong> ").append(currentDate).append("</p>");
        receipt.append("<p><strong>Payment Method:</strong> ");
        receipt.append("visa".equals(paymentMethod) ? "Credit Card (Visa)" : "Cash on Delivery");
        receipt.append("</p>");
        
        receipt.append("<table border='1' cellpadding='5' cellspacing='0' style='border-collapse: collapse;'>");
        receipt.append("<tr bgcolor='#f2f2f2'>");
        receipt.append("<th>Book</th><th>Author</th><th>Price</th><th>Quantity</th><th>Total</th>");
        receipt.append("</tr>");
        
        for (CartItem item : cart.getItems()) {
            Books book = item.getBook();
            receipt.append("<tr>");
            receipt.append("<td>").append(book.getName()).append("</td>");
            receipt.append("<td>").append(book.getAuthor()).append("</td>");
            receipt.append("<td>$").append(String.format("%.2f", book.getPrice())).append("</td>");
            receipt.append("<td>").append(item.getQuantity()).append("</td>");
            receipt.append("<td>$").append(String.format("%.2f", item.getTotalPrice())).append("</td>");
            receipt.append("</tr>");
        }
        
        receipt.append("<tr bgcolor='#f2f2f2'>");
        receipt.append("<td colspan='4' align='right'><strong>Total:</strong></td>");
        receipt.append("<td><strong>$").append(String.format("%.2f", cart.getTotalPrice())).append("</strong></td>");
        receipt.append("</tr>");
        receipt.append("</table>");
        
        receipt.append("<p><strong>Shipping Address:</strong><br>");
        receipt.append(user.getAddress()).append("</p>");
        
        receipt.append("<p>If you have any questions, please contact our customer service.</p>");
        receipt.append("<p>Thank you for shopping with Book Shop!</p>");
        receipt.append("</body></html>");
        
        return receipt.toString();
    }
}
