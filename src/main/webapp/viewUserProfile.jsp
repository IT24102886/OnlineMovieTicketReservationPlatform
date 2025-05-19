<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>User Profile | QuickFlicks</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-black: #0A0F1D;
            --secondary-black: #1C2526;
            --dark-gray: #2A2F3A;
            --medium-gray: #6B7280;
            --light-gray: #D1D5DB;
            --accent-pink: #EC4899;
            --accent-dark-pink: #BE185D;
            --accent-cyan: #06B6D4;
            --white: #F9FAFB;
            --glow-cyan: 0 0 10px rgba(6, 182, 212, 0.5);
            --rating-yellow: #FBBF24;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: var(--primary-black);
            color: var(--light-gray);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)),
            url('https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?ixlib=rb-4.0.3&auto=format&fit=crop&w=1470&q=80');
            background-size: cover;
            background-position: center;
        }

        h1, h2, h3, h4, h5, h6 {
            font-family: 'Bebas Neue', sans-serif;
            letter-spacing: 1px;
        }

        .edit-container {
            max-width: 700px;
            width: 100%;
            margin: 2rem auto;
            padding: 2.5rem;
            background-color: var(--secondary-black);
            border-radius: 10px;
            box-shadow: 0 5px 30px rgba(0, 0, 0, 0.5);
            border-top: 4px solid var(--accent-dark-pink);
        }

        .btn-outline-red {
            border: 2px solid var(--accent-pink);
            color: var(--accent-pink);
            background-color: transparent;
            font-weight: 700;
            padding: 10px 28px;
            border-radius: 5px;
            letter-spacing: 1px;
            transition: all 0.3s;
            width: 100%;
            margin-top: 1.5rem;
            text-align: center;
        }

        .btn-outline-red:hover {
            background-color: var(--accent-dark-pink);
            color: var(--white);
            transform: translateY(-3px);
            box-shadow: var(--glow-cyan);
        }

        .login-logo {
            font-family: 'Bebas Neue', sans-serif;
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--white);
            text-align: center;
            margin-bottom: 1.5rem;
            letter-spacing: 2px;
        }

        .login-logo span {
            color: var(--accent-dark-pink);
        }

        .login-title {
            font-family: 'Bebas Neue', sans-serif;
            color: var(--accent-cyan);
            font-size: 1.8rem;
            margin-bottom: 1.5rem;
            text-align: center;
            letter-spacing: 1px;
        }

        .profile-info {
            margin-bottom: 2rem;
        }

        .profile-info .info-group {
            position: relative;
            padding-left: 45px;
            margin-bottom: 1rem;
        }

        .profile-info .info-icon {
            position: absolute;
            top: 50%;
            left: 15px;
            transform: translateY(-50%);
            color: var(--medium-gray);
        }

        .profile-info p {
            font-size: 1rem;
            margin: 0;
            color: var(--light-gray);
        }

        .profile-info strong {
            color: var(--accent-cyan);
            font-weight: 600;
        }

        .section-title {
            font-family: 'Bebas Neue', sans-serif;
            color: var(--accent-dark-pink);
            font-size: 1.5rem;
            margin-top: 2rem;
            margin-bottom: 1rem;
            letter-spacing: 1px;
        }

        .table {
            color: var(--light-gray);
            background-color: var(--dark-gray);
            border-radius: 5px;
            overflow: hidden;
        }

        .table th {
            background-color: var(--secondary-black);
            color: var(--accent-dark-pink);
            font-family: 'Bebas Neue', sans-serif;
            letter-spacing: 1px;
            padding: 12px;
        }

        .table td {
            border-color: var(--medium-gray);
            padding: 12px;
        }

        .table-hover tbody tr:hover {
            background-color: var(--secondary-black);
        }

        .review-item {
            background-color: var(--dark-gray);
            border-radius: 5px;
            padding: 1rem;
            margin-bottom: 1rem;
        }

        .review-item p {
            margin: 0.5rem 0;
        }

        .review-item strong {
            color: var(--accent-cyan);
        }

        .rating-stars {
            color: var(--rating-yellow);
        }

        .text-danger {
            font-size: 1rem;
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .no-data {
            font-size: 1rem;
            color: var(--medium-gray);
            text-align: center;
            margin-bottom: 1.5rem;
        }

        @media (max-width: 768px) {
            .edit-container {
                margin: 1rem;
                padding: 1.5rem;
            }
            .table {
                font-size: 0.9rem;
            }
            .table th, .table td {
                padding: 8px;
            }
        }

        @media (max-width: 576px) {
            .login-logo {
                font-size: 2rem;
            }
            .login-title {
                font-size: 1.5rem;
            }
            .section-title {
                font-size: 1.3rem;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="edit-container">
        <div class="login-logo">QUICK<span>FLICKS</span></div>
        <h2 class="login-title">USER PROFILE</h2>

        <c:if test="${not empty profileUser}">
            <!-- Profile Information -->
            <div class="profile-info">
                <div class="info-group">
                    <i class="fas fa-user info-icon"></i>
                    <p><strong>Name:</strong> ${profileUser.name}</p>
                </div>
                <div class="info-group">
                    <i class="fas fa-envelope info-icon"></i>
                    <p><strong>Email:</strong> ${profileUser.email}</p>
                </div>
                <div class="info-group">
                    <i class="fas fa-phone info-icon"></i>
                    <p><strong>Contact:</strong> ${profileUser.contactNumber}</p>
                </div>
                <div class="info-group">
                    <i class="fas fa-calendar-alt info-icon"></i>
                    <p><strong>Registered Date:</strong> ${profileUser.registeredDateTime}</p>
                </div>
                <div class="info-group">
                    <i class="fas fa-shield-alt info-icon"></i>
                    <p><strong>Admin Status:</strong> ${profileUser.admin ? 'Yes' : 'No'}</p>
                </div>
            </div>

            <!-- Recent Bookings -->
            <h3 class="section-title"><i class="fas fa-history me-2"></i>RECENT BOOKINGS</h3>
            <c:choose>
                <c:when test="${not empty bookingHistory}">
                    <div class="table-responsive">
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
                    </div>
                </c:when>
                <c:otherwise>
                    <p class="no-data">No recent bookings to display.</p>
                </c:otherwise>
            </c:choose>

            <!-- Reviews Given -->
            <h3 class="section-title"><i class="fas fa-comment-dots me-2"></i>REVIEWS GIVEN</h3>
            <c:choose>
                <c:when test="${not empty reviews}">
                    <c:forEach var="review" items="${reviews}">
                        <div class="review-item">
                            <p><strong>Movie:</strong> ${review.movieTitle}</p>
                            <p><strong>Rating:</strong>
                                <span class="rating-stars">
                                    <c:forEach begin="1" end="${review.rating}">
                                        <i class="fas fa-star"></i>
                                    </c:forEach>
                                    <c:forEach begin="${review.rating + 1}" end="5">
                                        <i class="far fa-star"></i>
                                    </c:forEach>
                                </span>
                            </p>
                            <p><strong>Comment:</strong> ${review.comment}</p>
                            <p><strong>Date:</strong> ${review.reviewDate}</p>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p class="no-data">No reviews submitted by this user.</p>
                </c:otherwise>
            </c:choose>

            <a href="UserServlet?action=viewAll" class="btn btn-outline-red"><i class="fas fa-arrow-left me-2"></i> Back to Users</a>
        </c:if>
        <c:if test="${empty profileUser}">
            <p class="text-danger">User not found.</p>
        </c:if>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>