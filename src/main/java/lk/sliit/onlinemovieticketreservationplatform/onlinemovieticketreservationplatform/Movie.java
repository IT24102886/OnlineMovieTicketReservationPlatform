package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import java.time.LocalDate;

public class Movie {
    private int id;
    private String title;
    private String genre;
    private int duration;
    private String showtime;
    private boolean available;
    private LocalDate releaseDate;

    // Constructor is now public since we're not using subclasses
    public Movie(int id, String title, String genre, int duration, String showtime, LocalDate releaseDate) {
        this.id = id;
        this.title = title;
        this.genre = genre;
        this.duration = duration;
        this.showtime = showtime;
        this.releaseDate = releaseDate;
        this.available = true;
    }

    // Getters & Setters
    public int getId() { return id; }
    public String getTitle() { return title; }
    public String getGenre() { return genre; }
    public int getDuration() { return duration; }
    public String getShowtime() { return showtime; }
    public boolean isAvailable() { return available; }
    public LocalDate getReleaseDate() { return releaseDate; }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public void setShowtime(String showtime) {
        this.showtime = showtime;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }

    public void setReleaseDate(LocalDate releaseDate) {
        this.releaseDate = releaseDate;
    }

    // Insertion sort to sort movies by release date (ascending order)
    public static void sortByReleaseDate(Movie[] movies) {
        if (movies == null || movies.length <= 1) {
            return;
        }

        for (int i = 1; i < movies.length; i++) {
            Movie current = movies[i];
            int j = i - 1;

            // Move elements that are after current's release date to one position ahead
            while (j >= 0 && movies[j].getReleaseDate().isAfter(current.getReleaseDate())) {
                movies[j + 1] = movies[j];
                j--;
            }
            movies[j + 1] = current;
        }
    }

    // Serialization/Deserialization (simplified)
    public static Movie fromString(String line) {
        String[] parts = line.split("\\|");
        int id = Integer.parseInt(parts[0]);
        String title = parts[1];
        String genre = parts[2];
        int duration = Integer.parseInt(parts[3]);
        String showtime = parts[4];
        boolean available = Boolean.parseBoolean(parts[5]);
        LocalDate releaseDate = LocalDate.parse(parts[6]);

        Movie movie = new Movie(id, title, genre, duration, showtime, releaseDate);
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
                releaseDate.toString()
        );
    }
}