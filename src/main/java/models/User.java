package models;

import java.sql.Timestamp;

public class User {
    private int id;
    private String email;
    private String password;
    private Timestamp registeredTime;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Constructors
    public User() {}
    
    public User(String email, String password) {
        this.email = email;
        this.password = password;
    }
    
    public User(int id, String email, String password, Timestamp registeredTime) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.registeredTime = registeredTime;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
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
    
    public Timestamp getRegisteredTime() {
        return registeredTime;
    }
    
    public void setRegisteredTime(Timestamp registeredTime) {
        this.registeredTime = registeredTime;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", email='" + email + '\'' +
                ", registeredTime=" + registeredTime +
                '}';
    }
}
