package Clasess;

import java.util.List;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class DatabaseInitializer implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Initializing database for web application...");
        
DB db = new DB();
        
        try {
            // Setup database tables
            System.out.println("Creating user table...");
            db.add_user_table();
            
            System.out.println("Creating books table...");
            db.add_books_table();
            
            // Add users
            System.out.println("Adding regular user...");
            User user = new User();
            user.setUsername("user1");
            user.setEmail("user1@gmail.com");
            user.setPassword("12345678");
            user.setPhoneNumber("0123456789");
            user.setAddress("123 Main St");
            user.setUserType("user");
            DB.add_user(user);
            
            System.out.println("Adding admin user...");
            User admin = new User();
            admin.setUsername("admin");
            admin.setEmail("admin@bookshop.com");
            admin.setPassword("admin123");
            admin.setPhoneNumber("9876543210");
            admin.setAddress("456 Admin St");
            admin.setUserType("admin");
            DB.add_user(admin);
            
            // Add books with different genres
            System.out.println("Adding sample books...");
            
            // Fiction books
            Books book1 = new Books("The Great Gatsby", 12.99, "F. Scott Fitzgerald", 10, "Fiction");
            Books book2 = new Books("To Kill a Mockingbird", 11.50, "Harper Lee", 15, "Fiction");
            Books book3 = new Books("1984", 10.99, "George Orwell", 20, "Fiction");
            Books book7 = new Books("The Catcher in the Rye", 11.99, "J.D. Salinger", 15, "Fiction");
            
            // Fantasy books
            Books book4 = new Books("Harry Potter and the Philosopher's Stone", 14.99, "J.K. Rowling", 25, "Fantasy");
            Books book5 = new Books("The Hobbit", 13.50, "J.R.R. Tolkien", 18, "Fantasy");
            
            // Other genres
            Books book6 = new Books("Pride and Prejudice", 9.99, "Jane Austen", 20, "Classic");
            Books book8 = new Books("The Da Vinci Code", 12.99, "Dan Brown", 22, "Mystery");
            Books book9 = new Books("The Alchemist", 10.50, "Paulo Coelho", 17, "Adventure");
            Books book10 = new Books("Sapiens", 15.99, "Yuval Noah Harari", 12, "Non-Fiction");
            
            // Add books to database
            DB.add_book(book1);
            DB.add_book(book2);
            DB.add_book(book3);
            DB.add_book(book4);
            DB.add_book(book5);
            DB.add_book(book6);
            DB.add_book(book7);
            DB.add_book(book8);
            DB.add_book(book9);
            DB.add_book(book10);
            
            // Verify books in database
            List<Books> allBooks = DB.getAllBooks();
            System.out.println("\nVerifying books in database:");
            System.out.println("Total books found: " + allBooks.size());
            
            for (Books book : allBooks) {
                System.out.println(book.getName() + " - Genre: " + book.getGenre());
            }
            
            System.out.println("\nUsers in database:");
            DB.listAllUsers();
            
            System.out.println("\nDatabase setup complete!");
            System.out.println("Now you can run the web application through Tomcat");
            System.out.println("Login with username 'user1' and password '12345678'");
            
        } catch (Exception e) {
            System.out.println("Error during database initialization: " + e.getMessage());
            e.printStackTrace();
        }

    }
}
