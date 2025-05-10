package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private UserManager userManager = new UserManager();

    // Admin credentials (consider moving these to a config file or database)
    private static final String ADMIN_EMAIL = "admin@quickflicks.com";
    private static final String ADMIN_PASSWORD = "admin123";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Check for admin login
        if (ADMIN_EMAIL.equals(email) && ADMIN_PASSWORD.equals(password)) {
            HttpSession session = request.getSession();
            // Create admin user object
            User adminUser = new User();
            adminUser.setEmail(email);
            adminUser.setAdmin(true);
            session.setAttribute("user", adminUser);
            response.sendRedirect("adminDashboard.jsp");
            return;
        }

        // Regular user login
        User authenticatedUser = userManager.authenticate(email, password);

        if (authenticatedUser != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", authenticatedUser);

            // Redirect based on user type
            if (authenticatedUser.isAdmin()) {
                response.sendRedirect("adminDashboard.jsp");
            } else {
                response.sendRedirect("userDashboard.jsp");
            }
        } else {
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle logout functionality
        String action = request.getParameter("action");

        if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect("login.jsp?logout=success");
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}