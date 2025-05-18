package Clasess;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
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
        
        // Check if email already exists
        if (DB.emailExists(email)) {
            request.setAttribute("errorMessage", "Email already in use. Please use a different email.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Generate verification code
        String verificationCode = generateVerificationCode();
        
        // Store user data and verification code in session
        HttpSession session = request.getSession();
        session.setAttribute("verificationCode", verificationCode);
        
        Map<String, String> userData = new HashMap<>();
        userData.put("username", username);
        userData.put("email", email);
        userData.put("password", password);
        userData.put("phoneNumber", phoneNumber);
        userData.put("address", address);
        userData.put("userType", userType);
        session.setAttribute("pendingUser", userData);
        
        try {
            // Send verification email
            String emailBody = "Welcome to BookShop!<br><br>"
                    + "Your verification code is: <b>" + verificationCode + "</b><br><br>"
                    + "Please enter this code on the verification page to complete your registration.<br><br>"
                    + "If you didn't request this code, please ignore this email.";
            
            EmailUtility.sendEmail(email, "BookShop Email Verification", emailBody);
            
            // Redirect to verification page
            response.sendRedirect("verify_email.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to send verification email. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
    
    private String generateVerificationCode() {
        // Generate random 6-digit code
        Random random = new Random();
        int code = 100000 + random.nextInt(900000);
        return String.valueOf(code);
    }
}
