package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
    private UserManager userManager = new UserManager();
    private MovieManager movieManager = new MovieManager();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        // 1. Check if user is logged in and is an admin
        if (currentUser == null || !currentUser.isAdmin()) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        try {
            switch (action) {
                case "addMovie":
                    addMovie(request, response);
                    break;
                case "deleteUser":
                    deleteUser(request, response);
                    break;
                case "promoteUser":
                    promoteUser(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        // 2. Admin check
        if (currentUser == null || !currentUser.isAdmin()) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 3. Set data for admin dashboard
        request.setAttribute("users", userManager.getAllUsers());
        request.setAttribute("movies", movieManager.getAllMovies());
        request.setAttribute("pendingApprovals", userManager.getPendingAdminApprovals());

        request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
    }

    // 4. Helper Methods
    private void addMovie(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        int duration = Integer.parseInt(request.getParameter("duration"));
        String genre = request.getParameter("genre");

        Movie newMovie = new Movie(title, description, duration, genre);
        movieManager.addMovie(newMovie);

        response.sendRedirect("AdminServlet?success=movieAdded");
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String userId = request.getParameter("userId");
        userManager.deleteUser(userId);
        response.sendRedirect("AdminServlet?success=userDeleted");
    }

    private void promoteUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String userId = request.getParameter("userId");
        User user = userManager.getUserById(userId);

        if (user != null) {
            user.setAdmin(true);
            userManager.updateUser(user);
            response.sendRedirect("AdminServlet?success=userPromoted");
        } else {
            response.sendRedirect("AdminServlet?error=userNotFound");
        }
    }
}