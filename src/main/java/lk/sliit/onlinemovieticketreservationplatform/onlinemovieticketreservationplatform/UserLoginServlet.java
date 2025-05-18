package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/UserLoginServlet")
public class UserLoginServlet extends HttpServlet {
    private Map<String, User> users = new HashMap<>();

    @Override
    public void init() throws ServletException {
        users.put("admin@quickflicks.com", new User("admin@quickflicks.com", "admin123", "admin"));
        users.put("user@quickflicks.com", new User("user@quickflicks.com", "user123", "user"));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");

        // Input validation
        if (email == null || email.trim().isEmpty() || password == null || password.isEmpty() ||
                userType == null || userType.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/adminLogin.jsp?error=All fields are required");
            return;
        }

        User user = users.get(email.trim());
        if (user != null && user.getPassword().equals(password) && user.getRole().equals(userType)) {
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(30 * 60); // 30 minutes timeout

            if ("admin".equals(userType)) {
                response.sendRedirect(request.getContextPath() + "/admin/movies");
            } else {
                response.sendRedirect(request.getContextPath() + "/movies");
            }
        } else {
            response.sendRedirect(request.getContextPath() +
                    "/adminLogin.jsp?error=Invalid email, password, or user type");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle logout or redirect to login page
        String logout = request.getParameter("logout");
        if ("true".equals(logout)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/adminLogin.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/adminLogin.jsp");
        }
    }
}