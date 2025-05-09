package Clasess;

public class Main {

    public static void main(String[] args) {
        DB db = new DB();
        
        // Reset database first (drop and recreate tables)
        db.resetDatabase();
        db.add_user_table();
        db.add_books_table();
        
        // Add a regular user
        User user = new User();
        user.setUsername("user1");
        user.setEmail("user1@gmail.com");
        user.setPassword("12345678");
        user.setPhoneNumber("0123456789");
        user.setAddress("123 Main St");
        user.setUserType("user");
        DB.add_user(user);
        
        
        // Add an admin user
        User admin = new User();
        admin.setUsername("admin");
        admin.setEmail("admin@bookshop.com");
        admin.setPassword("admin123");
        admin.setPhoneNumber("9876543210");
        admin.setAddress("456 Admin St");
        admin.setUserType("admin");
        DB.add_user(admin);
        
        // Add some sample books
        Books book1 = new Books("The Great Gatsby", 12.99, "F. Scott Fitzgerald", 10, "Fiction");
        Books book2 = new Books("To Kill a Mockingbird", 11.50, "Harper Lee", 15, "Fiction");
        Books book3 = new Books("1984", 10.99, "George Orwell", 20, "Fiction");
        
        DB.add_book(book1);
        DB.add_book(book2);
        DB.add_book(book3);
        
        System.out.println("Database initialized with users and books");
        db.printAllUsers();
        boolean i = db.verifyLogin("user1", "12345678");
        System.out.println("User login verification: " + i);
    }
}