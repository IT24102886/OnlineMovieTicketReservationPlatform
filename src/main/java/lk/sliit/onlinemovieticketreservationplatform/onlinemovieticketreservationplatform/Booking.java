package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import java.time.LocalDateTime;
import java.util.UUID;

public class Booking {
    private String bookingId;
    private String userId;
    private String movieTitle;
    private LocalDateTime showTime;
    private String seats;
    private LocalDateTime bookingDate;

    public Booking() {
        this.bookingId = UUID.randomUUID().toString();
        this.bookingDate = LocalDateTime.now();
    }

    public Booking(String bookingId, String userId, String movieTitle, LocalDateTime showTime, String seats, LocalDateTime bookingDate) {
        this.bookingId = (bookingId == null || bookingId.isEmpty()) ? UUID.randomUUID().toString() : bookingId;
        this.userId = userId;
        this.movieTitle = movieTitle;
        this.showTime = showTime;
        this.seats = seats;
        this.bookingDate = (bookingDate == null) ? LocalDateTime.now() : bookingDate;
    }

    // Getters and Setters
    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getMovieTitle() {
        return movieTitle;
    }

    public void setMovieTitle(String movieTitle) {
        this.movieTitle = movieTitle;
    }

    public LocalDateTime getShowTime() {
        return showTime;
    }

    public void setShowTime(LocalDateTime showTime) {
        this.showTime = showTime;
    }

    public String getSeats() {
        return seats;
    }

    public void setSeats(String seats) {
        this.seats = seats;
    }

    public LocalDateTime getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(LocalDateTime bookingDate) {
        this.bookingDate = bookingDate;
    }

    @Override
    public String toString() {
        return String.join(" , ", bookingId, userId, movieTitle, showTime.toString(), seats, bookingDate.toString());
    }
}