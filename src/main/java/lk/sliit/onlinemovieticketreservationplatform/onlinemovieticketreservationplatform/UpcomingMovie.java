package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import java.time.LocalDate;

public class UpcomingMovie extends Movie {
    public UpcomingMovie(int id, String title, String genre, LocalDate releaseDate, String posterLink) {
        super(id, title, genre, releaseDate, posterLink);
    }

    @Override
    public String displayDetails() {
        return "Coming Soon on " + getReleaseDate();
    }

    @Override
    public String getStatus() {
        return "Upcoming";
    }
}