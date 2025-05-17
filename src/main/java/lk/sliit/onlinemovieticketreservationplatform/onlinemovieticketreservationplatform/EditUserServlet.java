package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Logger;

@WebServlet("/EditUserServlet")
public class EditUserServlet extends HttpServlet {
    private UserManager userManager = UserManager.getInstance();
    private static final Logger LOGGER = Logger.getLogger(EditUserServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        // Check if user is admin
        if (currentUser == null || !currentUser.isAdmin()) {
            LOGGER.warning("Unauthorized access attempt to EditUserServlet GET");
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        String userId = request.getParameter("userId");
        if (userId == null || userId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "User ID is required");
            return;
        }

        User user = userManager.getUserById(userId);
        if (user == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
            return;
        }

        LOGGER.info("Displaying edit form for user: " + user.getEmail());
        request.setAttribute("user", user);
        request.getRequestDispatcher("editUser.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        // Check if user is admin
        if (currentUser == null || !currentUser.isAdmin()) {
            LOGGER.warning("Unauthorized access attempt to EditUserServlet POST");
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        String userId = request.getParameter("userId");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String contactNumber = request.getParameter("contactNumber");
        boolean isAdmin = Boolean.parseBoolean(request.getParameter("isAdmin"));

        // Validate inputs
        if (userId == null || name == null || email == null || contactNumber == null ||
                userId.isEmpty() || name.isEmpty() || email.isEmpty() || contactNumber.isEmpty()) {
            request.setAttribute("error", "All fields are required");
            User user = userManager.getUserById(userId);
            request.setAttribute("user", user);
            request.getRequestDispatcher("editUser.jsp").forward(request, response);
            return;
        }

        // Retrieve existing user
        User existingUser = userManager.getUserById(userId);
        if (existingUser == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
            return;
        }

        // Use existing password if new password is empty
        String updatedPassword = (password == null || password.isEmpty())
                ? existingUser.getPassword()
                : password;

        User updatedUser = new User(userId, name, email, updatedPassword, contactNumber, existingUser.getRegisteredDateTime());
        updatedUser.setAdmin(isAdmin);

        userManager.updateUser(updatedUser);
        LOGGER.info("Updated user: " + email);

        response.sendRedirect("UserServlet?action=viewAll");
    }
}