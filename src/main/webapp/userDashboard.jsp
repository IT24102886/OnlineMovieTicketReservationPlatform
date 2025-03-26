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
    <title>User Dashboard</title>
</head>
<body>
<h2>Welcome, ${user.username}!</h2>

<h3>Your Details:</h3>
<p>Email: ${user.email}</p>
<p>Phone: ${user.contactNumber}</p>
<p>Payment Preference: ${user.paymentPreferences}</p>

<a href="editProfile.jsp">Edit Profile</a> |
<a href="users?action=logout">Logout</a>
</body>
</html>