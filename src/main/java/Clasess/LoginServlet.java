package Clasess;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String redirectTo = request.getParameter("redirectTo");

        // Verify credentials and retrieve user
        DB db = new DB();
        User user = db.getUserByCredentials(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Redirect to the specified page or default to home.jsp
            if (redirectTo != null && !redirectTo.isEmpty()) {
                response.sendRedirect(redirectTo);
            } else if ("admin".equals(user.getUserType())) {
                response.sendRedirect("admin.jsp");
            } else {
                response.sendRedirect("home.jsp");
            }
        } else {
            // Failed login - return to login page with error
            request.setAttribute("errorMessage", "Invalid username or password");
            request.setAttribute("redirectTo", redirectTo);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
