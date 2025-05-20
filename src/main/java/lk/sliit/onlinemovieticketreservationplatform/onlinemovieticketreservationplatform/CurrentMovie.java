package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import java.time.LocalDate;

public class CurrentMovie extends Movie {
    public CurrentMovie(int id, String title, String genre, LocalDate releaseDate, String posterLink) {
        super(id, title, genre, releaseDate, posterLink);
    }

    @Override
    public String displayDetails() {
        return "Now Showing (Runtime: 2h 0m)"; // Example runtime; can be dynamic if added to Movie
    }

    @Override
    public String getStatus() {
        return "Current";
    }
}
