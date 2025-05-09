package Clasess;

public class Books {
    private String name;
    private double price;
    private String author;
    private int quantity;
    private String genre;
    
    // Default constructor added
    public Books() {
    }
    
    public Books(String name, double price, String author, int quantity, String genre) {
        this.name = name;
        this.price = price;
        this.author = author;
        this.quantity = quantity;
        this.genre = genre;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }
}