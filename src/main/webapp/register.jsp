<!-- filepath: /home/mesbah/Desktop/JAVAEE/Book_Shop/src/main/webapp/register.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Shop - Register</title>
<style>
    body {
        font-family: Arial, sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        background-color: #f4f4f4;
        margin: 0;
    }
    .register-form {
        background: white;
        padding: 30px;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
        width: 400px;
    }
    .register-form h2 {
        text-align: center;
        color: #333;
        margin-bottom: 20px;
    }
    input {
        width: 100%;
        padding: 10px;
        margin: 10px 0;
        box-sizing: border-box;
        border: 1px solid #ddd;
        border-radius: 3px;
    }
    input[type="submit"] {
        background-color: #4CAF50;
        color: white;
        cursor: pointer;
        font-weight: bold;
        border: none;
        padding: 12px;
    }
    input[type="submit"]:hover {
        background-color: #45a049;
    }
    .login-link {
        text-align: center;
        margin-top: 20px;
    }
    .error {
        color: red;
        text-align: center;
        margin-top: 10px;
    }
</style>
</head>
<body>
    <div class="register-form">
        <h2>Create an Account</h2>
        <form action="RegisterServlet" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
            
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
            
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
            
            <label for="phoneNumber">Phone Number:</label>
            <input type="text" id="phoneNumber" name="phoneNumber" required>
            
            <label for="address">Address:</label>
            <input type="text" id="address" name="address" required>
            
            <input type="hidden" name="userType" value="user">
            
            <input type="submit" value="Register">
        </form>
        
        <% if(request.getAttribute("errorMessage") != null) { %>
            <p class="error"><%= request.getAttribute("errorMessage") %></p>
        <% } %>
        
        <p class="login-link">
            Already have an account? <a href="login.jsp">Login here</a>
        </p>
    </div>
</body>
</html>