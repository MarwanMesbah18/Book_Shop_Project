<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Clasess.User, Clasess.Books, Clasess.DB, Clasess.ShoppingCart, Clasess.CartItem, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Shop - Checkout</title>
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
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
        }
        
        .section-title {
            font-size: 1.5rem;
            color: var(--primary-color);
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid var(--secondary-color);
        }
        
        .receipt {
            border: 1px solid #e0e0e0;
            padding: 1.5rem;
            margin-bottom: 2rem;
            border-radius: var(--border-radius);
            background-color: var(--light-gray);
        }
        
        .receipt-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1.5rem;
        }
        
        .receipt-info {
            color: var(--dark-gray);
        }
        
        .receipt-info strong {
            color: var(--primary-color);
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 1.5rem 0;
        }
        
        th {
            background-color: var(--primary-color);
            color: white;
            padding: 1rem;
            text-align: left;
            font-weight: 500;
        }
        
        td {
            padding: 1rem;
            border-bottom: 1px solid #e0e0e0;
        }
        
        tr:last-child td {
            border-bottom: none;
        }
        
        tr:hover {
            background-color: rgba(52, 152, 219, 0.05);
        }
        
        .total-row {
            font-weight: 600;
        }
        
        .total-amount {
            color: var(--success-color);
            font-size: 1.25rem;
        }
        
        .payment-info {
            padding: 1.5rem;
            border: 1px solid #e0e0e0;
            border-radius: var(--border-radius);
            background-color: var(--light-gray);
            margin-bottom: 2rem;
        }
        
        .payment-option {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 1rem;
            background-color: white;
            border-radius: var(--border-radius);
        }
        
        .payment-icon {
            background-color: var(--success-color);
            color: white;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            font-weight: bold;
        }
        
        .payment-description {
            font-weight: 500;
            margin-bottom: 0.25rem;
        }
        
        .payment-note {
            font-size: 0.9rem;
            color: var(--dark-gray);
        }
        
        .checkout-btn {
            background-color: var(--success-color);
            color: white;
            border: none;
            padding: 0.85rem 1.75rem;
            border-radius: var(--border-radius);
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: var(--transition);
            display: block;
            width: 100%;
            text-align: center;
            margin-top: 1rem;
        }
        
        .checkout-btn:hover {
            background-color: #219653;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(39, 174, 96, 0.2);
        }
        
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
    
    ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
    if (cart == null || cart.getItems().isEmpty()) {
        response.sendRedirect("cart.jsp");
        return;
    }
    
    List<CartItem> cartItems = cart.getItems();
%>

<div class="header">
    <a href="cart.jsp" class="back-link">
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <line x1="19" y1="12" x2="5" y2="12"></line>
            <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
        Back to Cart
    </a>
    <h1>Checkout</h1>
</div>

<div class="container">
    <h2 class="section-title">Order Summary</h2>
    
    <div class="receipt">
        <div class="receipt-header">
            <div>
                <h3>Order Receipt</h3>
                <p class="receipt-info"><strong>Customer:</strong> <%= user.getUsername() %></p>
            </div>
            <p class="receipt-info"><strong>Date:</strong> <%= new java.util.Date() %></p>
        </div>
        
        <table>
            <thead>
                <tr>
                    <th>Book</th>
                    <th>Author</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                <% for(CartItem item : cartItems) { %>
                <tr>
                    <td><%= item.getBook().getName() %></td>
                    <td><%= item.getBook().getAuthor() %></td>
                    <td>$<%= String.format("%.2f", item.getBook().getPrice()) %></td>
                    <td><%= item.getQuantity() %></td>
                    <td>$<%= String.format("%.2f", item.getTotalPrice()) %></td>
                </tr>
                <% } %>
                <tr class="total-row">
                    <td colspan="4" style="text-align: right;">Grand Total:</td>
                    <td class="total-amount">$<%= String.format("%.2f", cart.getTotalPrice()) %></td>
                </tr>
            </tbody>
        </table>
    </div>
    
    <h2 class="section-title">Payment Method</h2>
    
    <div class="payment-info">
        <div class="payment-option">
            <div class="payment-icon">💵</div>
            <div>
                <p class="payment-description">Cash on Delivery</p>
                <p class="payment-note">Pay when you receive your order</p>
            </div>
        </div>
    </div>
    
    <form action="ConfirmOrderServlet" method="post">
        <button type="submit" class="checkout-btn">Confirm Order</button>
    </form>
</div>
</body>
</html>
