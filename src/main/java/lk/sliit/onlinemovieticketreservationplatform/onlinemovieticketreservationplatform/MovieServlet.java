package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet("/movies/*")
public class MovieServlet extends HttpServlet {
    private static final String FILE_PATH = "/WEB-INF/classes/movies.txt";

    // Helper: Get real path to data file
    private String getRealPath(HttpServletRequest request) {
        return request.getServletContext().getRealPath(FILE_PATH);
    }

    // GET: List all movies or search
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Movie> movies = readMovies(request);

        // Search functionality
        String searchTerm = request.getParameter("search");
        if (searchTerm != null && !searchTerm.isEmpty()) {
            String searchType = request.getParameter("searchType");
            movies = filterMovies(movies, searchTerm, searchType);
        }

        request.setAttribute("movies", movies);
        request.getRequestDispatcher("/movies.jsp").forward(request, response);
    }

    // POST: Add new movie
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String format = request.getParameter("format");
        Movie movie = format.equalsIgnoreCase("IMAX") ?
                Movie.createIMAXMovie(
                        generateId(request),
                        request.getParameter("title"),
                        request.getParameter("genre"),
                        Integer.parseInt(request.getParameter("duration")),
                        request.getParameter("showtime")
                ) :
                Movie.createRegularMovie(
                        generateId(request),
                        request.getParameter("title"),
                        request.getParameter("genre"),
                        Integer.parseInt(request.getParameter("duration")),
                        request.getParameter("showtime")
                );

        List<Movie> movies = readMovies(request);
        movies.add(movie);
        writeMovies(movies, request);
        response.sendRedirect(request.getContextPath() + "/movies");
    }

    // PUT: Update movie
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Map<String, String> params = parseBody(request);
        List<Movie> movies = readMovies(request);

        int id = Integer.parseInt(params.get("id"));
        for (Movie m : movies) {
            if (m.getId() == id) {
                m.setTitle(params.get("title"));
                m.setGenre(params.get("genre"));
                m.setDuration(Integer.parseInt(params.get("duration")));
                m.setShowtime(params.get("showtime"));
                m.setAvailable(Boolean.parseBoolean(params.get("available")));
                writeMovies(movies, request);
                response.setStatus(HttpServletResponse.SC_OK);
                return;
            }
        }
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Movie not found");
    }

    // DELETE: Remove movie
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getPathInfo().substring(1));
        List<Movie> movies = readMovies(request);
        boolean removed = movies.removeIf(m -> m.getId() == id);

        if (removed) {
            writeMovies(movies, request);
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    // Helper: Filter movies by search term
    private List<Movie> filterMovies(List<Movie> movies, String term, String type) {
        return movies.stream()
                .filter(m -> {
                    switch (type) {
                        case "title": return m.getTitle().toLowerCase().contains(term.toLowerCase());
                        case "genre": return m.getGenre().toLowerCase().contains(term.toLowerCase());
                        case "showtime": return m.getShowtime().contains(term);
                        default: return true;
                    }
                })
                .collect(Collectors.toList());
    }

    // Helper: Read movies from file
    private List<Movie> readMovies(HttpServletRequest request) throws IOException {
        String realPath = getRealPath(request);
        if (!Files.exists(Paths.get(realPath))) return new ArrayList<>();
        return Files.readAllLines(Paths.get(realPath)).stream()
                .map(Movie::fromString)
                .collect(Collectors.toList());
    }

    // Helper: Write movies to file
    private void writeMovies(List<Movie> movies, HttpServletRequest request) throws IOException {
        Files.write(Paths.get(getRealPath(request)),
                movies.stream()
                        .map(Movie::toString)
                        .collect(Collectors.toList()));
    }

    // Helper: Generate new ID
    private int generateId(HttpServletRequest request) throws IOException {
        List<Movie> movies = readMovies(request);
        return movies.stream().mapToInt(Movie::getId).max().orElse(0) + 1;
    }

    // Helper: Parse request body
    private Map<String, String> parseBody(HttpServletRequest request) throws IOException {
        String body = request.getReader().lines().collect(Collectors.joining());
        return Arrays.stream(body.split("&"))
                .map(pair -> pair.split("="))
                .collect(Collectors.toMap(
                        kv -> kv[0],
                        kv -> kv.length > 1 ? kv[1] : ""
                ));
    }
}