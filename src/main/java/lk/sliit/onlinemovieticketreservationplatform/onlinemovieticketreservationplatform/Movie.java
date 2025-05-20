package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import java.time.LocalDate;

public abstract class Movie {
    private int id;
    private String title;
    private String genre;
    private LocalDate releaseDate;
    private String posterLink;

    public Movie(int id, String title, String genre, LocalDate releaseDate, String posterLink) {
        this.id = id;
        this.title = title;
        this.genre = genre;
        this.releaseDate = releaseDate;
        this.posterLink = posterLink;
    }

    // Abstract method for polymorphic behavior
    public abstract String displayDetails();

    // Abstract method to get status
    public abstract String getStatus();

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

    public String getPosterLink() {
        return posterLink;
    }

    public void setPosterLink(String posterLink) {
        this.posterLink = posterLink;
    }

    // To String for file storage
    @Override
    public String toString() {
        return id + "," + title + "," + genre + "," + releaseDate + "," + getStatus() + "," + posterLink;
    }
}