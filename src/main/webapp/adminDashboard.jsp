<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Admin Dashboard | QuickFlicks</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;900&family=Bebas+Neue&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
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
            --glow-cyan: 0 0 10px rgba(0, 255, 255, 0.7);
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: var(--primary-black);
            color: var(--light-gray);
            overflow-x: hidden;
        }

        h1, h2, h3, h4, h5, h6 {
            font-family: 'Bebas Neue', sans-serif;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .navbar {
            background-color: rgba(13, 19, 33, 0.95) !important;
            border-bottom: 2px solid var(--accent-pink);
            padding: 15px 0;
            transition: all 0.3s ease;
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.8rem;
            color: var(--white) !important;
        }

        .navbar-brand span {
            color: var(--accent-pink);
        }

        .nav-link {
            color: var(--light-gray) !important;
            font-weight: 500;
            margin: 0 10px;
            position: relative;
            padding: 5px 0 !important;
        }

        .nav-link:before {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: 0;
            left: 0;
            background-color: var(--accent-pink);
            visibility: hidden;
            transition: all 0.3s ease-in-out;
        }

        .nav-link:hover:before {
            visibility: visible;
            width: 100%;
        }

        .nav-link:hover {
            color: var(--accent-pink) !important;
        }

        .nav-link.active {
            color: var(--accent-pink) !important;
        }

        .nav-link.active:before {
            visibility: visible;
            width: 100%;
        }

        .dashboard-header {
            background: linear-gradient(rgba(0, 0, 0, 0.8), rgba(0, 0, 0, 0.8)),
            url('https://images.unsplash.com/photo-1517604931442-7e0c8ed2962c?ixlib=rb-4.0.3&auto=format&fit=crop&w=1470&q=80');
            background-size: cover;
            background-position: center;
            color: var(--white);
            padding: 60px 0;
            margin-bottom: 30px;
            text-align: center;
            position: relative;
        }

        .dashboard-header:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 100px;
            background: linear-gradient(transparent, var(--primary-black));
            z-index: 1;
        }

        .dashboard-header-content {
            position: relative;
            z-index: 2;
        }

        .card {
            background-color: var(--secondary-black);
            border-radius: 10px;
            padding: 30px;
            height: 100%;
            transition: all 0.4s;
            border-left: 4px solid transparent;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .card:hover {
            transform: translateY(-10px);
            border-left: 4px solid var(--accent-pink);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
        }

        .card-icon {
            font-size: 3rem;
            color: var(--accent-pink);
            margin-bottom: 20px;
            text-shadow: var(--glow-cyan);
            transition: all 0.3s;
        }

        .card:hover .card-icon {
            transform: scale(1.1);
        }

        .card-title {
            color: var(--white);
            margin-bottom: 15px;
        }

        .btn-pink {
            background-color: var(--accent-pink);
            color: var(--white);
            border: none;
            font-weight: 700;
            padding: 12px 20px;
            border-radius: 30px;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s;
            width: 100%;
        }

        .btn-pink:hover {
            background-color: var(--accent-dark-pink);
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(255, 20, 147, 0.3);
            color: var(--white);
        }

        .btn-outline-gray {
            border: 2px solid var(--medium-gray);
            color: var(--light-gray);
            background-color: transparent;
            font-weight: 700;
            padding: 10px 20px;
            border-radius: 30px;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s;
            width: 100%;
        }

        .btn-outline-gray:hover {
            border-color: var(--accent-pink);
            color: var(--accent-pink);
            transform: translateY(-3px);
        }

        .admin-container {
            max-width: 1200px;
            margin: 0 auto 50px;
            padding: 0 15px;
        }

        .alert {
            border-radius: 5px;
            border-left: 4px solid var(--accent-pink);
        }

        footer {
            background-color: var(--primary-black);
            padding: 30px 0;
            border-top: 1px solid var(--medium-gray);
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .dashboard-header {
                padding: 40px 0;
            }

            .card {
                margin-bottom: 20px;
            }
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">
            QUICK<span>FLIX</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp"><i class="fas fa-home me-1"></i> Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="#"><i class="fas fa-tachometer-alt me-1"></i> Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="viewUsers.jsp"><i class="fas fa-users me-1"></i> Users</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="viewMovies.jsp"><i class="fas fa-film me-1"></i> Movies</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="LoginServlet?action=logout"><i class="fas fa-sign-out-alt me-1"></i> Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<br>
<br>
<br>

<!-- Dashboard Header -->
<header class="dashboard-header">
    <div class="dashboard-header-content">
        <h1><i class="fas fa-tachometer-alt me-2"></i>ADMIN DASHBOARD</h1>
        <p class="lead mb-0">Manage your QuickFlicks platform operations</p>
    </div>
</header>

<!-- Dashboard Content -->
<div class="admin-container">
    <c:if test="${not empty param.success}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle me-2"></i>
            <c:choose>
                <c:when test="${param.success == 'movieAdded'}">Movie added successfully.</c:when>
                <c:when test="${param.success == 'movieUpdated'}">Movie updated successfully.</c:when>
                <c:when test="${param.success == 'movieDeleted'}">Movie deleted successfully.</c:when>
                <c:when test="${param.success == 'showTimesAdded'}">Showtimes added successfully.</c:when>
                <c:when test="${param.success == 'userDeleted'}">User deleted successfully.</c:when>
                <c:when test="${param.success == 'userPromoted'}">User promoted to admin successfully.</c:when>
                <c:otherwise>Operation completed successfully.</c:otherwise>
            </c:choose>
        </div>
    </c:if>
    <c:if test="${not empty param.error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle me-2"></i>
            <c:choose>
                <c:when test="${param.error == 'userNotFound'}">User not found.</c:when>
                <c:otherwise>Error: ${param.error}</c:otherwise>
            </c:choose>
        </div>
    </c:if>

    <div class="row g-4">
        <!-- Users Card -->
        <div class="col-md-4">
            <div class="card">
                <div class="card-body text-center">
                    <div class="card-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <h3 class="card-title">USERS</h3>
                    <p class="card-text">Manage user accounts and admin approvals</p>
                    <a href="viewUsers.jsp" class="btn btn-pink mt-3">
                        <i class="fas fa-users me-1"></i> VIEW USERS
                    </a>
                </div>
            </div>
        </div>

        <!-- Movies Card -->
        <div class="col-md-4">
            <div class="card">
                <div class="card-body text-center">
                    <div class="card-icon">
                        <i class="fas fa-film"></i>
                    </div>
                    <h3 class="card-title">MOVIES</h3>
                    <p class="card-text">Create, edit, and manage all movies</p>
                    <div class="d-grid gap-3 mt-3">
                        <a href="viewMovies.jsp" class="btn btn-pink">
                            <i class="fas fa-film me-1"></i> VIEW MOVIES
                        </a>
                        <a href="addMovie.jsp" class="btn btn-outline-gray">
                            <i class="fas fa-plus me-1"></i> ADD NEW MOVIE
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Showtimes Card -->
        <div class="col-md-4">
            <div class="card">
                <div class="card-body text-center">
                    <div class="card-icon">
                        <i class="fas fa-clock"></i>
                    </div>
                    <h3 class="card-title">SHOWTIMES</h3>
                    <p class="card-text">Add and manage movie showtimes</p>
                    <div class="d-grid gap-3 mt-3">
                        <a href="manageShowtimes.jsp" class="btn btn-pink">
                            <i class="fas fa-clock me-1"></i> VIEW SHOWTIMES
                        </a>
                        <a href="addShowtime.jsp" class="btn btn-outline-gray">
                            <i class="fas fa-plus me-1"></i> ADD NEW SHOWTIME
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Actions Row -->
    <div class="row mt-4 g-4">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title"><i class="fas fa-user-edit me-2"></i>QUICK USER ACTIONS</h4>
                    <div class="d-grid gap-3 mt-3">
                        <a href="addUser.jsp" class="btn btn-outline-gray">
                            <i class="fas fa-user-plus me-1"></i> ADD NEW USER
                        </a>
                        <a href="pendingApprovals.jsp" class="btn btn-outline-gray">
                            <i class="fas fa-user-check me-1"></i> VIEW PENDING APPROVALS
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title"><i class="fas fa-cog me-2"></i>SYSTEM MANAGEMENT</h4>
                    <div class="d-grid gap-3 mt-3">
                        <a href="systemSettings.jsp" class="btn btn-outline-gray">
                            <i class="fas fa-sliders-h me-1"></i> SYSTEM SETTINGS
                        </a>
                        <a href="reports.jsp" class="btn btn-outline-gray">
                            <i class="fas fa-chart-bar me-1"></i> GENERATE REPORTS
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer>
    <div class="container text-center">
        <p class="mb-0">© 2025 QUICKFLICKS. ALL RIGHTS RESERVED.</p>
    </div>
</footer>

<!-- Bootstrap 5 JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>