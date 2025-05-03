<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quick Flix | Premium Movie Experience</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-black: #141414;
            --secondary-black: #1f1f1f;
            --dark-gray: #2a2a2a;
            --medium-gray: #4a4a4a;
            --light-gray: #e5e5e5;
            --accent-red: #e50914;
            --accent-dark-red: #b20710;
            --white: #ffffff;
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
            background-color: rgba(20, 20, 20, 0.95) !important;
            border-bottom: 2px solid var(--accent-red);
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
            font-size: 2rem;
            color: var(--accent-red) !important;
            font-family: 'Bebas Neue', sans-serif;
            letter-spacing: 2px;
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
            background-color: var(--accent-red);
            visibility: hidden;
            transition: all 0.3s ease-in-out;
        }

        .nav-link:hover:before {
            visibility: visible;
            width: 100%;
        }

        .nav-link:hover {
            color: var(--accent-red) !important;
        }

        .nav-link.active {
            color: var(--accent-red) !important;
        }

        .nav-link.active:before {
            visibility: visible;
            width: 100%;
        }

        .hero-section {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)),
            url('https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80');
            background-size: cover;
            background-position: center;
            height: 90vh;
            min-height: 700px;
            display: flex;
            align-items: center;
            position: relative;
            overflow: hidden;
        }

        .hero-content {
            position: relative;
            z-index: 2;
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

        .btn-red {
            background-color: var(--accent-red);
            color: var(--white);
            border: none;
            font-weight: 700;
            padding: 12px 30px;
            border-radius: 5px;
            letter-spacing: 1px;
            transition: all 0.3s;
        }

        .btn-red:hover {
            background-color: var(--accent-dark-red);
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(229, 9, 20, 0.3);
            color: var(--white);
        }

        .btn-outline-red {
            border: 2px solid var(--accent-red);
            color: var(--accent-red);
            background-color: transparent;
            font-weight: 700;
            padding: 10px 28px;
            border-radius: 5px;
            letter-spacing: 1px;
            transition: all 0.3s;
        }

        .btn-outline-red:hover {
            background-color: var(--accent-red);
            color: var(--white);
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(229, 9, 20, 0.3);
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
            background: var(--accent-red);
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
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.4);
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

        .movie-rating {
            color: #f5c518;
            font-weight: bold;
        }

        .movie-badge {
            background-color: var(--accent-red);
            color: white;
            padding: 3px 8px;
            border-radius: 5px;
            font-size: 0.8rem;
            font-weight: bold;
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
            color: var(--accent-red);
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
            border-left: 4px solid var(--accent-red);
        }

        .testimonial-text {
            font-style: italic;
            margin-bottom: 20px;
        }

        .testimonial-author {
            font-weight: 700;
            color: var(--accent-red);
        }

        .testimonial-rating {
            color: #f5c518;
            margin-bottom: 10px;
        }

        .cta-section {
            background: linear-gradient(135deg, var(--primary-black) 0%, var(--dark-gray) 100%);
            padding: 80px 0;
            border-top: 2px solid var(--accent-red);
            border-bottom: 2px solid var(--accent-red);
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

        footer {
            background-color: var(--primary-black);
            padding: 60px 0 20px;
            position: relative;
        }

        .footer-logo {
            font-size: 2rem;
            font-weight: 700;
            color: var(--accent-red);
            margin-bottom: 20px;
            font-family: 'Bebas Neue', sans-serif;
            letter-spacing: 2px;
        }

        .footer-links h5 {
            color: var(--accent-red);
            margin-bottom: 20px;
            position: relative;
            padding-bottom: 10px;
            font-family: 'Bebas Neue', sans-serif;
            letter-spacing: 1px;
            font-size: 1.5rem;
        }

        .footer-links h5:after {
            content: '';
            position: absolute;
            width: 50px;
            height: 2px;
            background: var(--accent-red);
            bottom: 0;
            left: 0;
        }

        .footer-links ul {
            list-style: none;
            padding: 0;
        }

        .footer-links li {
            margin-bottom: 10px;
        }

        .footer-links a {
            color: var(--light-gray);
            text-decoration: none;
            transition: all 0.3s;
        }

        .footer-links a:hover {
            color: var(--accent-red);
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
            background-color: var(--accent-red);
            color: var(--white);
            transform: translateY(-5px);
        }

        .copyright {
            border-top: 1px solid var(--medium-gray);
            padding-top: 20px;
            margin-top: 40px;
            text-align: center;
        }

        /* Animation */
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        .pulse-animation {
            animation: pulse 2s infinite;
        }

        /* Coming Soon Badge */
        .coming-soon {
            position: absolute;
            top: 15px;
            right: 15px;
            background-color: var(--accent-red);
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-weight: bold;
            z-index: 2;
            transform: rotate(15deg);
        }

        /* Theater Card */
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
            border-left: 4px solid var(--accent-red);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }

        .theater-name {
            color: var(--accent-red);
            font-size: 1.3rem;
            margin-bottom: 10px;
        }

        /* Responsive adjustments */
        @media (max-width: 992px) {
            .hero-title {
                font-size: 4rem;
            }
            .movie-poster {
                height: 300px;
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
                height: 250px;
            }
        }

        @media (max-width: 576px) {
            .hero-title {
                font-size: 2.5rem;
            }
            .section-title {
                font-size: 2rem;
            }
        }

        /* Showtimes */
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
            background-color: var(--accent-red);
            color: white;
        }

        /* Featured Movie */
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
        }

        .featured-badge {
            background-color: var(--accent-red);
            color: white;
            display: inline-block;
            padding: 5px 10px;
            border-radius: 5px;
            margin-bottom: 15px;
            font-weight: bold;
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#">
            QUICK<span>FLIX</span>
        </a>
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
                <li class="nav-item">
                    <a class="nav-link" href="login.jsp"><i class="fas fa-sign-in-alt me-1"></i> Login</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="register.jsp"><i class="fas fa-user-plus me-1"></i> Register</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero-section">
    <div class="container">
        <div class="hero-content">
            <h1 class="hero-title">YOUR TICKET TO<br>UNLIMITED ENTERTAINMENT</h1>
            <p class="hero-subtitle">Book tickets for the latest blockbusters, exclusive premieres, and special events at theaters near you.</p>
            <div class="d-flex flex-wrap gap-3">
                <a href="movies.jsp" class="btn btn-red pulse-animation"><i class="fas fa-ticket-alt me-2"></i> BOOK NOW</a>
                <a href="#now-playing" class="btn btn-outline-red"><i class="fas fa-play-circle me-2"></i> NOW SHOWING</a>
            </div>
        </div>
    </div>
</section>

<!-- Featured Movie Section -->
<section class="py-5" style="background-color: var(--dark-gray);">
    <div class="container py-4">
        <div class="featured-movie">
            <img src="https://4kwallpapers.com/images/walls/thumbs_3t/20040.jpg" alt="Featured Movie">
            <div class="featured-overlay">
                <span class="featured-badge">FEATURED MOVIE</span>
                <h2 style="font-size: 2.5rem; margin-bottom: 10px;">A Minecraft Movie</h2>
                <p style="max-width: 600px; margin-bottom: 20px;">A mysterious portal pulls four misfits into the Overworld, a bizarre, cubic wonderland that thrives on imagination. To get back home, they'll have to master the terrain while embarking on a magical quest with an unexpected crafter named Steve.</p>
                <div class="d-flex flex-wrap gap-3">
                    <a href="#" class="btn btn-red"><i class="fas fa-ticket-alt me-2"></i> GET TICKETS</a>
                    <a href="#" class="btn btn-outline-red"><i class="fas fa-play-circle me-2"></i> WATCH TRAILER</a>
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
                            <span>Coming Jun 15</span>
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
                            <span>Coming Jul 3</span>
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
                    <img src="https://upload.wikimedia.org/wikipedia/en/6/6a/Zootopia_2_%282025_film%29.jpg" class="movie-poster" alt="Movie Poster">
                    <div class="movie-info">
                        <h3 class="movie-title">Zootopia 2</h3>
                        <div class="movie-meta">
                            <span>Coming Jul 22</span>
                        </div>
                        <span class="movie-badge">FAMILY</span>
                        <span class="movie-badge">COMEDY</span>
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
                            <span>Coming Aug 10</span>
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
                    <h3 class="theater-name">Quick Flix Downtown</h3>
                    <p><i class="fas fa-map-marker-alt me-2"></i> 123 Cinema Ave, Downtown</p>
                    <p><i class="fas fa-phone me-2"></i> (555) 123-4567</p>
                    <p><i class="fas fa-star me-2"></i> Premium seating, Dolby Atmos, IMAX</p>
                    <div class="mt-3">
                        <a href="#" class="btn btn-outline-red">VIEW SHOWTIMES</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="theater-card">
                    <h3 class="theater-name">Quick Flix Westside</h3>
                    <p><i class="fas fa-map-marker-alt me-2"></i> 456 Movie St, Westside</p>
                    <p><i class="fas fa-phone me-2"></i> (555) 234-5678</p>
                    <p><i class="fas fa-star me-2"></i> Luxury recliners, 4DX, Gourmet food</p>
                    <div class="mt-3">
                        <a href="#" class="btn btn-outline-red">VIEW SHOWTIMES</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="theater-card">
                    <h3 class="theater-name">Quick Flix Eastend</h3>
                    <p><i class="fas fa-map-marker-alt me-2"></i> 789 Screen Blvd, Eastend</p>
                    <p><i class="fas fa-phone me-2"></i> (555) 345-6789</p>
                    <p><i class="fas fa-star me-2"></i> Family friendly, Arcade, Party rooms</p>
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
                    <div class="stat-number">25+</div>
                    <div class="stat-label">Theaters</div>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="stat-item">
                    <div class="stat-number">1M+</div>
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

<!-- Testimonials Section -->
<section class="testimonials-section">
    <div class="container">
        <h2 class="section-title text-white">WHAT OUR CUSTOMERS SAY</h2>
        <div class="row">
            <div class="col-lg-4 col-md-6">
                <div class="testimonial-card">
                    <div class="testimonial-rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <p class="testimonial-text">"Quick Flix makes booking tickets so easy! I love the user-friendly interface and the ability to choose my seats in advance."</p>
                    <div class="testimonial-author">- Jessica M.</div>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="testimonial-card">
                    <div class="testimonial-rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <p class="testimonial-text">"The theaters are always clean and well-maintained. The premium seating options make the movie experience exceptional."</p>
                    <div class="testimonial-author">- Robert T.</div>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="testimonial-card">
                    <div class="testimonial-rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                    <p class="testimonial-text">"I appreciate the variety of movies available and the frequent updates about new releases. The mobile app is very convenient too!"</p>
                    <div class="testimonial-author">- Samantha K.</div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Call to Action Section -->
<section class="cta-section">
    <div class="container text-center">
        <h2 class="cta-title">READY FOR YOUR NEXT MOVIE EXPERIENCE?</h2>
        <p class="cta-subtitle">Join millions of movie lovers who trust Quick Flix for their entertainment needs.</p>
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
                <div class="footer-logo">QUICK<span>FLIX</span></div>
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
                        <li><i class="fas fa-map-marker-alt me-2"></i> 123 Cinema St, Hollywood</li>
                        <li><i class="fas fa-phone me-2"></i> (555) 987-6543</li>
                        <li><i class="fas fa-envelope me-2"></i> info@quickflix.com</li>
                        <li><i class="fas fa-clock me-2"></i> Support 24/7</li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="copyright">
            <p>&copy; 2023 QUICK FLIX. ALL RIGHTS RESERVED.</p>
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