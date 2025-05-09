package Clasess;

import java.util.*;

public class Admin {
    private String adminName;
    private String password;
    private List<Books> books;
    private List<User> users;
    
    public Admin() {
        this.books = new ArrayList<>();
        this.users = new ArrayList<>();
    }
    
    public Admin(String adminName, String password) {
        this.adminName = adminName;
        this.password = password;
        this.books = new ArrayList<>();
        this.users = new ArrayList<>();
    }

    public String getAdminName() {
        return adminName;
    }
    
    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public List<Books> getBooks() {
        return books;
    }
    
    public void setBooks(List<Books> books) {
        this.books = books;
    }
    
    public List<User> getUsers() {
        return users;
    }
    
    public void setUsers(List<User> users) {
        this.users = users;
    }
}