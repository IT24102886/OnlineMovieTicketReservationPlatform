<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.IOException" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Quick Flicks | Premium Movie Experience</title>
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

    /* Hero Carousel */
    .hero-section {
      height: 100vh;
      min-height: 700px;
      position: relative;
      overflow: hidden;
      z-index: 1;
    }

    .hero-carousel {
      width: 100%;
      height: 100vh;
      object-fit: cover;
    }

    .hero-overlay {
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7));
      display: flex;
      align-items: center;
    }

    .hero-content {
      position: relative;
      z-index: 2;
      padding-top: 150px; /* Increased to move content lower */
    }

    .hero-title {
      font-size: 5rem;
      font-weight: 700;
      margin-bottom: 1.5rem;
      text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.5);
      line-height: 1;
    }

    .hero-subtitle {
      font-size: 1.5rem;
      margin-bottom: 2.5rem;
      max-width: 700px;
    }

    .hero-badge {
      background-color: var(--accent-cyan);
      color: var(--primary-black);
      padding: 5px 15px;
      border-radius: 30px;
      font-weight: bold;
      display: inline-block;
      margin-bottom: 15px;
      text-transform: uppercase;
      font-size: 0.9rem;
    }

    section:not(.hero-section) {
      position: relative;
      z-index: 0;
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
    }

    /*.profile-section {*/
    /*  background-color: var(--secondary-black);*/
    /*  padding: 2rem;*/
    /*  border-radius: 10px;*/
    /*  margin: 2rem 0;*/
    /*  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);*/
    /*}*/

    /*.profile-header {*/
    /*  text-align: center;*/
    /*  margin-bottom: 2rem;*/
    /*}*/

    .profile-header h2 {
      color: var(--white);
      font-size: 2.5rem;
      margin-bottom: 0.5rem;
    }

    .profile-card {
      background-color: var(--dark-gray);
      border-radius: 8px;
      padding: 1.5rem;
      margin-bottom: 2rem;
    }

    .profile-detail {
      margin-bottom: 1rem;
      font-size: 1.1rem;
    }

    .btn-action {
      background-color: var(--accent-dark-pink);
      border: none;
      padding: 10px 20px;
      font-weight: 600;
      letter-spacing: 1px;
      text-transform: uppercase;
      transition: all 0.3s;
      margin-right: 1rem;
    }

    .btn-action:hover {
      background-color: var(--accent-dark-pink);
      transform: translateY(-3px);
      box-shadow: var(--glow-cyan);
    }

    .booking-table {
      background-color: var(--dark-gray);
      border-radius: 8px;
      padding: 1.5rem;
    }

    .table {
      color: var(--light-gray);
    }

    .table th {
      color: var(--accent-dark-pink);
      font-family: 'Bebas Neue', sans-serif;
      letter-spacing: 1px;
    }

    .stats-section {
      background: linear-gradient(rgba(0, 0, 0, 0.8), rgba(0, 0, 0, 0.8)),
      url('https://images.unsplash.com/photo-1536440136628-849c177e76a1?ixlib=rb-4.0.3&auto=format&fit=crop&w=1470&q=80');
      background-size: cover;
      background-position: center;
      background-attachment: fixed;
      padding: 100px 0;
      position: relative;
    }

    .stat-item {
      text-align: center;
      padding: 30px;
    }

    .stat-number {
      font-size: 3.5rem;
      font-weight: 700;
      color: var(--accent-dark-pink);
      margin-bottom: 10px;
    }

    .stat-label {
      font-size: 1.2rem;
      letter-spacing: 1px;
    }

    .testimonials-section {
      background-color: var(--secondary-black);
      padding: 100px 0;
    }

    .testimonial-card {
      background-color: var(--dark-gray);
      border-radius: 10px;
      padding: 30px;
      margin: 15px;
      position: relative;
      border-left: 4px solid var(--accent-dark-pink);
    }

    .testimonial-text {
      font-style: italic;
      margin-bottom: 20px;
    }

    .testimonial-author {
      font-weight: 700;
      color: var(--accent-dark-pink);
    }

    .testimonial-rating {
      color: var(--rating-yellow);
      margin-bottom: 10px;
    }

    .cta-section {
      background: linear-gradient(135deg, var(--primary-black) 0%, var(--dark-gray) 100%);
      padding: 80px 0;
      border-top: 2px solid var(--accent-dark-pink);
      border-bottom: 2px solid var(--accent-dark-pink);
    }

    .cta-title {
      font-size: 2.5rem;
      margin-bottom: 20px;
    }

    .cta-subtitle {
      font-size: 1.2rem;
      margin-bottom: 30px;
      opacity: 0.9;
    }

    /*editors pick section*/
    /*.featured-badge {*/
    /*  background-color: var(--accent-cyan);*/
    /*  color: var(--primary-black);*/
    /*  padding: 5px 15px;*/
    /*  border-radius: 30px;*/
    /*  font-weight: bold;*/
    /*  display: inline-block;*/
    /*  margin-bottom: 15px;*/
    /*  text-transform: uppercase;*/
    /*  font-size: 0.9rem;*/
    /*}*/

    .featured-movie {
      position: relative;
      border-radius: 10px;
      overflow: hidden;
      height: 500px;
    }

    .featured-movie img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .featured-overlay {
      position: absolute;
      bottom: 0;
      left: 0;
      right: 0;
      background: linear-gradient(to top, rgba(0,0,0,0.9), transparent);
      padding: 30px;
      color: var(--white); /* Changed to make text content more white */
    }

    .coming-soon {
      position: absolute;
      top: 15px;
      right: 15px;
      background-color: var(--accent-dark-pink);
      color: var(--white);
      padding: 5px 10px;
      border-radius: 5px;
      font-weight: bold;
      z-index: 2;
      transform: rotate(15deg);
    }

    .theater-card {
      background-color: var(--secondary-black);
      border-radius: 10px;
      padding: 20px;
      transition: all 0.3s;
      height: 100%;
      border-left: 4px solid transparent;
    }

    .theater-card:hover {
      transform: translateY(-5px);
      border-left: 4px solid var(--accent-dark-pink);
      box-shadow: var(--glow-cyan);
    }

    .theater-name {
      color: var(--accent-dark-pink);
      font-size: 1.3rem;
      margin-bottom: 10px;
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

    /* Updated Carousel-specific styles */
    .carousel-control-prev, .carousel-control-next {
      width: 5%;
      background: transparent;
      transition: none;
    }

    .carousel-control-prev:hover, .carousel-control-next:hover {
      background: transparent;
    }

    .carousel-control-prev-icon, .carousel-control-next-icon {
      background-size: 100%, 100%;
      background-image: none;
      width: 24px;
      height: 24px;
    }

    .carousel-control-prev-icon::after, .carousel-control-next-icon::after {
      font-family: 'Font Awesome 6 Free';
      font-weight: 900;
      font-size: 24px;
      color: var(--light-gray);
      transition: color 0.3s;
    }

    .carousel-control-prev-icon::after {
      content: '\f053';
    }

    .carousel-control-next-icon::after {
      content: '\f054';
    }

    .carousel-control-prev:hover .carousel-control-prev-icon::after,
    .carousel-control-next:hover .carousel-control-next-icon::after {
      color: var(--accent-pink);
    }

    .carousel-indicators {
      display: none;
    }

    @keyframes pulse {
      0% { transform: scale(1); }
      50% { transform: scale(1.05); }
      100% { transform: scale(1); }
    }

    .pulse-animation {
      animation: pulse 2s infinite;
    }

    /* Responsive Adjustments */
    @media (max-width: 992px) {
      .hero-title {
        font-size: 4rem;
      }
      .movie-poster {
        height: 500px;
      }
      .hero-section {
        height: 80vh;
        min-height: 500px;
      }
    }

    @media (max-width: 768px) {
      .hero-title {
        font-size: 3rem;
      }
      .hero-subtitle {
        font-size: 1.2rem;
      }
      .movie-poster {
        height: 4000px;
      }
      .hero-section {
        height: 70vh;
        min-height: 400px;
      }
    }

    @media (max-width: 576px) {
      .hero-title {
        font-size: 2.5rem;
      }
      .section-title {
        font-size: 2rem;
      }
      .hero-section {
        height: 60vh;
        min-height: 300px;
      }
      .hero-subtitle {
        font-size: 1rem;
      }
      .navbar-brand {
        font-size: 1.8rem;
      }
    }

    /* Feedback Section Styles */
    .feedback-section {
        background-color: var(--primary-black);
        padding: 80px 0;
    }

    .feedback-section h2 {
        color: var(--white);
        font-size: 3rem;
        margin-bottom: 2rem;
        text-transform: uppercase;
    }

    .feedback-card {
        transition: all 0.3s ease;
        background-color: var(--secondary-black);
        border-radius: 10px;
        border-left: 4px solid var(--accent-dark-pink);
        margin-bottom: 20px;
    }

    .feedback-card:hover {
        transform: translateY(-5px);
        box-shadow: var(--glow-cyan);
    }

    .feedback-content {
        color: var(--light-gray);
    }

    .rating {
        color: var(--rating-yellow);
        font-size: 1.2rem;
        margin-bottom: 10px;
    }

    .feedback-content strong {
        color: var(--accent-dark-pink);
    }

    .feedback-content br {
        margin-bottom: 5px;
    }
  </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
  <div class="container">
    <a class="navbar-brand" href="#"><span class="quick">QUICK</span><span class="flicks">FLICKS</span></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link active" href="index.jsp"><i class="fas fa-home me-1"></i> Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="movies.jsp"><i class="fas fa-film me-1"></i> Movies</a>
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

<!-- Hero Carousel Section -->
<section class="hero-section">
  <div id="heroCarousel" class="carousel slide h-100" data-bs-ride="carousel">
    <div class="carousel-inner h-100">
      <!-- Featured Movie Slide -->
      <div class="carousel-item active h-100">
        <img src="https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?ixlib=rb-4.0.3&auto=format&fit=crop&w=1470&q=80" class="hero-carousel d-block w-100" alt="Movie Night">
        <div class="hero-overlay">
          <div class="container">
            <div class="hero-content">
              <br><br><br>
              <h1 class="hero-title">YOUR TICKET TO<br>UNLIMITED ENTERTAINMENT</h1>
              <p class="hero-subtitle">Book tickets for the latest blockbusters, exclusive premieres, and special events at theaters near you.</p>
              <div class="d-flex flex-wrap gap-3">
                <a href="#" class="btn btn-red"><i class="fas fa-film me-2"></i> BROWSE MOVIES</a>
                <a href="#" class="btn btn-outline-red"><i class="fas fa-calendar-alt me-2"></i> BOOK NOW</a>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="carousel-item h-100">
        <img src="https://images.savoysystems.co.uk/KIW/33936241.jpg" class="hero-carousel d-block w-100" alt="Mission: Impossible">
        <div class="hero-overlay">
          <div class="container">
            <div class="hero-content">
              <br><br><br><br>
              <span class="hero-badge">Special Engagement</span>
              <h1 class="hero-title">Mission: Impossible – The Final Reckoning</h1>
              <p class="hero-subtitle">Ethan Hunt and the IMF team race against time to find the Entity, a rogue artificial intelligence that can destroy mankind.</p>
              <div class="d-flex flex-wrap gap-3">
                <a href="#" class="btn btn-red pulse-animation"><i class="fas fa-ticket-alt me-2"></i> BUY TICKETS</a>
                <a href="https://youtu.be/fsQgc9pCyDU?si=tdItr4vyNnccASZA" class="btn btn-outline-red"><i class="fas fa-play-circle me-2"></i> WATCH TRAILER</a>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="carousel-item h-100">
        <img src="https://images.unsplash.com/photo-1536440136628-849c177e76a1?ixlib=rb-4.0.3&auto=format&fit=crop&w=1470&q=80" class="hero-carousel d-block w-100" alt="Movie Theater">
        <div class="hero-overlay">
          <div class="container">
            <div class="hero-content">
              <br><br><br>
              <h1 class="hero-title">PREMIUM MOVIE EXPERIENCE</h1>
              <p class="hero-subtitle">Enjoy movies like never before in our state-of-the-art theaters, featuring immersive Dolby Atmos sound and breathtaking IMAX visuals that put you at the heart of the action</p>
              <div class="d-flex flex-wrap gap-3">
                <a href="#" class="btn btn-red"><i class="fas fa-map-marker-alt me-2"></i> FIND THEATERS</a>
                <a href="#" class="btn btn-outline-red"><i class="fas fa-crown me-2"></i> VIP LOUNGE</a>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="carousel-item h-100">
        <img src="https://rialtocinemas.com/wp-content/uploads/2025/04/Thunderbolts-Banner-1536x734.jpg" class="hero-carousel d-block w-100" alt="Thunderbolts*">
        <div class="hero-overlay">
          <div class="container">
            <div class="hero-content">
              <br><br><br><br><br>
              <h1 class="hero-title">THUNDERBOLTS*</h1>
              <p class="hero-subtitle">Catch the explosive action now! Thunderbolts brings a rogue team of antiheroes to life on the big screen.</p>
              <div class="d-flex flex-wrap gap-3">
                <a href="#" class="btn btn-red pulse-animation"><i class="fas fa-ticket-alt me-2"></i> BUY TICKETS</a>
                <a href="https://youtu.be/v-94Snw-H4o?si=hu5IOIDLSoT5HgdR" class="btn btn-outline-red"><i class="fas fa-play-circle me-2"></i> WATCH TRAILER</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel" data-bs-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Next</span>
    </button>
  </div>
</section>

<!-- Editor's pick Section -->
<section class="py-5" style="background-color: var(--dark-gray);">
  <div class="container py-4">
    <h2 class="section-title text-white"><i class="fas fa-crown me-2"></i> EDITOR'S PICK</h2>
    <div class="featured-movie">
      <img src="https://4kwallpapers.com/images/walls/thumbs_3t/20040.jpg" alt="A Minecraft Movie">
      <div class="featured-overlay">
        <h2 style="font-size: 2.5rem; margin-bottom: 10px; color: var(--white);">A Minecraft Movie</h2>
        <div class="movie-meta my-3">
          <span class="me-3"><i class="fas fa-certificate"></i> PG-13</span>
          <span class="me-3"><i class="far fa-clock"></i> 2h 15m</span>
          <span class="movie-rating"><i class="fas fa-star"></i> 8.7/10</span>
        </div>
        <p style="max-width: 600px; margin-bottom: 20px; color: var(--white);">A mysterious portal pulls four misfits into the Overworld, a bizarre, cubic wonderland that thrives on imagination. To get back home, they'll have to master the terrain while embarking on a magical quest with an unexpected crafter named Steve.</p>
        <div class="d-flex flex-wrap gap-3">
          <a href="#" class="btn btn-red"><i class="fas fa-ticket-alt me-2"></i> GET TICKETS</a>
          <a href="https://youtu.be/8B1EtVPBSMw?si=-S_mggg1N3JA7dLl" class="btn btn-outline-red"><i class="fas fa-play-circle me-2"></i> WATCH TRAILER</a>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Now Playing Section -->
<section id="now-playing" class="py-5" style="background-color: var(--secondary-black);">
  <div class="container py-5">
    <h2 class="section-title text-white">NOW PLAYING</h2>
    <div class="row g-4">
      <div class="col-lg-3 col-md-6">
        <div class="movie-card">
          <div class="coming-soon">NEW</div>
          <img src="https://i.redd.it/lmw9lobh2n7e1.jpeg" class="movie-poster" alt="Movie Poster">
          <div class="movie-info">
            <h3 class="movie-title">Lilo & Stitch</h3>
            <div class="movie-meta">
              <span>2h 15m</span>
              <span class="movie-rating"><i class="fas fa-star"></i> 8.7</span>
            </div>
            <span class="movie-badge">COMEDY</span>
            <span class="movie-badge">SCI-FI</span>
            <div class="mt-3">
              <button class="showtime-btn">10:00 AM</button>
              <button class="showtime-btn">1:30 PM</button>
              <button class="showtime-btn">4:45 PM</button>
              <button class="showtime-btn">8:00 PM</button>
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <div class="movie-card">
          <img src="https://image.tmdb.org/t/p/original/fvodooEJ74rXV9MfBM8asTGBv3Z.jpg" class="movie-poster" alt="Movie Poster">
          <div class="movie-info">
            <h3 class="movie-title">Thunderbolts*</h3>
            <div class="movie-meta">
              <span>1h 58m</span>
              <span class="movie-rating"><i class="fas fa-star"></i> 7.9</span>
            </div>
            <span class="movie-badge">ACTION</span>
            <span class="movie-badge">ADVENTURE</span>
            <div class="mt-3">
              <button class="showtime-btn">11:15 AM</button>
              <button class="showtime-btn">2:30 PM</button>
              <button class="showtime-btn">5:45 PM</button>
              <button class="showtime-btn">9:00 PM</button>
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <div class="movie-card">
          <img src="https://i0.wp.com/www.justaddcoloronline.com/wp-content/uploads/2024/05/Moana-2-Teaser-Poster-Movie-Database-May-29th-2024.jpg?w=970&ssl=1" class="movie-poster" alt="Movie Poster">
          <div class="movie-info">
            <h3 class="movie-title">Moana 2</h3>
            <div class="movie-meta">
              <span>1h 45m</span>
              <span class="movie-rating"><i class="fas fa-star"></i> 6.8</span>
            </div>
            <span class="movie-badge">FAMILY</span>
            <span class="movie-badge">ADVENTURE</span>
            <div class="mt-3">
              <button class="showtime-btn">10:30 AM</button>
              <button class="showtime-btn">1:00 PM</button>
              <button class="showtime-btn">4:15 PM</button>
              <button class="showtime-btn">7:30 PM</button>
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <div class="movie-card">
          <div class="coming-soon">NEW</div>
          <img src="https://s3.amazonaws.com/nightjarprod/content/uploads/sites/130/2025/03/24184557/SNNRS_EM_VERT_DOM_TSR_1080x1920_NIRD_REV.jpg" class="movie-poster" alt="Movie Poster">
          <div class="movie-info">
            <h3 class="movie-title">Sinners</h3>
            <div class="movie-meta">
              <span>2h 05m</span>
              <span class="movie-rating"><i class="fas fa-star"></i> 7.2</span>
            </div>
            <span class="movie-badge">HORROR</span>
            <span class="movie-badge">ADVENTURE</span>
            <div class="mt-3">
              <button class="showtime-btn">12:00 PM</button>
              <button class="showtime-btn">3:15 PM</button>
              <button class="showtime-btn">6:30 PM</button>
              <button class="showtime-btn">9:45 PM</button>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="text-center mt-4">
      <a href="movies.jsp" class="btn btn-outline-red">View All Movies</a>
    </div>
  </div>
</section>

<!-- Coming Soon Section -->
<section class="py-5" style="background-color: var(--dark-gray);">
  <div class="container py-5">
    <h2 class="section-title text-white">COMING SOON</h2>
    <div class="row g-4">
      <div class="col-lg-3 col-md-6">
        <div class="movie-card">
          <img src="https://media.formula1.com/image/upload/t_16by9Centre/f_auto/q_auto/v1741890645/fom-website/2025/F1%20movie/f1_movie_poster16x9%20(1).jpg" class="movie-poster" alt="Movie Poster">
          <div class="movie-info">
            <h3 class="movie-title">F1</h3>
            <div class="movie-meta">
              <span>Coming Jun 27</span>
            </div>
            <span class="movie-badge">ACTION</span>
            <span class="movie-badge">SPORTS</span>
            <div class="mt-3">
              <button class="btn btn-outline-red btn-sm w-100">NOTIFY ME</button>
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <div class="movie-card">
          <img src="https://m.media-amazon.com/images/M/MV5BOTkwZmNmOTYtYjY1Mi00YjkzLThmODQtZjgyZDk5ODliMDNiXkEyXkFqcGc@._V1_.jpg" class="movie-poster" alt="Movie Poster">
          <div class="movie-info">
            <h3 class="movie-title">Spider-Man: Brand New Day</h3>
            <div class="movie-meta">
              <span>Coming Jul 31</span>
            </div>
            <span class="movie-badge">ADVENTURE</span>
            <span class="movie-badge">ACTION</span>
            <div class="mt-3">
              <button class="btn btn-outline-red btn-sm w-100">NOTIFY ME</button>
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <div class="movie-card">
          <img src="https://lumiere-a.akamaihd.net/v1/images/12_blue_teaser2_4x5_ig_2609a9ad.jpeg?region=0,0,1080,1350" class="movie-poster" alt="Movie Poster">
          <div class="movie-info">
            <h3 class="movie-title">The Fantastic Four: First Steps</h3>
            <div class="movie-meta">
              <span>Coming Jul 25</span>
            </div>
            <span class="movie-badge">SCI-FI</span>
            <span class="movie-badge">ACTION</span>
            <div class="mt-3">
              <button class="btn btn-outline-red btn-sm w-100">NOTIFY ME</button>
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <div class="movie-card">
          <img src="https://m.media-amazon.com/images/M/MV5BYjE0OWZmYWMtZjBhMi00YzM5LTkzOTctOTZhMTIwNDcxY2U0XkEyXkFqcGc@._V1_.jpg" class="movie-poster" alt="Movie Poster">
          <div class="movie-info">
            <h3 class="movie-title">Avatar: Fire and Ash</h3>
            <div class="movie-meta">
              <span>Coming Dec 19</span>
            </div>
            <span class="movie-badge">ACTION</span>
            <span class="movie-badge">SCI-FI</span>
            <div class="mt-3">
              <button class="btn btn-outline-red btn-sm w-100">NOTIFY ME</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Theaters Section -->
<section class="py-5" style="background-color: var(--secondary-black);">
  <div class="container py-5">
    <h2 class="section-title text-white">OUR THEATERS</h2>
    <div class="row g-4">
      <div class="col-lg-4 col-md-6">
        <div class="theater-card">
          <h3 class="theater-name">QuickFlicks Malabe</h3>
          <p><i class="fas fa-map-marker-alt me-2"></i> 123 Main St, Malabe</p>
          <p><i class="fas fa-phone me-2"></i> +94 11 234 5678</p>
          <p><i class="fas fa-star me-2"></i> Premium seating, Dolby Atmos, IMAX</p>
          <div class="mt-3">
            <a href="#" class="btn btn-outline-red">VIEW SHOWTIMES</a>
          </div>
        </div>
      </div>
      <div class="col-lg-4 col-md-6">
        <div class="theater-card">
          <h3 class="theater-name">QuickFlicks Bambalapitiya</h3>
          <p><i class="fas fa-map-marker-alt me-2"></i> Bambalapitiya, Colombo</p>
          <p><i class="fas fa-phone me-2"></i> +94 11 555 6789</p>
          <p><i class="fas fa-star me-2"></i> Dolby Vision, Private Screenings, Gourmet Food</p>
          <div class="mt-3">
            <a href="#" class="btn btn-outline-red">VIEW SHOWTIMES</a>
          </div>
        </div>
      </div>
      <div class="col-lg-4 col-md-6">
        <div class="theater-card">
          <h3 class="theater-name">QuickFlick Negombo</h3>
          <p><i class="fas fa-map-marker-alt me-2"></i> Negombo, Sri Lanka</p>
          <p><i class="fas fa-phone me-2"></i> +94 31 222 3333</p>
          <p><i class="fas fa-star me-2"></i> Ocean View Lounge, Budget Pricing, Free Parking</p>
          <div class="mt-3">
            <a href="#" class="btn btn-outline-red">VIEW SHOWTIMES</a>
          </div>
        </div>
      </div>
    </div>
    <div class="text-center mt-4">
      <a href="theaters.jsp" class="btn btn-outline-red">View All Theaters</a>
    </div>
  </div>
</section>

<!-- Stats Section -->
<section class="stats-section">
  <div class="container">
    <div class="row text-center">
      <div class="col-md-3 col-6">
        <div class="stat-item">
          <div class="stat-number">150+</div>
          <div class="stat-label">Movies Monthly</div>
        </div>
      </div>
      <div class="col-md-3 col-6">
        <div class="stat-item">
          <div class="stat-number">10+</div>
          <div class="stat-label">Theaters</div>
        </div>
      </div>
      <div class="col-md-3 col-6">
        <div class="stat-item">
          <div class="stat-number">10K+</div>
          <div class="stat-label">Happy Customers</div>
        </div>
      </div>
      <div class="col-md-3 col-6">
        <div class="stat-item">
          <div class="stat-number">24/7</div>
          <div class="stat-label">Support</div>
        </div>
      </div>
    </div>
  </div>
</section>

<section class="feedback-section py-5">
  <div class="container">
    <h2 class="section-title text-white">What Our Users Say</h2>
    <div class="row">
      <div class="col-12">
        <div class="feedback-container">
          <%
            String feedbackPath = application.getRealPath("/WEB-INF/feedback/feedback.txt");
            File feedbackFile = new File(feedbackPath);
            if (feedbackFile.exists()) {
              try (BufferedReader reader = new BufferedReader(new FileReader(feedbackFile))) {
                String line;
                boolean isEntry = false;
                String currentEntry = "";
                while ((line = reader.readLine()) != null) {
                  if (line.startsWith("=== Feedback Entry ===")) {
                    isEntry = true;
                    currentEntry = "";
                  } else if (line.startsWith("===================")) {
                    isEntry = false;
                    if (!currentEntry.isEmpty()) {
                      // Extract rating from the entry
                      String rating = "0";
                      String[] lines = currentEntry.split("\n");
                      for (String l : lines) {
                        if (l.startsWith("Rating:")) {
                          rating = l.split(" ")[1];
                          break;
                        }
                      }

                      // Create star rating HTML
                      StringBuilder stars = new StringBuilder();
                      int ratingNum = Integer.parseInt(rating);
                      for (int i = 1; i <= 5; i++) {
                        if (i <= ratingNum) {
                          stars.append("<i class='fas fa-star text-warning'></i>");
                        } else {
                          stars.append("<i class='far fa-star text-warning'></i>");
                        }
                      }

                      out.println("<div class='feedback-card mb-4 p-4' style='background-color: var(--secondary-black); border-radius: 10px; border-left: 4px solid var(--accent-dark-pink);'>");
                      out.println("<div class='d-flex justify-content-between align-items-start'>");
                      out.println("<div class='feedback-content'>");
                      out.println("<div class='rating mb-2'>" + stars.toString() + "</div>");
                      out.println(currentEntry.replace("\n", "<br>"));
                      out.println("</div>");
                      out.println("</div>");
                      out.println("</div>");
                    }
                  } else if (isEntry) {
                    currentEntry += line + "\n";
                  }
                }
              } catch (IOException e) {
                out.println("<p class='text-danger'>Error reading feedback.</p>");
              }
            } else {
              out.println("<p class='text-center'>No feedback available yet.</p>");
            }
          %>
        </div>
      </div>
    </div>
  </div>
</section>


<!-- Call to Action Section -->
<section class="cta-section">
  <div class="container text-center">
    <h2 class="cta-title">READY FOR YOUR NEXT MOVIE EXPERIENCE?</h2>
    <p class="cta-subtitle">Join millions of movie lovers who trust Quick Flicks for their entertainment needs.</p>
    <div class="d-flex justify-content-center flex-wrap gap-3">
      <a href="register.jsp" class="btn btn-red btn-lg"><i class="fas fa-user-plus me-2"></i> SIGN UP NOW</a>
      <a href="movies.jsp" class="btn btn-outline-red btn-lg"><i class="fas fa-film me-2"></i> BROWSE MOVIES</a>
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

  // Smooth scrolling for anchor links
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      e.preventDefault();
      document.querySelector(this.getAttribute('href')).scrollIntoView({
        behavior: 'smooth'
      });
    });
  });

  // Movie card hover effect for show times
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