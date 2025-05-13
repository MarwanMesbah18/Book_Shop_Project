<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Clasess.User, Clasess.Books, Clasess.DB, Clasess.ShoppingCart, java.util.List, java.util.HashSet" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Shop - Home</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f4f4f4;
    }
    .header {
        background-color: #333;
        color: white;
        padding: 15px 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .user-info {
        margin-right: 20px;
    }
    .container {
        max-width: 1200px;
        margin: 20px auto;
        padding: 0 20px;
    }
    .book-container {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
        gap: 20px;
        margin-top: 20px;
    }
    .book-card {
        background-color: white;
        border-radius: 5px;
        padding: 15px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }
    .book-title {
        font-size: 18px;
        font-weight: bold;
        margin-bottom: 10px;
    }
    .book-author {
        color: #666;
        margin-bottom: 10px;
    }
    .book-price {
        font-weight: bold;
        color: #4CAF50;
        margin-bottom: 10px;
    }
    .book-genre {
        font-style: italic;
        margin-bottom: 15px;
    }
    .add-to-cart {
        background-color: #4CAF50;
        color: white;
        border: none;
        padding: 8px 10px;
        cursor: pointer;
        border-radius: 3px;
    }
    .add-to-cart:hover {
        background-color: #45a049;
    }
    .logout-form {
        display: inline;
    }
    .logout-btn {
        background: none;
        border: none;
        color: white;
        cursor: pointer;
        font-size: 16px;
    }
    .filter-form {
        background-color: white;
        padding: 15px;
        border-radius: 5px;
        margin-bottom: 20px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    .filter-form select {
        padding: 8px;
        margin-right: 10px;
        border-radius: 3px;
        border: 1px solid #ddd;
    }
    .filter-button {
        padding: 8px 15px;
        background-color: #333;
        color: white;
        border: none;
        border-radius: 3px;
        cursor: pointer;
    }
</style>
</head>
<body>
<%
    List<Books> debugBooks = DB.getAllBooks();
    out.println("<!-- DEBUG: Found " + debugBooks.size() + " books in database -->");
    for (Books b : debugBooks) {
        out.println("<!-- Book: " + b.getName() + ", Genre: " + b.getGenre() + " -->");
    }
%>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        // Not logged in, redirect to login page
        response.sendRedirect("login.jsp");
        return; // Stop execution
    }
    
    // Get all books from database
    List<Books> booksList = DB.getAllBooks();
    
    // Get selected genre for filtering
    String selectedGenre = request.getParameter("genre");
    
    // Get all unique genres for the filter dropdown
   // Get all unique genres for the filter dropdown
HashSet<String> genres = new HashSet<>();
// Add all possible genres first
genres.add("Fiction");
genres.add("Fantasy");
genres.add("Classic");
genres.add("Mystery");
genres.add("Adventure");
genres.add("Non-Fiction");
genres.add("Science Fiction");
genres.add("Romance");
genres.add("Horror");
genres.add("Biography");

// Then add any from books (though this is redundant now)
for (Books book : booksList) {
    genres.add(book.getGenre());
}

%>

<div class="header">
    <h1>Book Shop</h1>
    <div class="user-info">
        <a href="cart.jsp" style="color: white; margin-right: 15px;">
            View Cart (<%= session.getAttribute("cart") != null ? 
                     ((ShoppingCart)session.getAttribute("cart")).getTotalQuantity() : 0 %>)
        </a>
        Welcome, <%= user.getUsername() %>! | 
        <form class="logout-form" action="LogoutServlet" method="post">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
    </div>
</div>

<div class="container">
    <h2>Available Books</h2>
    
    <!-- Genre and search filter -->
<div class="filter-form">
    <form action="home.jsp" method="get">
        <div style="display: flex; align-items: center; gap: 15px; flex-wrap: wrap;">
            <div>
                <label for="genre">Filter by Genre:</label>
                <select name="genre" id="genre">
                    <option value="">All Genres</option>
                    <% for (String genre : genres) { %>
                    <option value="<%= genre %>" <%= genre.equals(selectedGenre) ? "selected" : "" %>><%= genre %></option>
                    <% } %>
                </select>
            </div>
            
            <div>
                <label for="search">Search:</label>
                <input type="text" id="search" name="search" placeholder="Search by title or author" 
                       value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>" 
                       style="padding: 8px; border-radius: 3px; border: 1px solid #ddd; width: 250px;">
            </div>
            
            <button type="submit" class="filter-button">Apply Filters</button>
        </div>
    </form>
</div>

    
<div class="book-container">
<% 
if(booksList != null && !booksList.isEmpty()) {
    String searchQuery = request.getParameter("search");
    searchQuery = (searchQuery != null) ? searchQuery.toLowerCase() : "";
    
    for(Books book : booksList) {
        // Apply genre filter and search filter
        boolean matchesGenre = selectedGenre == null || selectedGenre.isEmpty() || selectedGenre.equals(book.getGenre());
        boolean matchesSearch = searchQuery.isEmpty() || 
                               book.getName().toLowerCase().contains(searchQuery) || 
                               book.getAuthor().toLowerCase().contains(searchQuery);
        
        if (matchesGenre && matchesSearch) {
%>
    <div class="book-card">
        <div class="book-title"><%= book.getName() %></div>
        <div class="book-author">by <%= book.getAuthor() %></div>
        <div class="book-genre"><%= book.getGenre() %></div>
        <div class="book-price">$<%= String.format("%.2f", book.getPrice()) %></div>
        <% if(book.getQuantity() > 0) { %>
            <form action="AddToCartServlet" method="post">
                <input type="hidden" name="bookName" value="<%= book.getName() %>">
                <button type="submit" class="add-to-cart">Add to Cart</button>
            </form>
        <% } else { %>
            <span style="color: red;">Out of Stock</span>
        <% } %>
    </div>
<% 
        }
    }
} else { 
%>
    <p>No books available at the moment.</p>
<% } %>
</div>

</div>

</body>
</html>
