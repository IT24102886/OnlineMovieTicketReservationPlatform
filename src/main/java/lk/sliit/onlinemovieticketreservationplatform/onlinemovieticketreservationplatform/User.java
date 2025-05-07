//package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;
//
//import java.util.UUID;
//
//public class User {
//
//    private String userID;
//    private String name;
//    private String email;
//    private String password;
//    private String contactNumber;
//    private boolean isAdmin = false;
//
//    // Default constructor
//    public User() {
//        this.userID = UUID.randomUUID().toString();
//        this.isAdmin = false;
//    }
//
//    // Parameterized constructor
//    public User(String userID, String name, String email, String password, String contactNumber) {
//        this.userID = (userID == null || userID.isEmpty()) ? UUID.randomUUID().toString() : userID;
//        this.name = name;
//        this.email = email;
//        this.password = password;
//        this.contactNumber = contactNumber;
//    }
//
//    // Getters and Setters
//    public String getUserId() {
//        return userID;
//    }
//
//    public void setMemberId(String memberId) {
//        this.userID = (memberId == null || memberId.isEmpty()) ? UUID.randomUUID().toString() : memberId;
//    }
//
//    public String getName() {
//        return name;
//    }
//
//    public void setName(String name) {
//        this.name = name;
//    }
//
//    public String getEmail() {
//        return email;
//    }
//
//    public void setEmail(String email) {
//        this.email = email;
//    }
//
//    public String getPassword() {
//        return password;
//    }
//
//    public void setPassword(String password) {
//        this.password = password;
//    }
//
//    public String getContactNumber() {
//        return contactNumber;
//    }
//
//    public void setContactNumber(String contactNumber) {
//        this.contactNumber = contactNumber;
//    }
//
//    public boolean isAdmin() {
//        return isAdmin;
//    }
//
//    public void setAdmin(boolean admin) {
//        isAdmin = admin;
//    }
//
//    @Override
//    public String toString() {
//        return userID + "," + name + "," + email + "," + password + "," + contactNumber;
//    }
//}






package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import java.util.UUID;

public class User {

    private String userID;
    private String name;
    private String email;
    private String password;
    private String contactNumber;
    private boolean isAdmin = false;

    // Default constructor
    public User() {
        this.userID = UUID.randomUUID().toString();
        this.isAdmin = false;
    }

    // Parameterized constructor
    public User(String userID, String name, String email, String password, String contactNumber) {
        this.userID = (userID == null || userID.isEmpty()) ? UUID.randomUUID().toString() : userID;
        this.name = name;
        this.email = email;
        this.password = password;
        this.contactNumber = contactNumber;
    }

    // Getters and Setters
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

    @Override
    public String toString() {
        return String.join(" , ", userID, name, email, password, contactNumber, String.valueOf(isAdmin));
    }
}