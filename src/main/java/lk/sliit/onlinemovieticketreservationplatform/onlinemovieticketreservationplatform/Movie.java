package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

public abstract class Movie {
    private int id;
    private String title;
    private String genre;
    private int duration;
    private String showtime;
    private boolean available;

    // Constructor (protected to restrict instantiation outside this file)
    protected Movie(int id, String title, String genre, int duration, String showtime) {
        this.id = id;
        this.title = title;
        this.genre = genre;
        this.duration = duration;
        this.showtime = showtime;
        this.available = true;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public void setShowtime(String showtime) {
        this.showtime = showtime;
    }

    // Abstract method (forces subclasses to define their format)
    public abstract String getFormat();

    // Static factory methods for creating movies
    public static Movie createRegularMovie(int id, String title, String genre, int duration, String showtime) {
        return new RegularMovie(id, title, genre, duration, showtime);
    }

    public static Movie createIMAXMovie(int id, String title, String genre, int duration, String showtime) {
        return new IMAXMovie(id, title, genre, duration, showtime);
    }

    // Inner class for Regular Movies
    private static class RegularMovie extends Movie {
        public RegularMovie(int id, String title, String genre, int duration, String showtime) {
            super(id, title, genre, duration, showtime);
        }

        @Override
        public String getFormat() {
            return "REGULAR";
        }
    }

    // Inner class for IMAX Movies
    private static class IMAXMovie extends Movie {
        public IMAXMovie(int id, String title, String genre, int duration, String showtime) {
            super(id, title, genre, duration, showtime);
        }

        @Override
        public String getFormat() {
            return "IMAX";
        }
    }

    // Getters & Setters (same as before)
    public int getId() { return id; }
    public String getTitle() { return title; }
    public String getGenre() { return genre; }
    public int getDuration() { return duration; }
    public String getShowtime() { return showtime; }
    public boolean isAvailable() { return available; }
    public void setAvailable(boolean available) { this.available = available; }

    // Serialization/Deserialization (updated to use factory methods)
    public static Movie fromString(String line) {
        String[] parts = line.split("\\|");
        int id = Integer.parseInt(parts[0]);
        String title = parts[1];
        String genre = parts[2];
        int duration = Integer.parseInt(parts[3]);
        String showtime = parts[4];
        boolean available = Boolean.parseBoolean(parts[5]);
        String format = parts[6];

        Movie movie = format.equals("IMAX") ?
                createIMAXMovie(id, title, genre, duration, showtime) :
                createRegularMovie(id, title, genre, duration, showtime);

        movie.setAvailable(available);
        return movie;
    }

    public String toString() {
        return String.join("|",
                String.valueOf(id),
                title,
                genre,
                String.valueOf(duration),
                showtime,
                String.valueOf(available),
                getFormat()
        );
    }
}