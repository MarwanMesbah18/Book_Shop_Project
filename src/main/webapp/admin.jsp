<!-- filepath: /home/mesbah/Desktop/JAVAEE/Book_Shop/src/main/webapp/admin.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Clasess.User, Clasess.Books, Clasess.DB, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Shop - Admin Panel</title>
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
        max-width: 1200px;
        margin: 20px auto;
        padding: 0 20px;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    table, th, td {
        border: 1px solid #ddd;
    }
    th, td {
        padding: 12px;
        text-align: left;
    }
    th {
        background-color: #333;
        color: white;
    }
    tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    .action-btn {
        background-color: #4CAF50;
        color: white;
        border: none;
        padding: 6px 10px;
        cursor: pointer;
        border-radius: 3px;
        margin-right: 5px;
    }
    .delete-btn {
        background-color: #f44336;
    }
    .action-btn:hover {
        opacity: 0.8;
    }
    .add-form {
        background-color: white;
        padding: 20px;
        border-radius: 5px;
        margin-top: 20px;
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
    .tabs {
        display: flex;
        margin-bottom: 20px;
    }
    .tab {
        padding: 10px 20px;
        cursor: pointer;
        border: 1px solid #ccc;
        background-color: #f1f1f1;
        margin-right: 5px;
    }
    .tab.active {
        background-color: white;
        border-bottom: none;
    }
    .tab-content {
        display: none;
    }
    .tab-content.active {
        display: block;
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
    if (user == null || !"admin".equals(user.getUserType())) {
        // Not logged in as admin, redirect to login page
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Get all books from database
    List<Books> booksList = DB.getAllBooks();
%>

<div class="header">
    <h1>Admin Panel</h1>
    <div>
        Welcome, <%= user.getUsername() %>! | 
        <form class="logout-form" action="LogoutServlet" method="post">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
    </div>
</div>

<div class="container">
    <div class="tabs">
        <div class="tab active" onclick="showTab('books')">Manage Books</div>
        <div class="tab" onclick="showTab('users')">Manage Users</div>
    </div>

    <div id="books-tab" class="tab-content active">
        <h2>Book Management</h2>
        
        <div class="add-form">
            <h3>Add New Book</h3>
            <form action="AddBookServlet" method="post">
                <div class="form-group">
                    <label for="name">Book Title:</label>
                    <input type="text" id="name" name="name" required>
                </div>
                
                <div class="form-group">
                    <label for="author">Author:</label>
                    <input type="text" id="author" name="author" required>
                </div>
                
                <div class="form-group">
                    <label for="price">Price:</label>
                    <input type="number" id="price" name="price" step="0.01" min="0" required>
                </div>
                
                <div class="form-group">
                    <label for="quantity">Quantity:</label>
                    <input type="number" id="quantity" name="quantity" min="0" required>
                </div>
                
                <div class="form-group">
                    <label for="genre">Genre:</label>
                    <input type="text" id="genre" name="genre" required>
                </div>
                
                <button type="submit" class="submit-btn">Add Book</button>
            </form>
        </div>
        
        <h3>Current Books</h3>
        <table>
            <tr>
                <th>Title</th>
                <th>Author</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Genre</th>
                <th>Actions</th>
            </tr>
            <% if(booksList != null && !booksList.isEmpty()) {
                  for(Books book : booksList) { %>
            <tr>
                <td><%= book.getName() %></td>
                <td><%= book.getAuthor() %></td>
                <td>$<%= String.format("%.2f", book.getPrice()) %></td>
                <td><%= book.getQuantity() %></td>
                <td><%= book.getGenre() %></td>
                <td>
                    <form action="EditBookServlet" method="get" style="display:inline;">
                        <input type="hidden" name="bookName" value="<%= book.getName() %>">
                        <button type="submit" class="action-btn">Edit</button>
                    </form>
                    <form action="DeleteBookServlet" method="post" style="display:inline;">
                        <input type="hidden" name="bookName" value="<%= book.getName() %>">
                        <button type="submit" class="action-btn delete-btn">Delete</button>
                    </form>
                </td>
            </tr>
            <% }
               } else { %>
            <tr>
                <td colspan="6">No books available.</td>
            </tr>
            <% } %>
        </table>
    </div>
    
    <div id="users-tab" class="tab-content">
        <h2>User Management</h2>
        <!-- User management functionality would go here -->
        <p>User management functionality is under development.</p>
    </div>
</div>

<script>
function showTab(tabName) {
    // Hide all tab contents
    var tabContents = document.getElementsByClassName("tab-content");
    for (var i = 0; i < tabContents.length; i++) {
        tabContents[i].classList.remove("active");
    }
    
    // Deactivate all tabs
    var tabs = document.getElementsByClassName("tab");
    for (var i = 0; i < tabs.length; i++) {
        tabs[i].classList.remove("active");
    }
    
    // Show the selected tab content
    document.getElementById(tabName + "-tab").classList.add("active");
    
    // Activate the clicked tab
    event.currentTarget.classList.add("active");
}
</script>

</body>
</html>