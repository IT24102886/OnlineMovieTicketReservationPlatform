//package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import java.io.IOException;
//
//@WebServlet("/UserLoginServlet")
//public class UserLoginServlet extends HttpServlet {
//    private UserManager userManager = new UserManager();
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String email = request.getParameter("email");
//        String password = request.getParameter("password");
//
//        // Authenticate user
//        User user = userManager.authenticate(email, password);
//
//        if (user != null) {
//            HttpSession session = request.getSession();
//            session.setAttribute("user", user);
//
//            // Redirect based on user type
//            if (user.isAdmin()) {
//                response.sendRedirect("adminDashboard.jsp");
//            } else {
//                response.sendRedirect("index.jsp");
//            }
//        } else {
//            request.setAttribute("error", "Invalid email or password");
//            request.getRequestDispatcher("login.jsp").forward(request, response);
//        }
//    }
//
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        // Redirect to login page for GET requests
//        response.sendRedirect("login.jsp");
//    }
//}

package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/UserLoginServlet")
public class UserLoginServlet extends HttpServlet {
    private UserManager userManager = new UserManager();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");

        // Authenticate user
        User user = userManager.authenticate(email, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Redirect based on user type
            if (user.isAdmin()) {
                response.sendRedirect("adminDashboard.jsp");
            } else {
                response.sendRedirect("index.jsp");
            }
        } else {
            if ("admin".equals(userType)) {
                request.setAttribute("error", "Invalid email or password for admin");
                request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Invalid email or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to login page for GET requests
        response.sendRedirect("login.jsp");
    }
}