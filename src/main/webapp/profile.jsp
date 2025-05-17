<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Clasess.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Shop - My Profile</title>
<style>
    :root {
        --primary-color: #2c3e50;
        --secondary-color: #3498db;
        --accent-color: #e74c3c;
        --light-gray: #ecf0f1;
        --dark-gray: #7f8c8d;
        --success-color: #27ae60;
    }
    
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }
    
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f4f4f4;
    }
    
    .header {
        background-color: var(--primary-color);
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
    
    .profile-section {
        display: flex;
        flex-direction: column;
        gap: 20px;
    }
    
    .profile-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }
    
    .profile-title {
        font-size: 24px;
        color: var(--primary-color);
    }
    
    .edit-btn {
        background-color: var(--secondary-color);
        color: white;
        border: none;
        padding: 10px 15px;
        border-radius: 4px;
        cursor: pointer;
        text-decoration: none;
        font-weight: 500;
        display: inline-block;
    }
    
    .profile-details {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 15px;
    }
    
    .detail-item {
        padding: 10px;
        background-color: var(--light-gray);
        border-radius: 4px;
    }
    
    .detail-label {
        font-weight: bold;
        color: var(--dark-gray);
        margin-bottom: 5px;
    }
    
    .detail-value {
        color: var(--primary-color);
        font-size: 18px;
    }
    
    .form-group {
        margin-bottom: 15px;
    }
    
    .form-group label {
        display: block;
        margin-bottom: 5px;
        font-weight: 500;
    }
    
    .form-group input {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 16px;
    }
    
    .button-group {
        display: flex;
        gap: 10px;
        margin-top: 20px;
    }
    
    .save-btn {
        background-color: #4CAF50;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
    }
    
    .cancel-btn {
        background-color: #f44336;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 4px;
        cursor: pointer;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
    }
    
    .back-link {
        display: inline-block;
        margin-top: 20px;
        color: var(--secondary-color);
        text-decoration: none;
    }
    
    .message {
        padding: 10px;
        margin-bottom: 20px;
        border-radius: 4px;
    }
    
    .success-message {
        background-color: rgba(39, 174, 96, 0.1);
        color: var(--success-color);
        border: 1px solid var(--success-color);
    }
    
    .error-message {
        background-color: rgba(231, 76, 60, 0.1);
        color: var(--accent-color);
        border: 1px solid var(--accent-color);
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
    
    boolean editMode = "edit".equals(request.getParameter("mode"));
    boolean updated = "true".equals(request.getParameter("updated"));
    boolean error = "true".equals(request.getParameter("error"));
%>

<div class="header">
    <h1>My Profile</h1>
    <a href="home.jsp" style="color: white; text-decoration: none;">Back to Home</a>
</div>

<div class="container">
    <% if (updated) { %>
        <div class="message success-message">
            Profile updated successfully!
        </div>
    <% } else if (error) { %>
        <div class="message error-message">
            Failed to update profile. Please try again.
        </div>
    <% } %>

    <% if (!editMode) { %>
        <!-- View Mode -->
        <div class="profile-section">
            <div class="profile-header">
                <h2 class="profile-title">Profile Information</h2>
                <a href="profile.jsp?mode=edit" class="edit-btn">Edit Profile</a>
            </div>
            
            <div class="profile-details">
                <div class="detail-item">
                    <div class="detail-label">Username</div>
                    <div class="detail-value"><%= user.getUsername() %></div>
                </div>
                
                <div class="detail-item">
                    <div class="detail-label">Email</div>
                    <div class="detail-value"><%= user.getEmail() %></div>
                </div>
                
                <div class="detail-item">
                    <div class="detail-label">Phone Number</div>
                    <div class="detail-value"><%= user.getPhoneNumber() %></div>
                </div>
                
                <div class="detail-item">
                    <div class="detail-label">Address</div>
                    <div class="detail-value"><%= user.getAddress() %></div>
                </div>
            </div>
        </div>
    <% } else { %>
        <!-- Edit Mode -->
			<form action="EditProfileServlet" method="post" id="editProfileForm">
            <h2 class="profile-title">Edit Profile</h2>
            
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" value="<%= user.getUsername() %>" readonly>
                <small style="color: var(--dark-gray);">(Username cannot be changed)</small>
            </div>
            
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required>
            </div>
            
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" value="<%= user.getPassword() %>" required>
            </div>
            
            <div class="form-group">
                <label for="phoneNumber">Phone Number:</label>
                <input type="text" id="phoneNumber" name="phoneNumber" value="<%= user.getPhoneNumber() %>" required pattern="[0-9]+" title="Please enter only numbers">
            </div>
            
            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" value="<%= user.getAddress() %>" required>
            </div>
            
            <input type="hidden" name="userType" value="<%= user.getUserType() %>">
            
            <div class="button-group">
                <a href="profile.jsp" class="cancel-btn">Cancel</a>
                <button type="submit" class="save-btn">Save Changes</button>
            </div>
        </form>
    <% } %>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Auto-hide messages after 5 seconds
        setTimeout(function() {
            var messages = document.querySelectorAll('.message');
            messages.forEach(function(message) {
                message.style.display = 'none';
            });
        }, 5000);
        
        // Form validation
        var form = document.getElementById('editProfileForm');
        if (form) {
            form.addEventListener('submit', function(event) {
                var email = document.getElementById('email').value;
                var password = document.getElementById('password').value;
                var phone = document.getElementById('phoneNumber').value;
                
                if (!email.match(/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/)) {
                    alert('Please enter a valid email address');
                    event.preventDefault();
                    return;
                }
                
                if (password.length < 6) {
                    alert('Password must be at least 6 characters long');
                    event.preventDefault();
                    return;
                }
                
                if (!phone.match(/^[0-9]+$/)) {
                    alert('Phone number must contain only numbers');
                    event.preventDefault();
                    return;
                }
            });
        }
    });
</script>
</body>
</html>
