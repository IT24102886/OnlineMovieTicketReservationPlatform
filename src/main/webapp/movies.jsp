<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quick Flicks | Movies</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Montserrat:wght@800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
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
        }

        .movie-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--glow-cyan);
        }

        .movie-card:hover .movie-poster {
            transform: scale(1.05);
        }

        .movie-poster {
            width: 100%;
            height: 350px;
            object-fit: cover;
            transition: transform 0.4s;
        }

        .movie-info {
            padding: 20px;
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
            margin-right: 5px;
        }

        .showtime-btn {
            background-color: var(--dark-gray);
            color: var(--light-gray);
            border: none;
            padding: 8px 15px;
            margin: 5px;
            border-radius: 5px;
            transition: all 0.3s;
        }

        .showtime-btn:hover {
            background-color: var(--accent-dark-pink);
            color: var(--white);
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
            .movie-poster {
                height: 500px;
            }
        }

        @media (max-width: 768px) {
            .movie-poster {
                height: 400px;
            }
        }

        @media (max-width: 576px) {
            .section-title {
                font-size: 2rem;
            }
            .navbar-brand {
                font-size: 1.8rem;
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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/MovieServlet?action=list"><i class="fas fa-film me-1"></i> Movies</a>
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

<!-- Movies Section -->
<section class="py-5" style="background-color: var(--secondary-black);">
    <div class="container py-5">
        <h2 class="section-title text-white">NOW SHOWING IN THEATERS</h2>
        <div class="row g-4">
            <c:choose>
                <c:when test="${not empty movies}">
                    <c:forEach var="movie" items="${movies}">
                        <div class="col-lg-3 col-md-6">
                            <div class="movie-card">
                                <c:if test="${movie.releaseDate >= now}">
                                    <div class="coming-soon">NEW</div>
                                </c:if>
                                <img src="${movie.posterImageUrl}" class="movie-poster" alt="${movie.title} Poster">
                                <div class="movie-info">
                                    <h3 class="movie-title">${movie.title}</h3>
                                    <div class="movie-meta">
                                        <span>${movie.durationMinutes}m</span>
                                        <span class="movie-rating"><i class="fas fa-star"></i> 8.0</span> <!-- Placeholder rating -->
                                    </div>
                                    <c:forEach var="genre" items="${fn:split(movie.genre, ',')}">
                                        <span class="movie-badge">${genre}</span>
                                    </c:forEach>
                                    <div class="mt-3">
                                        <c:forEach var="showTime" items="${movie.showTimes}">
                                            <button class="showtime-btn">
                                                <fmt:formatDate value="${showTime}" pattern="hh:mm a"/>
                                            </button>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12 text-center">
                        <p class="text-white">No movies currently showing.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
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
                        <li><a href="${pageContext.request.contextPath}/MovieServlet?action=list">Movies</a></li>
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
                        <li><i class="fas fa-clock me-2"></i> Support 24/7</li>
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

    // Movie card hover effect
    document.querySelectorAll('.movie-card').forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.querySelector('.movie-poster').style.transform = 'scale(1.05)';
        });
        card.addEventListener('mouseleave', function() {
            this.querySelector('.movie-poster').style.transform = 'scale(1)';
        });
    });
</script>
</body>
</html>