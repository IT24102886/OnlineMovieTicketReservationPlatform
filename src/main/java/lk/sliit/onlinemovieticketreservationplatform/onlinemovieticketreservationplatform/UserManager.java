package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

public class UserManager {
    public boolean isAdmin(String role) {
        return "admin".equalsIgnoreCase(role);
    }

    public String getUserRole(String username) {
        // Placeholder: In a real app, this might query a database
        return "user"; // Default role; adjust based on your logic
    }
}