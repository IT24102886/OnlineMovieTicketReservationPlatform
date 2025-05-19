package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/UserLoginServlet")
public class UserLoginServlet extends HttpServlet {
    private UserManager userManager = UserManager.getInstance();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");

        User user = userManager.authenticate(email, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            if (user.isAdmin() && "admin".equals(userType)) {
                response.sendRedirect("adminDashboard.jsp");
            } else if (!user.isAdmin() && !"admin".equals(userType)) {
                response.sendRedirect("index.jsp");
            } else {
                request.setAttribute("error", "Invalid user type for credentials");
                request.getRequestDispatcher("admin".equals(userType) ? "adminLogin.jsp" : "login.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("admin".equals(userType) ? "adminLogin.jsp" : "login.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}