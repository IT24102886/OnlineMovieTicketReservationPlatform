//package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import java.io.IOException;
//import java.time.LocalDate;
//import java.time.LocalTime;
//import java.util.Arrays;
//import java.util.List;
//import java.util.stream.Collectors;
//
//@WebServlet("/AdminServlet")
//public class AdminServlet extends HttpServlet {
//    private UserManager userManager = new UserManager();
//    private MovieManager movieManager = new MovieManager();
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        HttpSession session = request.getSession();
//        User currentUser = (User) session.getAttribute("user");
//
//        // Check if user is logged in and is an admin
//        if (currentUser == null || !currentUser.isAdmin()) {
//            response.sendRedirect("login.jsp");
//            return;
//        }
//
//        String action = request.getParameter("action");
//
//        try {
//            switch (action) {
//                case "addMovie":
//                    addMovie(request, response);
//                    break;
//                case "deleteUser":
//                    deleteUser(request, response);
//                    break;
//                case "promoteUser":
//                    promoteUser(request, response);
//                    break;
//                case "updateMovie":
//                    updateMovie(request, response);
//                    break;
//                case "deleteMovie":
//                    deleteMovie(request, response);
//                    break;
//                case "addShowTimes":
//                    addShowTimes(request, response);
//                    break;
//                default:
//                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
//            }
//        } catch (Exception e) {
//            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error: " + e.getMessage());
//        }
//    }
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        HttpSession session = request.getSession();
//        User currentUser = (User) session.getAttribute("user");
//
//        // Admin check
//        if (currentUser == null || !currentUser.isAdmin()) {
//            response.sendRedirect("login.jsp");
//            return;
//        }
//
//        // Set data for admin dashboard
//        request.setAttribute("users", userManager.insertionSortUsersByName());
//        request.setAttribute("movies", movieManager.getAllMovies());
//        request.setAttribute("pendingApprovals", userManager.getPendingAdminApprovals());
//
//        request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
//    }
//
//    // Helper Methods
//    private void addMovie(HttpServletRequest request, HttpServletResponse response)
//            throws IOException, ServletException {
//
//        String title = request.getParameter("title");
//        String description = request.getParameter("description");
//        int duration = Integer.parseInt(request.getParameter("duration"));
//        String genre = request.getParameter("genre");
//        LocalDate releaseDate = LocalDate.parse(request.getParameter("releaseDate"));
//        String director = request.getParameter("director");
//        String language = request.getParameter("language");
//        String ageRating = request.getParameter("ageRating");
//        String posterImageUrl = request.getParameter("posterImageUrl");
//        String trailerUrl = request.getParameter("trailerUrl");
//        boolean isNowShowing = Boolean.parseBoolean(request.getParameter("isNowShowing"));
//
//        Movie newMovie = new Movie(title, description, genre, duration, releaseDate, director, language, ageRating);
//        newMovie.setPosterImageUrl(posterImageUrl);
//        newMovie.setTrailerUrl(trailerUrl);
//        newMovie.setNowShowing(isNowShowing);
//
//        movieManager.addMovie(newMovie);
//
//        response.sendRedirect("AdminServlet?success=movieAdded");
//    }
//
//    private void updateMovie(HttpServletRequest request, HttpServletResponse response)
//            throws IOException {
//
//        String movieId = request.getParameter("movieId");
//        String title = request.getParameter("title");
//        String description = request.getParameter("description");
//        int duration = Integer.parseInt(request.getParameter("duration"));
//        String genre = request.getParameter("genre");
//        LocalDate releaseDate = LocalDate.parse(request.getParameter("releaseDate"));
//        String director = request.getParameter("director");
//        String language = request.getParameter("language");
//        String ageRating = request.getParameter("ageRating");
//        String posterImageUrl = request.getParameter("posterImageUrl");
//        String trailerUrl = request.getParameter("trailerUrl");
//        boolean isNowShowing = Boolean.parseBoolean(request.getParameter("isNowShowing"));
//
//        Movie updatedMovie = new Movie(title, description, genre, duration, releaseDate, director, language, ageRating);
//        updatedMovie.setMovieId(movieId);
//        updatedMovie.setPosterImageUrl(posterImageUrl);
//        updatedMovie.setTrailerUrl(trailerUrl);
//        updatedMovie.setNowShowing(isNowShowing);
//
//        movieManager.updateMovie(updatedMovie);
//
//        response.sendRedirect("AdminServlet?success=movieUpdated");
//    }
//
//    private void deleteMovie(HttpServletRequest request, HttpServletResponse response)
//            throws IOException {
//
//        String movieId = request.getParameter("movieId");
//        movieManager.deleteMovie(movieId);
//        response.sendRedirect("AdminServlet?success=movieDeleted");
//    }
//
//    private void addShowTimes(HttpServletRequest request, HttpServletResponse response)
//            throws IOException {
//
//        String movieId = request.getParameter("movieId");
//        String showTimes = request.getParameter("showTimes");
//        List<LocalTime> newShowTimes = Arrays.stream(showTimes.split(","))
//                .map(String::trim)
//                .map(LocalTime::parse)
//                .collect(Collectors.toList());
//
//        movieManager.addShowTimes(movieId, newShowTimes);
//        response.sendRedirect("AdminServlet?success=showTimesAdded");
//    }
//
//    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
//            throws IOException {
//
//        String userId = request.getParameter("userId");
//        userManager.deleteUser(userId);
//        response.sendRedirect("AdminServlet?success=userDeleted");
//    }
//
//    private void promoteUser(HttpServletRequest request, HttpServletResponse response)
//            throws IOException {
//
//        String userId = request.getParameter("userId");
//        User user = userManager.getUserById(userId);
//
//        if (user != null) {
//            user.setAdmin(true);
//            userManager.updateUser(user);
//            response.sendRedirect("AdminServlet?success=userPromoted");
//        } else {
//            response.sendRedirect("AdminServlet?error=userNotFound");
//        }
//    }
//}

//package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import java.io.IOException;
//import java.time.LocalDate;
//import java.time.LocalTime;
//import java.util.Arrays;
//import java.util.List;
//import java.util.stream.Collectors;
//
//@WebServlet("/AdminServlet")
//public class AdminServlet extends HttpServlet {
//    private UserManager userManager = new UserManager();
//    private MovieManager movieManager = new MovieManager();
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        HttpSession session = request.getSession();
//        User currentUser = (User) session.getAttribute("user");
//
//        // Check if user is logged in and is an admin
//        if (currentUser == null || !currentUser.isAdmin()) {
//            response.sendRedirect("adminLogin.jsp");
//            return;
//        }
//
//        String action = request.getParameter("action");
//
//        try {
//            switch (action) {
//                case "addMovie":
//                    addMovie(request, response);
//                    break;
//                case "deleteUser":
//                    deleteUser(request, response);
//                    break;
//                case "promoteUser":
//                    promoteUser(request, response);
//                    break;
//                case "updateMovie":
//                    updateMovie(request, response);
//                    break;
//                case "deleteMovie":
//                    deleteMovie(request, response);
//                    break;
//                case "addShowTimes":
//                    addShowTimes(request, response);
//                    break;
//                default:
//                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
//            }
//        } catch (Exception e) {
//            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error: " + e.getMessage());
//        }
//    }
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        HttpSession session = request.getSession();
//        User currentUser = (User) session.getAttribute("user");
//
//        // Admin check
//        if (currentUser == null || !currentUser.isAdmin()) {
//            response.sendRedirect("login.jsp");
//            return;
//        }
//
//        // Set data for admin dashboard
//        request.setAttribute("users", userManager.getAllUsers());
//        request.setAttribute("movies", movieManager.getAllMovies());
//        request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
//    }
//
//    // Helper Methods
//    private void addMovie(HttpServletRequest request, HttpServletResponse response)
//            throws IOException, ServletException {
//
//        String title = request.getParameter("title");
//        String description = request.getParameter("description");
//        int duration = Integer.parseInt(request.getParameter("duration"));
//        String genre = request.getParameter("genre");
//        LocalDate releaseDate = LocalDate.parse(request.getParameter("releaseDate"));
//        String director = request.getParameter("director");
//        String language = request.getParameter("language");
//        String ageRating = request.getParameter("ageRating");
//        String posterImageUrl = request.getParameter("posterImageUrl");
//        String trailerUrl = request.getParameter("trailerUrl");
//        boolean isNowShowing = Boolean.parseBoolean(request.getParameter("isNowShowing"));
//
//        Movie newMovie = new Movie(title, description, genre, duration, releaseDate, director, language, ageRating);
//        newMovie.setPosterImageUrl(posterImageUrl);
//        newMovie.setTrailerUrl(trailerUrl);
//        newMovie.setNowShowing(isNowShowing);
//
//        movieManager.addMovie(newMovie);
//
//        response.sendRedirect("AdminServlet?success=movieAdded");
//    }
//
//    private void updateMovie(HttpServletRequest request, HttpServletResponse response)
//            throws IOException {
//
//        String movieId = request.getParameter("movieId");
//        String title = request.getParameter("title");
//        String description = request.getParameter("description");
//        int duration = Integer.parseInt(request.getParameter("duration"));
//        String genre = request.getParameter("genre");
//        LocalDate releaseDate = LocalDate.parse(request.getParameter("releaseDate"));
//        String director = request.getParameter("director");
//        String language = request.getParameter("language");
//        String ageRating = request.getParameter("ageRating");
//        String posterImageUrl = request.getParameter("posterImageUrl");
//        String trailerUrl = request.getParameter("trailerUrl");
//        boolean isNowShowing = Boolean.parseBoolean(request.getParameter("isNowShowing"));
//
//        Movie updatedMovie = new Movie(title, description, genre, duration, releaseDate, director, language, ageRating);
//        updatedMovie.setMovieId(movieId);
//        updatedMovie.setPosterImageUrl(posterImageUrl);
//        updatedMovie.setTrailerUrl(trailerUrl);
//        updatedMovie.setNowShowing(isNowShowing);
//
//        movieManager.updateMovie(updatedMovie);
//
//        response.sendRedirect("AdminServlet?success=movieUpdated");
//    }
//
//    private void deleteMovie(HttpServletRequest request, HttpServletResponse response)
//            throws IOException {
//
//        String movieId = request.getParameter("movieId");
//        movieManager.deleteMovie(movieId);
//        response.sendRedirect("AdminServlet?success=movieDeleted");
//    }
//
//    private void addShowTimes(HttpServletRequest request, HttpServletResponse response)
//            throws IOException {
//
//        String movieId = request.getParameter("movieId");
//        String showTimes = request.getParameter("showTimes");
//        List<LocalTime> newShowTimes = Arrays.stream(showTimes.split(","))
//                .map(String::trim)
//                .map(LocalTime::parse)
//                .collect(Collectors.toList());
//
//        movieManager.addShowTimes(movieId, newShowTimes);
//        response.sendRedirect("AdminServlet?success=showTimesAdded");
//    }
//
//    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
//            throws IOException {
//
//        String userId = request.getParameter("userId");
//        userManager.deleteUser(userId);
//        response.sendRedirect("AdminServlet?success=userDeleted");
//    }
//
//    private void promoteUser(HttpServletRequest request, HttpServletResponse response)
//            throws IOException {
//
//        String userId = request.getParameter("userId");
//        User user = userManager.getUserById(userId);
//
//        if (user != null) {
//            user.setAdmin(true);
//            userManager.updateUser(user);
//            response.sendRedirect("AdminServlet?success=userPromoted");
//        } else {
//            response.sendRedirect("AdminServlet?error=userNotFound");
//        }
//    }
//}

package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
    private UserManager userManager = new UserManager();
    private MovieManager movieManager = new MovieManager();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        // Check if user is logged in and is an admin
        if (currentUser == null || !currentUser.isAdmin()) {
            response.sendRedirect("adminLogin.jsp");
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
                case "updateMovie":
                    updateMovie(request, response);
                    break;
                case "deleteMovie":
                    deleteMovie(request, response);
                    break;
                case "addShowTimes":
                    addShowTimes(request, response);
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

        // Admin check
        if (currentUser == null || !currentUser.isAdmin()) {
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        // Set data for admin dashboard
        request.setAttribute("users", userManager.getAllUsers());
        request.setAttribute("movies", movieManager.getAllMovies());
        request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
    }

    // Helper Methods
    private void addMovie(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        int duration = Integer.parseInt(request.getParameter("duration"));
        String genre = request.getParameter("genre");
        LocalDate releaseDate = LocalDate.parse(request.getParameter("releaseDate"));
        String director = request.getParameter("director");
        String language = request.getParameter("language");
        String ageRating = request.getParameter("ageRating");
        String posterImageUrl = request.getParameter("posterImageUrl");
        String trailerUrl = request.getParameter("trailerUrl");
        boolean isNowShowing = Boolean.parseBoolean(request.getParameter("isNowShowing"));

        Movie newMovie = new Movie(title, description, genre, duration, releaseDate, director, language, ageRating);
        newMovie.setPosterImageUrl(posterImageUrl);
        newMovie.setTrailerUrl(trailerUrl);
        newMovie.setNowShowing(isNowShowing);

        movieManager.addMovie(newMovie);

        response.sendRedirect("AdminServlet?success=movieAdded");
    }

    private void updateMovie(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String movieId = request.getParameter("movieId");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        int duration = Integer.parseInt(request.getParameter("duration"));
        String genre = request.getParameter("genre");
        LocalDate releaseDate = LocalDate.parse(request.getParameter("releaseDate"));
        String director = request.getParameter("director");
        String language = request.getParameter("language");
        String ageRating = request.getParameter("ageRating");
        String posterImageUrl = request.getParameter("posterImageUrl");
        String trailerUrl = request.getParameter("trailerUrl");
        boolean isNowShowing = Boolean.parseBoolean(request.getParameter("isNowShowing"));

        Movie updatedMovie = new Movie(title, description, genre, duration, releaseDate, director, language, ageRating);
        updatedMovie.setMovieId(movieId);
        updatedMovie.setPosterImageUrl(posterImageUrl);
        updatedMovie.setTrailerUrl(trailerUrl);
        updatedMovie.setNowShowing(isNowShowing);

        movieManager.updateMovie(updatedMovie);

        response.sendRedirect("AdminServlet?success=movieUpdated");
    }

    private void deleteMovie(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String movieId = request.getParameter("movieId");
        movieManager.deleteMovie(movieId);
        response.sendRedirect("AdminServlet?success=movieDeleted");
    }

    private void addShowTimes(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String movieId = request.getParameter("movieId");
        String showTimes = request.getParameter("showTimes");
        List<LocalTime> newShowTimes = Arrays.stream(showTimes.split(","))
                .map(String::trim)
                .map(LocalTime::parse)
                .collect(Collectors.toList());

        movieManager.addShowTimes(movieId, newShowTimes);
        response.sendRedirect("AdminServlet?success=showTimesAdded");
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
