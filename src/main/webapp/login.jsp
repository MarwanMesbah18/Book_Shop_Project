<!-- filepath: /home/mesbah/Desktop/JAVAEE/Book_Shop/src/main/webapp/login.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Shop - Login</title>
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
    .login-form {
        background: white;
        padding: 30px;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
        width: 350px;
    }
    .login-form h2 {
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
    .register-link {
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
    <div class="login-form">
        <h2>Book Shop Login</h2>
        <form action="LoginServlet" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
            
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
            
            <input type="submit" value="Login">
        </form>
        
        <% if(request.getAttribute("errorMessage") != null) { %>
            <p class="error"><%= request.getAttribute("errorMessage") %></p>
        <% } %>
        
        <p class="register-link">
            Don't have an account? <a href="register.jsp">Register here</a>
        </p>
    </div>
</body>
</html>