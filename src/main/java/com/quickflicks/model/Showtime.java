package com.quickflicks.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Represents a movie showtime on a specific screen.
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Showtime {
    private String id;
    private String screenId;  // Reference to the screen
    private String movieTitle;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private double ticketPrice;
    private boolean[][] seatAvailability; // 2D array to track seat availability
    
    private static final DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
    
    public Showtime(String id, String screenId, String movieTitle, 
                   LocalDateTime startTime, LocalDateTime endTime, 
                   double ticketPrice, int rows, int cols) {
        this.id = id;
        this.screenId = screenId;
        this.movieTitle = movieTitle;
        this.startTime = startTime;
        this.endTime = endTime;
        this.ticketPrice = ticketPrice;
        this.seatAvailability = new boolean[rows][cols]; // Initialize all seats as available (false)
        
        // Set all seats to available by default
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                seatAvailability[i][j] = true;
            }
        }
    }
    
    // Method to book a seat
    public boolean bookSeat(int row, int col) {
        if (row >= 0 && row < seatAvailability.length && 
            col >= 0 && col < seatAvailability[0].length && 
            seatAvailability[row][col]) {
            seatAvailability[row][col] = false; // Mark as booked
            return true;
        }
        return false; // Seat is either invalid or already booked
    }
    
    // Method to cancel a booking
    public boolean cancelBooking(int row, int col) {
        if (row >= 0 && row < seatAvailability.length && 
            col >= 0 && col < seatAvailability[0].length && 
            !seatAvailability[row][col]) {
            seatAvailability[row][col] = true; // Mark as available
            return true;
        }
        return false; // Seat is either invalid or already available
    }
    
    // Convert showtime to string format for file storage
    public String toFileString() {
        StringBuilder sb = new StringBuilder();
        sb.append(String.join("|", 
            id, 
            screenId, 
            movieTitle, 
            startTime.format(DATE_TIME_FORMATTER),
            endTime.format(DATE_TIME_FORMATTER),
            String.valueOf(ticketPrice),
            String.valueOf(seatAvailability.length),
            String.valueOf(seatAvailability[0].length)
        ));
        
        // Append seat availability data
        for (int i = 0; i < seatAvailability.length; i++) {
            for (int j = 0; j < seatAvailability[0].length; j++) {
                sb.append("|").append(seatAvailability[i][j] ? "1" : "0");
            }
        }
        
        return sb.toString();
    }
    
    // Create showtime from string format from file storage
    public static Showtime fromFileString(String fileString) {
        String[] parts = fileString.split("\\|");
        if (parts.length >= 8) {
            String id = parts[0];
            String screenId = parts[1];
            String movieTitle = parts[2];
            LocalDateTime startTime = LocalDateTime.parse(parts[3], DATE_TIME_FORMATTER);
            LocalDateTime endTime = LocalDateTime.parse(parts[4], DATE_TIME_FORMATTER);
            double ticketPrice = Double.parseDouble(parts[5]);
            int rows = Integer.parseInt(parts[6]);
            int cols = Integer.parseInt(parts[7]);
            
            Showtime showtime = new Showtime(id, screenId, movieTitle, startTime, endTime, ticketPrice, rows, cols);
            
            // Parse seat availability data
            if (parts.length >= 8 + (rows * cols)) {
                for (int i = 0; i < rows; i++) {
                    for (int j = 0; j < cols; j++) {
                        int index = 8 + (i * cols) + j;
                        showtime.seatAvailability[i][j] = parts[index].equals("1");
                    }
                }
            }
            
            return showtime;
        }
        return null;
    }
}
