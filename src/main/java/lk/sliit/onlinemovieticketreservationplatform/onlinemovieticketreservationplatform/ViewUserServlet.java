package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Logger;

@WebServlet("/ViewUserServlet")
public class ViewUserServlet extends HttpServlet {
    private UserManager userManager = UserManager.getInstance();
    private static final Logger LOGGER = Logger.getLogger(ViewUserServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        // Check if user is admin
        if (currentUser == null || !currentUser.isAdmin()) {
            LOGGER.warning("Unauthorized access attempt to ViewUserServlet");
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        String userId = request.getParameter("userId");
        if (userId == null || userId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "User ID is required");
            return;
        }

        User profileUser = userManager.getUserById(userId);
        if (profileUser == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
            return;
        }

        LOGGER.info("Viewing profile for user: " + profileUser.getEmail());
        request.setAttribute("profileUser", profileUser);
        request.getRequestDispatcher("viewUserProfile.jsp").forward(request, response);
    }
}