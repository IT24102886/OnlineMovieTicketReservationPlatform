<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform.User" %>
<%@ page import="lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform.Booking" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuickFlicks | User Profile</title>
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
        }

        .container {
            max-width: 800px;
            color: var(--accent-cyan);
            margin: 2rem auto;
            padding: 2rem;
            background-color: var(--secondary-black);
            border-radius: 10px;
            box-shadow: 0 0 30px rgba(0, 255, 255, 0.2);
            border-top: 4px solid var(--accent-pink);
        }

        h1 {
            font-family: 'Bebas Neue', sans-serif;
            color: var(--accent-cyan);
            text-align: center;
            margin-bottom: 2rem;
        }

        .card {
            background-color: var(--dark-gray);
            color: var(--white);
            border: none;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .card-header {
            background-color: var(--secondary-black);
            color: var(--accent-pink);
            font-family: 'Bebas Neue', sans-serif;
            font-size: 1.5rem;
        }

        .table {
            color: var(--light-gray);
        }

        .table th {
            background-color: var(--secondary-black);
            color: var(--accent-cyan);
        }

        .btn-edit {
            background-color: var(--accent-pink);
            border: none;
            color: var(--white);
            transition: all 0.3s;
        }

        .btn-edit:hover {
            background-color: var(--accent-dark-pink);
            box-shadow: 0 0 15px rgba(0, 255, 255, 0.5);
        }

        .alert {
            border-radius: 5px;
            border-left: 4px solid var(--accent-pink);
        }
    </style>
</head>
<body>
<div class="container">
    <h1>User Profile</h1>

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

    <c:if test="${not empty success}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle me-2"></i> ${success}
        </div>
    </c:if>

    <!-- Profile Details -->
    <div class="card">
        <div class="card-header">
            <i class="fas fa-user me-2"></i> Profile Details
        </div>
        <div class="card-body">
            <p><strong>Name:</strong> <%= user.getName() %></p>
            <p><strong>Email:</strong> <%= user.getEmail() %></p>
            <p><strong>Contact Number:</strong> <%= user.getContactNumber() %></p>
            <a href="editProfile.jsp" class="btn btn-edit btn-sm">
                <i class="fas fa-edit me-2"></i> Edit Profile
            </a>
        </div>
    </div>

    <!-- Booking History -->
    <div class="card">
        <div class="card-header">
            <i class="fas fa-ticket-alt me-2"></i> Booking History
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty bookingHistory}">
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th>Booking ID</th>
                            <th>Movie</th>
                            <th>Cinema</th>
                            <th>Showtime</th>
                            <th>Seats</th>
                            <th>Total</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="booking" items="${bookingHistory}">
                            <tr>
                                <td>${booking.bookingId}</td>
                                <td>${booking.movieTitle}</td>
                                <td>${booking.cinema}</td>
                                <td>${booking.showtime}</td>
                                <td>${booking.seats}</td>
                                <td>LKR ${booking.total}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p>No bookings found.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>