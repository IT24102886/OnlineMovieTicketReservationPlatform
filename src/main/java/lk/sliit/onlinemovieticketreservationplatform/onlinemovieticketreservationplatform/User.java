package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import java.time.LocalDateTime;
import java.util.UUID;

public class User {

    private String userID;
    private String name;
    private String email;
    private String password;
    private String contactNumber;
    private boolean isAdmin = false;
    private LocalDateTime registeredDateTime;

    public User() {
        this.userID = UUID.randomUUID().toString();
        this.isAdmin = false;
        this.registeredDateTime = LocalDateTime.now();
    }

    public User(String userID, String name, String email, String password, String contactNumber, LocalDateTime registeredDateTime) {
        this.userID = (userID == null || userID.isEmpty()) ? UUID.randomUUID().toString() : userID;
        this.name = name;
        this.email = email;
        this.password = password;
        this.contactNumber = contactNumber;
        this.registeredDateTime = (registeredDateTime == null) ? LocalDateTime.now() : registeredDateTime;
    }

    public String getUserId() {
        return userID;
    }

    public void setUserId(String userId) {
        this.userID = (userId == null || userId.isEmpty()) ? UUID.randomUUID().toString() : userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    public boolean isAdmin() {
        return isAdmin;
    }

    public void setAdmin(boolean admin) {
        isAdmin = admin;
    }

    public LocalDateTime getRegisteredDateTime() {
        return registeredDateTime;
    }

    public void setRegisteredDateTime(LocalDateTime registeredDateTime) {
        this.registeredDateTime = registeredDateTime;
    }

    @Override
    public String toString() {
        return String.join(" , ", userID, name, email, password, contactNumber, String.valueOf(isAdmin), registeredDateTime.toString());
    }
}