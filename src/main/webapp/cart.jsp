<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Clasess.User, Clasess.ShoppingCart, Clasess.CartItem, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Book Shop - Shopping Cart</title>
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
        padding: 1.25rem 2rem;
        box-shadow: var(--box-shadow);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .header h1 {
        font-size: 1.5rem;
        font-weight: 600;
    }
    
    .user-nav {
        display: flex;
        align-items: center;
        gap: 1.5rem;
    }
    
    .nav-link {
        color: white;
        text-decoration: none;
        font-weight: 500;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        transition: var(--transition);
    }
    
    .nav-link:hover {
        color: var(--secondary-color);
    }
    
    .logout-btn {
        background: none;
        border: none;
        color: white;
        cursor: pointer;
        font-size: 1rem;
        font-weight: 500;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }
    
    .container {
        max-width: 1200px;
        margin: 2rem auto;
        padding: 0 1.5rem;
    }
    
    .empty-cart {
        background-color: white;
        border-radius: var(--border-radius);
        box-shadow: var(--box-shadow);
        padding: 3rem;
        text-align: center;
        margin: 2rem 0;
    }
    
    .empty-cart h2 {
        color: var(--primary-color);
        margin-bottom: 1rem;
    }
    
    .empty-cart p {
        color: var(--dark-gray);
        margin-bottom: 1.5rem;
    }
    
    .continue-btn {
        background-color: var(--primary-color);
        color: white;
        padding: 0.75rem 1.5rem;
        text-decoration: none;
        border-radius: var(--border-radius);
        font-weight: 500;
        transition: var(--transition);
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
    }
    
    .continue-btn:hover {
        background-color: #1a252f;
        transform: translateY(-2px);
    }
    
    .cart-table {
        width: 100%;
        border-collapse: collapse;
        background-color: white;
        border-radius: var(--border-radius);
        box-shadow: var(--box-shadow);
        overflow: hidden;
    }
    
    .cart-table th {
        background-color: var(--primary-color);
        color: white;
        padding: 1rem;
        text-align: left;
        font-weight: 500;
    }
    
    .cart-table td {
        padding: 1rem;
        border-bottom: 1px solid #e0e0e0;
    }
    
    .cart-table tr:last-child td {
        border-bottom: none;
    }
    
    .cart-table tr:hover {
        background-color: var(--light-gray);
    }
    
    .quantity-control {
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }
    
    .quantity-input {
        width: 60px;
        padding: 0.5rem;
        border: 1px solid #e0e0e0;
        border-radius: var(--border-radius);
        text-align: center;
    }
    
    .btn {
        padding: 0.5rem 1rem;
        border: none;
        border-radius: var(--border-radius);
        cursor: pointer;
        font-weight: 500;
        transition: var(--transition);
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
    }
    
    .btn-sm {
        padding: 0.4rem 0.8rem;
        font-size: 0.9rem;
    }
    
    .update-btn {
        background-color: var(--secondary-color);
        color: white;
    }
    
    .update-btn:hover {
        background-color: #2980b9;
    }
    
    .remove-btn {
        background-color: var(--accent-color);
        color: white;
    }
    
    .remove-btn:hover {
        background-color: #c0392b;
    }
    
    .cart-summary {
        background-color: white;
        padding: 1.5rem;
        margin-top: 1.5rem;
        border-radius: var(--border-radius);
        box-shadow: var(--box-shadow);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .total {
        font-size: 1.25rem;
        font-weight: 600;
        color: var(--primary-color);
    }
    
    .total-amount {
        color: var(--success-color);
        font-size: 1.5rem;
    }
    
    .action-buttons {
        display: flex;
        gap: 1rem;
    }
    
    .checkout-btn {
        background-color: var(--success-color);
        color: white;
        padding: 0.75rem 1.5rem;
        text-decoration: none;
        border-radius: var(--border-radius);
        font-weight: 500;
        transition: var(--transition);
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
    }
    
    .checkout-btn:hover {
        background-color: #219653;
        transform: translateY(-2px);
    }
    
    .btn-icon {
        width: 1rem;
        height: 1rem;
    }
    
    @media (max-width: 768px) {
        .header {
            flex-direction: column;
            gap: 1rem;
            padding: 1rem;
        }
        
        .user-nav {
            width: 100%;
            justify-content: space-between;
        }
        
        .cart-table {
            display: block;
            overflow-x: auto;
        }
        
        .cart-summary {
            flex-direction: column;
            gap: 1.5rem;
            align-items: flex-start;
        }
        
        .action-buttons {
            width: 100%;
            flex-direction: column;
        }
        
        .continue-btn, .checkout-btn {
            width: 100%;
            text-align: center;
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
    if (cart == null) {
        cart = new ShoppingCart();
        session.setAttribute("cart", cart);
    }
    
    List<CartItem> cartItems = cart.getItems();
%>

<div class="header">
    <h1>Shopping Cart</h1>
    <div class="user-nav">
        <span>Welcome, <%= user.getUsername() %>!</span>
        <a href="home.jsp" class="nav-link">
            <svg class="btn-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                <polyline points="9 22 9 12 15 12 15 22"></polyline>
            </svg>
            Home
        </a>
        <form class="logout-form" action="LogoutServlet" method="post">
            <button type="submit" class="logout-btn">
                <svg class="btn-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                    <polyline points="16 17 21 12 16 7"></polyline>
                    <line x1="21" y1="12" x2="9" y2="12"></line>
                </svg>
                Logout
            </button>
        </form>
    </div>
</div>

<div class="container">
    <% if(cartItems.isEmpty()) { %>
        <div class="empty-cart">
            <h2>Your cart is empty</h2>
            <p>Looks like you haven't added any books to your cart yet.</p>
            <a href="home.jsp" class="continue-btn">
                <svg class="btn-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                    <polyline points="9 22 9 12 15 12 15 22"></polyline>
                </svg>
                Continue Shopping
            </a>
        </div>
    <% } else { %>
        <table class="cart-table">
            <thead>
                <tr>
                    <th>Book</th>
                    <th>Author</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for(CartItem item : cartItems) { %>
                <tr>
                    <td><%= item.getBook().getName() %></td>
                    <td><%= item.getBook().getAuthor() %></td>
                    <td>$<%= String.format("%.2f", item.getBook().getPrice()) %></td>
                    <td>
                        <form action="UpdateCartServlet" method="post" class="quantity-control">
                            <input type="hidden" name="bookName" value="<%= item.getBook().getName() %>">
                            <input type="number" name="quantity" value="<%= item.getQuantity() %>" min="1" max="<%= item.getBook().getQuantity() %>" class="quantity-input">
                            <button type="submit" class="btn btn-sm update-btn">Update</button>
                        </form>
                    </td>
                    <td>$<%= String.format("%.2f", item.getTotalPrice()) %></td>
                    <td>
                        <form action="RemoveFromCartServlet" method="post">
                            <input type="hidden" name="bookName" value="<%= item.getBook().getName() %>">
                            <button type="submit" class="btn btn-sm remove-btn">
                                <svg class="btn-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <polyline points="3 6 5 6 21 6"></polyline>
                                    <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                                </svg>
                                Remove
                            </button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        
        <div class="cart-summary">
            <div class="total">Total: <span class="total-amount">$<%= String.format("%.2f", cart.getTotalPrice()) %></span></div>
            <div class="action-buttons">
                <a href="home.jsp" class="continue-btn">
                    <svg class="btn-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                        <polyline points="9 22 9 12 15 12 15 22"></polyline>
                    </svg>
                    Continue Shopping
                </a>
                <a href="checkout.jsp" class="checkout-btn">
                    <svg class="btn-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M5 12h14"></path>
                        <path d="M12 5l7 7-7 7"></path>
                    </svg>
                    Proceed to Checkout
                </a>
            </div>
        </div>
    <% } %>
</div>
</body>
</html>