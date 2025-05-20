package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "MovieServlet", urlPatterns = {"/MovieServlet"})
public class MovieServlet extends HttpServlet {
    private MovieManager movieManager;

    @Override
    public void init() throws ServletException {
        movieManager = new MovieManager();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String genre = request.getParameter("genre");
        String sort = request.getParameter("sort");

        if ("get".equals(action)) {
            // Handle single movie fetch for edit
            int id = Integer.parseInt(request.getParameter("id"));
            Movie movie = movieManager.getMovies().stream()
                    .filter(m -> m.getId() == id)
                    .findFirst()
                    .orElse(null);
            if (movie != null) {
                response.setContentType("text/plain");
                response.getWriter().write(String.format(
                        "%d,%s,%s,%s,%s,%s",
                        movie.getId(), movie.getTitle(), movie.getGenre(), movie.getReleaseDate(), movie.getStatus(), movie.getPosterLink()
                ));
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            }
            return;
        }

        // Handle sorting
        if (sort != null) {
            movieManager.sortMoviesByReleaseDate("asc".equals(sort));
        }

        // Handle filtering by genre
        List<Movie> movies = genre != null ? movieManager.getMoviesByGenre(genre) : movieManager.getMovies();

        // Separate movies by status
        List<Movie> currentMovies = movies.stream()
                .filter(m -> m instanceof CurrentMovie)
                .collect(Collectors.toList());
        List<Movie> upcomingMovies = movies.stream()
                .filter(m -> m instanceof UpcomingMovie)
                .collect(Collectors.toList());

        // Generate HTML response for movie lists
        response.setContentType("text/html");
        StringBuilder html = new StringBuilder();

        // Now Showing Section
        html.append("<div id='current-movies' class='mb-5'>");
        for (Movie movie : currentMovies) {
            html.append(generateMovieCard(movie));
        }
        html.append("</div>");

        // Coming Soon Section
        html.append("<div id='upcoming-movies'>");
        for (Movie movie : upcomingMovies) {
            html.append(generateMovieCard(movie));
        }
        html.append("</div>");

        response.getWriter().write(html.toString());
    }

    private String generateMovieCard(Movie movie) {
        String cardClass = movie instanceof CurrentMovie ? "current" : "upcoming";
        return "<div class='col-lg-3 col-md-6'>" +
                "<div class='movie-card " + cardClass + "'>" +
                "<img src='" + movie.getPosterLink() + "' class='movie-poster' alt='" + movie.getTitle() + " Poster'>" +
                "<div class='movie-info'>" +
                "<h3 class='movie-title'>" + movie.getTitle() + "</h3>" +
                "<div class='movie-meta'>" +
                "<span>" + movie.displayDetails() + "</span>" +
                "</div>" +
                "<span class='movie-badge'>" + movie.getGenre() + "</span>" +
                "<span class='movie-badge'>" + movie.getStatus() + "</span>" +
                "<div class='mt-3'>" +
                "<button class='btn btn-red btn-sm me-2' onclick='editMovie(" + movie.getId() + ")'><i class='fas fa-edit me-1'></i> Edit</button>" +
                "<button class='btn btn-outline-red btn-sm' onclick='deleteMovie(" + movie.getId() + ")'><i class='fas fa-trash me-1'></i> Delete</button>" +
                "</div>" +
                "</div>" +
                "</div>" +
                "</div>";
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action) || "update".equals(action)) {
            int id = "update".equals(action) ? Integer.parseInt(request.getParameter("id")) : 0;
            String title = request.getParameter("title");
            String genre = request.getParameter("genre");
            LocalDate releaseDate = LocalDate.parse(request.getParameter("release-date"));
            String status = request.getParameter("status");
            String posterLink = request.getParameter("poster-link");

            Movie movie;
            if ("Upcoming".equals(status)) {
                movie = new UpcomingMovie(id, title, genre, releaseDate, posterLink);
            } else {
                movie = new CurrentMovie(id, title, genre, releaseDate, posterLink);
            }

            if ("add".equals(action)) {
                movieManager.addMovie(movie);
            } else {
                movieManager.updateMovie(id, movie);
            }
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            movieManager.deleteMovie(id);
        }

        // Redirect to refresh the movie list
        response.sendRedirect("index.html");
    }
}