<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Clasess.User, Clasess.Books, Clasess.DB, Clasess.ShoppingCart, java.util.List, java.util.HashSet" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Shop - Home</title>
<style>
    :root {
        --primary-color: #2c3e50;
        --secondary-color: #3498db;
        --accent-color: #e74c3c;
        --light-gray: #ecf0f1;
        --dark-gray: #7f8c8d;
        --success-color: #27ae60;
        --card-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        --transition: all 0.3s ease;
    }
    
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }
    
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f9f9f9;
        color: #333;
        line-height: 1.6;
    }
    
    .header {
        background-color: var(--primary-color);
        color: white;
        padding: 1rem 2rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        position: sticky;
        top: 0;
        z-index: 100;
    }
    
    .logo {
        font-size: 1.8rem;
        font-weight: 700;
        letter-spacing: 1px;
    }
    
    .logo span {
        color: var(--secondary-color);
    }
    
    .user-info {
        display: flex;
        align-items: center;
        gap: 1.5rem;
    }
    
    .user-actions {
        display: flex;
        gap: 1rem;
    }
    
    .cart-link {
        color: white;
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        padding: 0.5rem 1rem;
        border-radius: 4px;
        transition: var(--transition);
        background-color: rgba(255, 255, 255, 0.1);
    }
    
    .cart-link:hover {
        background-color: rgba(255, 255, 255, 0.2);
    }
    
    .cart-icon {
        font-size: 1.2rem;
    }
    
    .logout-btn {
        background-color: var(--accent-color);
        color: white;
        border: none;
        padding: 0.5rem 1rem;
        border-radius: 4px;
        cursor: pointer;
        transition: var(--transition);
        font-weight: 500;
    }
    
    .logout-btn:hover {
        background-color: #c0392b;
    }
    
    .welcome-message {
        font-weight: 500;
    }
    
    .container {
        max-width: 1200px;
        margin: 2rem auto;
        padding: 0 1.5rem;
    }
    
    .page-title {
        font-size: 1.8rem;
        margin-bottom: 1.5rem;
        color: var(--primary-color);
        position: relative;
        padding-bottom: 0.5rem;
    }
    
    .page-title::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 60px;
        height: 3px;
        background-color: var(--secondary-color);
    }
    
    .filter-section {
        background-color: white;
        padding: 1.5rem;
        border-radius: 8px;
        margin-bottom: 2rem;
        box-shadow: var(--card-shadow);
    }
    
    .filter-form {
        display: flex;
        flex-wrap: wrap;
        gap: 1rem;
        align-items: flex-end;
    }
    
    .filter-group {
        display: flex;
        flex-direction: column;
        min-width: 200px;
    }
    
    .filter-label {
        margin-bottom: 0.5rem;
        font-weight: 500;
        color: var(--primary-color);
        font-size: 0.9rem;
    }
    
    .filter-select, .search-input {
        padding: 0.7rem;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 1rem;
        transition: var(--transition);
    }
    
    .filter-select:focus, .search-input:focus {
        outline: none;
        border-color: var(--secondary-color);
        box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
    }
    
    .search-input {
        width: 300px;
    }
    
    .apply-btn {
        background-color: var(--primary-color);
        color: white;
        border: none;
        padding: 0.7rem 1.5rem;
        border-radius: 4px;
        cursor: pointer;
        font-weight: 500;
        transition: var(--transition);
    }
    
    .apply-btn:hover {
        background-color: #1a252f;
    }
    
    .book-container {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 1.5rem;
        margin-top: 1rem;
    }
    
    .book-card {
        background-color: white;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: var(--card-shadow);
        transition: var(--transition);
        display: flex;
        flex-direction: column;
    }
    
    .book-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
    }
    
    .book-image {
        height: 200px;
        background-color: #eee;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #999;
        font-size: 3rem;
    }
    
    .book-details {
        padding: 1.5rem;
        flex-grow: 1;
        display: flex;
        flex-direction: column;
    }
    
    .book-title {
        font-size: 1.2rem;
        font-weight: 600;
        margin-bottom: 0.5rem;
        color: var(--primary-color);
    }
    
    .book-author {
        color: #666;
        margin-bottom: 0.5rem;
        font-size: 0.9rem;
    }
    
    .book-genre {
        display: inline-block;
        background-color: #e0f2fe;
        color: #0369a1;
        padding: 0.25rem 0.5rem;
        border-radius: 4px;
        font-size: 0.8rem;
        margin-bottom: 1rem;
    }
    
    .book-meta {
        display: flex;
        justify-content: space-between;
        margin-top: auto;
        padding-top: 1rem;
        border-top: 1px solid #eee;
    }
    
    .book-price {
        font-weight: 700;
        color: var(--success-color);
        font-size: 1.1rem;
    }
    
    .book-stock {
        color: #666;
        font-size: 0.9rem;
    }
    
    .add-to-cart {
        background-color: var(--primary-color);
        color: white;
        border: none;
        padding: 0.7rem;
        width: 100%;
        border-radius: 4px;
        cursor: pointer;
        font-weight: 500;
        margin-top: 1rem;
        transition: var(--transition);
    }
    
    .add-to-cart:hover {
        background-color: green;
    }
    
    .no-books {
        grid-column: 1 / -1;
        text-align: center;
        padding: 2rem;
        color: #666;
    }
    
    @media (max-width: 768px) {
        .header {
            flex-direction: column;
            gap: 1rem;
            padding: 1rem;
        }
        
        .user-info {
            width: 100%;
            justify-content: space-between;
        }
        
        .search-input {
            width: 100%;
        }
        
        .book-container {
            grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
        }
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
        response.sendRedirect("login.jsp");
        return;
    }
    
    List<Books> booksList = DB.getAllBooks();
    String selectedGenre = request.getParameter("genre");
    
    HashSet<String> genres = new HashSet<>();
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

    for (Books book : booksList) {
        genres.add(book.getGenre());
    }
%>

<div class="header">
    <div class="logo">Book<span>Shop</span></div>
    <div class="user-info">
        <div class="welcome-message">Welcome, <%= user.getUsername() %>!</div>
        <div class="user-actions">
            <a href="cart.jsp" class="cart-link">
                <span class="cart-icon">🛒</span>
                Cart (<%= session.getAttribute("cart") != null ? 
                     ((ShoppingCart)session.getAttribute("cart")).getTotalQuantity() : 0 %>)
            </a>
            <form class="logout-form" action="LogoutServlet" method="post">
                <button type="submit" class="logout-btn">Logout</button>
            </form>
        </div>
    </div>
</div>

<div class="container">
    <h1 class="page-title">Available Books</h1>
    
    <div class="filter-section">
        <form action="home.jsp" method="get" class="filter-form">
            <div class="filter-group">
                <label for="genre" class="filter-label">Filter by Genre</label>
                <select name="genre" id="genre" class="filter-select">
                    <option value="">All Genres</option>
                    <% for (String genre : genres) { %>
                    <option value="<%= genre %>" <%= genre.equals(selectedGenre) ? "selected" : "" %>>
                        <%= genre %>
                    </option>
                    <% } %>
                </select>
            </div>
            
            <div class="filter-group">
                <label for="search" class="filter-label">Search Books</label>
                <input type="text" id="search" name="search" class="search-input" 
                       placeholder="Search by title or author" 
                       value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
            </div>
            
            <button type="submit" class="apply-btn">Apply Filters</button>
        </form>
    </div>
    
    <div class="book-container">
    <% 
    if(booksList != null && !booksList.isEmpty()) {
        String searchQuery = request.getParameter("search");
        searchQuery = (searchQuery != null) ? searchQuery.toLowerCase() : "";
        
        for(Books book : booksList) {
            if(book.getQuantity() <= 0) continue;
            
            boolean matchesGenre = selectedGenre == null || selectedGenre.isEmpty() || selectedGenre.equals(book.getGenre());
            boolean matchesSearch = searchQuery.isEmpty() || 
                                   book.getName().toLowerCase().contains(searchQuery) || 
                                   book.getAuthor().toLowerCase().contains(searchQuery);
            
            if (matchesGenre && matchesSearch) {
    %>
        <div class="book-card">
            <div class="book-image">📚</div>
            <div class="book-details">
                <h3 class="book-title"><%= book.getName() %></h3>
                <p class="book-author">by <%= book.getAuthor() %></p>
                <span class="book-genre"><%= book.getGenre() %></span>
                <div class="book-meta">
                    <span class="book-price">$<%= String.format("%.2f", book.getPrice()) %></span>
                    <span class="book-stock"><%= book.getQuantity() %> in stock</span>
                </div>
                <form action="AddToCartServlet" method="post">
                    <input type="hidden" name="bookName" value="<%= book.getName() %>">
                    <button type="submit" class="add-to-cart">Add to Cart</button>
                </form>
            </div>
        </div>
    <% 
            }
        }
    } else { 
    %>
        <div class="no-books">
            <p>No books available matching your criteria.</p>
        </div>
    <% } %>
    </div>
</div>

</body>
</html>