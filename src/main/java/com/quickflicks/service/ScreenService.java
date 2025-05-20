package com.quickflicks.service;

import com.quickflicks.model.Screen;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * Service for managing screens.
 */
@Service
public class ScreenService {

    @Autowired
    private FileService fileService;
    
    // Create a new screen
    public Screen createScreen(Screen screen) {
        if (screen.getId() == null || screen.getId().isEmpty()) {
            screen.setId(UUID.randomUUID().toString());
        }
        
        fileService.appendLine(fileService.getScreensFilePath(), screen.toFileString());
        return screen;
    }
    
    // Get all screens
    public List<Screen> getAllScreens() {
        return fileService.readLines(fileService.getScreensFilePath()).stream()
            .filter(line -> !line.trim().isEmpty())
            .map(Screen::fromFileString)
            .collect(Collectors.toList());
    }
    
    // Get screen by ID
    public Screen getScreenById(String id) {
        return getAllScreens().stream()
            .filter(screen -> screen.getId().equals(id))
            .findFirst()
            .orElse(null);
    }
    
    // Get screens by theater ID
    public List<Screen> getScreensByTheaterId(String theaterId) {
        return getAllScreens().stream()
            .filter(screen -> screen.getTheaterId().equals(theaterId))
            .collect(Collectors.toList());
    }
    
    // Update a screen
    public Screen updateScreen(Screen screen) {
        fileService.updateLine(
            fileService.getScreensFilePath(),
            screen.getId(),
            screen.toFileString()
        );
        return screen;
    }
    
    // Delete a screen
    public boolean deleteScreen(String id) {
        fileService.deleteLine(fileService.getScreensFilePath(), id);
        return true;
    }
    
    // Delete all screens for a theater
    public boolean deleteScreensByTheaterId(String theaterId) {
        List<Screen> screens = getScreensByTheaterId(theaterId);
        screens.forEach(screen -> deleteScreen(screen.getId()));
        return true;
    }
}
