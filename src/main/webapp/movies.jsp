<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Now Showing - QuickFlicks</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Montserrat:wght@800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <link rel="icon" href="Logos/1.jpeg" type="image/jpeg">
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
        }

        .navbar-brand .quick {
            color: var(--white);
        }

        .navbar-brand .flicks {
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

        /* Buttons */
        .btn-red {
            background-color: var(--accent-dark-pink);
            color: var(--white);
            border: none;
            font-weight: 700;
            padding: 12px 30px;
            border-radius: 5px;
            letter-spacing: 1px;
            transition: all 0.3s;
        }

        .btn-red:hover {
            background-color: var(--accent-pink);
            transform: translateY(-3px);
            box-shadow: var(--glow-cyan);
            color: var(--white);
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
        }

        .btn-outline-red:hover {
            background-color: var(--accent-dark-pink);
            color: var(--white);
            transform: translateY(-3px);
            box-shadow: var(--glow-cyan);
        }

        .section-title {
            position: relative;
            display: inline-block;
            margin-bottom: 3rem;
            font-size: 2.5rem;
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

        .movie-card {
            background-color: var(--secondary-black);
            border-radius: 10px;
            overflow: hidden;
            transition: all 0.4s;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            position: relative;
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .movie-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--glow-cyan);
        }

        .movie-card:hover .movie-poster {
            transform: scale(1.05);
        }

        .movie-poster-container {
            overflow: hidden;
            height: 350px;
        }

        .movie-poster {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.4s;
        }

        .movie-info {
            padding: 20px;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }

        .movie-title {
            color: var(--white);
            margin-bottom: 10px;
            font-size: 1.5rem;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .movie-meta {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            color: var(--medium-gray);
        }

        .movie-meta span {
            margin-right: 15px;
        }

        .movie-rating {
            color: var(--rating-yellow);
            font-weight: bold;
        }

        .movie-badge {
            background-color: var(--accent-dark-pink);
            color: var(--white);
            padding: 3px 8px;
            border-radius: 5px;
            font-size: 0.8rem;
            font-weight: bold;
        }

        .movie-description {
            color: var(--light-gray);
            font-size: 0.9rem;
            margin-bottom: 15px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
            flex-grow: 1;
        }

        .movie-actions {
            margin-top: auto;
        }

        .filters-section {
            background-color: var(--secondary-black);
            padding: 2rem 0;
        }

        .filter-group {
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .filter-group label {
            color: var(--accent-dark-pink);
            font-family: 'Bebas Neue', sans-serif;
            font-size: 1.2rem;
            margin-right: 10px;
        }

        .filter-select, .filter-input {
            background-color: var(--dark-gray);
            border: 1px solid var(--medium-gray);
            color: var(--light-gray);
            padding: 10px;
            border-radius: 5px;
            font-size: 1rem;
        }

        .filter-select:focus, .filter-input:focus {
            outline: none;
            border-color: var(--accent-dark-pink);
            box-shadow: var(--glow-cyan);
        }

        .movies-grid-section {
            padding: 3rem 0;
        }

        .movies-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 2rem;
        }

        .loading-spinner {
            text-align: center;
            padding: 3rem;
        }

        .spinner {
            width: 50px;
            height: 50px;
            border: 5px solid var(--medium-gray);
            border-top: 5px solid var(--accent-dark-pink);
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin: 0 auto 1rem;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .no-results {
            text-align: center;
            padding: 3rem;
            color: var(--light-gray);
            font-size: 1.2rem;
        }

        main {
            padding-top: 70px; /* Offset for fixed navbar */
            min-height: calc(100vh - 400px); /* Ensure adequate height for content */
        }

        footer {
            background-color: var(--primary-black);
            padding: 60px 0 20px;
            position: relative;
        }

        .footer-logo {
            font-size: 2rem;
            font-weight: 700;
            color: var(--accent-dark-pink);
            margin-bottom: 20px;
            font-family: 'Bebas Neue', sans-serif;
            letter-spacing: 2px;
        }

        .footer-links h5 {
            color: var(--accent-dark-pink);
            margin-bottom: 20px;
            font-family: 'Bebas Neue', sans-serif;
            letter-spacing: 1px;
            font-size: 1.5rem;
        }

        .footer-links ul {
            list-style: none;
            padding: 0;
        }

        .footer-links a {
            color: var(--light-gray);
            text-decoration: none;
            transition: all 0.3s;
        }

        .footer-links a:hover {
            color: var(--accent-dark-pink);
            padding-left: 5px;
        }

        .social-icons a {
            display: inline-block;
            width: 40px;
            height: 40px;
            background-color: var(--dark-gray);
            color: var(--light-gray);
            border-radius: 50%;
            text-align: center;
            line-height: 40px;
            margin-right: 10px;
            transition: all 0.3s;
        }

        .social-icons a:hover {
            background-color: var(--accent-dark-pink);
            color: var(--white);
            transform: translateY(-5px);
        }

        .copyright {
            border-top: 1px solid var(--medium-gray);
            padding-top: 20px;
            margin-top: 40px;
            text-align: center;
        }

        /* Responsive Adjustments */
        @media (max-width: 992px) {
            .movie-poster-container {
                height: 300px;
            }
        }

        @media (max-width: 768px) {
            .movie-poster-container {
                height: 250px;
            }
        }

        @media (max-width: 576px) {
            .section-title {
                font-size: 2rem;
            }
            .navbar-brand {
                font-size: 1.8rem;
            }
            main {
                padding-top: 60px; /* Adjust for smaller navbar on mobile */
            }
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="index.jsp"><span class="quick">QUICK</span><span class="flicks">FLICKS</span></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp"><i class="fas fa-home me-1"></i> Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="movies.jsp"><i class="fas fa-film me-1"></i> Movies</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="theaters.jsp"><i class="fas fa-map-marker-alt me-1"></i> Theaters</a>
                </li>
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <li class="nav-item">
                            <a class="nav-link" href="userDashboard.jsp"><i class="fas fa-user me-1"></i> Profile</a>
                        </li>
                        <li class="nav-item">
                            <form action="${pageContext.request.contextPath}/UserLogoutServlet" method="post" style="display: inline;">
                                <button type="submit" class="nav-link btn btn-link"><i class="fas fa-sign-out-alt me-1"></i> Logout</button>
                            </form>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link" href="login.jsp"><i class="fas fa-sign-in-alt me-1"></i> Login</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="register.jsp"><i class="fas fa-user-plus me-1"></i> Register</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<main class="movies-main">
    <section class="filters-section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-5 filter-group">
                    <label for="genre-filter"><i class="fas fa-tags me-2"></i> Genre:</label>
                    <select id="genre-filter" class="filter-select form-select">
                        <option value="all">All Genres</option>
                        <option value="28">Action</option>
                        <option value="12">Adventure</option>
                        <option value="16">Animation</option>
                        <option value="35">Comedy</option>
                        <option value="80">Crime</option>
                        <option value="18">Drama</option>
                        <option value="10751">Family</option>
                        <option value="14">Fantasy</option>
                        <option value="27">Horror</option>
                        <option value="9648">Mystery</option>
                        <option value="10749">Romance</option>
                        <option value="878">Science Fiction</option>
                        <option value="53">Thriller</option>
                    </select>
                </div>
                <div class="col-md-5 filter-group">
                    <label for="date-filter"><i class="far fa-calendar-alt me-2"></i> Date:</label>
                    <input type="date" id="date-filter" class="filter-input form-control">
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-12 text-center">
                    <button id="apply-filters" class="btn btn-red">Apply Filters</button>
                    <button id="clear-filters" class="btn btn-outline-red ms-2">Clear Filters</button>
                </div>
            </div>
        </div>
    </section>
    <!-- Now Playing Section -->
    <section class="py-5">
        <div class="container">
            <h2 class="section-title text-white">NOW SHOWING IN THEATERS</h2>
            <div id="now-playing-container" class="row"></div>
        </div>
    </section>
</main>
<!-- Coming Soon Section -->
<section class="py-5 bg-dark">
    <div class="container">
        <h2 class="section-title text-white">COMING SOON</h2>
        <div id="coming-soon-container" class="row"></div>
    </div>
</section>

<!-- Footer -->
<footer>
    <div class="container">
        <div class="row">
            <div class="col-lg-4 mb-4">
                <div class="footer-logo">QUICK<span>FLICKS</span></div>
                <p>Your premier destination for movie tickets, exclusive content, and unforgettable cinematic experiences.</p>
                <div class="social-icons mt-3">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-youtube"></i></a>
                </div>
            </div>
            <div class="col-lg-2 col-md-6 mb-4">
                <div class="footer-links">
                    <h5>Quick Links</h5>
                    <ul>
                        <li><a href="index.jsp">Home</a></li>
                        <li><a href="movies.jsp">Movies</a></li>
                        <li><a href="theaters.jsp">Theaters</a></li>
                        <li><a href="login.jsp">Login</a></li>
                        <li><a href="register.jsp">Register</a></li>
                        <li><a href="adminLogin.jsp">Admin</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="footer-links">
                    <h5>Information</h5>
                    <ul>
                        <li><a href="#">About Us</a></li>
                        <li><a href="#">Contact Us</a></li>
                        <li><a href="#">Terms & Conditions</a></li>
                        <li><a href="#">Privacy Policy</a></li>
                        <li><a href="#">FAQ</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="footer-links">
                    <h5>Contact</h5>
                    <ul>
                        <li><i class="fas fa-map-marker-alt me-2"></i> 123 Main St, Malabe</li>
                        <li><i class="fas fa-phone me-2"></i> (0112) 987-654</li>
                        <li><i class="fas fa-envelope me-2"></i> info@quickflicks.com</li>
                        <li><i class="fas fa-clock me-2"></i> Support. 24/7</li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="copyright">
            <p>© 2025 QUICK FLICKS. ALL RIGHTS RESERVED.</p>
        </div>
    </div>
</footer>

<!-- Bootstrap 5 JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="script.js"></script>
</body>
</html>