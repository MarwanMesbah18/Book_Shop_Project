<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Clasess.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Book Shop - Add New User</title>
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
    
    /* Original button styles preserved with enhancements */
    .submit-btn {
        background-color: #4CAF50;
        color: white;
        border: none;
        padding: 0.85rem 1.75rem;
        cursor: pointer;
        font-size: 1rem;
        border-radius: var(--border-radius);
        font-weight: 500;
        transition: var(--transition);
    }
    
    .submit-btn:hover {
        background-color: #45a049;
        transform: translateY(-2px);
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }
    
    .cancel-btn {
        background-color: #f44336;
        color: white;
        border: none;
        padding: 0.85rem 1.75rem;
        cursor: pointer;
        font-size: 1rem;
        border-radius: var(--border-radius);
        font-weight: 500;
        transition: var(--transition);
    }
    
    .cancel-btn:hover {
        background-color: #e53935;
        transform: translateY(-2px);
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }
    
    .error-message {
        color: var(--accent-color);
        text-align: center;
        margin: 1.5rem 0;
        padding: 1rem;
        background-color: rgba(231, 76, 60, 0.1);
        border-radius: var(--border-radius);
        font-weight: 500;
    }
    
    /* Verification button styles */
    .verify-btn {
        background-color: var(--secondary-color);
        color: white;
        border: none;
        padding: 0.5rem 1rem;
        cursor: pointer;
        font-size: 0.9rem;
        border-radius: var(--border-radius);
        font-weight: 500;
        transition: var(--transition);
        margin-top: 0.5rem;
    }
    
    .verify-btn:hover {
        background-color: #2980b9;
    }
    
    .phone-input-group {
        display: flex;
        gap: 0.5rem;
    }
    
    .phone-input-group input {
        flex: 1;
    }
    
    .verification-status {
        margin-top: 0.5rem;
        font-size: 0.9rem;
        padding: 0.5rem;
        border-radius: var(--border-radius);
    }
    
    .verified {
        color: var(--success-color);
        background-color: rgba(39, 174, 96, 0.1);
    }
    
    .not-verified {
        color: var(--accent-color);
        background-color: rgba(231, 76, 60, 0.1);
    }
    
    /* Validation message styles */
    .validation-message {
        color: var(--accent-color);
        font-size: 0.8rem;
        margin-top: 0.5rem;
        display: none;
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
        
        .phone-input-group {
            flex-direction: column;
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
    <h1>Add New User</h1>
</div>

<div class="container">
    <h2 class="form-title">User Information</h2>
    <form action="AddUserServlet" method="post" id="userForm">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" class="form-control" required>
        </div>
        
        <div class="form-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" class="form-control" required
                   pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                   title="Please enter a valid email address (e.g., user@example.com)">
            <div id="emailValidation" class="validation-message">Please enter a valid email address</div>
        </div>
        
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" class="form-control" required>
        </div>
        
        <div class="form-group">
            <label for="phoneNumber">Phone Number</label>
            <div class="phone-input-group">
                <input type="tel" id="phoneNumber" name="phoneNumber" class="form-control" required 
                       pattern="^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$"
                       title="Please enter a valid phone number (e.g., 123-456-7890 or +1234567890)">
                <button type="button" id="verifyPhoneBtn" class="verify-btn">Verify Phone</button>
            </div>
            <div id="phoneValidation" class="validation-message">Please enter a valid phone number</div>
            <div id="verificationStatus" class="verification-status not-verified" style="display: none;">
                Phone number not verified
            </div>
            <input type="hidden" id="isPhoneVerified" name="isPhoneVerified" value="false">
        </div>
        
        <div class="form-group">
            <label for="address">Address</label>
            <input type="text" id="address" name="address" class="form-control" required>
        </div>
        
        <div class="form-group">
            <label for="userType">Account Type</label>
            <select id="userType" name="userType" class="form-control select-control" required>
                <option value="user">Regular User</option>
                <option value="admin">Administrator</option>
            </select>
        </div>
        
        <div class="btn-group">
            <a href="admin.jsp"><button type="button" class="cancel-btn">Cancel</button></a>
            <button type="submit" class="submit-btn" id="submitBtn">Add User</button>
        </div>
    </form>
    
    <% if(request.getAttribute("errorMessage") != null) { %>
        <div class="error-message"><%= request.getAttribute("errorMessage") %></div>
    <% } %>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const emailInput = document.getElementById('email');
        const emailValidation = document.getElementById('emailValidation');
        const phoneNumberInput = document.getElementById('phoneNumber');
        const phoneValidation = document.getElementById('phoneValidation');
        const verifyPhoneBtn = document.getElementById('verifyPhoneBtn');
        const verificationStatus = document.getElementById('verificationStatus');
        const isPhoneVerified = document.getElementById('isPhoneVerified');
        const submitBtn = document.getElementById('submitBtn');
        const userForm = document.getElementById('userForm');
        
        // Email validation regex
        function validateEmail(email) {
            const re = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            return re.test(String(email).toLowerCase());
        }
        
        // Phone number validation regex
        function validatePhoneNumber(phone) {
            const re = /^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/;
            return re.test(phone);
        }
        
        // Email validation
        emailInput.addEventListener('input', function() {
            if (emailInput.value.trim() === '') {
                emailValidation.style.display = 'none';
                return;
            }
            
            if (!validateEmail(emailInput.value.trim())) {
                emailValidation.style.display = 'block';
            } else {
                emailValidation.style.display = 'none';
            }
        });
        
        // Phone number validation
        phoneNumberInput.addEventListener('input', function() {
            verificationStatus.style.display = 'none';
            isPhoneVerified.value = 'false';
            
            if (phoneNumberInput.value.trim() === '') {
                phoneValidation.style.display = 'none';
                return;
            }
            
            if (!validatePhoneNumber(phoneNumberInput.value.trim())) {
                phoneValidation.style.display = 'block';
            } else {
                phoneValidation.style.display = 'none';
            }
        });
        
        // Verify phone number button click handler
        verifyPhoneBtn.addEventListener('click', function() {
            const phoneNumber = phoneNumberInput.value.trim();
            
            if (!validatePhoneNumber(phoneNumber)) {
                phoneValidation.style.display = 'block';
                phoneNumberInput.focus();
                return;
            }
            
            // In a real application, you would send an OTP to the phone number here
            // For this example, we'll simulate verification after a delay
            
            verifyPhoneBtn.disabled = true;
            verifyPhoneBtn.textContent = 'Sending OTP...';
            
            // Simulate sending OTP (replace with actual API call)
            setTimeout(function() {
                // Simulate user entering OTP (in real app, you'd prompt the user)
                const otp = prompt('Please enter the 6-digit OTP sent to your phone (for demo, enter 123456):');
                
                if (otp === '123456') {
                    // Successful verification
                    verificationStatus.textContent = 'Phone number verified!';
                    verificationStatus.className = 'verification-status verified';
                    isPhoneVerified.value = 'true';
                    verificationStatus.style.display = 'block';
                    
                    alert('Phone number verified successfully!');
                } else {
                    // Failed verification
                    verificationStatus.textContent = 'Verification failed. Please try again.';
                    verificationStatus.className = 'verification-status not-verified';
                    isPhoneVerified.value = 'false';
                    verificationStatus.style.display = 'block';
                    
                    alert('Invalid OTP. Please try again.');
                }
                
                verifyPhoneBtn.disabled = false;
                verifyPhoneBtn.textContent = 'Verify Phone';
            }, 1500);
        });
        
        // Form submission handler
        userForm.addEventListener('submit', function(e) {
            let isValid = true;
            
            // Validate email
            if (!validateEmail(emailInput.value.trim())) {
                emailValidation.style.display = 'block';
                isValid = false;
            }
            
            // Validate phone number
            if (!validatePhoneNumber(phoneNumberInput.value.trim())) {
                phoneValidation.style.display = 'block';
                isValid = false;
            }
            
            // Check phone verification
            if (isPhoneVerified.value === 'false') {
                alert('Please verify your phone number before submitting the form.');
                verifyPhoneBtn.scrollIntoView({ behavior: 'smooth' });
                isValid = false;
            }
            
            if (!isValid) {
                e.preventDefault();
            }
        });
    });
</script>
</body>
</html>