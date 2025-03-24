package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

public class User {
    private int userName;
    private String password;
    private String email;
    private String contactNum;
    private String paymentPreference;

    public User(int userName, String password, String email, String contactNum, String paymentPreference) {
        this.userName = userName;
        this.password = password;
        this.email = email;
        this.contactNum = contactNum;
        this.paymentPreference = paymentPreference;
    }

    public int getUserName() {
        return userName;
    }

    public void setUserName(int userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getContactNum() {
        return contactNum;
    }

    public void setContactNum(String contactNum) {
        this.contactNum = contactNum;
    }

    public String getPaymentPreference() {
        return paymentPreference;
    }

    public void setPaymentPreference(String paymentPreference) {
        this.paymentPreference = paymentPreference;
    }
}
