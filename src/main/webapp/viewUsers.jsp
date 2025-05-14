<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>User Management | QuickFlicks</title>
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

        .card {
            background-color: var(--secondary-black);
            border-radius: 10px;
            border-left: 4px solid var(--accent-dark-pink);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            overflow: hidden;
        }

        .card-header {
            background-color: var(--dark-gray);
            color: var(--white);
            border-bottom: 1px solid var(--medium-gray);
            padding: 20px;
        }

        .table-container {
            background-color: var(--secondary-black);
            border-radius: 0 0 10px 10px;
            overflow: hidden;
        }

        .table {
            color: var(--light-gray);
            margin-bottom: 0;
        }

        .table thead {
            background-color: var(--dark-gray);
            color: var(--white);
            text-transform: uppercase;
            font-size: 0.9rem;
        }

        .table th {
            border-bottom: 2px solid var(--accent-dark-pink);
            padding: 15px;
            font-family: 'Bebas Neue', sans-serif;
        }

        .table td {
            border-bottom: 1px solid var(--medium-gray);
            padding: 15px;
            vertical-align: middle;
        }

        .table tbody tr:hover {
            background-color: rgba(236, 72, 153, 0.05);
        }

        .btn-red {
            background-color: var(--accent-dark-pink);
            color: var(--white);
            border: none;
            font-weight: 700;
            padding: 8px 15px;
            border-radius: 5px;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 0.8rem;
            transition: all 0.3s;
        }

        .btn-red:hover {
            background-color: var(--accent-pink);
            transform: translateY(-2px);
            box-shadow: var(--glow-cyan);
            color: var(--white);
        }

        .btn-outline-red {
            border: 2px solid var(--accent-dark-pink);
            color: var(--accent-dark-pink);
            background-color: transparent;
            font-weight: 700;
            padding: 8px 15px;
            border-radius: 5px;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 0.8rem;
            transition: all 0.3s;
        }

        .btn-outline-red:hover {
            background-color: var(--accent-dark-pink);
            color: var(--white);
            transform: translateY(-2px);
            box-shadow: var(--glow-cyan);
        }

        .badge-admin {
            background-color: var(--accent-dark-pink);
            color: var(--white);
            font-weight: 700;
            padding: 6px 12px;
            border-radius: 20px;
            text-transform: uppercase;
            font-size: 0.7rem;
        }

        .badge-user {
            background-color: var(--medium-gray);
            color: var(--light-gray);
            font-weight: 700;
            padding: 6px 12px;
            border-radius: 20px;
            text-transform: uppercase;
            font-size: 0.7rem;
        }

        .action-buttons {
            white-space: nowrap;
        }

        .card-footer {
            background-color: var(--dark-gray);
            border-top: 1px solid var(--medium-gray);
            padding: 20px;
        }

        footer {
            background-color: var(--primary-black);
            padding: 30px 0;
            border-top: 1px solid var(--medium-gray);
        }

        .admin-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 80px 15px 50px;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .table-responsive {
                overflow-x: auto;
            }

            .action-buttons {
                white-space: normal;
            }

            .btn-red, .btn-outline-red {
                display: block;
                width: 100%;
                margin-bottom: 5px;
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
                    <a class="nav-link" href="adminDashboard.jsp"><i class="fas fa-tachometer-alt me-1"></i> Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="viewUsers.jsp"><i class="fas fa-users me-1"></i> Users</a>
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

<!-- Main Content -->
<div class="admin-container">
    <div class="card">
        <div class="card-header">
            <div class="d-flex justify-content-between align-items-center">
                <h3 class="mb-0"><i class="fas fa-users me-2"></i>USER MANAGEMENT</h3>
                <div>
                    <a href="UserServlet?action=sortByName" class="btn btn-outline-red me-2">
                        <i class="fas fa-sort me-1"></i> SORT BY NAME
                    </a>
                    <a href="addUser.jsp" class="btn btn-red">
                        <i class="fas fa-user-plus me-1"></i> ADD USER
                    </a>
                </div>
            </div>
        </div>

        <div class="table-container">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead>
                    <tr>
                        <th>USER ID</th>
                        <th>NAME</th>
                        <th>EMAIL</th>
                        <th>ROLE</th>
                        <th>CONTACT</th>
                        <th>ACTIONS</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td>${user.userId}</td>
                            <td>${user.name}</td>
                            <td>${user.email}</td>
                            <td>
                                <span class="${user.admin ? 'badge-admin' : 'badge-user'}">
                                        ${user.admin ? 'Admin' : 'User'}
                                </span>
                            </td>
                            <td>${user.contactNumber}</td>
                            <td class="action-buttons">
                                <a href="UserServlet?action=viewProfile&userId=${user.userId}" class="btn btn-outline-red me-1">
                                    <i class="fas fa-eye"></i> VIEW
                                </a>
                                <a href="editUser.jsp?userId=${user.userId}" class="btn btn-outline-red me-1">
                                    <i class="fas fa-edit"></i> EDIT
                                </a>
                                <a href="UserServlet?action=delete&userId=${user.userId}"
                                   class="btn btn-outline-red"
                                   onclick="return confirm('Are you sure you want to delete this user?')">
                                    <i class="fas fa-trash-alt"></i> DELETE
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="card-footer">
            <a href="adminDashboard.jsp" class="btn btn-outline-red">
                <i class="fas fa-arrow-left me-1"></i> BACK TO DASHBOARD
            </a>
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