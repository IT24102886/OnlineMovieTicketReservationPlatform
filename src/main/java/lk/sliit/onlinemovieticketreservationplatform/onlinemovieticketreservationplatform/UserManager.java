package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.*;
import java.util.stream.Collectors;

public class UserManager {
    private static UserManager instance;
    private Queue<User> users;
    private static final String FILE_PATH = System.getProperty("user.home") + "\\Desktop\\OOP\\users.txt";

    private UserManager() {
        this.users = new LinkedList<>(loadUsers());
        initializeAdminUser();
    }

    public static synchronized UserManager getInstance() {
        if (instance == null) {
            instance = new UserManager();
        }
        return instance;
    }

    private void initializeAdminUser() {
        if (!emailExists("admin@quickflicks.com")) {
            User adminUser = new User(
                    UUID.randomUUID().toString(),
                    "Admin User",
                    "admin@quickflicks.com",
                    "admin123",
                    "1234567890",
                    LocalDateTime.now()
            );
            adminUser.setAdmin(true);
            users.add(adminUser);
            saveUsers();
        }
    }

    private List<User> loadUsers() {
        List<User> loadedUsers = new ArrayList<>();
        File file = new File(FILE_PATH);

        if (!file.exists()) {
            return loadedUsers;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(" , ");
                if (parts.length >= 6) {
                    User user;
                    try {
                        // Try to parse parts[5] as LocalDateTime
                        LocalDateTime registeredDateTime = LocalDateTime.parse(parts[5]);
                        user = new User(
                                parts[0],  // userId
                                parts[1],  // name
                                parts[2],  // email
                                parts[3],  // password
                                parts[4],  // contactNumber
                                registeredDateTime // registeredDateTime
                        );
                        user.setAdmin(parts.length > 6 ? Boolean.parseBoolean(parts[6]) : false);
                    } catch (DateTimeParseException e) {
                        // Handle old format where parts[5] is isAdmin and parts[6] is registeredDateTime
                        if (parts.length >= 7) {
                            user = new User(
                                    parts[0],  // userId
                                    parts[1],  // name
                                    parts[2],  // email
                                    parts[3],  // password
                                    parts[4],  // contactNumber
                                    LocalDateTime.parse(parts[6]) // registeredDateTime
                            );
                            user.setAdmin(Boolean.parseBoolean(parts[5]));
                        } else {
                            System.err.println("Skipping invalid user line: " + line);
                            continue;
                        }
                    }
                    loadedUsers.add(user);
                } else {
                    System.err.println("Skipping malformed user line: " + line);
                }
            }
        } catch (IOException e) {
            System.err.println("Error loading users: " + e.getMessage());
        }
        return loadedUsers;
    }

    private void saveUsers() {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (User user : users) {
                writer.write(userToString(user));
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("Error saving users: " + e.getMessage());
        }
    }

    private String userToString(User user) {
        return String.join(" , ",
                user.getUserId(),
                user.getName(),
                user.getEmail(),
                user.getPassword(),
                user.getContactNumber(),
                user.getRegisteredDateTime().toString(),
                String.valueOf(user.isAdmin())
        );
    }

    public List<User> insertionSortUsersByName() {
        List<User> sortedUsers = new ArrayList<>(users);
        int n = sortedUsers.size();
        for (int i = 1; i < n; i++) {
            User key = sortedUsers.get(i);
            int j = i - 1;
            while (j >= 0 && sortedUsers.get(j).getName().compareToIgnoreCase(key.getName()) > 0) {
                sortedUsers.set(j + 1, sortedUsers.get(j));
                j--;
            }
            sortedUsers.set(j + 1, key);
        }
        return sortedUsers;
    }

    public List<User> insertionSortUsersByRegistrationDate() {
        List<User> sortedUsers = new ArrayList<>(users);
        int n = sortedUsers.size();
        for (int i = 1; i < n; i++) {
            User key = sortedUsers.get(i);
            int j = i - 1;
            while (j >= 0 && sortedUsers.get(j).getRegisteredDateTime().isAfter(key.getRegisteredDateTime())) {
                sortedUsers.set(j + 1, sortedUsers.get(j));
                j--;
            }
            sortedUsers.set(j + 1, key);
        }
        return sortedUsers;
    }

    public List<User> searchUsersByName(String searchName) {
        if (searchName == null || searchName.trim().isEmpty()) {
            return new ArrayList<>(users);
        }
        return users.stream()
                .filter(user -> user.getName().toLowerCase().contains(searchName.toLowerCase()))
                .collect(Collectors.toList());
    }

    public User getUserByEmail(String email) {
        return users.stream()
                .filter(user -> user.getEmail().equalsIgnoreCase(email))
                .findFirst()
                .orElse(null);
    }

    public User getUserById(String userId) {
        return users.stream()
                .filter(user -> user.getUserId().equals(userId))
                .findFirst()
                .orElse(null);
    }

    public void addUser(User user) {
        users.add(user);
        saveUsers();
    }

    public List<User> getAllUsers() {
        return new ArrayList<>(users);
    }

    public boolean updateUser(User updatedUser) {
        Queue<User> tempQueue = new LinkedList<>();
        boolean updated = false;
        while (!users.isEmpty()) {
            User user = users.poll();
            if (user.getUserId().equals(updatedUser.getUserId())) {
                tempQueue.add(updatedUser);
                updated = true;
            } else {
                tempQueue.add(user);
            }
        }
        users = tempQueue;
        if (updated) {
            saveUsers();
        }
        return updated;
    }

    public boolean deleteUser(String userId) {
        boolean removed = users.removeIf(user -> user.getUserId().equals(userId));
        if (removed) {
            saveUsers();
        }
        return removed;
    }

    public User authenticate(String email, String password) {
        return users.stream()
                .filter(user -> user.getEmail().equalsIgnoreCase(email) && user.getPassword().equals(password))
                .findFirst()
                .orElse(null);
    }

    public boolean emailExists(String email) {
        return users.stream()
                .anyMatch(user -> user.getEmail().equalsIgnoreCase(email));
    }
}