package com.quickflicks.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

/**
 * Represents a movie theater with a unique ID, name, and location.
 * Demonstrates encapsulation by hiding internal details and providing getters/setters.
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Theater {
    private String id;
    private String name;
    private String location;
    private String contactNumber;
    private String email;
    
    // Composition: Theater has Screens
    private List<Screen> screens = new ArrayList<>();
    
    public Theater(String id, String name, String location, String contactNumber, String email) {
        this.id = id;
        this.name = name;
        this.location = location;
        this.contactNumber = contactNumber;
        this.email = email;
    }
    
    // Method to add a screen to this theater
    public void addScreen(Screen screen) {
        screens.add(screen);
    }
    
    // Method to remove a screen from this theater
    public void removeScreen(Screen screen) {
        screens.remove(screen);
    }
    
    // Convert theater to string format for file storage
    public String toFileString() {
        return String.join("|", id, name, location, contactNumber, email);
    }
    
    // Create theater from string format from file storage
    public static Theater fromFileString(String fileString) {
        String[] parts = fileString.split("\\|");
        if (parts.length >= 5) {
            return new Theater(parts[0], parts[1], parts[2], parts[3], parts[4]);
        }
        return null;
    }
}
