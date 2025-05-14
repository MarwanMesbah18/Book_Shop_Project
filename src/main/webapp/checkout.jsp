<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Clasess.User, Clasess.Books, Clasess.DB, Clasess.ShoppingCart, Clasess.CartItem, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book Shop - Checkout</title>
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
        }
        .receipt {
            border: 1px solid #ddd;
            padding: 20px;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .total {
            font-weight: bold;
            text-align: right;
            margin: 10px 0;
            font-size: 18px;
        }
        .payment-options {
            margin-top: 20px;
        }
        .payment-option {
            display: block;
            margin: 10px 0;
        }
        .btn {
            display: inline-block;
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 3px;
            font-size: 16px;
            text-decoration: none;
        }
        .btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<%
    // Check if user is logged in
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Get shopping cart
    ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
    if (cart == null || cart.getItems().isEmpty()) {
        response.sendRedirect("cart.jsp");
        return;
    }
    
    List<CartItem> cartItems = cart.getItems();
%>

<div class="header">
    <h1>Checkout</h1>
</div>

<div class="container">
    <h2>Order Summary</h2>
    
    <div class="receipt">
        <h3>Receipt</h3>
        <p>Customer: <%= user.getUsername() %></p>
        <p>Date: <%= new java.util.Date() %></p>
        
        <table>
            <tr>
                <th>Book</th>
                <th>Author</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Total</th>
            </tr>
            <% for(CartItem item : cartItems) { %>
            <tr>
                <td><%= item.getBook().getName() %></td>
                <td><%= item.getBook().getAuthor() %></td>
                <td>$<%= String.format("%.2f", item.getBook().getPrice()) %></td>
                <td><%= item.getQuantity() %></td>
                <td>$<%= String.format("%.2f", item.getTotalPrice()) %></td>
            </tr>
            <% } %>
        </table>
        
        <div class="total">
            Grand Total: $<%= String.format("%.2f", cart.getTotalPrice()) %>
        </div>
    </div>
    
    <div class="payment-options">
        <h3>Payment Method</h3>
        <form action="ConfirmOrderServlet" method="post">
    <!-- Payment method selection -->
    <div class="payment-options">
        <h3>Payment Method</h3>
        <div>
            <input type="radio" id="visa" name="paymentMethod" value="visa" checked>
            <label for="visa">Credit Card (Visa)</label>
        </div>
        <div>
            <input type="radio" id="cash" name="paymentMethod" value="cash">
            <label for="cash">Cash on Delivery</label>
        </div>
    </div>
    
    <!-- Submit button -->
    <button type="submit" class="checkout-btn">Confirm Order</button>
</form>

    </div>
</div>

<script>
    // Show/hide credit card details based on payment selection
    document.getElementById('visa').addEventListener('change', function() {
        document.getElementById('visa-details').style.display = 'block';
    });
    
    document.getElementById('cash').addEventListener('change', function() {
        document.getElementById('visa-details').style.display = 'none';
    });
</script>
</body>
</html>
