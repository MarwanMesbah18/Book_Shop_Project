<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Clasess.User, Clasess.Books, Clasess.DB, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
    .form-group {
        margin-bottom: 15px;
    }
    .form-group label {
        display: block;
        margin-bottom: 5px;
    }
    .form-group input, .form-group select {
        width: 100%;
        padding: 8px;
        box-sizing: border-box;
        border: 1px solid #ddd;
        border-radius: 3px;
    }
    .submit-btn {
        background-color: #4CAF50;
        color: white;
        border: none;
        padding: 10px 15px;
        cursor: pointer;
        font-size: 16px;
        border-radius: 3px;
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
    .search-container {
        margin: 20px 0;
        display: flex;
    }
    .search-input {
        flex: 1;
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 3px;
    }
    .search-btn {
        background-color: #555;
        color: white;
        border: none;
        padding: 8px 15px;
        cursor: pointer;
        margin-left: 5px;
    }
    @media screen and (max-width: 768px) {
        .tabs {
            flex-direction: column;
        }
        .tab {
            margin-right: 0;
            margin-bottom: 5px;
        }
    }
    .add-btn {
        background-color: #4CAF50;
        color: white;
        padding: 8px 15px;
        text-decoration: none;
        border-radius: 3px;
        display: inline-block;
        margin-bottom: 20px;
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
    
    // Get search parameters
    String bookSearch = request.getParameter("bookSearch");
    if (bookSearch == null) bookSearch = "";
    
    String userSearch = request.getParameter("userSearch");
    if (userSearch == null) userSearch = "";
%>

<div class="header">
    <h1>Admin Panel</h1>
    <div>
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
        
        <!-- Search books -->
        <div class="search-container">
            <input type="text" id="bookSearchInput" class="search-input" placeholder="Search books..." 
                   value="<%= bookSearch %>" oninput="filterBooks()">
            <button class="search-btn" onclick="filterBooks()">Search</button>
        </div>
        
        <div>
            <a href="add_book.jsp" class="add-btn">Add New Book</a>
        </div>
        
        <h3>Current Books</h3>
        <table id="booksTable">
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
                    <form action="DeleteBookServlet" method="post" style="display:inline;" 
                          onsubmit="return confirmDelete('book', '<%= book.getName() %>')">
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
        
        <!-- Search users -->
        <div class="search-container">
            <input type="text" id="userSearchInput" class="search-input" placeholder="Search users..." 
                   value="<%= userSearch %>" oninput="filterUsers()">
            <button class="search-btn" onclick="filterUsers()">Search</button>
        </div>
        
        <div>
            <a href="add_user.jsp" class="add-btn">Add New User</a>
        </div>
        
        <table id="usersTable">
            <tr>
                <th>Username</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Address</th>
                <th>User Type</th>
                <th>Actions</th>
            </tr>
            <% 
            List<User> usersList = DB.getAllUsers();
            if(usersList != null && !usersList.isEmpty()) {
                for(User u : usersList) {
            %>
            <tr>
                <td><%= u.getUsername() %></td>
                <td><%= u.getEmail() %></td>
                <td><%= u.getPhoneNumber() %></td>
                <td><%= u.getAddress() %></td>
                <td><%= u.getUserType() %></td>
                <td>
                    <form action="EditUserServlet" method="get" style="display:inline;">
                        <input type="hidden" name="username" value="<%= u.getUsername() %>">
                        <button type="submit" class="action-btn">Edit</button>
                    </form>
                    <form action="DeleteUserServlet" method="post" style="display:inline;" 
                          onsubmit="return confirmDelete('user', '<%= u.getUsername() %>')">
                        <input type="hidden" name="username" value="<%= u.getUsername() %>">
                        <button type="submit" class="action-btn delete-btn"
                               <%= u.getUsername().equals(user.getUsername()) ? "disabled title='Cannot delete yourself'" : "" %>
                        >Delete</button>
                    </form>
                </td>
            </tr>
            <% }
            } else { %>
            <tr>
                <td colspan="6">No users available.</td>
            </tr>
            <% } %>
        </table>
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

function confirmDelete(type, name) {
    return confirm("Are you sure you want to delete this " + type + ": " + name + "?");
}

function filterBooks() {
    var input = document.getElementById("bookSearchInput");
    var filter = input.value.toUpperCase();
    var table = document.getElementById("booksTable");
    var tr = table.getElementsByTagName("tr");
    
    for (var i = 1; i < tr.length; i++) {
        var tdTitle = tr[i].getElementsByTagName("td")[0];
        var tdAuthor = tr[i].getElementsByTagName("td")[1];
        var tdGenre = tr[i].getElementsByTagName("td")[4];
        
        if (tdTitle && tdAuthor && tdGenre) {
            var titleText = tdTitle.textContent || tdTitle.innerText;
            var authorText = tdAuthor.textContent || tdAuthor.innerText;
            var genreText = tdGenre.textContent || tdGenre.innerText;
            
            if (titleText.toUpperCase().indexOf(filter) > -1 || 
                authorText.toUpperCase().indexOf(filter) > -1 ||
                genreText.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }
    }
}

function filterUsers() {
    var input = document.getElementById("userSearchInput");
    var filter = input.value.toUpperCase();
    var table = document.getElementById("usersTable");
    var tr = table.getElementsByTagName("tr");
    
    for (var i = 1; i < tr.length; i++) {
        var tdUsername = tr[i].getElementsByTagName("td")[0];
        var tdEmail = tr[i].getElementsByTagName("td")[1];
        
        if (tdUsername && tdEmail) {
            var usernameText = tdUsername.textContent || tdUsername.innerText;
            var emailText = tdEmail.textContent || tdEmail.innerText;
            
            if (usernameText.toUpperCase().indexOf(filter) > -1 || 
                emailText.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }
    }
}
</script>

</body>
</html>
