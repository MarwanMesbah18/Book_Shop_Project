<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Shop - Order Confirmation</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
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
        }
        
        .header h1 {
            font-size: 1.8rem;
            font-weight: 600;
            letter-spacing: 0.5px;
        }
        
        .container {
            max-width: 700px;
            margin: 2rem auto;
            padding: 3rem 2rem;
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            text-align: center;
        }
        
        .confirmation-icon {
            font-size: 4rem;
            color: var(--success-color);
            margin-bottom: 1.5rem;
            animation: bounce 1s ease;
        }
        
        .success-message {
            font-size: 1.75rem;
            color: var(--primary-color);
            margin-bottom: 1.5rem;
            font-weight: 600;
        }
        
        .thank-you {
            font-size: 1.25rem;
            color: var(--dark-gray);
            margin-bottom: 2rem;
        }
        
        .payment-info {
            background-color: var(--light-gray);
            border-radius: var(--border-radius);
            padding: 1.5rem;
            margin: 2rem 0;
            text-align: left;
        }
        
        .payment-info h3 {
            color: var(--primary-color);
            margin-bottom: 1rem;
            font-size: 1.25rem;
            border-bottom: 2px solid var(--secondary-color);
            padding-bottom: 0.5rem;
        }
        
        .payment-info p {
            margin-bottom: 0.75rem;
            color: var(--dark-gray);
        }
        
        .continue-btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background-color: var(--primary-color);
            color: white;
            padding: 0.85rem 1.75rem;
            text-decoration: none;
            border-radius: var(--border-radius);
            font-weight: 500;
            transition: var(--transition);
            margin-top: 1.5rem;
        }
        
        .continue-btn:hover {
            background-color: #1a252f;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {transform: translateY(0);}
            40% {transform: translateY(-20px);}
            60% {transform: translateY(-10px);}
        }
        
        @media (max-width: 768px) {
            .container {
                padding: 2rem 1.5rem;
                margin: 1.5rem;
            }
            
            .header {
                padding: 1.25rem;
            }
            
            .header h1 {
                font-size: 1.5rem;
            }
            
            .success-message {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
<%
    // Check if order was confirmed
    Boolean orderConfirmed = (Boolean) session.getAttribute("orderConfirmed");
    if (orderConfirmed == null || !orderConfirmed) {
        response.sendRedirect("home.jsp");
        return;
    }
    
    String paymentMethod = (String) session.getAttribute("paymentMethod");
    
    // Remove attributes
    session.removeAttribute("orderConfirmed");
    session.removeAttribute("paymentMethod");
%>

<div class="header">
    <h1>Order Confirmation</h1>
</div>

<div class="container">
    <div class="confirmation-icon">
        <i class="fas fa-check-circle"></i>
    </div>
    
    <h2 class="success-message">Your order has been placed successfully!</h2>
    
    <div class="payment-info">
        <h3>Payment Information</h3>
        <% if ("visa".equals(paymentMethod)) { %>
            <p><i class="fas fa-credit-card"></i> <strong>Payment Method:</strong> Credit Card (Visa)</p>
            <p><i class="fas fa-receipt"></i> Your card has been charged. A receipt has been sent to your email.</p>
            <p><i class="fas fa-shipping-fast"></i> Your order will be processed and shipped within 1-2 business days.</p>
        <% } else { %>
            <p><i class="fas fa-money-bill-wave"></i> <strong>Payment Method:</strong> Cash on Delivery</p>
            <p><i class="fas fa-exclamation-circle"></i> Please have the exact amount ready for the delivery person.</p>
            <p><i class="fas fa-clock"></i> Delivery typically takes 3-5 business days.</p>
        <% } %>
    </div>
    
    <p class="thank-you">Thank you for shopping with us! We appreciate your business.</p>
    
    <a href="home.jsp" class="continue-btn">
        <i class="fas fa-arrow-left"></i> Continue Shopping
    </a>
</div>
</body>
</html>