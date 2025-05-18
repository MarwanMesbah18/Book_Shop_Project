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

@WebServlet("/VerificationCodeServlet")
public class VerificationCodeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Get the submitted verification code
        String submittedCode = request.getParameter("verificationCode");
        String storedCode = (String) session.getAttribute("verificationCode");
        Map<String, String> userData = (Map<String, String>) session.getAttribute("pendingUser");
        
        if (userData == null || storedCode == null) {
            // Something is wrong, redirect back to registration
            response.sendRedirect("register.jsp");
            return;
        }
        
        // Compare the codes
        if (storedCode.equals(submittedCode)) {
            // Codes match, create the user
            User user = new User(
                userData.get("username"),
                userData.get("email"),
                userData.get("password"),
                userData.get("phoneNumber"),
                userData.get("address"),
                userData.get("userType")
            );
            
            // Add user to database
            int result = DB.add_user(user);
            
            if (result > 0) {
                // Clear verification data
                session.removeAttribute("verificationCode");
                session.removeAttribute("pendingUser");
                
                // Success - redirect to login page
                response.sendRedirect("login.jsp?verified=true");
            } else {
                // Failed - return to register page with error
                request.setAttribute("errorMessage", "Registration failed. Username may already exist.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } else {
            // Codes don't match
            request.setAttribute("errorMessage", "Verification code does not match. Please try again.");
            request.getRequestDispatcher("verify_email.jsp").forward(request, response);
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // For resending the verification code
        HttpSession session = request.getSession();
        Map<String, String> userData = (Map<String, String>) session.getAttribute("pendingUser");
        
        if (userData != null) {
            // Generate new verification code
            String verificationCode = generateVerificationCode();
            session.setAttribute("verificationCode", verificationCode);
            
            try {
                // Send verification email
                String emailBody = "Your verification code for BookShop registration is: <b>" + verificationCode + "</b><br><br>"
                        + "Please enter this code on the verification page to complete your registration.";
                
                EmailUtility.sendEmail(userData.get("email"), "BookShop Email Verification", emailBody);
                
                // Forward back to verification page with success message
                request.setAttribute("resendSuccess", true);
                request.getRequestDispatcher("verify_email.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Failed to send verification email. Please try again.");
                request.getRequestDispatcher("verify_email.jsp").forward(request, response);
            }
        } else {
            // No pending user, redirect to registration
            response.sendRedirect("register.jsp");
        }
    }
    
    private String generateVerificationCode() {
        // Generate random 6-digit code
        Random random = new Random();
        int code = 100000 + random.nextInt(900000);
        return String.valueOf(code);
    }
}
