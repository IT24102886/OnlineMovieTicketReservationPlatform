package com.quickflicks.service;

import com.quickflicks.model.Showtime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * Service for managing showtimes.
 */
@Service
public class ShowtimeService {

    @Autowired
    private FileService fileService;

    // Create a new showtime
    public Showtime createShowtime(Showtime showtime) {
        if (showtime.getId() == null || showtime.getId().isEmpty()) {
            showtime.setId(UUID.randomUUID().toString());
        }

        fileService.appendLine(fileService.getShowtimesFilePath(), showtime.toFileString());
        return showtime;
    }

    // Get all showtimes
    public List<Showtime> getAllShowtimes() {
        return fileService.readLines(fileService.getShowtimesFilePath()).stream()
            .filter(line -> !line.trim().isEmpty())
            .map(Showtime::fromFileString)
            .collect(Collectors.toList());
    }

    // Get showtime by ID
    public Showtime getShowtimeById(String id) {
        return getAllShowtimes().stream()
            .filter(showtime -> showtime.getId().equals(id))
            .findFirst()
            .orElse(null);
    }

    // Get showtimes by screen ID
    public List<Showtime> getShowtimesByScreenId(String screenId) {
        return getAllShowtimes().stream()
            .filter(showtime -> showtime.getScreenId().equals(screenId))
            .collect(Collectors.toList());
    }

    // Update a showtime
    public Showtime updateShowtime(Showtime showtime) {
        fileService.updateLine(
            fileService.getShowtimesFilePath(),
            showtime.getId(),
            showtime.toFileString()
        );
        return showtime;
    }

    // Delete a showtime
    public boolean deleteShowtime(String id) {
        fileService.deleteLine(fileService.getShowtimesFilePath(), id);
        return true;
    }

    // Delete all showtimes for a screen
    public boolean deleteShowtimesByScreenId(String screenId) {
        List<Showtime> showtimes = getShowtimesByScreenId(screenId);
        showtimes.forEach(showtime -> deleteShowtime(showtime.getId()));
        return true;
    }

    // Book seats for a showtime
    public boolean bookSeats(String showtimeId, List<int[]> seats) {
        Showtime showtime = getShowtimeById(showtimeId);
        if (showtime == null) {
            return false;
        }

        boolean allSeatsBooked = true;
        for (int[] seat : seats) {
            int row = seat[0];
            int col = seat[1];
            if (!showtime.bookSeat(row, col)) {
                allSeatsBooked = false;
            }
        }

        if (allSeatsBooked) {
            updateShowtime(showtime);
        }

        return allSeatsBooked;
    }

    // Check if seats are available
    public boolean areSeatsAvailable(String showtimeId, List<int[]> seats) {
        Showtime showtime = getShowtimeById(showtimeId);
        if (showtime == null) {
            return false;
        }

        for (int[] seat : seats) {
            int row = seat[0];
            int col = seat[1];

            // Check if seat is within bounds
            if (row < 0 || row >= showtime.getSeatAvailability().length ||
                col < 0 || col >= showtime.getSeatAvailability()[0].length) {
                return false;
            }

            // Check if seat is available
            if (!showtime.getSeatAvailability()[row][col]) {
                return false; // Seat is already booked
            }
        }

        return true; // All seats are available
    }

    // Cancel booking for seats
    public boolean cancelBooking(String showtimeId, List<int[]> seats) {
        Showtime showtime = getShowtimeById(showtimeId);
        if (showtime == null) {
            return false;
        }

        boolean allSeatsCancelled = true;
        for (int[] seat : seats) {
            int row = seat[0];
            int col = seat[1];
            if (!showtime.cancelBooking(row, col)) {
                allSeatsCancelled = false;
            }
        }

        if (allSeatsCancelled) {
            updateShowtime(showtime);
        }

        return allSeatsCancelled;
    }
}
