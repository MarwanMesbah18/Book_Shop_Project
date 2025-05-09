package Clasess;

import java.util.ArrayList;
import java.util.List;

public class ShoppingCart {
    private List<CartItem> items;
    
    public ShoppingCart() {
        this.items = new ArrayList<>();
    }
    
    public List<CartItem> getItems() {
        return items;
    }
    
    public void addItem(Books book, int quantity) {
        // Check if book already exists in cart
        for (CartItem item : items) {
            if (item.getBook().getName().equals(book.getName())) {
                // Update quantity instead of adding new item
                item.setQuantity(item.getQuantity() + quantity);
                return;
            }
        }
        
        // Book not in cart, add new item
        CartItem newItem = new CartItem(book, quantity);
        items.add(newItem);
    }
    
    public void removeItem(String bookName) {
        items.removeIf(item -> item.getBook().getName().equals(bookName));
    }
    
    public void updateItemQuantity(String bookName, int newQuantity) {
        for (CartItem item : items) {
            if (item.getBook().getName().equals(bookName)) {
                if (newQuantity <= 0) {
                    removeItem(bookName);
                } else {
                    item.setQuantity(newQuantity);
                }
                return;
            }
        }
    }
    
    public void clearCart() {
        items.clear();
    }
    
    public double getTotalPrice() {
        double total = 0;
        for (CartItem item : items) {
            total += item.getTotalPrice();
        }
        return total;
    }
    
    public int getItemCount() {
        return items.size();
    }
    
    public int getTotalQuantity() {
        int count = 0;
        for (CartItem item : items) {
            count += item.getQuantity();
        }
        return count;
    }
}