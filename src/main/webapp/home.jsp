<!-- filepath: /home/mesbah/Desktop/JAVAEE/Book_Shop/src/main/webapp/home.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Clasess.User, Clasess.Books, Clasess.DB, java.util.List" %>
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
</style>
</head>
<body>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        // Not logged in, redirect to login page
        response.sendRedirect("login.jsp");
        return; // Stop execution
    }
    
    // Get all books from database
    List<Books> booksList = DB.getAllBooks();
%>

<div class="header">
    <h1>Book Shop</h1>
    <div class="user-info">
        Welcome, <%= user.getUsername() %>! | 
        <form class="logout-form" action="LogoutServlet" method="post">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
    </div>
</div>

<div class="container">
    <h2>Available Books</h2>
    
    <div class="book-container">
    <% if(booksList != null && !booksList.isEmpty()) {
           for(Books book : booksList) { %>
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
    <% }
       } else { %>
        <p>No books available at the moment.</p>
    <% } %>
    </div>
</div>

</body>
</html>