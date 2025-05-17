// Genre mapping for display purposes
const genreMap = {
    28: "Action",
    12: "Adventure",
    16: "Animation",
    35: "Comedy",
    80: "Crime",
    18: "Drama",
    10751: "Family",
    14: "Fantasy",
    27: "Horror",
    9648: "Mystery",
    10749: "Romance",
    878: "Science Fiction",
    53: "Thriller",
    10402: "Music",
    36: "History"
};

// Check if user is admin (set by JSP via script injection)
const isAdmin = document.body.dataset.isAdmin === 'true';

// Function to create HTML for a movie card
function createMovieCard(movie) {
    const releaseYear = new Date(movie.releaseDate).getFullYear();
    const primaryGenre = genreMap[movie.genres[0]] || "Unknown";
    let formattedRuntime = "N/A";
    if (movie.runtime > 0) {
        const hours = Math.floor(movie.runtime / 60);
        const minutes = movie.runtime % 60;
        formattedRuntime = `${hours}h ${minutes}m`;
    }

    return `
        <div class="col-md-6 col-lg-3 mb-4">
            <div class="movie-card animate__animated animate__fadeIn">
                <div class="movie-poster-container">
                    <img src="${movie.posterPath}" alt="${movie.title}" class="movie-poster">
                </div>
                <div class="movie-info">
                    <h3 class="movie-title">${movie.title}</h3>
                    <div class="movie-meta">
                        <span>${releaseYear}</span>
                        <span>${formattedRuntime}</span>
                        ${movie.voteAverage > 0 ? `<span class="movie-rating"><i class="fas fa-star me-1"></i>${movie.voteAverage}</span>` : ''}
                    </div>
                    <span class="movie-badge mb-2">${primaryGenre}</span>
                    <p class="movie-description">${movie.overview}</p>
                    <div class="movie-actions">
                        <a href="movieDetail.jsp?id=${movie.id}" class="btn btn-red btn-sm"><i class="fas fa-ticket-alt me-1"></i> Book Tickets</a>
                        <a href="movieDetail.jsp?id=${movie.id}" class="btn btn-outline-red btn-sm ms-2"><i class="fas fa-info-circle me-1"></i> Details</a>
                        ${isAdmin ? `
                            <button class="btn btn-outline-red btn-sm ms-2 edit-movie" data-id="${movie.id}" data-bs-toggle="modal" data-bs-target="#editMovieModal"><i class="fas fa-edit me-1"></i> Edit</button>
                            <button class="btn btn-outline-red btn-sm ms-2 delete-movie" data-id="${movie.id}"><i class="fas fa-trash me-1"></i> Delete</button>
                        ` : ''}
                    </div>
                </div>
                </div>
        </div>
    `;
}

// Function to display movies in specific sections based on release date
function displayMoviesBySections() {
    const nowPlayingContainer = document.getElementById('now-playing-container');
    const comingSoonContainer = document.getElementById('coming-soon-container');

    const loadingHTML = `
        <div class="col-12">
            <div class="loading-spinner">
                <div class="spinner"></div>
                <p>Loading movies...</p>
            </div>
        </div>
    `;

    nowPlayingContainer.innerHTML = loadingHTML;
    comingSoonContainer.innerHTML = loadingHTML;

    setTimeout(() => {
        const today = new Date();
        const sortedMovies = [...sampleMovies].sort((a, b) =>
            new Date(a.releaseDate) - new Date(b.releaseDate)
        );

        const nowPlayingMovies = sortedMovies.filter(movie =>
            new Date(movie.releaseDate) <= today
        );
        const comingSoonMovies = sortedMovies.filter(movie =>
            new Date(movie.releaseDate) > today
        );

        let nowPlayingHTML = '';
        if (nowPlayingMovies.length > 0) {
            nowPlayingMovies.forEach(movie => {
                nowPlayingHTML += createMovieCard(movie);
            });
        } else {
            nowPlayingHTML = `
                <div class="col-12">
                    <div class="no-results">
                        <i class="fas fa-film fa-3x mb-3"></i>
                        <p>No movies currently playing.</p>
                    </div>
                </div>
            `;
        }

        let comingSoonHTML = '';
        if (comingSoonMovies.length > 0) {
            comingSoonMovies.forEach(movie => {
                comingSoonHTML += createMovieCard(movie);
            });
        } else {
            comingSoonHTML = `
                <div class="col-12">
                    <div class="no-results">
                        <i class="fas fa-film fa-3x mb-3"></i>
                        <p>No upcoming movies scheduled.</p>
                    </div>
                </div>
            `;
        }

        nowPlayingContainer.innerHTML = nowPlayingHTML;
        comingSoonContainer.innerHTML = comingSoonHTML;
    }, 800);
}

// Function to apply filters to both sections
function applyFilters() {
    const genreFilter = document.getElementById('genre-filter').value;
    const dateFilter = document.getElementById('date-filter').value;

    const nowPlayingContainer = document.getElementById('now-playing-container');
    const comingSoonContainer = document.getElementById('coming-soon-container');

    const loadingHTML = `
        <div class="col-12">
            <div class="loading-spinner">
                <div class="spinner"></div>
                <p>Loading movies...</p>
            </div>
        </div>
    `;

    nowPlayingContainer.innerHTML = loadingHTML;
    comingSoonContainer.innerHTML = loadingHTML;

    setTimeout(() => {
        const today = new Date();
        let filteredMovies = [...sampleMovies];

        if (genreFilter && genreFilter !== 'all') {
            filteredMovies = filteredMovies.filter(movie =>
                movie.genres.includes(parseInt(genreFilter))
            );
        }

        if (dateFilter) {
            const filterDate = new Date(dateFilter);
            filteredMovies = filteredMovies.filter(movie => {
                const movieDate = new Date(movie.releaseDate);
                return movieDate >= filterDate;
            });
        }

        const nowPlayingMovies = filteredMovies.filter(movie =>
            new Date(movie.releaseDate) <= today
        );
        const comingSoonMovies = filteredMovies.filter(movie =>
            new Date(movie.releaseDate) > today
        );

        let nowPlayingHTML = '';
        if (nowPlayingMovies.length > 0) {
            nowPlayingMovies.forEach(movie => {
                nowPlayingHTML += createMovieCard(movie);
            });
        } else {
            nowPlayingHTML = `
                <div class="col-12">
                    <div class="no-results">
                        <i class="fas fa-film fa-3x mb-3"></i>
                        <p>No movies found matching your criteria.</p>
                    </div>
                </div>
            `;
        }

        let comingSoonHTML = '';
        if (comingSoonMovies.length > 0) {
            comingSoonMovies.forEach(movie => {
                comingSoonHTML += createMovieCard(movie);
            });
        } else {
            comingSoonHTML = `
                <div class="col-12">
                    <div class="no-results">
                        <i class="fas fa-film fa-3x mb-3"></i>
                        <p>No upcoming movies found matching your criteria.</p>
                    </div>
                </div>
            `;
        }

        nowPlayingContainer.innerHTML = nowPlayingHTML;
        comingSoonContainer.innerHTML = comingSoonHTML;
    }, 800);
}

// Function to clear all filters
function clearFilters() {
    const genreFilter = document.getElementById('genre-filter');
    const dateFilter = document.getElementById('date-filter');
    if (genreFilter) genreFilter.value = 'all';
    if (dateFilter) dateFilter.value = '';
}

// Function to populate edit modal with movie data
function populateEditModal(movieId) {
    const movie = sampleMovies.find(m => m.id === parseInt(movieId));
    if (!movie) return;

    document.getElementById('editMovieId').value = movie.id;
    document.getElementById('editTitle').value = movie.title;
    document.getElementById('editGenre').value = movie.genres.map(id => genreMap[id] || 'Unknown').join(', ');
    document.getElementById('editDuration').value = movie.runtime;
    document.getElementById('editShowtime').value = movie.showtime || '';
    document.getElementById('editReleaseDate').value = movie.releaseDate;
    document.getElementById('editPosterPath').value = movie.posterPath;
    document.getElementById('editVoteAverage').value = movie.voteAverage;
    document.getElementById('editGenres').value = movie.genres.join(',');
    document.getElementById('editOverview').value = movie.overview;
}

// Event listeners
document.addEventListener('DOMContentLoaded', () => {
    const applyFiltersBtn = document.getElementById('apply-filters');
    const clearFiltersBtn = document.getElementById('clear-filters');
    const dateFilter = document.getElementById('date-filter');

    if (applyFiltersBtn) {
        applyFiltersBtn.addEventListener('click', () => {
            applyFilters();
        });
    }

    if (clearFiltersBtn) {
        clearFiltersBtn.addEventListener('click', () => {
            clearFilters();
            displayMoviesBySections();
        });
    }

    displayMoviesBySections();

    if (dateFilter) {
        const today = new Date();
        const formattedDate = today.toISOString().split('T')[0];
        dateFilter.value = formattedDate;
    }

    // Admin edit/delete event listeners
    if (isAdmin) {
        document.addEventListener('click', async (e) => {
            if (e.target.closest('.edit-movie')) {
                const movieId = e.target.closest('.edit-movie').dataset.id;
                populateEditModal(movieId);
            } else if (e.target.closest('.delete-movie')) {
                const movieId = e.target.closest('.delete-movie').dataset.id;
                if (confirm('Are you sure you want to delete this movie?')) {
                    try {
                        const response = await fetch(`/movies/${movieId}`, {
                            method: 'DELETE'
                        });
                        if (response.ok) {
                            alert('Movie deleted successfully');
                            window.location.reload(); // Reload to refresh movie list
                        } else {
                            alert('Failed to delete movie');
                        }
                    } catch (error) {
                        alert('Error deleting movie: ' + error.message);
                    }
                }
            }
        });

        // Handle edit form submission
        const editMovieForm = document.getElementById('editMovieForm');
        if (editMovieForm) {
            editMovieForm.addEventListener('submit', async (e) => {
                e.preventDefault();
                const formData = new FormData(editMovieForm);
                const data = {};
                formData.forEach((value, key) => { data[key] = value; });

                try {
                    const response = await fetch('/movies', {
                        method: 'PUT',
                        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                        body: new URLSearchParams(data).toString()
                    });
                    if (response.ok) {
                        alert('Movie updated successfully');
                        window.location.reload();
                    } else {
                        alert('Failed to update movie');
                    }
                } catch (error) {
                    alert('Error updating movie: ' + error.message);
                }
            });
        }
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