<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform.Movie" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Online Movie Ticket Reservation - Movies</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #333;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 5px;
        }

        h1, h2 {
            color: #2c3e50;
        }

        .movie-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .movie-card {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 15px;
            background: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }

        .movie-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        .movie-title {
            font-size: 1.2rem;
            font-weight: bold;
            margin-bottom: 10px;
            color: #3498db;
        }

        .movie-format {
            display: inline-block;
            padding: 3px 8px;
            background: #3498db;
            color: white;
            border-radius: 3px;
            font-size: 0.8rem;
            margin-bottom: 10px;
        }

        .movie-format.imax {
            background: #e74c3c;
        }

        .movie-details {
            margin-bottom: 10px;
        }

        .movie-detail {
            display: flex;
            margin-bottom: 5px;
        }

        .detail-label {
            font-weight: 500;
            width: 80px;
        }

        .search-form {
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        input, select, button {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
        }

        button {
            background: #3498db;
            color: white;
            cursor: pointer;
            border: none;
        }

        button:hover {
            background: #2980b9;
        }

        .add-movie {
            margin-top: 30px;
            border-top: 1px solid #eee;
            padding-top: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }

        .btn-danger {
            background: #e74c3c;
        }

        .btn-danger:hover {
            background: #c0392b;
        }

        .btn-edit {
            background: #f39c12;
        }

        .btn-edit:hover {
            background: #d35400;
        }

        .status-badge {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 3px;
            font-size: 0.8rem;
            margin-left: 10px;
        }

        .status-available {
            background: #2ecc71;
            color: white;
        }

        .status-unavailable {
            background: #e74c3c;
            color: white;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Movie Listings</h1>

    <!-- Search Form -->
    <div class="search-form">
        <form action="${pageContext.request.contextPath}/movies" method="get">
            <input type="text" name="search" placeholder="Search..."
                   value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
            <select name="searchType">
                <option value="title" <%= "title".equals(request.getParameter("searchType")) ? "selected" : "" %>>Title</option>
                <option value="genre" <%= "genre".equals(request.getParameter("searchType")) ? "selected" : "" %>>Genre</option>
                <option value="showtime" <%= "showtime".equals(request.getParameter("searchType")) ? "selected" : "" %>>Showtime</option>
                <option value="format" <%= "format".equals(request.getParameter("searchType")) ? "selected" : "" %>>Format</option>
            </select>
            <button type="submit">Search</button>
            <a href="${pageContext.request.contextPath}/movies"><button type="button">Clear</button></a>
        </form>
    </div>

    <!-- Movie List -->
    <div class="movie-list">
        <%
            List<Movie> movies = (List<Movie>) request.getAttribute("movies");
            if (movies != null && !movies.isEmpty()) {
                for (Movie movie : movies) {
        %>
        <div class="movie-card">
            <div class="movie-title">
                <%= movie.getTitle() %>
                <span class="status-badge <%= movie.isAvailable() ? "status-available" : "status-unavailable" %>">
                        <%= movie.isAvailable() ? "Available" : "Sold Out" %>
                    </span>
            </div>
            <div class="movie-format <%= movie.getFormat().equalsIgnoreCase("IMAX") ? "imax" : "" %>">
                <%= movie.getFormat() %>
            </div>
            <div class="movie-details">
                <div class="movie-detail">
                    <span class="detail-label">Genre:</span>
                    <span><%= movie.getGenre() %></span>
                </div>
                <div class="movie-detail">
                    <span class="detail-label">Duration:</span>
                    <span><%= movie.getDuration() %> mins</span>
                </div>
                <div class="movie-detail">
                    <span class="detail-label">Showtime:</span>
                    <span><%= movie.getShowtime() %></span>
                </div>
            </div>
            <div class="action-buttons">
                <button class="btn-edit" onclick="editMovie(<%= movie.getId() %>)">Edit</button>
                <button class="btn-danger" onclick="deleteMovie(<%= movie.getId() %>)">Delete</button>
            </div>
        </div>
        <%
            }
        } else {
        %>
        <p>No movies found. Add some movies below!</p>
        <% } %>
    </div>

    <!-- Add Movie Form -->
    <div class="add-movie">
        <h2>Add New Movie</h2>
        <form action="${pageContext.request.contextPath}/movies" method="post">
            <div class="form-group">
                <label for="title">Title:</label>
                <input type="text" id="title" name="title" required>
            </div>
            <div class="form-group">
                <label for="genre">Genre:</label>
                <input type="text" id="genre" name="genre" required>
            </div>
            <div class="form-group">
                <label for="duration">Duration (minutes):</label>
                <input type="number" id="duration" name="duration" min="1" required>
            </div>
            <div class="form-group">
                <label for="showtime">Showtime:</label>
                <input type="text" id="showtime" name="showtime" placeholder="e.g., 7:30 PM" required>
            </div>
            <div class="form-group">
                <label for="format">Format:</label>
                <select id="format" name="format" required>
                    <option value="REGULAR">Regular</option>
                    <option value="IMAX">IMAX</option>
                </select>
            </div>
            <button type="submit">Add Movie</button>
        </form>
    </div>
</div>

<script>
    // Function to delete a movie
    function deleteMovie(id) {
        if (confirm('Are you sure you want to delete this movie?')) {
            // Create a form to submit the delete request
            const form = document.createElement('form');
            form.method = 'post';
            form.action = '${pageContext.request.contextPath}/movies/' + id;

            // Add hidden field for DELETE method simulation
            const methodField = document.createElement('input');
            methodField.type = 'hidden';
            methodField.name = '_method';
            methodField.value = 'DELETE';
            form.appendChild(methodField);

            document.body.appendChild(form);
            form.submit();
        }
    }

    // Function to edit a movie (redirect to edit page)
    function editMovie(id) {
        window.location.href = '${pageContext.request.contextPath}/movies/' + id + '/edit';
    }
</script>
</body>
</html>