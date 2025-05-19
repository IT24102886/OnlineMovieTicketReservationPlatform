
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
            overflow-x: hidden;
        }

        h1, h2, h3, h4, h5, h6 {
            font-family: 'Bebas Neue', sans-serif;
            letter-spacing: 1px;
        }

        .navbar {
            background-color: rgba(10, 15, 29, 0.95) !important;
            border-bottom: 2px solid var(--accent-dark-pink);
            padding: 15px 0;
            transition: all 0.3s ease;
        }

        .navbar.scrolled {
            padding: 10px 0;
            background-color: var(--primary-black) !important;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.3);
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 2.2rem;
            font-family: 'Bebas Neue', sans-serif;
            letter-spacing: 2px;
            color: var(--white) !important;
        }

        .navbar-brand span {
            color: var(--accent-dark-pink);
        }

        .nav-link {
            color: var(--light-gray) !important;
            font-weight: 600;
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
            background-color: var(--accent-dark-pink);
            visibility: hidden;
            transition: all 0.3s ease-in-out;
        }

        .nav-link:hover:before {
            visibility: visible;
            width: 100%;
        }

        .nav-link:hover {
            color: var(--accent-dark-pink) !important;
        }

        .nav-link.active {
            color: var(--accent-dark-pink) !important;
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
            border-left: 4px solid var(--accent-dark-pink);
            box-shadow: var(--glow-cyan);
        }

        .card-icon {
            font-size: 3rem;
            color: var(--accent-dark-pink);
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

        .btn-red {
            background-color: var(--accent-dark-pink);
            color: var(--white);
            border: none;
            font-weight: 700;
            padding: 12px 20px;
            border-radius: 5px;
            letter-spacing: 1px;
            transition: all 0.3s;
            width: 100%;
        }

        .btn-red:hover {
            background-color: var(--accent-pink);
            transform: translateY(-3px);
            box-shadow: var(--glow-cyan);
            color: var(--white);
        }

        .btn-outline-red {
            border: 2px solid var(--accent-dark-pink);
            color: var(--accent-dark-pink);
            background-color: transparent;
            font-weight: 700;
            padding: 10px 20px;
            border-radius: 5px;
            letter-spacing: 1px;
            transition: all 0.3s;
            width: 100%;
        }

        .btn-outline-red:hover {
            background-color: var(--accent-dark-pink);
            color: var(--white);
            transform: translateY(-3px);
            box-shadow: var(--glow-cyan);
        }

        .admin-container {
            max-width: 1200px;
            margin: 0 auto 50px;
            padding: 0 15px;
        }

        .alert {
            border-radius: 5px;
            border-left: 4px solid var(--accent-dark-pink);
            background-color: var(--dark-gray);
            color: var(--light-gray);
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
            QUICK<span>FLICKS</span>
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
                    <a class="nav-link" href="UserServlet?action=insertionSortUsersByName"><i class="fas fa-users me-1"></i> Users</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="viewMovies.jsp"><i class="fas fa-film me-1"></i> Movies</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="UserLogoutServlet">
                    <i class="fas fa-sign-out-alt me-2"></i> Logout
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<br>
<br>
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
                        <i class="fas fa-film"></i>
                    </div>
                    <h3 class="card-title">USERS</h3>
                    <p class="card-text">Create, edit, and manage all movies</p>
                    <div class="d-grid gap-3 mt-3">
                        <a href="viewUsers.jsp" class="btn btn-red">
                            <i class="fas fa-film me-1"></i> VIEW USERS
                        </a>
                        <a href="register.jsp" class="btn btn-outline-red">
                            <i class="fas fa-plus me-1"></i> ADD NEW USER
                        </a>
                    </div>
                </div>
            </div>
        </div>


        <!-- Movies Card -->
<%--        <div class="col-md-4">--%>
<%--            <div class="card">--%>
<%--                <div class="card-body text-center">--%>
<%--                    <div class="card-icon">--%>
<%--                        <i class="fas fa-film"></i>--%>
<%--                    </div>--%>
<%--                    <h3 class="card-title">MOVIES</h3>--%>
<%--                    <p class="card-text">Create, edit, and manage all movies</p>--%>
<%--                    <div class="d-grid gap-3 mt-3">--%>
<%--                        <a href="viewMovies.jsp" class="btn btn-red">--%>
<%--                            <i class="fas fa-film me-1"></i> VIEW MOVIES--%>
<%--                        </a>--%>
<%--                        <a href="addMovie.jsp" class="btn btn-outline-red">--%>
<%--                            <i class="fas fa-plus me-1"></i> ADD NEW MOVIE--%>
<%--                        </a>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>


            <div class="col-md-4">
                <div class="card">
                    <div class="card-body text-center">
                        <div class="card-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <h3 class="card-title">MOVIES</h3>
                        <p class="card-text">Create, edit, and manage all movies</p>
                        <div class="d-grid gap-3 mt-3">
                            <a href="viewMovies.jsp" class="btn btn-red">
                                <i class="fas fa-map-marker-alt me-1"></i> VIEW MOVIES
                            </a>
                            <a href="addMovie.jsp" class="btn btn-outline-red">
                                <i class="fas fa-plus me-1"></i>  ADD NEW MOVIE
                            </a>
                        </div>
                    </div>
                </div>
            </div>

        <div class="col-md-4">
            <div class="card">
                <div class="card-body text-center">
                    <div class="card-icon">
                        <i class="fas fa-clock"></i>
                    </div>
                    <h3 class="card-title">LOCATIONS</h3>
                    <p class="card-text">Add and manage movie locations</p>
                    <div class="d-grid gap-3 mt-3">
                        <a href="locations.jsp" class="btn btn-red">
                            <i class="fas fa-map-marker-alt me-1"></i> VIEW LOCATIONS
                        </a>
                        <a href="locations.jsp" class="btn btn-outline-red">
                            <i class="fas fa-plus me-1"></i> ADD NEW SHOWTIME
                        </a>
                    </div>
                </div>
            </div>
        </div>
        </div>

        <!-- Showtimes Card -->

    </div>

    <!-- Quick Actions Row -->
    <div class="row mt-4 g-4">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title"><i class="fas fa-bolt me-2"></i>QUICK ACTIONS</h4>
                    <div class="d-grid gap-3 mt-3">
                        <a href="feedback.jsp" class="btn btn-outline-red">
                            <i class="fas fa-user-plus me-1"></i> REVIEW FEEDBACK
                        </a>
                        <a href="pendingApprovals.jsp" class="btn btn-outline-red">
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
                        <a href="systemSettings.jsp" class="btn btn-outline-red">
                            <i class="fas fa-sliders-h me-1"></i> SYSTEM SETTINGS
                        </a>
                        <a href="reports.jsp" class="btn btn-outline-red">
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
<!-- Custom JS -->
<script>
    // Navbar scroll effect
    window.addEventListener('scroll', function() {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });
</script>
</body>
</html>
