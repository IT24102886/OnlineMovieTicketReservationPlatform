// Updated movie data from index.jsp
const sampleMovies = [
    {
        id: 1,
        title: "Lilo & Stitch",
        posterPath: "https://i.redd.it/lmw9lobh2n7e1.jpeg",
        releaseDate: "2025-06-15",
        runtime: 135, // 2h 15m in minutes
        voteAverage: 8.7,
        genres: [35, 878], // Comedy, Sci-Fi
        overview: "A mysterious portal pulls four misfits into the Overworld, a bizarre, cubic wonderland that thrives on imagination."
    },
    {
        id: 2,
        title: "Thunderbolts*",
        posterPath: "https://image.tmdb.org/t/p/original/fvodooEJ74rXV9MfBM8asTGBv3Z.jpg",
        releaseDate: "2025-05-02",
        runtime: 118, // 1h 58m in minutes
        voteAverage: 7.9,
        genres: [28, 12], // Action, Adventure
        overview: "Ethan Hunt and the IMF team race against time to find the Entity, a rogue artificial intelligence that can destroy mankind."
    },
    {
        id: 3,
        title: "Moana 2",
        posterPath: "https://i0.wp.com/www.justaddcoloronline.com/wp-content/uploads/2024/05/Moana-2-Teaser-Poster-Movie-Database-May-29th-2024.jpg?w=970&ssl=1",
        releaseDate: "2025-04-10",
        runtime: 105, // 1h 45m in minutes
        voteAverage: 6.8,
        genres: [10751, 12], // Family, Adventure
        overview: "The sequel to the popular animated movie featuring Moana's new adventures."
    },
    {
        id: 4,
        title: "Sinners",
        posterPath: "https://s3.amazonaws.com/nightjarprod/content/uploads/sites/130/2025/03/24184557/SNNRS_EM_VERT_DOM_TSR_1080x1920_NIRD_REV.jpg",
        releaseDate: "2025-06-01",
        runtime: 125, // 2h 05m in minutes
        voteAverage: 7.2,
        genres: [27, 12], // Horror, Adventure
        overview: "A thrilling horror adventure that will keep you on the edge of your seat."
    },
    {
        id: 5,
        title: "F1",
        posterPath: "https://media.formula1.com/image/upload/t_16by9Centre/f_auto/q_auto/v1741890645/fom-website/2025/F1%20movie/f1_movie_poster16x9%20(1).jpg",
        releaseDate: "2025-06-27",
        runtime: 0, // Runtime not specified
        voteAverage: 0, // Rating not specified
        genres: [28, 0], // Action, (Sports genre not in our map)
        overview: "An exciting movie about Formula 1 racing."
    },
    {
        id: 6,
        title: "Spider-Man: Brand New Day",
        posterPath: "https://m.media-amazon.com/images/M/MV5BOTkwZmNmOTYtYjY1Mi00YjkzLThmODQtZjgyZDk5ODliMDNiXkEyXkFqcGc@._V1_.jpg",
        releaseDate: "2025-07-31",
        runtime: 0, // Runtime not specified
        voteAverage: 0, // Rating not specified
        genres: [12, 28], // Adventure, Action
        overview: "The newest Spider-Man adventure featuring your favorite web-slinger."
    },
    {
        id: 7,
        title: "The Fantastic Four: First Steps",
        posterPath: "https://lumiere-a.akamaihd.net/v1/images/12_blue_teaser2_4x5_ig_2609a9ad.jpeg?region=0,0,1080,1350",
        releaseDate: "2025-07-25",
        runtime: 0, // Runtime not specified
        voteAverage: 0, // Rating not specified
        genres: [878, 28], // Sci-Fi, Action
        overview: "The origin story of Marvel's Fantastic Four."
    },
    {
        id: 8,
        title: "Avatar: Fire and Ash",
        posterPath: "https://m.media-amazon.com/images/M/MV5BYjE0OWZmYWMtZjBhMi00YzM5LTkzOTctOTZhMTIwNDcxY2U0XkEyXkFqcGc@._V1_.jpg",
        releaseDate: "2025-12-19",
        runtime: 0, // Runtime not specified
        voteAverage: 0, // Rating not specified
        genres: [28, 878], // Action, Sci-Fi
        overview: "The next chapter in the Avatar saga."
    }
];

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
function displayMoviesBySections() {
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

    // Simulate API delay
    setTimeout(() => {
        const today = new Date();

        // Sort movies by release date
        const sortedMovies = [...sampleMovies].sort((a, b) =>
            new Date(a.releaseDate) - new Date(b.releaseDate)
        );

        // Split movies into now playing and coming soon
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
    }, 800); // Simulate loading delay
}

// Function to apply filters to both sections
function applyFilters() {
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

    // Simulate API delay
    setTimeout(() => {
        const today = new Date();
        let filteredMovies = [...sampleMovies];

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
                        <p>No movies found matching your criteria.</p>
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
    }, 800); // Simulate loading delay
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