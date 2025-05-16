<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Clasess.User, Clasess.Books, Clasess.DB, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Book Shop - Admin Panel</title>
<style>
    :root {
        --primary-color: #2c3e50;
        --secondary-color: #3498db;
        --accent-color: #e74c3c;
        --success-color: #27ae60;
        --light-gray: #f8f9fa;
        --dark-gray: #6c757d;
        --border-radius: 8px;
        --box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        --transition: all 0.3s ease;
    }
    
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }
    
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f5f7fa;
        color: #333;
        line-height: 1.6;
    }
    
    .header {
        background: linear-gradient(135deg, var(--primary-color) 0%, #1a252f 100%);
        color: white;
        padding: 1.25rem 2rem;
        box-shadow: var(--box-shadow);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .header h1 {
        font-size: 1.5rem;
        font-weight: 600;
    }
    
    .container {
        max-width: 1200px;
        margin: 2rem auto;
        padding: 0 1.5rem;
    }
    
    .tabs {
        display: flex;
        margin-bottom: 1.5rem;
        border-bottom: 1px solid #e0e0e0;
    }
    
    .tab {
        padding: 0.75rem 1.5rem;
        cursor: pointer;
        font-weight: 500;
        color: var(--dark-gray);
        border-bottom: 3px solid transparent;
        transition: var(--transition);
    }
    
    .tab.active {
        color: var(--primary-color);
        border-bottom-color: var(--secondary-color);
    }
    
    .tab:hover:not(.active) {
        color: var(--primary-color);
    }
    
    .tab-content {
        display: none;
        background-color: white;
        border-radius: var(--border-radius);
        box-shadow: var(--box-shadow);
        padding: 1.5rem;
    }
    
    .tab-content.active {
        display: block;
    }
    
    .search-container {
        display: flex;
        margin-bottom: 1.5rem;
    }
    
    .search-input {
        flex: 1;
        padding: 0.75rem 1rem;
        border: 1px solid #e0e0e0;
        border-radius: var(--border-radius) 0 0 var(--border-radius);
        font-size: 1rem;
        transition: var(--transition);
    }
    
    .search-input:focus {
        outline: none;
        border-color: var(--secondary-color);
        box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
    }
    
    .search-btn {
        background-color: var(--primary-color);
        color: white;
        border: none;
        padding: 0 1.5rem;
        border-radius: 0 var(--border-radius) var(--border-radius) 0;
        cursor: pointer;
        transition: var(--transition);
    }
    
    .search-btn:hover {
        background-color: #1a252f;
    }
    
    .add-btn {
        background-color: var(--success-color);
        color: white;
        padding: 0.75rem 1.5rem;
        text-decoration: none;
        border-radius: var(--border-radius);
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        margin-bottom: 1.5rem;
        font-weight: 500;
        transition: var(--transition);
    }
    
    .add-btn:hover {
        background-color: #219653;
        transform: translateY(-2px);
    }
    
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 1rem;
    }
    
    th, td {
        padding: 1rem;
        text-align: left;
        border-bottom: 1px solid #e0e0e0;
    }
    
    th {
        background-color: var(--primary-color);
        color: white;
        font-weight: 500;
    }
    
    tr:hover {
        background-color: var(--light-gray);
    }
    
    .action-btn {
        padding: 0.5rem 1rem;
        border: none;
        border-radius: var(--border-radius);
        cursor: pointer;
        font-weight: 500;
        transition: var(--transition);
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
    }
    
    .edit-btn {
        background-color: var(--secondary-color);
        color: white;
    }
    
    .edit-btn:hover {
        background-color: #2980b9;
    }
    
    .delete-btn {
        background-color: var(--accent-color);
        color: white;
    }
    
    .delete-btn:hover {
        background-color: #c0392b;
    }
    
    .logout-btn {
        background: none;
        border: none;
        color: white;
        cursor: pointer;
        font-size: 1rem;
        font-weight: 500;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }
    
    .btn-icon {
        width: 1rem;
        height: 1rem;
    }
    
    .no-data {
        text-align: center;
        padding: 2rem;
        color: var(--dark-gray);
    }
    
    @media (max-width: 768px) {
        .container {
            padding: 0 1rem;
        }
        
        .tabs {
            flex-direction: column;
            border-bottom: none;
        }
        
        .tab {
            border-bottom: 1px solid #e0e0e0;
            border-left: 3px solid transparent;
        }
        
        .tab.active {
            border-left-color: var(--secondary-color);
            border-bottom-color: #e0e0e0;
        }
        
        th, td {
            padding: 0.75rem;
        }
        
        .action-btn {
            padding: 0.5rem;
        }
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
    
    List<Books> booksList = DB.getAllBooks();
    String bookSearch = request.getParameter("bookSearch");
    if (bookSearch == null) bookSearch = "";
    
    String userSearch = request.getParameter("userSearch");
    if (userSearch == null) userSearch = "";
%>

<div class="header">
    <h1>Admin Dashboard</h1>
    <form class="logout-form" action="LogoutServlet" method="post">
        <button type="submit" class="logout-btn">
            <svg class="btn-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                <polyline points="16 17 21 12 16 7"></polyline>
                <line x1="21" y1="12" x2="9" y2="12"></line>
            </svg>
            Logout
        </button>
    </form>
</div>

<div class="container">
    <div class="tabs">
        <div class="tab active" onclick="showTab('books')">Books Management</div>
        <div class="tab" onclick="showTab('users')">Users Management</div>
    </div>

    <div id="books-tab" class="tab-content active">
        <h2>Books Management</h2>
        
        <div class="search-container">
            <input type="text" id="bookSearchInput" class="search-input" placeholder="Search books..." 
                   value="<%= bookSearch %>" oninput="filterBooks()">
            <button class="search-btn" onclick="filterBooks()">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="11" cy="11" r="8"></circle>
                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                </svg>
            </button>
        </div>
        
        <a href="add_book.jsp" class="add-btn">
            <svg class="btn-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <line x1="12" y1="5" x2="12" y2="19"></line>
                <line x1="5" y1="12" x2="19" y2="12"></line>
            </svg>
            Add New Book
        </a>
        
        <table id="booksTable">
            <thead>
                <tr>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Genre</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
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
                            <button type="submit" class="action-btn edit-btn">
                                <svg class="btn-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                                    <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                                </svg>
                                Edit
                            </button>
                        </form>
                        <form action="DeleteBookServlet" method="post" style="display:inline;" 
                              onsubmit="return confirmDelete('book', '<%= book.getName() %>')">
                            <input type="hidden" name="bookName" value="<%= book.getName() %>">
                            <button type="submit" class="action-btn delete-btn">
                                <svg class="btn-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <polyline points="3 6 5 6 21 6"></polyline>
                                    <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                                    <line x1="10" y1="11" x2="10" y2="17"></line>
                                    <line x1="14" y1="11" x2="14" y2="17"></line>
                                </svg>
                                Delete
                            </button>
                        </form>
                    </td>
                </tr>
                <% }
                   } else { %>
                <tr>
                    <td colspan="6" class="no-data">No books available</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    
    <div id="users-tab" class="tab-content">
        <h2>Users Management</h2>
        
        <div class="search-container">
            <input type="text" id="userSearchInput" class="search-input" placeholder="Search users..." 
                   value="<%= userSearch %>" oninput="filterUsers()">
            <button class="search-btn" onclick="filterUsers()">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="11" cy="11" r="8"></circle>
                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                </svg>
            </button>
        </div>
        
        <a href="add_user.jsp" class="add-btn">
            <svg class="btn-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <line x1="12" y1="5" x2="12" y2="19"></line>
                <line x1="5" y1="12" x2="19" y2="12"></line>
            </svg>
            Add New User
        </a>
        
        <table id="usersTable">
            <thead>
                <tr>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Address</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
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
                            <button type="submit" class="action-btn edit-btn">
                                <svg class="btn-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                                    <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                                </svg>
                                Edit
                            </button>
                        </form>
                        <form action="DeleteUserServlet" method="post" style="display:inline;" 
                              onsubmit="return confirmDelete('user', '<%= u.getUsername() %>')">
                            <input type="hidden" name="username" value="<%= u.getUsername() %>">
                            <button type="submit" class="action-btn delete-btn"
                                   <%= u.getUsername().equals(user.getUsername()) ? "disabled title='Cannot delete yourself'" : "" %>>
                                <svg class="btn-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <polyline points="3 6 5 6 21 6"></polyline>
                                    <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                                    <line x1="10" y1="11" x2="10" y2="17"></line>
                                    <line x1="14" y1="11" x2="14" y2="17"></line>
                                </svg>
                                Delete
                            </button>
                        </form>
                    </td>
                </tr>
                <% }
                } else { %>
                <tr>
                    <td colspan="6" class="no-data">No users available</td>
                </tr>
                <% } %>
            </tbody>
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