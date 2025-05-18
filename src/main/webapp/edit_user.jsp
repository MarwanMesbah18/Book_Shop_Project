<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Clasess.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Shop - Edit User</title>
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
    .form-group input, .form-group select {
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
    User admin = (User) session.getAttribute("user");
    if (admin == null || !"admin".equals(admin.getUserType())) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    User editUser = (User) request.getAttribute("editUser");
    if (editUser == null) {
        response.sendRedirect("admin.jsp");
        return;
    }
%>

<div class="header">
    <h1>Edit User</h1>
</div>

<div class="container">
	 <% if(request.getAttribute("errorMessage") != null) { %>
        <div style="background-color: #f8d7da; color: #721c24; padding: 10px; border-radius: 4px; margin-bottom: 15px;">
            <%= request.getAttribute("errorMessage") %>
        </div>
    <% } %>
    <form action="EditUserServlet" method="post">
        <input type="hidden" name="originalUsername" value="<%= editUser.getUsername() %>">
        
        <div class="form-group">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" value="<%= editUser.getUsername() %>" required>
        </div>
        
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="<%= editUser.getEmail() %>" required>
        </div>
        
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" value="<%= editUser.getPassword() %>" required>
        </div>
        
        <div class="form-group">
            <label for="phoneNumber">Phone Number:</label>
            <input type="text" id="phoneNumber" name="phoneNumber" value="<%= editUser.getPhoneNumber() %>" required>
        </div>
        
        <div class="form-group">
            <label for="address">Address:</label>
            <input type="text" id="address" name="address" value="<%= editUser.getAddress() %>" required>
        </div>
        
        <div class="form-group">
            <label for="userType">User Type:</label>
            <select id="userType" name="userType" required>
                <option value="user" <%= "user".equals(editUser.getUserType()) ? "selected" : "" %>>User</option>
                <option value="admin" <%= "admin".equals(editUser.getUserType()) ? "selected" : "" %>>Admin</option>
            </select>
        </div>
        
        <div>
            <a href="admin.jsp"><button type="button" class="cancel-btn">Cancel</button></a>
            <button type="submit" class="submit-btn">Update User</button>
        </div>
    </form>
</div>
</body>
</html>
