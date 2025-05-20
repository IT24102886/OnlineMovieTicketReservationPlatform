package com.quickflicks.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

/**
 * Represents a screen within a theater.
 * Demonstrates composition as a Theater has Screens.
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Screen {
    private String id;
    private String theaterId;  // Reference to the parent theater
    private String name;
    private int capacity;
    private String screenType; // Regular, IMAX, 3D, etc.
    
    // Composition: Screen has Showtimes
    private List<Showtime> showtimes = new ArrayList<>();
    
    public Screen(String id, String theaterId, String name, int capacity, String screenType) {
        this.id = id;
        this.theaterId = theaterId;
        this.name = name;
        this.capacity = capacity;
        this.screenType = screenType;
    }
    
    // Method to add a showtime to this screen
    public void addShowtime(Showtime showtime) {
        showtimes.add(showtime);
    }
    
    // Method to remove a showtime from this screen
    public void removeShowtime(Showtime showtime) {
        showtimes.remove(showtime);
    }
    
    // Convert screen to string format for file storage
    public String toFileString() {
        return String.join("|", id, theaterId, name, String.valueOf(capacity), screenType);
    }
    
    // Create screen from string format from file storage
    public static Screen fromFileString(String fileString) {
        String[] parts = fileString.split("\\|");
        if (parts.length >= 5) {
            return new Screen(
                parts[0], 
                parts[1], 
                parts[2], 
                Integer.parseInt(parts[3]), 
                parts[4]
            );
        }
        return null;
    }
}
