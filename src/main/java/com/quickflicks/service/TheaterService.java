package com.quickflicks.service;

import com.quickflicks.model.Theater;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * Service for managing theaters.
 */
@Service
public class TheaterService {

    @Autowired
    private FileService fileService;
    
    // Create a new theater
    public Theater createTheater(Theater theater) {
        if (theater.getId() == null || theater.getId().isEmpty()) {
            theater.setId(UUID.randomUUID().toString());
        }
        
        fileService.appendLine(fileService.getTheatersFilePath(), theater.toFileString());
        return theater;
    }
    
    // Get all theaters
    public List<Theater> getAllTheaters() {
        return fileService.readLines(fileService.getTheatersFilePath()).stream()
            .filter(line -> !line.trim().isEmpty())
            .map(Theater::fromFileString)
            .collect(Collectors.toList());
    }
    
    // Get theater by ID
    public Theater getTheaterById(String id) {
        return getAllTheaters().stream()
            .filter(theater -> theater.getId().equals(id))
            .findFirst()
            .orElse(null);
    }
    
    // Update a theater
    public Theater updateTheater(Theater theater) {
        fileService.updateLine(
            fileService.getTheatersFilePath(),
            theater.getId(),
            theater.toFileString()
        );
        return theater;
    }
    
    // Delete a theater
    public boolean deleteTheater(String id) {
        fileService.deleteLine(fileService.getTheatersFilePath(), id);
        return true;
    }
}
