package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import java.time.LocalDate;
import java.util.UUID;

public class User {
    private String userId;
    private String username;
    private String email;
    private String password;
    private String contactNumber;
    private LocalDate registrationDate;
    private String paymentPreferences;

    public User(String username, String email, String password,
                String contactNumber, LocalDate now, String paymentPreferences) {
        this.userId = UUID.randomUUID().toString();
        this.username = username;
        this.email = email;
        this.password = password; // In real apps, hash this!
        this.contactNumber = contactNumber;
        this.registrationDate = LocalDate.now();
        this.paymentPreferences = paymentPreferences;
    }

    // Getters and Setters
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = (userId == null || userId.isEmpty()) ? UUID.randomUUID().toString() : userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
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

    public LocalDate getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(LocalDate registrationDate) {
        this.registrationDate = registrationDate;
    }

    public String getPaymentPreferences() {
        return paymentPreferences;
    }

    public void setPaymentPreferences(String paymentPreferences) {
        this.paymentPreferences = paymentPreferences;
    }

    @Override
    public String toString() {
        return userId + "," + username + "," + email + "," + password + "," + contactNumber + "," + registrationDate + "," +
                paymentPreferences;
    }
}