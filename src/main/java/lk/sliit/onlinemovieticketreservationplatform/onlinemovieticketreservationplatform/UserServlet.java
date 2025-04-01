package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "UserServlet", urlPatterns = {"/users"})
public class UserServlet extends HttpServlet {
    private final UserManager userManager = new UserManager();
    private String filePath;

    @Override
    public void init() throws ServletException {
        filePath = getServletContext().getInitParameter("dataFilePath");
        File file = new File(filePath);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        try {
            switch (action) {
                case "register":
                    handleRegistration(request, response, session);
                    break;
                case "update":
                    handleUpdate(request, response, session);
                    break;
                case "delete":
                    handleDeletion(request, response, session);
                    break;
                case "login":
                    handleLogin(request, response, session);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } catch (IllegalArgumentException e) {
            session.setAttribute("errorMessage", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        } catch (Exception e) {
            session.setAttribute("errorMessage", "An unexpected error occurred");
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String searchTerm = request.getParameter("search");
            List<User> users = searchTerm != null && !searchTerm.isEmpty() ?
                    searchUsers(searchTerm) : userManager.getAllUsers();

            request.setAttribute("users", users);
            request.getRequestDispatcher("/WEB-INF/views/userDashboard.jsp").forward(request, response);
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Failed to retrieve users");
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }

    private void handleRegistration(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException {
        // Validate input
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (username == null || username.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            throw new IllegalArgumentException("All fields are required");
        }

        // Create new user - now matches the User class constructor
        User newUser = new User(
                username,
                email,
                password, // Should be hashed in production!
                request.getParameter("contactNumber"),
                LocalDate.now(),
                request.getParameter("paymentPreferences")
        );

        userManager.addUser(newUser);
        session.setAttribute("successMessage", "Registration successful!");
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
    private void handleUpdate(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException {
        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            throw new IllegalArgumentException("User not authenticated");
        }

        User existingUser = userManager.getUserById(userId);
        if (existingUser == null) {
            throw new IllegalArgumentException("User not found");
        }

        // Update user details
        existingUser.setEmail(validateEmail(request.getParameter("email")));
        existingUser.setContactNumber(request.getParameter("contactNumber"));
        existingUser.setPaymentPreferences(request.getParameter("paymentPreferences"));

        // Only update password if provided
        String newPassword = request.getParameter("password");
        if (newPassword != null && !newPassword.trim().isEmpty()) {
            existingUser.setPassword(newPassword); // Should be hashed!
        }

        userManager.updateUser(existingUser);
        session.setAttribute("successMessage", "Profile updated successfully");
        response.sendRedirect(request.getContextPath() + "/userProfile.jsp");
    }

    private void handleDeletion(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException {
        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            throw new IllegalArgumentException("User not authenticated");
        }

        userManager.deleteUser(userId);
        session.invalidate();
        session = request.getSession(true);
        session.setAttribute("successMessage", "Account deleted successfully");
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = userManager.getUserByUsername(username);
        if (user == null || !user.getPassword().equals(password)) { // Should compare hashes!
            session.setAttribute("errorMessage", "Invalid username or password");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        session.setAttribute("userId", user.getUserId());
        session.setAttribute("successMessage", "Login successful");
        response.sendRedirect(request.getContextPath() + "/userDashboard.jsp");
    }

    private List<User> searchUsers(String searchTerm) throws IOException {
        List<User> users = new ArrayList<>();
        User user = userManager.getUserById(searchTerm);
        if (user != null) {
            users.add(user);
        } else {
            user = userManager.getUserByUsername(searchTerm);
            if (user != null) {
                users.add(user);
            }
        }
        return users;
    }

    private String validateEmail(String email) {
        if (email == null || !email.matches("^[\\w-.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            throw new IllegalArgumentException("Invalid email format");
        }
        return email;
    }
}