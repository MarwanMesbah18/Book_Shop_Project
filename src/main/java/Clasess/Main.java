package Clasess;

public class Main {

    public static void main(String[] args) {
        System.out.println("Starting database initialization...");
        System.out.println("Database location: " + System.getProperty("user.home") + "/bookshop_db");
        
        DB db = new DB();
        
        try {
            // Reset database first (drop and recreate tables)
            System.out.println("Resetting database...");
            db.resetDatabase();
            
            System.out.println("Creating user table...");
            db.add_user_table();
            
            System.out.println("Creating books table...");
            db.add_books_table();
            
            // Add a regular user
            System.out.println("Adding regular user...");
            User user = new User();
            user.setUsername("user1");
            user.setEmail("user1@gmail.com");
            user.setPassword("12345678");
            user.setPhoneNumber("0123456789");
            user.setAddress("123 Main St");
            user.setUserType("user");
            DB.add_user(user);
            
            // Add an admin user
            System.out.println("Adding admin user...");
            User admin = new User();
            admin.setUsername("admin");
            admin.setEmail("admin@bookshop.com");
            admin.setPassword("admin123");
            admin.setPhoneNumber("9876543210");
            admin.setAddress("456 Admin St");
            admin.setUserType("admin");
            DB.add_user(admin);
            
            // Add some sample books
            System.out.println("Adding sample books...");
            Books book1 = new Books("The Great Gatsby", 12.99, "F. Scott Fitzgerald", 10, "Fiction");
            Books book2 = new Books("To Kill a Mockingbird", 11.50, "Harper Lee", 15, "Fiction");
            Books book3 = new Books("1984", 10.99, "George Orwell", 20, "Fiction");
            
            DB.add_book(book1);
            DB.add_book(book2);
            DB.add_book(book3);
            
            System.out.println("Database successfully initialized with users and books");
            System.out.println("\nUsers in database:");
            DB.listAllUsers();
            
            // Test login verification with both methods
            System.out.println("\nTesting login verification:");
            boolean verified = db.verifyLogin("user1", "12345678");
            System.out.println("verifyLogin result: " + verified);
            
            User foundUser = db.getUserByCredentials("user1", "12345678");
            System.out.println("getUserByCredentials result: " + (foundUser != null ? "User found" : "User NOT found"));
            
            if (foundUser != null) {
                System.out.println("Username: " + foundUser.getUsername());
                System.out.println("Email: " + foundUser.getEmail());
                System.out.println("User type: " + foundUser.getUserType());
            }
            
            System.out.println("\nDatabase setup complete!");
            System.out.println("Now you can run the web application through Tomcat");
            System.out.println("Login with username 'user1' and password '12345678'");
            
        } catch (Exception e) {
            System.out.println("Error during database initialization: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
