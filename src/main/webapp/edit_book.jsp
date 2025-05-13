<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Clasess.User, Clasess.Books" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Shop - Edit Book</title>
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
    .container {
        max-width: 800px;
        margin: 20px auto;
        padding: 20px;
        background-color: white;
        border-radius: 5px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    .form-group {
        margin-bottom: 15px;
    }
    .form-group label {
        display: block;
        margin-bottom: 5px;
    }
    .form-group input {
        width: 100%;
        padding: 8px;
        box-sizing: border-box;
    }
    .submit-btn {
        background-color: #4CAF50;
        color: white;
        border: none;
        padding: 10px 15px;
        cursor: pointer;
        font-size: 16px;
    }
    .cancel-btn {
        background-color: #f44336;
        color: white;
        border: none;
        padding: 10px 15px;
        cursor: pointer;
        font-size: 16px;
        margin-right: 10px;
    }
</style>
</head>
<body>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getUserType())) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    Books book = (Books) request.getAttribute("book");
    if (book == null) {
        response.sendRedirect("admin.jsp");
        return;
    }
%>

<div class="header">
    <h1>Edit Book</h1>
</div>

<div class="container">
    <form action="EditBookServlet" method="post">
        <input type="hidden" name="originalName" value="<%= book.getName() %>">
        
        <div class="form-group">
            <label for="name">Book Title:</label>
            <input type="text" id="name" name="name" value="<%= book.getName() %>" required>
        </div>
        
        <div class="form-group">
            <label for="author">Author:</label>
            <input type="text" id="author" name="author" value="<%= book.getAuthor() %>" required>
        </div>
        
        <div class="form-group">
            <label for="price">Price:</label>
            <input type="number" id="price" name="price" step="0.01" min="0" value="<%= book.getPrice() %>" required>
        </div>
        
        <div class="form-group">
            <label for="quantity">Quantity:</label>
            <input type="number" id="quantity" name="quantity" min="0" value="<%= book.getQuantity() %>" required>
        </div>
        
        <div class="form-group">
    <label for="genre">Genre:</label>
    <select id="genre" name="genre" required class="form-control">
        <option value="">Select a Genre</option>
        <option value="Fiction" <%= "Fiction".equals(book.getGenre()) ? "selected" : "" %>>Fiction</option>
        <option value="Fantasy" <%= "Fantasy".equals(book.getGenre()) ? "selected" : "" %>>Fantasy</option>
        <option value="Classic" <%= "Classic".equals(book.getGenre()) ? "selected" : "" %>>Classic</option>
        <option value="Mystery" <%= "Mystery".equals(book.getGenre()) ? "selected" : "" %>>Mystery</option>
        <option value="Adventure" <%= "Adventure".equals(book.getGenre()) ? "selected" : "" %>>Adventure</option>
        <option value="Non-Fiction" <%= "Non-Fiction".equals(book.getGenre()) ? "selected" : "" %>>Non-Fiction</option>
        <option value="Science Fiction" <%= "Science Fiction".equals(book.getGenre()) ? "selected" : "" %>>Science Fiction</option>
        <option value="Romance" <%= "Romance".equals(book.getGenre()) ? "selected" : "" %>>Romance</option>
        <option value="Horror" <%= "Horror".equals(book.getGenre()) ? "selected" : "" %>>Horror</option>
        <option value="Biography" <%= "Biography".equals(book.getGenre()) ? "selected" : "" %>>Biography</option>
    </select>
</div>

        
        <div>
            <a href="admin.jsp"><button type="button" class="cancel-btn">Cancel</button></a>
            <button type="submit" class="submit-btn">Update Book</button>
        </div>
    </form>
</div>
</body>
</html>
