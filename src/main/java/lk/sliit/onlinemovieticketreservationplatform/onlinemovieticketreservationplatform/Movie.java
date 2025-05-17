package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.stream.Collectors;

public class Movie {
    private int id;
    private String title;
    private String genre;
    private int duration;
    private String showtime;
    private boolean available;
    private LocalDate releaseDate;
    private String posterPath;
    private double voteAverage;
    private int[] genres;
    private String overview;

    // Constructor
    public Movie(int id, String title, String genre, int duration, String showtime, LocalDate releaseDate,
                 String posterPath, double voteAverage, int[] genres, String overview) {
        this.id = id;
        this.title = title;
        this.genre = genre;
        this.duration = duration;
        this.showtime = showtime;
        this.releaseDate = releaseDate;
        this.available = true;
        this.posterPath = posterPath;
        this.voteAverage = voteAverage;
        this.genres = genres;
        this.overview = overview;
    }

    // Getters & Setters
    public int getId() { return id; }
    public String getTitle() { return title; }
    public String getGenre() { return genre; }
    public int getDuration() { return duration; }
    public String getShowtime() { return showtime; }
    public boolean isAvailable() { return available; }
    public LocalDate getReleaseDate() { return releaseDate; }
    public String getPosterPath() { return posterPath; }
    public double getVoteAverage() { return voteAverage; }
    public int[] getGenres() { return genres; }
    public String getOverview() { return overview; }

    public void setTitle(String title) { this.title = title; }
    public void setGenre(String genre) { this.genre = genre; }
    public void setDuration(int duration) { this.duration = duration; }
    public void setShowtime(String showtime) { this.showtime = showtime; }
    public void setAvailable(boolean available) { this.available = available; }
    public void setReleaseDate(LocalDate releaseDate) { this.releaseDate = releaseDate; }
    public void setPosterPath(String posterPath) { this.posterPath = posterPath; }
    public void setVoteAverage(double voteAverage) { this.voteAverage = voteAverage; }
    public void setGenres(int[] genres) { this.genres = genres; }
    public void setOverview(String overview) { this.overview = overview; }

    // Insertion sort to sort movies by release date (ascending order)
    public static void sortByReleaseDate(Movie[] movies) {
        if (movies == null || movies.length <= 1) {
            return;
        }

        for (int i = 1; i < movies.length; i++) {
            Movie current = movies[i];
            int j = i - 1;

            while (j >= 0 && movies[j].getReleaseDate().isAfter(current.getReleaseDate())) {
                movies[j + 1] = movies[j];
                j--;
            }
            movies[j + 1] = current;
        }
    }

    // Serialization/Deserialization
    public static Movie fromString(String line) {
        String[] parts = line.split("\\|");
        int id = Integer.parseInt(parts[0]);
        String title = parts[1];
        String genre = parts[2];
        int duration = Integer.parseInt(parts[3]);
        String showtime = parts[4];
        boolean available = Boolean.parseBoolean(parts[5]);
        LocalDate releaseDate = LocalDate.parse(parts[6]);
        String posterPath = parts[7];
        double voteAverage = Double.parseDouble(parts[8]);
        int[] genres = Arrays.stream(parts[9].split(",")).mapToInt(Integer::parseInt).toArray();
        String overview = parts[10];

        Movie movie = new Movie(id, title, genre, duration, showtime, releaseDate, posterPath, voteAverage, genres, overview);
        movie.setAvailable(available);
        return movie;
    }

    public String toString() {
        return String.join("|",
                String.valueOf(id),
                title,
                genre,
                String.valueOf(duration),
                showtime,
                String.valueOf(available),
                releaseDate.toString(),
                posterPath,
                String.valueOf(voteAverage),
                Arrays.stream(genres).mapToObj(String::valueOf).collect(Collectors.joining(",")),
                overview
        );
    }
}