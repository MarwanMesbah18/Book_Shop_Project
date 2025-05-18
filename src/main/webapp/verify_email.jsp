<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Shop - Email Verification</title>
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
    
    .verification-container {
        background: white;
        padding: 40px;
        border-radius: 12px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 450px;
        text-align: center;
    }
    
    h2 {
        color: var(--primary-color);
        margin-bottom: 20px;
    }
    
    p {
        color: var(--dark-gray);
        margin-bottom: 30px;
        line-height: 1.6;
    }
    
    .code-input {
        display: flex;
        justify-content: center;
        gap: 10px;
        margin-bottom: 30px;
    }
    
    .code-input input {
        width: 50px;
        height: 60px;
        font-size: 24px;
        text-align: center;
        border: 2px solid #ddd;
        border-radius: 8px;
    }
    
    .code-input input:focus {
        border-color: var(--secondary-color);
        outline: none;
        box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
    }
    
    .verify-btn {
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
        margin-bottom: 20px;
    }
    
    .verify-btn:hover {
        background-color: green;
    }
    
    .resend-link {
        color: var(--secondary-color);
        text-decoration: none;
        font-size: 14px;
        display: inline-block;
    }
    
    .resend-link:hover {
        text-decoration: underline;
    }
    
    .disabled {
        color: var(--dark-gray);
        cursor: not-allowed;
        pointer-events: none;
    }
    
    .timer {
        color: var(--dark-gray);
        font-size: 14px;
        margin-left: 5px;
    }
    
    .error, .success {
        padding: 10px;
        border-radius: 8px;
        margin-bottom: 20px;
    }
    
    .error {
        background-color: rgba(231, 76, 60, 0.1);
        color: var(--accent-color);
    }
    
    .success {
        background-color: rgba(39, 174, 96, 0.1);
        color: var(--success-color);
    }
    
    .spam-note {
        font-size: 13px;
        color: var(--dark-gray);
        font-style: italic;
        margin-top: 20px;
    }
    
     .code-input {
        display: flex;
        justify-content: center;
        gap: 10px;
        margin-bottom: 30px;
    }
    
    .code-digit {
        width: 50px;
        height: 60px;
        font-size: 24px;
        text-align: center;
        border: 2px solid #ddd;
        border-radius: 8px;
    }
    
    .code-digit:focus {
        border-color: var(--secondary-color);
        outline: none;
        box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
    }
    
    #timer {
        font-weight: bold;
        color: var(--primary-color);
        font-size: 16px;
    }
    
</style>
</head>
<body>
<%
    Map<String, String> userData = (Map<String, String>) session.getAttribute("pendingUser");
    if (userData == null) {
        response.sendRedirect("register.jsp");
        return;
    }
    String email = userData.get("email");
    
    // Mask the email for privacy
    String maskedEmail = "";
    if (email != null && email.contains("@")) {
        int atIndex = email.indexOf('@');
        String username = email.substring(0, atIndex);
        String domain = email.substring(atIndex);
        
        if (username.length() > 2) {
            maskedEmail = username.substring(0, 2) + "***" + domain;
        } else {
            maskedEmail = username + "***" + domain;
        }
    }
%>

<div class="verification-container">
    <h2>Email Verification</h2>
    
    <% if(request.getAttribute("errorMessage") != null) { %>
        <div class="error">
            <%= request.getAttribute("errorMessage") %>
        </div>
    <% } %>
    
    <% if(request.getAttribute("resendSuccess") != null) { %>
        <div class="success">
            Verification code has been resent to your email.
        </div>
    <% } %>
    
    <p>We've sent a 6-digit verification code to <strong><%= maskedEmail %></strong>. Please enter the code below to verify your email address.</p>
    
    <form action="VerificationCodeServlet" method="post" id="verificationForm">
    <div class="code-input">
        <input type="text" class="code-digit" maxlength="1" pattern="[0-9]" required autocomplete="off">
        <input type="text" class="code-digit" maxlength="1" pattern="[0-9]" required autocomplete="off">
        <input type="text" class="code-digit" maxlength="1" pattern="[0-9]" required autocomplete="off">
        <input type="text" class="code-digit" maxlength="1" pattern="[0-9]" required autocomplete="off">
        <input type="text" class="code-digit" maxlength="1" pattern="[0-9]" required autocomplete="off">
        <input type="text" class="code-digit" maxlength="1" pattern="[0-9]" required autocomplete="off">
        <input type="hidden" name="verificationCode" id="verificationCodeHidden">
    </div>
    
    <button type="submit" class="verify-btn">Verify Email</button>
</form>

<div>
    <a href="#" id="resendLink" class="resend-link disabled">Resend Code</a>
    <span id="timer" class="timer">(00:<span id="countdown">10</span>)</span>
</div>

    
    <p class="spam-note">
        Note: If you don't see the email in your inbox, please check your spam or junk folder.
    </p>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const resendLink = document.getElementById('resendLink');
    const timerSpan = document.getElementById('countdown');
    const codeInputs = document.querySelectorAll('.code-digit');
    const hiddenInput = document.getElementById('verificationCodeHidden');
    const form = document.getElementById('verificationForm');
    
    // Check if there's a saved timer value in session storage
    let seconds = sessionStorage.getItem('verificationTimer') || 10;
    
    // Set initial state
    resendLink.classList.add('disabled');
    // Don't use leading zeros for the initial display if it's 10
    timerSpan.textContent = seconds;
    
    // Start countdown timer
    const timer = setInterval(() => {
        seconds--;
        // Simply display the number without formatting
        timerSpan.textContent = seconds;
        sessionStorage.setItem('verificationTimer', seconds);
        
        if (seconds <= 0) {
            clearInterval(timer);
            resendLink.classList.remove('disabled');
            resendLink.href = 'VerificationCodeServlet';
            sessionStorage.removeItem('verificationTimer');
        }
    }, 1000);
    
    
    // Handle digit input boxes
    codeInputs.forEach((input, index) => {
        // Auto-focus first input on page load if empty
        if (index === 0 && !input.value) {
            input.focus();
        }
        
        // Restrict to only numbers and control keys
        input.addEventListener('keydown', function(e) {
            const allowedKeys = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 
                                'ArrowLeft', 'ArrowRight', 'Backspace', 'Delete', 'Tab'];
            
            if (!allowedKeys.includes(e.key) && !e.ctrlKey) {
                e.preventDefault();
            }
        });
        
        // Handle input and auto-focus next field
        input.addEventListener('input', function(e) {
            // Replace any non-numeric value
            this.value = this.value.replace(/[^0-9]/g, '');
            
            // Move to next input on entry
            if (this.value.length === 1) {
                if (index < codeInputs.length - 1) {
                    codeInputs[index + 1].focus();
                } else {
                    // Last digit entered - remove focus to hide mobile keyboard
                    this.blur();
                }
            }
            
            // Update hidden field with complete code
            updateHiddenField();
            
            // Auto-submit if all fields are filled
            if (isCodeComplete()) {
                // Small delay to ensure the final digit is processed
                setTimeout(() => {
                    if (hiddenInput.value.length === 6) {
                        form.submit();
                    }
                }, 300);
            }
        });
        
        // Handle backspace to go to previous field
        input.addEventListener('keydown', function(e) {
            if (e.key === 'Backspace') {
                if (!this.value && index > 0) {
                    codeInputs[index - 1].focus();
                    // Optional: clear the previous field too
                    // codeInputs[index - 1].value = '';
                }
            }
        });
        
        // Handle arrow keys for navigation between inputs
        input.addEventListener('keydown', function(e) {
            if (e.key === 'ArrowLeft' && index > 0) {
                codeInputs[index - 1].focus();
            } else if (e.key === 'ArrowRight' && index < codeInputs.length - 1) {
                codeInputs[index + 1].focus();
            }
        });
    });
    
    // Update hidden field with the complete verification code
    function updateHiddenField() {
        let code = '';
        codeInputs.forEach(input => {
            code += input.value;
        });
        hiddenInput.value = code;
    }
    
    // Check if all 6 digits are entered
    function isCodeComplete() {
        return Array.from(codeInputs).every(input => input.value.length === 1);
    }
    
    // Form validation
    form.addEventListener('submit', function(e) {
        updateHiddenField();
        if (hiddenInput.value.length !== 6) {
            e.preventDefault();
            alert('Please enter all 6 digits of the verification code');
            codeInputs[0].focus();
        }
    });
    
    // Allow pasting code into any field
    codeInputs.forEach((input, index) => {
        input.addEventListener('paste', function(e) {
            e.preventDefault();
            const pastedText = (e.clipboardData || window.clipboardData).getData('text');
            const digits = pastedText.replace(/\D/g, '').substring(0, 6);
            
            if (digits.length > 0) {
                // Clear all fields first
                codeInputs.forEach(input => input.value = '');
                
                // Fill in the digits
                for (let i = 0; i < Math.min(digits.length, codeInputs.length); i++) {
                    codeInputs[i].value = digits[i];
                }
                
                updateHiddenField();
                
                // Focus appropriate field after paste
                if (digits.length < 6) {
                    codeInputs[digits.length].focus();
                } else {
                    codeInputs[5].blur(); // Remove focus if complete
                    // Auto-submit on complete paste
                    setTimeout(() => form.submit(), 300);
                }
            }
        });
    });
    
    // Handle resend link click
    resendLink.addEventListener('click', function(e) {
        if (this.classList.contains('disabled')) {
            e.preventDefault();
            return false;
        }
        
        // Show loading state
        this.textContent = 'Sending...';
        this.classList.add('disabled');
    });
    
    // Reset timer if there was an error message
    if (document.querySelector('.error')) {
        sessionStorage.removeItem('verificationTimer');
    }
});

</script>
</body>
</html>
