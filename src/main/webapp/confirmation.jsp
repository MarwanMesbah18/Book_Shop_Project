<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book Shop - Order Confirmation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .header {
            background-color: #333;
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
            text-align: center;
        }
        .success-message {
            color: #4CAF50;
            font-size: 24px;
            margin: 20px 0;
        }
        .payment-info {
            margin: 20px 0;
            padding: 10px;
            background-color: #f9f9f9;
            border-radius: 3px;
        }
        .continue-btn {
            display: inline-block;
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 3px;
            margin-top: 20px;
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
    <div class="success-message">
        <i class="fas fa-check-circle"></i> Your order has been placed successfully!
    </div>
    
    <div class="payment-info">
        <h3>Payment Information</h3>
        <% if ("visa".equals(paymentMethod)) { %>
            <p>Payment Method: Credit Card (Visa)</p>
            <p>Your card has been charged. A receipt has been sent to your email.</p>
        <% } else { %>
            <p>Payment Method: Cash on Delivery</p>
            <p>Please have the exact amount ready for the delivery person.</p>
        <% } %>
    </div>
    
    <p>Thank you for shopping with us!</p>
    
    <a href="home.jsp" class="continue-btn">Continue Shopping</a>
</div>
</body>
</html>
