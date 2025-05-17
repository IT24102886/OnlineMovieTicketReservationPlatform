<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quick Flicks | View Movies</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Montserrat:wght@800&display=swap" rel="stylesheet">
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
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: var(--primary-black);
            color: var(--light-gray);
        }

        h1, h2, h3, h4, h5, h6 {
            font-family: 'Bebas Neue', sans-serif;
            letter-spacing: 1px;
        }

        .navbar {
            background-color: rgba(10, 15, 29, 0.95);
            border-bottom: 2px solid var(--accent-dark-pink);
        }

        .navbar-brand {
            font-family: 'Bebas Neue', sans-serif;
            font-size: 2rem;
            color: var(--white);
        }

        .navbar-brand span {
            color: var(--accent-dark-pink);
        }

        .nav-link {
            color: var(--light-gray) !important;
            font-weight: 600;
        }

        .nav-link:hover, .nav-link.active {
            color: var(--accent-dark-pink) !important;
        }

        .table {
            background-color: var(--secondary-black);
            color: var(--light-gray);
        }

        .table th {
            background-color: var(--dark-gray);
            color: var(--white);
            font-family: 'Bebas Neue', sans-serif;
        }

        .table td {
            vertical-align: middle;
        }

        .btn-red {
            background-color: var(--accent-dark-pink);
            color: var(--white);
            border: none;
            font-weight: 600;
            padding: 8px 16px;
            border-radius: 5px;
            transition: all 0.3s;
        }

        .btn-red:hover {
            background-color: var(--accent-pink);
            box-shadow: var(--glow-cyan);
        }

        .btn-outline-red {
            border: 2px solid var(--accent-pink);
            color: var(--accent-pink);
            background-color: transparent;
            padding: 8px 16px;
            border-radius: 5px;
            transition: all 0.3s;
        }

        .btn-outline-red:hover {
            background-color: var(--accent-dark-pink);
            color: var(--white);
        }

        .section-title {
            position: relative;
            display: inline-block;
            margin-bottom: 2rem;
            font-size: 2.5rem;
            color: var(--white);
        }

        .section-title:after {
            content: '';
            position: absolute;
            width: 50%;
            height: 4px;
            background: var(--accent-dark-pink);
            bottom: -10px;
            left: 0;
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">QUICK<span>FLICKS</span></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp"><i class="fas fa-home me-1"></i> Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="AdminServlet"><i class="fas fa-tachometer-alt me-1"></i> Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="viewUsers.jsp"><i class="fas fa-users me-1"></i> Users</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/viewMovies.jsp"><i class="fas fa-film me-1"></i> Movies</a>
                </li>
                <li class="nav-item">
                    <form action="${pageContext.request.contextPath}/UserLogoutServlet" method="post" style="display: inline;">
                        <button type="submit" class="nav-link btn btn-link"><i class="fas fa-sign-out-alt me-1"></i> Logout</button>
                    </form>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Movies Section -->
<section class="py-5" style="background-color: var(--secondary-black);">
    <div class="container py-5">
        <h2 class="section-title">MANAGE MOVIES</h2>
        <c:if test="${not empty param.success}">
            <div class="alert alert-success">
                <c:choose>
                    <c:when test="${param.success == 'movieAdded'}">Movie added successfully.</c:when>
                    <c:when test="${param.success == 'movieUpdated'}">Movie updated successfully.</c:when>
                    <c:when test="${param.success == 'movieDeleted'}">Movie deleted successfully.</c:when>
                    <c:when test="${param.success == 'showTimesAdded'}">Showtimes added successfully.</c:when>
                </c:choose>
            </div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger">${param.error}</div>
        </c:if>
        <div class="table-responsive">
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>Title</th>
                    <th>Genre</th>
                    <th>Duration</th>
                    <th>Release Date</th>
                    <th>Now Showing</th>
                    <th>Showtimes</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${not empty movies}">
                        <c:forEach var="movie" items="${movies}">
                            <tr>
                                <td>${movie.title}</td>
                                <td>${movie.genre}</td>
                                <td>${movie.durationMinutes}m</td>
                                <td><fmt:formatDate value="${movie.releaseDate}" pattern="yyyy-MM-dd"/></td>
                                <td>${movie.isNowShowing ? 'Yes' : 'No'}</td>
                                <td>
                                    <c:forEach var="showTime" items="${movie.showTimes}">
                                        <fmt:formatDate value="${showTime}" pattern="hh:mm a"/>,
                                    </c:forEach>
                                </td>
                                <td>
                                    <a href="editMovie.jsp?movieId=${movie.movieId}" class="btn btn-outline-red btn-sm">Edit</a>
                                    <form action="${pageContext.request.contextPath}/AdminServlet" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="deleteMovie">
                                        <input type="hidden" name="movieId" value="${movie.movieId}">
                                        <button type="submit" class="btn btn-red btn-sm" onclick="return confirm('Are you sure you want to delete ${movie.title}?')">Delete</button>
                                    </form>
                                    <a href="addShowTimes.jsp?movieId=${movie.movieId}" class="btn btn-outline-red btn-sm">Add Showtimes</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="7" class="text-center">No movies available.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
        <a href="addMovie.jsp" class="btn btn-red mt-3">Add New Movie</a>
    </div>
</section>

<!-- Bootstrap 5 JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>