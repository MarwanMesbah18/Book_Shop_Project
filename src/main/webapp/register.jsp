<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Shop - Register</title>
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
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        padding: 20px;
    }
    
    .register-form {
        background: white;
        padding: 40px;
        border-radius: 12px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 450px;
        transition: transform 0.3s ease;
    }
    
    .register-form:hover {
        transform: translateY(-5px);
    }
    
    .register-form h2 {
        text-align: center;
        color: var(--primary-color);
        margin-bottom: 25px;
        font-size: 28px;
        font-weight: 600;
        position: relative;
    }
    
    .register-form h2::after {
        content: '';
        display: block;
        width: 60px;
        height: 3px;
        background: var(--secondary-color);
        margin: 10px auto;
        border-radius: 3px;
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
        font-size: 14px;
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
        font-size: 14px;
    }
    
    .register-btn {
        width: 100%;
        padding: 14px;
        background-color: var(--primary-color);
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s;
        margin-top: 10px;
        text-transform: uppercase;
        letter-spacing: 1px;
    }
    
    .register-btn:hover {
        background-color: green;
        transform: translateY(-2px);
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
    
    .login-link {
        text-align: center;
        margin-top: 25px;
        color: var(--dark-gray);
        font-size: 14px;
    }
    
    .login-link a {
        color: var(--secondary-color);
        text-decoration: none;
        font-weight: 500;
        transition: color 0.2s;
    }
    
    .login-link a:hover {
        color: #2980b9;
        text-decoration: underline;
    }
    
    /* Password strength indicator */
    .password-strength {
        height: 4px;
        background: #eee;
        margin-top: 5px;
        border-radius: 2px;
        overflow: hidden;
    }
    
    .strength-bar {
        height: 100%;
        width: 0;
        background: var(--accent-color);
        transition: width 0.3s, background 0.3s;
    }
    
    /* Input icons */
    .input-icon {
        position: absolute;
        right: 15px;
        top: 40px;
        color: var(--dark-gray);
    }
</style>
</head>
<body>
    <div class="register-form">
        <h2>Create an Account</h2>
        <form action="RegisterServlet" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" placeholder="Enter your username" required>
                <i class="input-icon">👤</i>
            </div>
            
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" required>
                <i class="input-icon">✉️</i>
            </div>
            
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Create a password" required>
                <i class="input-icon">🔒</i>
                <div class="password-strength">
                    <div class="strength-bar" id="strengthBar"></div>
                </div>
            </div>
            
            <div class="form-group">
                <label for="phoneNumber">Phone Number</label>
                <input type="text" id="phoneNumber" name="phoneNumber" placeholder="Enter your phone number" required>
                <i class="input-icon">📱</i>
            </div>
            
            <div class="form-group">
                <label for="address">Address</label>
                <input type="text" id="address" name="address" placeholder="Enter your address" required>
                <i class="input-icon">🏠</i>
            </div>
            
            <input type="hidden" name="userType" value="user">
            
            <button type="submit" class="register-btn">Register Now</button>
        </form>
        
        <% if(request.getAttribute("errorMessage") != null) { %>
            <p class="error"><%= request.getAttribute("errorMessage") %></p>
        <% } %>
        
        <p class="login-link">
            Already have an account? <a href="login.jsp">Login here</a>
        </p>
    </div>

    <script>
        // Simple password strength indicator
        document.getElementById('password').addEventListener('input', function(e) {
            const strengthBar = document.getElementById('strengthBar');
            const password = e.target.value;
            let strength = 0;
            
            if (password.length > 0) strength += 20;
            if (password.length >= 8) strength += 30;
            if (/[A-Z]/.test(password)) strength += 20;
            if (/[0-9]/.test(password)) strength += 20;
            if (/[^A-Za-z0-9]/.test(password)) strength += 10;
            
            strengthBar.style.width = strength + '%';
            
            if (strength < 40) {
                strengthBar.style.background = 'var(--accent-color)';
            } else if (strength < 70) {
                strengthBar.style.background = 'orange';
            } else {
                strengthBar.style.background = 'var(--success-color)';
            }
        });
    </script>
</body>
</html>