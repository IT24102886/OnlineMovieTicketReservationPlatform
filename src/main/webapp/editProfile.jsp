<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuickFlicks | Edit Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;900&family=Bebas+Neue&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-black: #0D1321;
            --secondary-black: #1A1A2E;
            --dark-gray: #16213E;
            --medium-gray: #4a4a4a;
            --light-gray: #e5e5e5;
            --accent-pink: #FF1493;
            --accent-dark-pink: #D81159;
            --accent-cyan: #00FFFF;
            --white: #ffffff;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: var(--primary-black);
            color: var(--light-gray);
            min-height: 100vh;
            display: flex;
            align-items: center;
        }

        .container {
            max-width: 500px;
            margin: 2rem auto;
            padding: 2.5rem;
            background-color: var(--secondary-black);
            border-radius: 10px;
            box-shadow: 0 0 30px rgba(0, 255, 255, 0.2);
            border-top: 4px solid var(--accent-pink);
        }

        h2 {
            font-family: 'Bebas Neue', sans-serif;
            color: var(--accent-cyan);
            text-align: center;
            margin-bottom: 2rem;
        }

        .form-control {
            background-color: var(--dark-gray);
            border: 1px solid var(--medium-gray);
            color: var(--light-gray);
            height: 50px;
            padding: 0 20px;
        }

        .form-control:focus {
            background-color: var(--dark-gray);
            color: var(--white);
            border-color: var(--accent-cyan);
            box-shadow: 0 0 0 0.25rem rgba(0, 255, 255, 0.25);
        }

        .btn-submit {
            background-color: var(--accent-pink);
            border: none;
            padding: 12px;
            font-weight: 700;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: all 0.3s;
            width: 100%;
        }

        .btn-submit:hover {
            background-color: var(--accent-dark-pink);
            transform: translateY(-3px);
            box-shadow: 0 0 20px rgba(0, 255, 255, 0.5);
        }

        .alert {
            border-radius: 5px;
            border-left: 4px solid var(--accent-pink);
        }

        .qf-input-group {
            position: relative;
        }

        .qf-input-icon {
            position: absolute;
            top: 50%;
            left: 15px;
            transform: translateY(-50%);
            color: var(--medium-gray);
        }

        .qf-input-group input {
            padding-left: 45px !important;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Edit Profile</h2>

    <%-- Get user from session --%>
    <% User user = (User) session.getAttribute("user"); %>
    <c:if test="${empty user}">
        <c:redirect url="login.jsp"/>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle me-2"></i> ${error}
        </div>
    </c:if>

    <form action="UserProfileServlet" method="post">
        <input type="hidden" name="action" value="updateProfile">

        <div class="mb-3">
            <label for="name" class="form-label">Full Name</label>
            <div class="qf-input-group">
                <i class="fas fa-user qf-input-icon"></i>
                <input type="text" class="form-control" id="name" name="name" value="<%= user.getName() %>" required>
            </div>
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <div class="qf-input-group">
                <i class="fas fa-envelope qf-input-icon"></i>
                <input type="email" class="form-control" id="email" name="email" value="<%= user.getEmail() %>" required>
            </div>
        </div>

        <div class="mb-3">
            <label for="contactNumber" class="form-label">Contact Number</label>
            <div class="qf-input-group">
                <i class="fas fa-phone qf-input-icon"></i>
                <input type="tel" class="form-control" id="contactNumber" name="contactNumber" value="<%= user.getContactNumber() %>" required>
            </div>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">New Password (Optional)</label>
            <div class="qf-input-group">
                <i class="fas fa-lock qf-input-icon"></i>
                <input type="password" class="form-control" id="password" name="password" placeholder="Leave blank to keep current password" minlength="8">
            </div>
        </div>

        <button type="submit" class="btn btn-submit">
            <i class="fas fa-save me-2"></i> Save Changes
        </button>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>