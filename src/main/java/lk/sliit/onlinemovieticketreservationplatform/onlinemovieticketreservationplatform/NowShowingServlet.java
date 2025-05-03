package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/NowShowingServlet")
public class NowShowingServlet extends HttpServlet {

    private MovieManager movieManager = new MovieManager();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Movie> movies = movieManager.getNowShowingMovies();
        request.setAttribute("movies", movies);
        request.getRequestDispatcher("/movies/now-showing.jsp").forward(request, response);
    }
}