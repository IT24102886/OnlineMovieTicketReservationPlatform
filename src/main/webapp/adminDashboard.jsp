<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - QuickFlicks</title>
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
            --white: #F9FAFB;
        }
        body { font-family: 'Montserrat', sans-serif; background-color: var(--primary-black); color: var(--light-gray); }
        .navbar { background-color: var(--secondary-black); padding: 15px 0; }
        .navbar-brand { font-family: 'Bebas Neue', sans-serif; font-size: 2.2rem; color: var(--accent-dark-pink); }
        .nav-link { color: var(--light-gray); margin: 0 10px; }
        .nav-link:hover { color: var(--accent-dark-pink); }
        .section-title { font-family: 'Bebas Neue', sans-serif; font-size: 2rem; margin-bottom: 1rem; }
        .card { background-color: var(--secondary-black); border: none; }
        .table { color: var(--light-gray); }
        .btn-custom { background-color: var(--accent-dark-pink); color: var(--white); }
        .btn-custom:hover { background-color: var(--accent-pink); }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="#">QUICKFLICKS</a>
        <div class="navbar-nav">
            <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">Home</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/adminDashboard.jsp">Dashboard</a>
            <a class="nav-link" href="#">Users</a>
            <a class="nav-link" href="#">Movies</a>
            <form action="${pageContext.request.contextPath}/UserLogoutServlet" method="post" style="display: inline;">
                <button type="submit" class="nav-link btn btn-link">Logout</button>
            </form>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h1 class="section-title">ADMIN DASHBOARD</h1>
    <p class="lead">Manage your QuickFlicks platform operations</p>

    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="row">
        <div class="col-md-4">
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">USERS</h5>
                    <p class="card-text">Manage user accounts and admin approvals</p>
                    <a href="#" class="btn btn-custom">VIEW USERS</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">MOVIES</h5>
                    <p class="card-text">Create, edit, and manage all movies</p>
                    <button id="viewMoviesBtn" class="btn btn-custom mb-2">VIEW MOVIES</button>
                    <button id="addMovieBtn" class="btn btn-custom" data-bs-toggle="modal" data-bs-target="#addMovieModal">ADD NEW MOVIE</button>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">LOCATIONS</h5>
                    <p class="card-text">Add and manage movie locations</p>
                    <a href="#" class="btn btn-custom">VIEW LOCATIONS</a>
                    <a href="#" class="btn btn-custom">ADD NEW SHOWTIME</a>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6">
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">QUICK ACTIONS</h5>
                    <a href="#" class="btn btn-custom mb-2">REVIEW FEEDBACK</a>
                    <a href="#" class="btn btn-custom">VIEW PENDING APPROVALS</a>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">SYSTEM MANAGEMENT</h5>
                    <a href="#" class="btn btn-custom mb-2">SYSTEM SETTINGS</a>
                    <a href="#" class="btn btn-custom">GENERATE REPORTS</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Movie Table -->
    <div id="movieTableContainer" class="mb-4" style="display: none;">
        <h5 class="section-title">Movie Management</h5>
        <table class="table table-striped">
            <thead>
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Genre</th>
                <th>Duration</th>
                <th>Showtime</th>
                <th>Release Date</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody id="movieTableBody"></tbody>
        </table>
    </div>

    <!-- Add Movie Modal -->
    <div class="modal fade" id="addMovieModal" tabindex="-1" aria-labelledby="addMovieModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content bg-dark text-light">
                <div class="modal-header">
                    <h5 class="modal-title" id="addMovieModalLabel">Add New Movie</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="addMovieForm">
                        <div class="mb-3">
                            <label for="title" class="form-label">Title</label>
                            <input type="text" class="form-control" id="title" name="title" required>
                        </div>
                        <div class="mb-3">
                            <label for="genre" class="form-label">Genre</label>
                            <input type="text" class="form-control" id="genre" name="genre" required>
                        </div>
                        <div class="mb-3">
                            <label for="duration" class="form-label">Duration (minutes)</label>
                            <input type="number" class="form-control" id="duration" name="duration" required>
                        </div>
                        <div class="mb-3">
                            <label for="showtime" class="form-label">Showtime</label>
                            <input type="text" class="form-control" id="showtime" name="showtime" required>
                        </div>
                        <div class="mb-3">
                            <label for="releaseDate" class="form-label">Release Date</label>
                            <input type="date" class="form-control" id="releaseDate" name="releaseDate" required>
                        </div>
                        <div class="mb-3">
                            <label for="posterPath" class="form-label">Poster URL</label>
                            <input type="url" class="form-control" id="posterPath" name="posterPath" required>
                        </div>
                        <div class="mb-3">
                            <label for="voteAverage" class="form-label">Rating (0-10)</label>
                            <input type="number" step="0.1" min="0" max="10" class="form-control" id="voteAverage" name="voteAverage" required>
                        </div>
                        <div class="mb-3">
                            <label for="genres" class="form-label">Genres (comma-separated IDs)</label>
                            <input type="text" class="form-control" id="genres" name="genres" required>
                        </div>
                        <div class="mb-3">
                            <label for="overview" class="form-label">Overview</label>
                            <textarea class="form-control" id="overview" name="overview" rows="3" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-custom">Add Movie</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<footer class="text-center py-4">
    <p>&copy; 2025 QUICKFLICKS. ALL RIGHTS RESERVED.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const contextPath = "${pageContext.request.contextPath}";

    // Fetch and display movies
    async function loadMovies() {
        try {
            const response = await fetch(`${contextPath}/admin/movies/list`);
            if (!response.ok) throw new Error('Failed to fetch movies');
            const movies = await response.json();
            const tbody = document.getElementById('movieTableBody');
            tbody.innerHTML = '';
            movies.forEach(movie => {
                const tr = document.createElement('tr');
                tr.innerHTML = `
                        <td>${movie.id}</td>
                        <td>${movie.title}</td>
                        <td>${movie.genre}</td>
                        <td>${movie.duration} mins</td>
                        <td>${movie.showtime}</td>
                        <td>${movie.releaseDate}</td>
                        <td>
                            <button class="btn btn-custom btn-sm edit-btn" data-id="${movie.id}">Edit</button>
                            <button class="btn btn-custom btn-sm delete-btn" data-id="${movie.id}">Delete</button>
                        </td>
                    `;
                tbody.appendChild(tr);
            });
            document.getElementById('movieTableContainer').style.display = 'block';
        } catch (error) {
            console.error('Error loading movies:', error);
        }
    }

    // Add movie
    document.getElementById('addMovieForm').addEventListener('submit', async (e) => {
        e.preventDefault();
        const movie = {
            title: document.getElementById('title').value,
            genre: document.getElementById('genre').value,
            duration: parseInt(document.getElementById('duration').value),
            showtime: document.getElementById('showtime').value,
            releaseDate: document.getElementById('releaseDate').value,
            posterPath: document.getElementById('posterPath').value,
            voteAverage: parseFloat(document.getElementById('voteAverage').value),
            genres: document.getElementById('genres').value.split(',').map(id => parseInt(id.trim())),
            overview: document.getElementById('overview').value
        };

        try {
            const response = await fetch(`${contextPath}/admin/movies`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(movie)
            });
            if (response.ok) {
                const modal = bootstrap.Modal.getInstance(document.getElementById('addMovieModal'));
                modal.hide();
                document.getElementById('addMovieForm').reset();
                loadMovies();
                alert('Movie added successfully.');
            } else {
                alert('Failed to add movie.');
            }
        } catch (error) {
            console.error('Error adding movie:', error);
            alert('Error adding movie.');
        }
    });

    // Edit movie (placeholder)
    document.getElementById('movieTableBody').addEventListener('click', (e) => {
        if (e.target.classList.contains('edit-btn')) {
            const id = e.target.getAttribute('data-id');
            // Implement edit logic here (e.g., open modal with pre-filled form)
            alert(`Edit movie with ID: ${id}`);
        }
    });

    // Delete movie
    document.getElementById('movieTableBody').addEventListener('click', async (e) => {
        if (e.target.classList.contains('delete-btn')) {
            const id = e.target.getAttribute('data-id');
            if (confirm(`Are you sure you want to delete movie with ID ${id}?`)) {
                try {
                    const response = await fetch(`${contextPath}/admin/movies/${id}`, {
                        method: 'DELETE'
                    });
                    if (response.ok) {
                        loadMovies();
                        alert('Movie deleted successfully.');
                    } else {
                        alert('Failed to delete movie.');
                    }
                } catch (error) {
                    console.error('Error deleting movie:', error);
                    alert('Error deleting movie.');
                }
            }
        }
    });

    // Event listeners
    document.getElementById('viewMoviesBtn').addEventListener('click', loadMovies);
    document.getElementById('addMovieBtn').addEventListener('click', () => {
        document.getElementById('addMovieForm').reset();
    });

    // Load movies on page load
    window.addEventListener('load', loadMovies);
</script>
</body>
</html>