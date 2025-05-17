package Clasess;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DB {

	   // Use a fixed path that will be consistent between Main.java and Tomcat
    private static final String DB_PATH = System.getProperty("catalina.base") != null ?
            System.getProperty("catalina.base") + "/bookshop_db" :
            System.getProperty("user.home") + "/bookshop_db";
    
    private static final String DB_URL = "jdbc:derby:" + DB_PATH + ";create=true";
    private static final String DB_DRIVER = "org.apache.derby.jdbc.EmbeddedDriver";
    
    static {
        // Print DB path for debugging
        System.out.println("Database location being used: " + DB_PATH);
    }

    public void resetDatabase() {
        try {
            Class.forName(DB_DRIVER);
            try (Connection con = DriverManager.getConnection(DB_URL)) {
                try {
                    Statement st = con.createStatement();
                    st.executeUpdate("DROP TABLE USERS");
                    System.out.println("USERS table dropped successfully");
                } catch (SQLException e) {
                    System.out.println("Note: USERS table did not exist or could not be dropped");
                }

                try {
                    Statement st = con.createStatement();
                    st.executeUpdate("DROP TABLE BOOKS");
                    System.out.println("BOOKS table dropped successfully");
                } catch (SQLException e) {
                    System.out.println("Note: BOOKS table did not exist or could not be dropped");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void add_user_table() {
        try {
            Class.forName(DB_DRIVER);
            try (Connection con = DriverManager.getConnection(DB_URL)) {
                Statement st = con.createStatement();
                st.executeUpdate("CREATE TABLE USERS (username VARCHAR(30) PRIMARY KEY, " +
                                "email VARCHAR(50), password VARCHAR(30), phoneNumber VARCHAR(30), " +
                                "address VARCHAR(30), userType VARCHAR(30))");
                System.out.println("USERS table created successfully");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void add_books_table() {
        try {
            Class.forName(DB_DRIVER);
            try (Connection con = DriverManager.getConnection(DB_URL)) {
                Statement st = con.createStatement();
                st.executeUpdate("CREATE TABLE BOOKS (name VARCHAR(100) PRIMARY KEY, " +
                                "price DOUBLE, author VARCHAR(50), quantity INTEGER, " +
                                "genre VARCHAR(30))");
                System.out.println("BOOKS table created successfully");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static int add_user(User u) {
        int flag = 0;
        try {
            Class.forName(DB_DRIVER);
            try (Connection con = DriverManager.getConnection(DB_URL)) {
                try (PreparedStatement pst = con.prepareStatement("INSERT INTO USERS VALUES(?,?,?,?,?,?)")) {
                    pst.setString(1, u.getUsername());
                    pst.setString(2, u.getEmail());
                    pst.setString(3, u.getPassword());
                    pst.setString(4, u.getPhoneNumber());
                    pst.setString(5, u.getAddress());
                    pst.setString(6, u.getUserType());

                    flag = pst.executeUpdate();
                    System.out.println("User added successfully: " + u.getUsername());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }

    public static int add_book(Books book) {
        int flag = 0;
        try {
            Class.forName(DB_DRIVER);
            try (Connection con = DriverManager.getConnection(DB_URL)) {
                try (PreparedStatement pst = con.prepareStatement("INSERT INTO BOOKS VALUES(?,?,?,?,?)")) {
                    pst.setString(1, book.getName());
                    pst.setDouble(2, book.getPrice());
                    pst.setString(3, book.getAuthor());
                    pst.setInt(4, book.getQuantity());
                    pst.setString(5, book.getGenre());

                    flag = pst.executeUpdate();
                    System.out.println("Book added successfully: " + book.getName());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }

    public static List<Books> getAllBooks() {
        List<Books> booksList = new ArrayList<>();
        try {
            Class.forName(DB_DRIVER);
            try (Connection con = DriverManager.getConnection(DB_URL)) {
                try (Statement st = con.createStatement();
                     ResultSet rs = st.executeQuery("SELECT * FROM BOOKS")) {

                    while (rs.next()) {
                        Books book = new Books();
                        book.setName(rs.getString("name"));
                        book.setPrice(rs.getDouble("price"));
                        book.setAuthor(rs.getString("author"));
                        book.setQuantity(rs.getInt("quantity"));
                        book.setGenre(rs.getString("genre"));
                        booksList.add(book);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return booksList;
    }

    public boolean verifyLogin(String username, String password) {
        boolean isValid = false;
        try {
            Class.forName(DB_DRIVER);
            try (Connection con = DriverManager.getConnection(DB_URL);
                 PreparedStatement pst = con.prepareStatement(
                         "SELECT * FROM USERS WHERE username=? AND password=?")) {

                pst.setString(1, username);
                pst.setString(2, password);

                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next()) {
                        isValid = true;      
                    } 
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isValid;
    }

    public static boolean updateBookQuantity(String bookName, int newQuantity) {
        boolean success = false;
        try {
            Class.forName(DB_DRIVER);
            try (Connection con = DriverManager.getConnection(DB_URL);
                 PreparedStatement pst = con.prepareStatement(
                         "UPDATE BOOKS SET quantity=? WHERE name=?")) {

                pst.setInt(1, newQuantity);
                pst.setString(2, bookName);

                int rowsAffected = pst.executeUpdate();
                success = (rowsAffected > 0);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }
    
    public static void listAllUsers() {
        try {
            Class.forName(DB_DRIVER);
            try (Connection con = DriverManager.getConnection(DB_URL);
                 Statement stmt = con.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT * FROM USERS")) {
                
                System.out.println("All users in database:");
                while (rs.next()) {
                    System.out.println("Username: " + rs.getString("username") + 
                                       ", Password: " + rs.getString("password") + 
                                       ", Type: " + rs.getString("userType"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    
    public User getUserByCredentials(String username, String password) {
        User user = null;
        try {
            Class.forName(DB_DRIVER);
            try (Connection con = DriverManager.getConnection(DB_URL);
                 PreparedStatement pst = con.prepareStatement(
                     "SELECT * FROM USERS WHERE username=? AND password=?")) {

                pst.setString(1, username);
                pst.setString(2, password);
                System.out.println("Trying login with: " + username + ", " + password);

                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next()) {
                        user = new User();
                        user.setUsername(rs.getString("username"));
                        user.setEmail(rs.getString("email"));
                        user.setPassword(rs.getString("password"));
                        user.setPhoneNumber(rs.getString("phoneNumber"));
                        user.setAddress(rs.getString("address"));
                        user.setUserType(rs.getString("userType"));
                        System.out.println("User found in database");
                    } else {
                        System.out.println("No user found with these credentials");
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Error during login: " + e.getMessage());
            e.printStackTrace();
        }
        return user;
    }
    
    public static List<User> getAllUsers() {
        List<User> usersList = new ArrayList<>();
        try {
            Class.forName(DB_DRIVER);
            try (Connection con = DriverManager.getConnection(DB_URL)) {
                try (Statement st = con.createStatement();
                     ResultSet rs = st.executeQuery("SELECT * FROM USERS")) {

                    while (rs.next()) {
                        User user = new User();
                        user.setUsername(rs.getString("username"));
                        user.setEmail(rs.getString("email"));
                        user.setPassword(rs.getString("password"));
                        user.setPhoneNumber(rs.getString("phoneNumber"));
                        user.setAddress(rs.getString("address"));
                        user.setUserType(rs.getString("userType"));
                        usersList.add(user);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return usersList;
    }
    public static boolean updateUser(String originalUsername, User updatedUser) {
        try {
            // First delete the original user
            Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
            java.sql.Connection con = java.sql.DriverManager.getConnection(
                "jdbc:derby:" + System.getProperty("catalina.base", System.getProperty("user.home")) + 
                "/bookshop_db" + ";create=true");
            
            // Delete the existing user
            java.sql.PreparedStatement pst = con.prepareStatement("DELETE FROM USERS WHERE username=?");
            pst.setString(1, originalUsername);
            pst.executeUpdate();
            pst.close();
            
            // Add the updated user
            pst = con.prepareStatement("INSERT INTO USERS VALUES(?,?,?,?,?,?)");
            pst.setString(1, updatedUser.getUsername());
            pst.setString(2, updatedUser.getEmail());
            pst.setString(3, updatedUser.getPassword());
            pst.setString(4, updatedUser.getPhoneNumber());
            pst.setString(5, updatedUser.getAddress());
            pst.setString(6, updatedUser.getUserType());
            
            int result = pst.executeUpdate();
            pst.close();
            con.close();
            
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


}
