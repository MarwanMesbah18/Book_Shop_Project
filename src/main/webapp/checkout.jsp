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
        
        .payment-options {
            margin-top: 2rem;
        }
        
        .payment-method {
            margin-bottom: 1.5rem;
        }
        
        .payment-card {
            background-color: white;
            border: 1px solid #e0e0e0;
            border-radius: var(--border-radius);
            padding: 1.5rem;
            margin-top: 1rem;
            display: none;
        }
        
        .payment-card.active {
            display: block;
            animation: fadeIn 0.3s ease;
        }
        
        .form-group {
            margin-bottom: 1.25rem;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--primary-color);
        }
        
        .form-control {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid #e0e0e0;
            border-radius: var(--border-radius);
            font-size: 1rem;
            transition: var(--transition);
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
        }
        
        .form-row {
            display: flex;
            gap: 1rem;
        }
        
        .form-row .form-group {
            flex: 1;
        }
        
        .radio-option {
            display: flex;
            align-items: center;
            margin-bottom: 0.75rem;
            cursor: pointer;
        }
        
        .radio-option input {
            margin-right: 0.75rem;
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
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            margin-top: 1rem;
        }
        
        .checkout-btn:hover {
            background-color: #219653;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(39, 174, 96, 0.2);
        }
        
        .btn-icon {
            width: 1rem;
            height: 1rem;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
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
            
            .form-row {
                flex-direction: column;
                gap: 0;
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
    
    <div class="payment-options">
        <h2 class="section-title">Payment Method</h2>
        
        <form action="ConfirmOrderServlet" method="post">
            <div class="payment-method">
                <div class="radio-option">
                    <input type="radio" id="visa" name="paymentMethod" value="visa" checked>
                    <label for="visa">Credit/Debit Card</label>
                </div>
                
                <div class="payment-card active" id="visa-details">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="cardNumber">Card Number</label>
                            <input type="text" id="cardNumber" name="cardNumber" class="form-control" placeholder="1234 5678 9012 3456">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="cardName">Name on Card</label>
                            <input type="text" id="cardName" name="cardName" class="form-control" placeholder="John Doe">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="expiryDate">Expiry Date</label>
                            <input type="text" id="expiryDate" name="expiryDate" class="form-control" placeholder="MM/YY">
                        </div>
                        <div class="form-group">
                            <label for="cvv">CVV</label>
                            <input type="text" id="cvv" name="cvv" class="form-control" placeholder="123">
                        </div>
                    </div>
                </div>
                
                <div class="radio-option">
                    <input type="radio" id="cash" name="paymentMethod" value="cash">
                    <label for="cash">Cash on Delivery</label>
                </div>
            </div>
            
            <button type="submit" class="checkout-btn">
                <svg class="btn-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M5 12h14"></path>
                    <path d="M12 5l7 7-7 7"></path>
                </svg>
                Confirm Order
            </button>
        </form>
    </div>
</div>

<script>
    // Show/hide payment card details based on selection
    document.querySelectorAll('input[name="paymentMethod"]').forEach(radio => {
        radio.addEventListener('change', function() {
            document.getElementById('visa-details').classList.toggle('active', this.value === 'visa');
        });
    });
</script>
</body>
</html>