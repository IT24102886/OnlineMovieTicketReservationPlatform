<%--
  Created by IntelliJ IDEA.
  User: Sahanmi Perera
  Date: 3/26/2025
  Time: 10:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register - Movie Ticket System</title>
    <style>
        body { font-family: Arial; max-width: 500px; margin: 0 auto; padding: 20px; }
        .error { color: red; }
    </style>
</head>
<body>
<h2>User Registration</h2>

<div class="error">${errorMessage}</div>

<form action="users" method="post">
    <input type="hidden" name="action" value="register">

    <label>Username:</label>
    <input type="text" name="username" required><br><br>

    <label>Email:</label>
    <input type="email" name="email" required><br><br>

    <label>Password:</label>
    <input type="password" name="password" required><br><br>

    <label>Phone:</label>
    <input type="text" name="contactNumber"><br><br>

    <label>Payment Preference:</label>
    <select name="paymentPreferences">
        <option value="Credit Card">Credit Card</option>
        <option value="PayPal">PayPal</option>
    </select><br><br>

    <button type="submit">Register</button>
</form>

<p>Already have an account? <a href="login.jsp">Login here</a></p>
</body>
</html>