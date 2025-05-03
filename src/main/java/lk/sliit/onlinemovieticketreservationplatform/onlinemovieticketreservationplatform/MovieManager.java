package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import java.io.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.*;
import java.util.stream.Collectors;

public class MovieManager {
    private static final String MOVIES_FILE_PATH = System.getProperty("user.home") + "/OOP/movies.txt";
    private List<Movie> movies;

    public MovieManager() {
        this.movies = loadMovies();
    }

    public void addMovie(Movie movie) {
        if (movie.getMovieId() == null) {
            movie.setMovieId(UUID.randomUUID().toString());
        }
        movies.add(movie);
        saveMovies();
    }

    public List<Movie> getAllMovies() {
        return new ArrayList<>(movies);
    }

    public List<Movie> getNowShowingMovies() {
        return movies.stream()
                .filter(Movie::isNowShowing)
                .collect(Collectors.toList());
    }

    public List<Movie> getMoviesByGenre(String genre) {
        return movies.stream()
                .filter(m -> m.getGenre().equalsIgnoreCase(genre))
                .collect(Collectors.toList());
    }

    public Movie getMovieById(String movieId) {
        return movies.stream()
                .filter(m -> m.getMovieId().equals(movieId))
                .findFirst()
                .orElse(null);
    }

    public boolean updateMovie(Movie updatedMovie) {
        for (int i = 0; i < movies.size(); i++) {
            if (movies.get(i).getMovieId().equals(updatedMovie.getMovieId())) {
                movies.set(i, updatedMovie);
                saveMovies();
                return true;
            }
        }
        return false;
    }

    public boolean deleteMovie(String movieId) {
        boolean removed = movies.removeIf(m -> m.getMovieId().equals(movieId));
        if (removed) {
            saveMovies();
        }
        return removed;
    }

    public boolean addShowTimes(String movieId, List<LocalTime> newShowTimes) {
        Movie movie = getMovieById(movieId);
        if (movie != null) {
            List<LocalTime> existingShowTimes = movie.getShowTimes();
            if (existingShowTimes == null) {
                existingShowTimes = new ArrayList<>();
            }
            existingShowTimes.addAll(newShowTimes);
            movie.setShowTimes(existingShowTimes);
            saveMovies();
            return true;
        }
        return false;
    }

    public List<Movie> searchMoviesByTitle(String searchTerm) {
        return movies.stream()
                .filter(m -> m.getTitle().toLowerCase().contains(searchTerm.toLowerCase()))
                .collect(Collectors.toList());
    }

    public List<Movie> getUpcomingMovies() {
        LocalDate today = LocalDate.now();
        return movies.stream()
                .filter(m -> m.getReleaseDate().isAfter(today))
                .collect(Collectors.toList());
    }

    private List<Movie> loadMovies() {
        List<Movie> loadedMovies = new ArrayList<>();
        File file = new File(MOVIES_FILE_PATH);

        if (!file.exists()) {
            return loadedMovies;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(MOVIES_FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                try {
                    Movie movie = parseMovie(line);
                    if (movie != null) {
                        loadedMovies.add(movie);
                    }
                } catch (Exception e) {
                    System.err.println("Error parsing movie: " + e.getMessage());
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading movies file: " + e.getMessage());
        }

        return loadedMovies;
    }

    private void saveMovies() {
        File file = new File(MOVIES_FILE_PATH);
        file.getParentFile().mkdirs();

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(MOVIES_FILE_PATH))) {
            for (Movie movie : movies) {
                writer.write(serializeMovie(movie));
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("Error saving movies: " + e.getMessage());
        }
    }

    private Movie parseMovie(String data) {
        String[] parts = data.split("\\|");
        if (parts.length < 11) return null;

        try {
            Movie movie = new Movie(
                    parts[1],  // title
                    parts[2],  // description
                    parts[3],  // genre
                    Integer.parseInt(parts[4]),  // duration
                    LocalDate.parse(parts[5]),  // release date
                    parts[6],  // director
                    parts[7],  // language
                    parts[8]   // age rating
            );

            movie.setMovieId(parts[0]);
            movie.setPosterImageUrl(parts[9]);
            movie.setTrailerUrl(parts[10]);
            movie.setNowShowing(Boolean.parseBoolean(parts[11]));

            if (parts.length > 12 && !parts[12].isEmpty()) {
                List<LocalTime> showTimes = Arrays.stream(parts[12].split(","))
                        .map(LocalTime::parse)
                        .collect(Collectors.toList());
                movie.setShowTimes(showTimes);
            }

            if (parts.length > 13 && !parts[13].isEmpty()) {
                movie.setCast(Arrays.asList(parts[13].split(",")));
            }

            return movie;
        } catch (Exception e) {
            System.err.println("Error parsing movie data: " + e.getMessage());
            return null;
        }
    }

    private String serializeMovie(Movie movie) {
        String showTimes = movie.getShowTimes() != null ?
                movie.getShowTimes().stream()
                        .map(LocalTime::toString)
                        .collect(Collectors.joining(",")) : "";

        String cast = movie.getCast() != null ?
                String.join(",", movie.getCast()) : "";

        return String.join("|",
                movie.getMovieId(),
                movie.getTitle(),
                movie.getDescription(),
                movie.getGenre(),
                String.valueOf(movie.getDurationMinutes()),
                movie.getReleaseDate().toString(),
                movie.getDirector(),
                movie.getLanguage(),
                movie.getAgeRating(),
                movie.getPosterImageUrl() != null ? movie.getPosterImageUrl() : "",
                movie.getTrailerUrl() != null ? movie.getTrailerUrl() : "",
                String.valueOf(movie.isNowShowing()),
                showTimes,
                cast
        );
    }
}