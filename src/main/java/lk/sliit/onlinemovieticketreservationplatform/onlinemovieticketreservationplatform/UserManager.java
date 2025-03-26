package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import java.io.*;
import java.time.LocalDate;
import java.util.*;
import java.util.concurrent.locks.ReentrantLock;
import java.util.stream.Collectors;

public class UserManager {
    private static final String FILE_PATH = "users.txt";
    private static final ReentrantLock fileLock = new ReentrantLock();
    private static final String DELIMITER = "|||"; // More reliable than comma

    public void addUser(User user) throws IOException, IllegalArgumentException {
        fileLock.lock();
        try {
            if (getUserByUsername(user.getUsername()) != null) {
                throw new IllegalArgumentException("Username already exists!");
            }

            try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
                writer.write(serializeUser(user));
                writer.newLine();
            }
        } finally {
            fileLock.unlock();
        }
    }

    public User getUserByUsername(String username) throws IOException {
        fileLock.lock();
        try {
            try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    User user = deserializeUser(line);
                    if (user != null && user.getUsername().equals(username)) {
                        return user;
                    }
                }
            }
            return null;
        } finally {
            fileLock.unlock();
        }
    }

    public User getUserById(String userId) throws IOException {
        fileLock.lock();
        try {
            try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    User user = deserializeUser(line);
                    if (user != null && user.getUserId().equals(userId)) {
                        return user;
                    }
                }
            }
            return null;
        } finally {
            fileLock.unlock();
        }
    }

    public void updateUser(User updatedUser) throws IOException {
        fileLock.lock();
        try {
            List<User> users = getAllUsersInternal();
            users = users.stream()
                    .map(u -> u.getUserId().equals(updatedUser.getUserId()) ? updatedUser : u)
                    .collect(Collectors.toList());
            saveAllUsersInternal(users);
        } finally {
            fileLock.unlock();
        }
    }

    public void deleteUser(String userId) throws IOException {
        fileLock.lock();
        try {
            List<User> users = getAllUsersInternal();
            users = users.stream()
                    .filter(u -> !u.getUserId().equals(userId))
                    .collect(Collectors.toList());
            saveAllUsersInternal(users);
        } finally {
            fileLock.unlock();
        }
    }

    public List<User> getAllUsers() throws IOException {
        fileLock.lock();
        try {
            return getAllUsersInternal();
        } finally {
            fileLock.unlock();
        }
    }

    private List<User> getAllUsersInternal() throws IOException {
        List<User> users = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                User user = deserializeUser(line);
                if (user != null) {
                    users.add(user);
                }
            }
        }
        return users;
    }

    private void saveAllUsersInternal(List<User> users) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (User user : users) {
                writer.write(serializeUser(user));
                writer.newLine();
            }
        }
    }

    private String serializeUser(User user) {
        return String.join(DELIMITER,
                user.getUserId(),
                user.getUsername(),
                user.getEmail(),
                user.getPassword(),
                user.getContactNumber(),
                user.getRegistrationDate().toString(),
                user.getPaymentPreferences()
        );
    }

    private User deserializeUser(String line) {
        try {
            String[] data = line.split("\\|\\|\\|");
            if (data.length != 8) return null;

            User user;
            if ("Admin".equals(data[4])) {
                user = new AdminUser(
                        data[1], // username
                        data[2], // email
                        data[3], // password
                        data[5], // contactNumber
                        "Full"    // accessLevel
                );
            } else {
                user = new User(
                        data[1], // username
                        data[2], // email
                        data[3], // password
                        data[5], // contactNumber
                        LocalDate.now(), data[7]  // paymentPreferences
                );
            }

            user.setUserId(data[0]);
            user.setRegistrationDate(LocalDate.parse(data[6]));
            return user;
        } catch (Exception e) {
            System.err.println("Error deserializing user: " + e.getMessage());
            return null;
        }
    }
}