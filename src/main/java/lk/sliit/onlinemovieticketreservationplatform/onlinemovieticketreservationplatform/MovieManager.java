package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import java.io.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class MovieManager {
    private static final String FILE_PATH = "C:\\Users\\DELL\\OneDrive\\Desktop\\MovieMng\\demo\\src\\main\\webapp\\WEB-INF\\movies.txt";
    private List<Movie> movies;

    public MovieManager() {
        movies = loadMovies();
    }

    // Load movies from file
    private List<Movie> loadMovies() {
        List<Movie> movieList = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Movie movie = Movie.fromString(line);
                if (movie != null) {
                    movieList.add(movie);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return movieList;
    }

    // Save movies to file
    private void saveMovies() {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Movie movie : movies) {
                writer.write(movie.toString());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Add a movie
    public void addMovie(Movie movie) {
        int newId = movies.isEmpty() ? 1 : movies.get(movies.size() - 1).getId() + 1;
        movie.setId(newId);
        movies.add(movie);
        saveMovies();
    }

    // Update a movie
    public void updateMovie(int id, Movie updatedMovie) {
        for (int i = 0; i < movies.size(); i++) {
            if (movies.get(i).getId() == id) {
                updatedMovie.setId(id);
                movies.set(i, updatedMovie);
                saveMovies();
                break;
            }
        }
    }

    // Delete a movie
    public void deleteMovie(int id) {
        movies.removeIf(movie -> movie.getId() == id);
        saveMovies();
    }

    // Get all movies
    public List<Movie> getMovies() {
        return new ArrayList<>(movies);
    }

    // Get movies by genre
    public List<Movie> getMoviesByGenre(String genre) {
        if (genre.equals("All")) {
            return getMovies();
        }
        List<Movie> filtered = new ArrayList<>();
        for (Movie movie : movies) {
            if (movie.getGenre().equals(genre)) {
                filtered.add(movie);
            }
        }
        return filtered;
    }

    // Sort movies by release date (Insertion Sort)
    public void sortMoviesByReleaseDate(boolean ascending) {
        for (int i = 1; i < movies.size(); i++) {
            Movie key = movies.get(i);
            int j = i - 1;
            while (j >= 0 && (ascending ? movies.get(j).getReleaseDate().isAfter(key.getReleaseDate()) :
                    movies.get(j).getReleaseDate().isBefore(key.getReleaseDate()))) {
                movies.set(j + 1, movies.get(j));
                j--;
            }
            movies.set(j + 1, key);
        }
        saveMovies();
    }
}
