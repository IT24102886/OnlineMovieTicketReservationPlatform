//package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;
//
//import java.io.*;
//import java.util.*;
//import java.util.stream.Collectors;
//
//public class UserManager {
//    private static final String FILE_PATH = System.getProperty("user.home") + "\\Desktop\\OOP\\users.txt";
//    private List<User> users;
//    private Queue<User> adminApprovalQueue = new LinkedList<>();
//
//    public UserManager() {
//        this.users = loadUsers();
//    }
//
//    // Load users from file
//    private List<User> loadUsers() {
//        List<User> loadedUsers = new ArrayList<>();
//        File file = new File(FILE_PATH);
//
//        if (!file.exists()) {
//            return loadedUsers;
//        }
//
//        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
//            String line;
//            while ((line = reader.readLine()) != null) {
//                String[] parts = line.split(" , ");
//                if (parts.length >= 5) {
//                    User user = new User(
//                            parts[0],  // userId
//                            parts[1],  // name
//                            parts[2],  // email
//                            parts[3],  // password
//                            parts[4]   // contactNumber
//                    );
//                    if (parts.length > 5) {
//                        user.setAdmin(Boolean.parseBoolean(parts[5]));
//                    }
//                    loadedUsers.add(user);
//                }
//            }
//        } catch (IOException e) {
//            System.err.println("Error loading users: " + e.getMessage());
//        }
//        return loadedUsers;
//    }
//
//    // Save users to file
//    private void saveUsers() {
//        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
//            for (User user : users) {
//                writer.write(userToString(user));
//                writer.newLine();
//            }
//        } catch (IOException e) {
//            System.err.println("Error saving users: " + e.getMessage());
//        }
//    }
//
//    // Convert User to string for storage
//    private String userToString(User user) {
//        return String.join(" , ",
//                user.getUserId(),
//                user.getName(),
//                user.getEmail(),
//                user.getPassword(),
//                user.getContactNumber(),
//                String.valueOf(user.isAdmin())
//        );
//    }
//
//    // Insertion sort by name
//    public List<User> insertionSortUsersByName() {
//        List<User> sortedUsers = new ArrayList<>(users);
//        int n = sortedUsers.size();
//        for (int i = 1; i < n; i++) {
//            User key = sortedUsers.get(i);
//            int j = i - 1;
//            while (j >= 0 && sortedUsers.get(j).getName().compareToIgnoreCase(key.getName()) > 0) {
//                sortedUsers.set(j + 1, sortedUsers.get(j));
//                j--;
//            }
//            sortedUsers.set(j + 1, key);
//        }
//        return sortedUsers;
//    }
//
//    // Fetch user by email
//    public User getUserByEmail(String email) {
//        return users.stream()
//                .filter(user -> user.getEmail().equalsIgnoreCase(email))
//                .findFirst()
//                .orElse(null);
//    }
//
//    // Required methods for AdminServlet
//    public List<User> getPendingAdminApprovals() {
//        return users.stream()
//                .filter(user -> !user.isAdmin() && adminApprovalQueue.contains(user))
//                .collect(Collectors.toList());
//    }
//
//    public User getUserById(String userId) {
//        return users.stream()
//                .filter(user -> user.getUserId().equals(userId))
//                .findFirst()
//                .orElse(null);
//    }
//
//    // Basic CRUD operations
//    public void addUser(User user) {
//        users.add(user);
//        saveUsers();
//    }
//
//    public List<User> getAllUsers() {
//        return new ArrayList<>(users);
//    }
//
//    public boolean updateUser(User updatedUser) {
//        for (int i = 0; i < users.size(); i++) {
//            if (users.get(i).getUserId().equals(updatedUser.getUserId())) {
//                users.set(i, updatedUser);
//                saveUsers();
//                return true;
//            }
//        }
//        return false;
//    }
//
//    public boolean deleteUser(String userId) {
//        boolean removed = users.removeIf(user -> user.getUserId().equals(userId));
//        if (removed) {
//            saveUsers();
//        }
//        return removed;
//    }
//
//    // Authentication
//    public User authenticate(String email, String password) {
//        return users.stream()
//                .filter(user -> user.getEmail().equals(email) && user.getPassword().equals(password))
//                .findFirst()
//                .orElse(null);
//    }
//
//    public boolean emailExists(String email) {
//        return users.stream()
//                .anyMatch(user -> user.getEmail().equalsIgnoreCase(email));
//    }
//
//    // Admin approval queue
//    public void addToAdminApprovalQueue(User user) {
//        adminApprovalQueue.add(user);
//    }
//
//    public User processAdminApprovalRequest() {
//        return adminApprovalQueue.poll();
//    }
//}

package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import java.io.*;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

public class UserManager {
    private static final String FILE_PATH = System.getProperty("user.home") + "\\Desktop\\OOP\\users.txt";
    private Queue<User> users;

    public UserManager() {
        this.users = new LinkedList<>(loadUsers());
    }

    // Load users from file into a queue
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
                    User user = new User(
                            parts[0],  // userId
                            parts[1],  // name
                            parts[2],  // email
                            parts[3],  // password
                            parts[4],  // contactNumber
                            parts.length > 6 ? LocalDateTime.parse(parts[6]) : LocalDateTime.now() // registeredDateTime
                    );
                    user.setAdmin(Boolean.parseBoolean(parts[5]));
                    loadedUsers.add(user);
                }
            }
        } catch (IOException e) {
            System.err.println("Error loading users: " + e.getMessage());
        }
        return loadedUsers;
    }

    // Save users to file
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

    // Convert User to string for storage
    private String userToString(User user) {
        return String.join(" , ",
                user.getUserId(),
                user.getName(),
                user.getEmail(),
                user.getPassword(),
                user.getContactNumber(),
                String.valueOf(user.isAdmin()),
                user.getRegisteredDateTime().toString()
        );
    }

    // Insertion sort by name
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

    // Insertion sort by registration date
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

    // Search users by name
    public List<User> searchUsersByName(String searchName) {
        if (searchName == null || searchName.trim().isEmpty()) {
            return new ArrayList<>(users);
        }
        return users.stream()
                .filter(user -> user.getName().toLowerCase().contains(searchName.toLowerCase()))
                .collect(Collectors.toList());
    }

    // Fetch user by email
    public User getUserByEmail(String email) {
        return users.stream()
                .filter(user -> user.getEmail().equalsIgnoreCase(email))
                .findFirst()
                .orElse(null);
    }

    // Fetch user by ID
    public User getUserById(String userId) {
        return users.stream()
                .filter(user -> user.getUserId().equals(userId))
                .findFirst()
                .orElse(null);
    }

    // Basic CRUD operations
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

    // Authentication
    public User authenticate(String email, String password) {
        return users.stream()
                .filter(user -> user.getEmail().equals(email) && user.getPassword().equals(password))
                .findFirst()
                .orElse(null);
    }

    public boolean emailExists(String email) {
        return users.stream()
                .anyMatch(user -> user.getEmail().equalsIgnoreCase(email));
    }
}