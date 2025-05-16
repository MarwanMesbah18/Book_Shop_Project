<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Clasess.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Book Shop - Add New Book</title>
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
        padding: 1.5rem 2rem;
        box-shadow: var(--box-shadow);
        text-align: center;
        position: relative;
    }
    
    .header h1 {
        font-size: 1.8rem;
        font-weight: 600;
        letter-spacing: 0.5px;
    }
    
    .back-link {
        position: absolute;
        left: 2rem;
        top: 50%;
        transform: translateY(-50%);
        color: white;
        text-decoration: none;
        font-weight: 500;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }
    
    .container {
        max-width: 700px;
        margin: 2rem auto;
        padding: 2rem;
        background-color: white;
        border-radius: var(--border-radius);
        box-shadow: var(--box-shadow);
    }
    
    .form-title {
        font-size: 1.5rem;
        color: var(--primary-color);
        margin-bottom: 1.5rem;
        padding-bottom: 0.5rem;
        border-bottom: 2px solid var(--secondary-color);
    }
    
    .form-group {
        margin-bottom: 1.5rem;
    }
    
    .form-group label {
        display: block;
        margin-bottom: 0.75rem;
        font-weight: 500;
        color: var(--primary-color);
        font-size: 0.95rem;
    }
    
    .form-control {
        width: 100%;
        padding: 0.85rem 1.25rem;
        font-size: 1rem;
        border: 1px solid #e0e0e0;
        border-radius: var(--border-radius);
        transition: var(--transition);
        background-color: var(--light-gray);
    }
    
    .form-control:focus {
        border-color: var(--secondary-color);
        outline: none;
        box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
        background-color: white;
    }
    
    .select-control {
        appearance: none;
        background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
        background-repeat: no-repeat;
        background-position: right 1rem center;
        background-size: 1em;
    }
    
    .btn-group {
        display: flex;
        justify-content: flex-end;
        gap: 1rem;
        margin-top: 2rem;
    }
    
    /* Original button styles preserved */
    .submit-btn {
        background-color: #4CAF50;
        color: white;
        border: none;
        padding: 10px 15px;
        cursor: pointer;
        font-size: 16px;
        border-radius: var(--border-radius);
        transition: var(--transition);
    }
    
    .submit-btn:hover {
        background-color: #45a049;
        transform: translateY(-2px);
    }
    
    .cancel-btn {
        background-color: #f44336;
        color: white;
        border: none;
        padding: 10px 15px;
        cursor: pointer;
        font-size: 16px;
        border-radius: var(--border-radius);
        transition: var(--transition);
    }
    
    .cancel-btn:hover {
        background-color: #e53935;
        transform: translateY(-2px);
    }
    
    .error-message {
        color: var(--accent-color);
        text-align: center;
        margin: 1.5rem 0;
        padding: 1rem;
        background-color: rgba(231, 76, 60, 0.1);
        border-radius: var(--border-radius);
    }
    
    /* Responsive adjustments */
    @media (max-width: 768px) {
        .container {
            padding: 1.5rem;
            margin: 1.5rem;
        }
        
        .header {
            padding: 1.25rem;
        }
        
        .header h1 {
            font-size: 1.5rem;
        }
        
        .back-link {
            position: static;
            transform: none;
            margin-bottom: 1rem;
            justify-content: center;
        }
        
        .btn-group {
            flex-direction: column;
        }
        
        .cancel-btn, .submit-btn {
            width: 100%;
        }
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
%>

<div class="header">
    <a href="admin.jsp" class="back-link">
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <line x1="19" y1="12" x2="5" y2="12"></line>
            <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
        Back to Admin
    </a>
    <h1>Add New Book</h1>
</div>

<div class="container">
    <h2 class="form-title">Book Details</h2>
    <form action="AddBookServlet" method="post">
        <div class="form-group">
            <label for="name">Book Title</label>
            <input type="text" id="name" name="name" class="form-control" required>
        </div>
        
        <div class="form-group">
            <label for="author">Author</label>
            <input type="text" id="author" name="author" class="form-control" required>
        </div>
        
        <div class="form-group">
            <label for="price">Price ($)</label>
            <input type="number" id="price" name="price" class="form-control" 
                   step="0.01" min="0" required>
        </div>
        
        <div class="form-group">
            <label for="quantity">Stock Quantity</label>
            <input type="number" id="quantity" name="quantity" class="form-control" 
                   min="0" required>
        </div>
        
        <div class="form-group">
            <label for="genre">Genre</label>
            <select id="genre" name="genre" class="form-control select-control" required>
                <option value="">Select a Genre</option>
                <option value="Fiction">Fiction</option>
                <option value="Fantasy">Fantasy</option>
                <option value="Classic">Classic</option>
                <option value="Mystery">Mystery</option>
                <option value="Adventure">Adventure</option>
                <option value="Non-Fiction">Non-Fiction</option>
                <option value="Science Fiction">Science Fiction</option>
                <option value="Romance">Romance</option>
                <option value="Horror">Horror</option>
                <option value="Biography">Biography</option>
            </select>
        </div>
        
        <div class="btn-group">
            <a href="admin.jsp"><button type="button" class="cancel-btn">Cancel</button></a>
            <button type="submit" class="submit-btn">Add Book</button>
        </div>
    </form>
    
    <% if(request.getAttribute("errorMessage") != null) { %>
        <div class="error-message"><%= request.getAttribute("errorMessage") %></div>
    <% } %>
</div>
</body>
</html>