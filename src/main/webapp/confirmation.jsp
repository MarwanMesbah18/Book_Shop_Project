<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Clasess.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Shop - Order Confirmation</title>
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
    
    .container {
        max-width: 800px;
        margin: 3rem auto;
        padding: 2rem;
        background-color: white;
        border-radius: var(--border-radius);
        box-shadow: var(--box-shadow);
        text-align: center;
    }
    
    .success-icon {
        color: var(--success-color);
        font-size: 5rem;
        margin-bottom: 1rem;
    }
    
    h1 {
        color: var(--primary-color);
        margin-bottom: 1rem;
    }
    
    p {
        margin-bottom: 1.5rem;
    }
    
    .btn {
        display: inline-block;
        padding: 0.875rem 1.5rem;
        background-color: var(--primary-color);
        color: white;
        text-decoration: none;
        border-radius: var(--border-radius);
        transition: var(--transition);
        font-weight: 500;
    }
    
    .btn:hover {
        background-color: #1a252f;
        transform: translateY(-2px);
    }
</style>
</head>
<body>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<div class="container">
    <div class="success-icon">✓</div>
    <h1>Order Confirmed!</h1>
    <p>Thank you for your purchase, <%= user.getUsername() %>.</p>
    <p>Your order has been received and is being processed.</p>
    <p>We've sent a confirmation email to your registered email address.</p>
    
    <a href="home.jsp" class="btn">Continue Shopping</a>
</div>

</body>
</html>
