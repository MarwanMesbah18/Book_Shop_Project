<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Shop - Login</title>
<style>
    :root {
        --primary-color: #2c3e50;
        --secondary-color: #3498db;
        --accent-color: #e74c3c;
        --light-gray: #ecf0f1;
        --dark-gray: #7f8c8d;
    }
    
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }
    
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        padding: 20px;
    }
    
    .login-form {
        background: white;
        padding: 40px;
        border-radius: 12px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 400px;
        transition: transform 0.3s ease;
    }
    
    .login-form:hover {
        transform: translateY(-5px);
    }
    
    .login-form h2 {
        text-align: center;
        color: var(--primary-color);
        margin-bottom: 30px;
        font-size: 28px;
        font-weight: 600;
    }
    
    .form-group {
        margin-bottom: 20px;
        position: relative;
    }
    
    .form-group label {
        display: block;
        margin-bottom: 8px;
        color: var(--primary-color);
        font-weight: 500;
    }
    
    .form-group input {
        width: 100%;
        padding: 12px 15px;
        border: 2px solid #ddd;
        border-radius: 8px;
        font-size: 16px;
        transition: all 0.3s;
    }
    
    .form-group input:focus {
        border-color: var(--secondary-color);
        outline: none;
        box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
    }
    
    .form-group input::placeholder {
        color: var(--dark-gray);
        opacity: 0.7;
    }
    
    .login-btn {
        width: 100%;
        padding: 14px;
        background-color: var(--primary-color);
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: background-color 0.3s;
        margin-top: 10px;
    }
    
    .login-btn:hover {
        background-color: green;
    }
    
    .error {
        color: var(--accent-color);
        text-align: center;
        margin: 15px 0;
        font-size: 14px;
        padding: 10px;
        background-color: rgba(231, 76, 60, 0.1);
        border-radius: 6px;
    }
    
    .register-link {
        text-align: center;
        margin-top: 25px;
        color: var(--dark-gray);
        font-size: 14px;
    }
    
    .register-link a {
        color: var(--secondary-color);
        text-decoration: none;
        font-weight: 500;
        transition: color 0.2s;
    }
    
    .register-link a:hover {
        color: #2980b9;
        text-decoration: underline;
    }
    
    /* Decorative elements */
    .book-icon {
        display: block;
        text-align: center;
        margin-bottom: 20px;
        font-size: 40px;
        color: var(--primary-color);
    }
</style>
</head>
<body>
    <div class="login-form">
        <div class="book-icon">📚</div>
        <h2>Book Shop Login</h2>
        <form action="LoginServlet" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" placeholder="Enter your username" required>
            </div>
            
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
            </div>
            
            <button type="submit" class="login-btn">Login</button>
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