package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonSerializer;

@WebServlet("/admin/movies/*")
public class AdminMovieServlet extends HttpServlet {
    private static final String FILE_PATH = "/WEB-INF/movies.txt";
    private static final Gson GSON = new GsonBuilder()
            .registerTypeAdapter(LocalDate.class, (JsonSerializer<LocalDate>) (src, typeOfSrc, context) ->
                    context.serialize(src.toString()))
            .registerTypeAdapter(LocalDate.class, (JsonDeserializer<LocalDate>) (json, typeOfT, context) ->
                    LocalDate.parse(json.getAsString()))
            .create();

    private String getRealPath(HttpServletRequest request) {
        return request.getServletContext().getRealPath(FILE_PATH);
    }

    private List<Movie> readMovies(HttpServletRequest request) throws IOException {
        String realPath = getRealPath(request);
        if (!Files.exists(Paths.get(realPath))) {
            return new ArrayList<>();
        }
        return Files.readAllLines(Paths.get(realPath)).stream()
                .map(Movie::fromString)
                .collect(Collectors.toList());
    }

    private void writeMovies(List<Movie> movies, HttpServletRequest request) throws IOException {
        String realPath = getRealPath(request);
        Files.write(Paths.get(realPath),
                movies.stream()
                        .map(Movie::toString)
                        .collect(Collectors.toList()));
    }

    private int generateId(HttpServletRequest request) throws IOException {
        List<Movie> movies = readMovies(request);
        return movies.stream().mapToInt(Movie::getId).max().orElse(0) + 1;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null ||
                !"admin".equals(((User) session.getAttribute("user")).getRole())) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Admin access required");
            return;
        }

        String pathInfo = request.getPathInfo();
        List<Movie> movies = readMovies(request);

        if (pathInfo != null && pathInfo.equals("/list")) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(GSON.toJson(movies));
        } else {
            request.setAttribute("movies", movies);
            request.getRequestDispatcher("/adminDashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null ||
                !"admin".equals(((User) session.getAttribute("user")).getRole())) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Admin access required");
            return;
        }

        try {
            String contentType = request.getContentType();
            Movie movie;

            if (contentType != null && contentType.contains("application/json")) {
                String body = request.getReader().lines().collect(Collectors.joining());
                movie = GSON.fromJson(body, Movie.class);
                movie.setId(generateId(request));
            } else {
                String genresStr = request.getParameter("genres");
                int[] genres = genresStr != null && !genresStr.isEmpty() ?
                        Arrays.stream(genresStr.split(","))
                                .map(String::trim)
                                .mapToInt(Integer::parseInt)
                                .toArray() :
                        new int[]{0};

                movie = new Movie(
                        generateId(request),
                        validateString(request.getParameter("title"), "Title is required"),
                        validateString(request.getParameter("genre"), "Genre is required"),
                        parseIntParameter(request.getParameter("duration"), "Invalid duration"),
                        validateString(request.getParameter("showtime"), "Showtime is required"),
                        parseLocalDate(request.getParameter("releaseDate"), "Invalid release date"),
                        validateString(request.getParameter("posterPath"), "Poster path is required"),
                        parseDoubleParameter(request.getParameter("voteAverage"), "Invalid vote average"),
                        genres,
                        validateString(request.getParameter("overview"), "Overview is required")
                );
            }

            List<Movie> movies = readMovies(request);
            movies.add(movie);
            writeMovies(movies, request);

            response.setContentType("application/json");
            response.setStatus(HttpServletResponse.SC_CREATED);
            response.getWriter().write(GSON.toJson(movie));
        } catch (IllegalArgumentException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null ||
                !"admin".equals(((User) session.getAttribute("user")).getRole())) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Admin access required");
            return;
        }

        try {
            String contentType = request.getContentType();
            Movie updatedMovie;

            if (contentType != null && contentType.contains("application/json")) {
                String body = request.getReader().lines().collect(Collectors.joining());
                updatedMovie = GSON.fromJson(body, Movie.class);
            } else {
                Map<String, String> params = parseBody(request);
                int id = parseIntParameter(params.get("id"), "Invalid movie ID");
                String genresStr = params.get("genres");
                int[] genres = genresStr != null && !genresStr.isEmpty() ?
                        Arrays.stream(genresStr.split(","))
                                .map(String::trim)
                                .mapToInt(Integer::parseInt)
                                .toArray() :
                        new int[]{0};

                updatedMovie = new Movie(
                        id,
                        validateString(params.get("title"), "Title is required"),
                        validateString(params.get("genre"), "Genre is required"),
                        parseIntParameter(params.get("duration"), "Invalid duration"),
                        validateString(params.get("showtime"), "Showtime is required"),
                        parseLocalDate(params.get("releaseDate"), "Invalid release date"),
                        validateString(params.get("posterPath"), "Poster path is required"),
                        parseDoubleParameter(params.get("voteAverage"), "Invalid vote average"),
                        genres,
                        validateString(params.get("overview"), "Overview is required")
                );
                updatedMovie.setAvailable(Boolean.parseBoolean(params.getOrDefault("available", "true")));
            }

            List<Movie> movies = readMovies(request);
            boolean updated = false;

            for (int i = 0; i < movies.size(); i++) {
                if (movies.get(i).getId() == updatedMovie.getId()) {
                    movies.set(i, updatedMovie);
                    updated = true;
                    break;
                }
            }

            if (updated) {
                writeMovies(movies, request);
                response.setContentType("application/json");
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write(GSON.toJson(updatedMovie));
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Movie not found");
            }
        } catch (IllegalArgumentException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null ||
                !"admin".equals(((User) session.getAttribute("user")).getRole())) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Admin access required");
            return;
        }

        try {
            int id = Integer.parseInt(request.getPathInfo().substring(1));
            List<Movie> movies = readMovies(request);
            boolean removed = movies.removeIf(m -> m.getId() == id);

            if (removed) {
                writeMovies(movies, request);
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Movie not found");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid movie ID");
        }
    }

    private Map<String, String> parseBody(HttpServletRequest request) throws IOException {
        String body = request.getReader().lines().collect(Collectors.joining());
        return Arrays.stream(body.split("&"))
                .map(pair -> {
                    String[] kv = pair.split("=", 2); // Explicitly define as String[]
                    return kv;
                })
                .collect(Collectors.toMap(
                        kv -> kv[0],
                        kv -> kv.length > 1 ? kv[1] : "",
                        (v1, v2) -> v1
                ));
    }

    private String validateString(String value, String errorMessage) {
        if (value == null || value.trim().isEmpty()) {
            throw new IllegalArgumentException(errorMessage);
        }
        return value.trim();
    }

    private int parseIntParameter(String value, String errorMessage) {
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException(errorMessage);
        }
    }

    private double parseDoubleParameter(String value, String errorMessage) {
        try {
            return Double.parseDouble(value);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException(errorMessage);
        }
    }

    private LocalDate parseLocalDate(String value, String errorMessage) {
        try {
            return LocalDate.parse(value);
        } catch (Exception e) {
            throw new IllegalArgumentException(errorMessage);
        }
    }
}