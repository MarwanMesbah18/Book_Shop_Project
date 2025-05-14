<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Clasess.User, Clasess.ShoppingCart, Clasess.CartItem, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Shop - Shopping Cart</title>
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
        max-width: 1200px;
        margin: 20px auto;
        padding: 0 20px;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        background-color: white;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    th, td {
        padding: 12px 15px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }
    th {
        background-color: #333;
        color: white;
    }
    .quantity-input {
        width: 60px;
        padding: 5px;
        text-align: center;
    }
    .btn {
        background-color: #4CAF50;
        color: white;
        border: none;
        padding: 6px 10px;
        cursor: pointer;
        border-radius: 3px;
    }
    .remove-btn {
        background-color: #f44336;
    }
    .cart-summary {
        background-color: white;
        padding: 20px;
        margin-top: 20px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .total {
        font-size: 20px;
        font-weight: bold;
    }
    .checkout-btn {
        background-color: #4CAF50;
        color: white;
        border: none;
        padding: 10px 20px;
        cursor: pointer;
        font-size: 16px;
    }
    .continue-shopping {
        color: #4CAF50;
        text-decoration: none;
        font-weight: bold;
        margin-right: 15px;
    }
    .logout-form {
        display: inline;
    }
    .logout-btn {
        background: none;
        border: none;
        color: white;
        cursor: pointer;
        font-size: 16px;
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
    if (cart == null) {
        cart = new ShoppingCart();
        session.setAttribute("cart", cart);
    }
    
    List<CartItem> cartItems = cart.getItems();
%>

<div class="header">
    <h1>Shopping Cart</h1>
    <div>
        Welcome, <%= user.getUsername() %>! | 
        <a href="home.jsp" style="color: white; margin-right: 15px;">Home</a>
        <form class="logout-form" action="LogoutServlet" method="post">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
    </div>
</div>

<div class="container">
    <% if(cartItems.isEmpty()) { %>
        <div style="text-align: center; padding: 20px; background-color: white; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
            <h2>Your cart is empty</h2>
            <p>Looks like you haven't added any books to your cart yet.</p>
            <a href="home.jsp" class="continue-shopping">Continue Shopping</a>
        </div>
    <% } else { %>
        <table>
            <tr>
                <th>Book</th>
                <th>Author</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Total</th>
                <th>Actions</th>
            </tr>
            <% for(CartItem item : cartItems) { %>
            <tr>
                <td><%= item.getBook().getName() %></td>
                <td><%= item.getBook().getAuthor() %></td>
                <td>$<%= String.format("%.2f", item.getBook().getPrice()) %></td>
                <td>
                    <form action="UpdateCartServlet" method="post" style="display:inline;">
                        <input type="hidden" name="bookName" value="<%= item.getBook().getName() %>">
                        <input type="number" name="quantity" value="<%= item.getQuantity() %>" min="1" max="<%= item.getBook().getQuantity() %>" class="quantity-input">
                        <button type="submit" class="btn">Update</button>
                    </form>
                </td>
                <td>$<%= String.format("%.2f", item.getTotalPrice()) %></td>
                <td>
                    <form action="RemoveFromCartServlet" method="post">
                        <input type="hidden" name="bookName" value="<%= item.getBook().getName() %>">
                        <button type="submit" class="btn remove-btn">Remove</button>
                    </form>
                </td>
            </tr>
            <% } %>
        </table>
        
        <div class="cart-summary">
    <div class="total">Total: $<%= String.format("%.2f", cart.getTotalPrice()) %></div>
    <div>
        <a href="home.jsp" class="continue-shopping">Continue Shopping</a>
        <a href="checkout.jsp" class="checkout-btn">Proceed to Checkout</a>
    </div>
</div>

    <% } %>
</div>
</body>
</html>
