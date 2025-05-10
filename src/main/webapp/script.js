// Sample movie data for development purposes
// In a real application, this would come from an API or database
const sampleMovies = [
    {
        id: 1,
        title: "Dune: Part Two",
        posterPath: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg",
        releaseDate: "2025-03-01",
        runtime: 166,
        voteAverage: 7.8,
        genres: [28, 878, 12], // Action, Sci-Fi, Adventure
        overview: "Follow the mythic journey of Paul Atreides as he unites with Chani and the Fremen while on a path of revenge against the conspirators who destroyed his family."
    },
    {
        id: 2,
        title: "Gladiator II",
        posterPath: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/1wDBP8za3R9qnEgWaJ5EvKdLZtE.jpg",
        releaseDate: "2025-03-15",
        runtime: 155,
        voteAverage: 8.2,
        genres: [28, 18, 36], // Action, Drama, History
        overview: "The sequel to the 2000 epic historical drama film continues the story of power, revenge, and honor in ancient Rome."
    },
    {
        id: 3,
        title: "The Batman 2",
        posterPath: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/ztVMJwOCJbBmYn6iIWEHWn1JyFN.jpg",
        releaseDate: "2025-04-01",
        runtime: 148,
        voteAverage: 8.5,
        genres: [28, 80, 9648], // Action, Crime, Mystery
        overview: "Bruce Wayne continues his fight against corruption in Gotham City while confronting a dangerous new threat."
    },
    {
        id: 4,
        title: "Fantastic Voyage",
        posterPath: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/7tBvUKUzUXryE2Idn8Yld6YUEuW.jpg",
        releaseDate: "2025-04-15",
        runtime: 142,
        voteAverage: 7.6,
        genres: [878, 12, 53], // Sci-Fi, Adventure, Thriller
        overview: "A team of scientists are miniaturized and injected into a patient's bloodstream in a race against time to save their life."
    },
    {
        id: 5,
        title: "The Lost City",
        posterPath: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/neMZH82Stu91d3iqvLdNQfqPPyl.jpg",
        releaseDate: "2025-02-15",
        runtime: 138,
        voteAverage: 7.1,
        genres: [12, 35, 10749], // Adventure, Comedy, Romance
        overview: "An author finds herself on a wild jungle adventure with her cover model as they search for an ancient lost city."
    },
    {
        id: 6,
        title: "Black Widow 2",
        posterPath: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg",
        releaseDate: "2025-05-01",
        runtime: 134,
        voteAverage: 7.9,
        genres: [28, 12, 53], // Action, Adventure, Thriller
        overview: "Natasha Romanoff returns for another thrilling mission that will test her skills and confront her past."
    },
    {
        id: 7,
        title: "The Haunting",
        posterPath: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/A3bsT0m1um6tvcmlIGxBwx9eAxn.jpg",
        releaseDate: "2025-03-10",
        runtime: 125,
        voteAverage: 7.4,
        genres: [27, 9648, 53], // Horror, Mystery, Thriller
        overview: "A family moves into a seemingly perfect home, only to discover it harbors dark secrets and supernatural entities."
    },
    {
        id: 8,
        title: "Moonlight Sonata",
        posterPath: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/8kNruSfhk5IoE4eZOc4UpvDn6tq.jpg",
        releaseDate: "2025-04-20",
        runtime: 128,
        voteAverage: 8.0,
        genres: [18, 10749, 10402], // Drama, Romance, Music
        overview: "A gifted pianist finds inspiration and love while struggling with a creative block and personal demons."
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

    // Format runtime to hours and minutes
    const hours = Math.floor(movie.runtime / 60);
    const minutes = movie.runtime % 60;
    const formattedRuntime = `${hours}h ${minutes}m`;

    // Create HTML for the movie card
    return `
        <div class="movie-card animate__animated animate__fadeIn">
            <div class="movie-poster-container">
                <img src="${movie.posterPath}" alt="${movie.title}" class="movie-poster">
            </div>
            <div class="movie-info">
                <h3 class="movie-title">${movie.title}</h3>
                <div class="movie-meta">
                    <span>${releaseYear}</span>
                    <span>${formattedRuntime}</span>
                    <span class="movie-rating"><i class="fas fa-star me-1"></i>${movie.voteAverage}</span>
                </div>
                <span class="movie-badge mb-2">${primaryGenre}</span>
                <p class="movie-description">${movie.overview}</p>
                <div class="movie-actions">
                    <a href="movieDetail.jsp?id=${movie.id}" class="btn btn-red btn-sm"><i class="fas fa-ticket-alt me-1"></i> Book Tickets</a>
                    <a href="movieDetail.jsp?id=${movie.id}" class="btn btn-outline-red btn-sm ms-2"><i class="fas fa-info-circle me-1"></i> Details</a>
                </div>
            </div>
        </div>
    `;
}

// Function to display movies based on filters
function displayMovies(movies, filters = {}) {
    const moviesContainer = document.getElementById('movies-container');

    // Show loading spinner
    moviesContainer.innerHTML = `
        <div class="loading-spinner">
            <div class="spinner"></div>
            <p>Loading movies...</p>
        </div>
    `;

    // Simulate API delay
    setTimeout(() => {
        // Apply filters
        let filteredMovies = movies;

        // Filter by genre if specified
        if (filters.genre && filters.genre !== 'all') {
            filteredMovies = filteredMovies.filter(movie =>
                movie.genres.includes(parseInt(filters.genre))
            );
        }

        // Filter by date if specified
        if (filters.date) {
            const filterDate = new Date(filters.date);
            filteredMovies = filteredMovies.filter(movie => {
                const movieDate = new Date(movie.releaseDate);
                return movieDate >= filterDate;
            });
        }

        // Sort movies based on selection
        if (filters.sort) {
            switch(filters.sort) {
                case 'popular':
                    // For this example, we're just keeping the original order
                    // In a real app, this would sort by popularity metric
                    break;
                case 'rating':
                    filteredMovies.sort((a, b) => b.voteAverage - a.voteAverage);
                    break;
                case 'date':
                    filteredMovies.sort((a, b) => new Date(b.releaseDate) - new Date(a.releaseDate));
                    break;
            }
        }

        // Display the filtered movies
        if (filteredMovies.length === 0) {
            moviesContainer.innerHTML = `
                <div class="no-results">
                    <i class="fas fa-film fa-3x mb-3"></i>
                    <p>No movies found matching your criteria.</p>
                    <button id="reset-search" class="btn btn-red mt-3">Reset Filters</button>
                </div>
            `;

            // Add event listener to reset button
            document.getElementById('reset-search').addEventListener('click', () => {
                clearFilters();
                displayMovies(sampleMovies);
            });

            return;
        }

        // Generate HTML for all movies
        let moviesHTML = '';
        filteredMovies.forEach(movie => {
            moviesHTML += createMovieCard(movie);
        });

        // Update the container with movie cards
        moviesContainer.innerHTML = moviesHTML;
    }, 800); // Simulate loading delay
}

// Function to get current filter values
function getFilters() {
    return {
        genre: document.getElementById('genre-filter').value,
        date: document.getElementById('date-filter').value,
        sort: document.getElementById('sort-filter').value
    };
}

// Function to clear all filters
function clearFilters() {
    document.getElementById('genre-filter').value = 'all';
    document.getElementById('date-filter').value = '';
    document.getElementById('sort-filter').value = 'popular';
}

// Event listeners for filter actions
document.getElementById('apply-filters').addEventListener('click', () => {
    const filters = getFilters();
    displayMovies(sampleMovies, filters);
});

document.getElementById('clear-filters').addEventListener('click', () => {
    clearFilters();
    displayMovies(sampleMovies);
});

// Initialize: Load movies when page loads
document.addEventListener('DOMContentLoaded', () => {
    // Display all movies without filters initially
    displayMovies(sampleMovies);

    // Set default date to today
    const today = new Date();
    const formattedDate = today.toISOString().split('T')[0]; // Format as YYYY-MM-DD
    document.getElementById('date-filter').value = formattedDate;
});