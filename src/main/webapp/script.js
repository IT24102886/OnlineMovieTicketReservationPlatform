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

// Function to fetch movies from the API
async function fetchMovies() {
    try {
        const response = await fetch('/movies/data', {
            headers: {
                'Accept': 'application/json'
            }
        });
        if (!response.ok) {
            throw new Error('Failed to fetch movies');
        }
        return await response.json();
    } catch (error) {
        console.error('Error fetching movies:', error);
        return [];
    }
}

// Function to create HTML for a movie card
function createMovieCard(movie) {
    // Format date to display only the year
    const releaseYear = new Date(movie.releaseDate).getFullYear();

    // Get primary genre name
    const primaryGenre = genreMap[movie.genres[0]] || "Unknown";

    // Format runtime to hours and minutes if available
    let formattedRuntime = "N/A";
    if (movie.runtime > 0) {
        const hours = Math.floor(movie.runtime / 60);
        const minutes = movie.runtime % 60;
        formattedRuntime = `${hours}h ${minutes}m`;
    }

    // Create HTML for the movie card
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
                    </div>
                </div>
            </div>
        </div>
    `;
}

// Function to display movies in specific sections based on release date
async function displayMoviesBySections() {
    const nowPlayingContainer = document.getElementById('now-playing-container');
    const comingSoonContainer = document.getElementById('coming-soon-container');

    // Show loading spinners
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

    // Fetch movies
    const movies = await fetchMovies();

    // Sort movies by release date
    const sortedMovies = [...movies].sort((a, b) =>
        new Date(a.releaseDate) - new Date(b.releaseDate)
    );

    // Split movies into now playing and coming soon
    const today = new Date();
    const nowPlayingMovies = sortedMovies.filter(movie =>
        new Date(movie.releaseDate) <= today
    );
    const comingSoonMovies = sortedMovies.filter(movie =>
        new Date(movie.releaseDate) > today
    );

    // Generate HTML for now playing movies
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

    // Generate HTML for coming soon movies
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

    // Update the containers with movie cards
    nowPlayingContainer.innerHTML = nowPlayingHTML;
    comingSoonContainer.innerHTML = comingSoonHTML;
}

// Function to apply filters to both sections
async function applyFilters() {
    const genreFilter = document.getElementById('genre-filter').value;
    const dateFilter = document.getElementById('date-filter').value;

    const nowPlayingContainer = document.getElementById('now-playing-container');
    const comingSoonContainer = document.getElementById('coming-soon-container');

    // Show loading spinners
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

    // Fetch movies
    let filteredMovies = await fetchMovies();

    // Apply genre filter if selected
    if (genreFilter && genreFilter !== 'all') {
        filteredMovies = filteredMovies.filter(movie =>
            movie.genres.includes(parseInt(genreFilter))
        );
    }

    // Apply date filter if selected
    if (dateFilter) {
        const filterDate = new Date(dateFilter);
        filteredMovies = filteredMovies.filter(movie => {
            const movieDate = new Date(movie.releaseDate);
            return movieDate >= filterDate;
        });
    }

    // Split filtered movies into now playing and coming soon
    const today = new Date();
    const nowPlayingMovies = filteredMovies.filter(movie =>
        new Date(movie.releaseDate) <= today
    );
    const comingSoonMovies = filteredMovies.filter(movie =>
        new Date(movie.releaseDate) > today
    );

    // Generate HTML for now playing movies
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
                    <p>No movies found modi matching your criteria.</p>
                </div>
            </div>
        `;
    }

    // Generate HTML for coming soon movies
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

    // Update the containers with movie cards
    nowPlayingContainer.innerHTML = nowPlayingHTML;
    comingSoonContainer.innerHTML = comingSoonHTML;
}

// Function to clear all filters
function clearFilters() {
    document.getElementById('genre-filter').value = 'all';
    document.getElementById('date-filter').value = '';
}

// Event listeners for filter actions
document.getElementById('apply-filters').addEventListener('click', () => {
    applyFilters();
});

document.getElementById('clear-filters').addEventListener('click', () => {
    clearFilters();
    displayMoviesBySections();
});

// Initialize: Load movies when page loads
document.addEventListener('DOMContentLoaded', () => {
    // Display movies in their respective sections
    displayMoviesBySections();

    // Set default date to today
    const today = new Date();
    const formattedDate = today.toISOString().split('T')[0]; // Format as YYYY-MM-DD
    document.getElementById('date-filter').value = formattedDate;
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