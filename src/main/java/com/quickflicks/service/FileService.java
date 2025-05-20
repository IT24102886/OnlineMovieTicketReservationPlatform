package com.quickflicks.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Service for handling file operations.
 */
@Service
public class FileService {

    @Value("${app.storage.theaters}")
    private String theatersFilePath;
    
    @Value("${app.storage.screens}")
    private String screensFilePath;
    
    @Value("${app.storage.showtimes}")
    private String showtimesFilePath;
    
    @Value("${app.storage.transactions}")
    private String transactionsFilePath;
    
    @PostConstruct
    public void init() {
        // Create data directory if it doesn't exist
        createDirectoryIfNotExists("data");
        
        // Create files if they don't exist
        createFileIfNotExists(theatersFilePath);
        createFileIfNotExists(screensFilePath);
        createFileIfNotExists(showtimesFilePath);
        createFileIfNotExists(transactionsFilePath);
    }
    
    private void createDirectoryIfNotExists(String directoryPath) {
        Path path = Paths.get(directoryPath);
        if (!Files.exists(path)) {
            try {
                Files.createDirectories(path);
            } catch (IOException e) {
                throw new RuntimeException("Failed to create directory: " + directoryPath, e);
            }
        }
    }
    
    private void createFileIfNotExists(String filePath) {
        Path path = Paths.get(filePath);
        if (!Files.exists(path)) {
            try {
                // Create parent directories if they don't exist
                Files.createDirectories(path.getParent());
                // Create the file
                Files.createFile(path);
            } catch (IOException e) {
                throw new RuntimeException("Failed to create file: " + filePath, e);
            }
        }
    }
    
    // Read all lines from a file
    public List<String> readLines(String filePath) {
        try {
            return Files.readAllLines(Paths.get(filePath));
        } catch (IOException e) {
            throw new RuntimeException("Failed to read from file: " + filePath, e);
        }
    }
    
    // Write lines to a file
    public void writeLines(String filePath, List<String> lines) {
        try {
            Files.write(Paths.get(filePath), lines);
        } catch (IOException e) {
            throw new RuntimeException("Failed to write to file: " + filePath, e);
        }
    }
    
    // Append a line to a file
    public void appendLine(String filePath, String line) {
        try {
            List<String> lines = new ArrayList<>(readLines(filePath));
            lines.add(line);
            writeLines(filePath, lines);
        } catch (Exception e) {
            throw new RuntimeException("Failed to append to file: " + filePath, e);
        }
    }
    
    // Update a line in a file
    public void updateLine(String filePath, String identifier, String newLine) {
        try {
            List<String> lines = readLines(filePath);
            List<String> updatedLines = lines.stream()
                .map(line -> line.startsWith(identifier + "|") ? newLine : line)
                .collect(Collectors.toList());
            writeLines(filePath, updatedLines);
        } catch (Exception e) {
            throw new RuntimeException("Failed to update line in file: " + filePath, e);
        }
    }
    
    // Delete a line from a file
    public void deleteLine(String filePath, String identifier) {
        try {
            List<String> lines = readLines(filePath);
            List<String> updatedLines = lines.stream()
                .filter(line -> !line.startsWith(identifier + "|"))
                .collect(Collectors.toList());
            writeLines(filePath, updatedLines);
        } catch (Exception e) {
            throw new RuntimeException("Failed to delete line from file: " + filePath, e);
        }
    }
    
    // Getter methods for file paths
    public String getTheatersFilePath() {
        return theatersFilePath;
    }
    
    public String getScreensFilePath() {
        return screensFilePath;
    }
    
    public String getShowtimesFilePath() {
        return showtimesFilePath;
    }
    
    public String getTransactionsFilePath() {
        return transactionsFilePath;
    }
}
