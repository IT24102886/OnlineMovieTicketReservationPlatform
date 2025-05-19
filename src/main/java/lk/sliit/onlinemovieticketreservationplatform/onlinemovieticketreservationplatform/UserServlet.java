package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
    private UserManager userManager = UserManager.getInstance();
    private static final Logger LOGGER = Logger.getLogger(UserServlet.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "register":
                    registerUser(request, response);
                    break;
                case "update":
                    updateUser(request, response);
                    break;
                case "login":
                    authenticateUser(request, response);
                    break;
                case "searchByName":
                    searchUsersByName(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } catch (Exception e) {
            LOGGER.severe("Error processing POST request: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request: " + e.getMessage());
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "delete":
                    deleteUser(request, response);
                    break;
                case "viewAll":
                    viewAllUsers(request, response);
                    break;
                case "viewProfile":
                    viewUserProfile(request, response);
                    break;
                case "sortByName":
                    sortUsersByName(request, response);
                    break;
                case "sortByDate":
                    sortUsersByDate(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } else {
            viewAllUsers(request, response);
        }
    }

    private void registerUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String contactNumber = request.getParameter("contactNumber");

        if (name == null || email == null || password == null || contactNumber == null ||
                name.isEmpty() || email.isEmpty() || password.isEmpty() || contactNumber.isEmpty()) {
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (userManager.emailExists(email)) {
            request.setAttribute("error", "Email already exists");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        User newUser = new User(null, name, email, password, contactNumber, null);
        userManager.addUser(newUser);
        LOGGER.info("Registered new user: " + email);

        if (request.getParameter("adminAction") != null) {
            response.sendRedirect("UserServlet?action=viewAll");
        } else {
            response.sendRedirect("login.jsp?registration=success");
        }
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String userId = request.getParameter("userId");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String contactNumber = request.getParameter("contactNumber");
        boolean isAdmin = Boolean.parseBoolean(request.getParameter("isAdmin"));

        // Validate inputs
        if (userId == null || name == null || email == null || contactNumber == null ||
                userId.isEmpty() || name.isEmpty() || email.isEmpty() || contactNumber.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required fields");
            return;
        }

        // Retrieve the existing user
        User existingUser = userManager.getUserById(userId);
        if (existingUser == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
            return;
        }

        // Use existing password if new password is empty or null
        String updatedPassword = (password == null || password.isEmpty())
                ? existingUser.getPassword()
                : password;

        User updatedUser = new User(userId, name, email, updatedPassword, contactNumber, existingUser.getRegisteredDateTime());
        updatedUser.setAdmin(isAdmin);

        userManager.updateUser(updatedUser);
        LOGGER.info("Updated user: " + email + ", Password preserved: " + (password == null || password.isEmpty()));

        response.sendRedirect("userDashboard.jsp");
    }

    private void authenticateUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Email and password are required");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        User user = userManager.authenticate(email, password);

        if (user != null) {
            request.getSession().setAttribute("user", user);
            LOGGER.info("User logged in: " + email);
            if (user.isAdmin()) {
                response.sendRedirect("adminDashboard.jsp");
            } else {
                response.sendRedirect("userDashboard.jsp");
            }
        } else {
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String userId = request.getParameter("userId");
        if (userId != null) {
            userManager.deleteUser(userId);
            LOGGER.info("Deleted user with ID: " + userId);
        }
        response.sendRedirect("UserServlet?action=viewAll");
    }

    private void viewAllUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<User> users = userManager.getAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("viewUsers.jsp").forward(request, response);
    }

    private void viewUserProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userId = request.getParameter("userId");
        User profileUser = userManager.getUserById(userId);

        if (profileUser != null) {
            request.setAttribute("profileUser", profileUser);
            request.getRequestDispatcher("userProfile.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
        }
    }

    private void sortUsersByName(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<User> users = userManager.insertionSortUsersByName();
        request.setAttribute("users", users);
        request.getRequestDispatcher("viewUsers.jsp").forward(request, response);
    }

    private void sortUsersByDate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<User> users = userManager.insertionSortUsersByRegistrationDate();
        request.setAttribute("users", users);
        request.getRequestDispatcher("viewUsers.jsp").forward(request, response);
    }

    private void searchUsersByName(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchName = request.getParameter("searchName");
        List<User> users = userManager.searchUsersByName(searchName);
        request.setAttribute("users", users);
        request.setAttribute("searchName", searchName);
        request.getRequestDispatcher("viewUsers.jsp").forward(request, response);
    }
}
