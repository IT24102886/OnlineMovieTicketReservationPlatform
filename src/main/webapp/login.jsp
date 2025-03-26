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
  <title>Login - Movie Ticket System</title>
  <style>
    body { font-family: Arial; max-width: 500px; margin: 0 auto; padding: 20px; }
    .error { color: red; }
    .success { color: green; }
  </style>
</head>
<body>
<h2>User Login</h2>

<%-- Error/Success Messages --%>
<div class="error">${errorMessage}</div>
<div class="success">${successMessage}</div>

<form action="users" method="post">
  <input type="hidden" name="action" value="login">

  <label>Username:</label>
  <input type="text" name="username" required><br><br>

  <label>Password:</label>
  <input type="password" name="password" required><br><br>

  <button type="submit">Login</button>
</form>

<p>New user? <a href="register.jsp">Register here</a></p>
</body>
</html>