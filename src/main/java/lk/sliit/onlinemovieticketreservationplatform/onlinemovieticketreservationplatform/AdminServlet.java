package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
    private UserManager userManager = UserManager.getInstance();
    private MovieManager movieManager;
    private static final Logger LOGGER = Logger.getLogger(AdminServlet.class.getName());

    @Override
    public void init() throws ServletException {
        super.init();
        String contextPath = getServletContext().getRealPath("");
        LOGGER.info("AdminServlet context path: " + contextPath);
        movieManager = new MovieManager();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null || !currentUser.isAdmin()) {
            LOGGER.warning("Unauthorized access attempt to AdminServlet GET");
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        String action = request.getParameter("action");
        LOGGER.info("Processing AdminServlet GET with action: " + action);

        if (action != null && action.equals("viewMovies")) {
            List<Movie> movies = movieManager.getAllMovies();
            LOGGER.info("Fetched " + movies.size() + " movies for viewMovies.jsp");
            request.setAttribute("movies", movies);
            request.getRequestDispatcher("viewMovies.jsp").forward(request, response);
        } else {
            List<User> users = userManager.getAllUsers();
            List<Movie> movies = movieManager.getAllMovies();
            LOGGER.info("Fetched " + users.size() + " users and " + movies.size() + " movies for adminDashboard.jsp");
            request.setAttribute("users", users);
            request.setAttribute("movies", movies);
            request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
        }
    }
}
//
//package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import java.io.IOException;
//import java.util.List;
//import java.util.logging.Logger;
//
//@WebServlet("/AdminServlet")
//public class AdminServlet extends HttpServlet {
//    private UserManager userManager = UserManager.getInstance();
//    private static final Logger LOGGER = Logger.getLogger(AdminServlet.class.getName());
//
//    @Override
//    public void init() throws ServletException {
//        super.init();
//        String contextPath = getServletContext().getRealPath("");
//        LOGGER.info("AdminServlet context path: " + contextPath);
//    }
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        User currentUser = (User) session.getAttribute("user");
//
//        if (currentUser == null || !currentUser.isAdmin()) {
//            LOGGER.warning("Unauthorized access attempt to AdminServlet GET");
//            response.sendRedirect("adminLogin.jsp");
//            return;
//        }
//
//        LOGGER.info("Processing AdminServlet GET");
//        List<User> users = userManager.getAllUsers();
//        LOGGER.info("Fetched " + users.size() + " users for adminDashboard.jsp");
//        request.setAttribute("users", users);
//        request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
//    }
//}
