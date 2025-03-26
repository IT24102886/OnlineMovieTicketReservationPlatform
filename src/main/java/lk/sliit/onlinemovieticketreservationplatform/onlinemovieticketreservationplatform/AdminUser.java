package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import java.time.LocalDate;

public class AdminUser extends User {
    private String adminAccessLevel;

    public AdminUser(String username, String email, String password,
                     String contactNumber, String accessLevel) {
        super(username, email, password, contactNumber, LocalDate.now(), "N/A");
        this.adminAccessLevel = accessLevel;
    }

    // Admin-specific methods
    public void banUser(User user) {
        System.out.println("User " + user.getUsername() + " banned by admin.");
    }
}