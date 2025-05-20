package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import java.time.LocalDate;

public class Movie {
    private int id;
    private String title;
    private String genre;
    private LocalDate releaseDate;
    private String status;
    private String posterLink;

    public Movie(int id, String title, String genre, LocalDate releaseDate, String status, String posterLink) {
        this.id = id;
        this.title = title;
        this.genre = genre;
        this.releaseDate = releaseDate;
        this.status = status;
        this.posterLink = posterLink;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public LocalDate getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(LocalDate releaseDate) {
        this.releaseDate = releaseDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPosterLink() {
        return posterLink;
    }

    public void setPosterLink(String posterLink) {
        this.posterLink = posterLink;
    }

    // To String for file storage
    @Override
    public String toString() {
        return id + "," + title + "," + genre + "," + releaseDate + "," + status + "," + posterLink;
    }

    // Parse from string
    public static Movie fromString(String line) {
        String[] parts = line.split(",", 6);
        if (parts.length == 6) {
            return new Movie(
                    Integer.parseInt(parts[0]),
                    parts[1],
                    parts[2],
                    LocalDate.parse(parts[3]),
                    parts[4],
                    parts[5]
            );
        }
        return null;
    }
}