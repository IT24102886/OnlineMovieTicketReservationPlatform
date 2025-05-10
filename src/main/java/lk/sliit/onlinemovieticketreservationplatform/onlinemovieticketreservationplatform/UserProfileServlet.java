//package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import java.io.IOException;
//import java.util.ArrayList;
//import java.util.List;
//
//@WebServlet("/UserProfileServlet")
//public class UserProfileServlet extends HttpServlet {
//    private UserManager userManager = new UserManager();
//    // Mock booking history (in a real system, this would come from a database)
//    private List<Booking> getBookingHistory(String userId) {
//        // This is a mock implementation. In a real system, you'd query a database
//        List<Booking> bookings = new ArrayList<>();
//        bookings.add(new Booking("B001", "A Minecraft Movie", "Quick Flix Downtown", "2025-05-10 14:30", 2, 1500.00));
//        bookings.add(new Booking("B002", "Moana 2", "Quick Flix Westside", "2025-05-08 18:00", 1, 750.00));
//        return bookings;
//    }
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        HttpSession session = request.getSession(false);
//        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;
//
//        // Check if user is logged in
//        if (currentUser == null) {
//            response.sendRedirect("login.jsp");
//            return;
//        }
//
//        // Get booking history
//        List<Booking> bookingHistory = getBookingHistory(currentUser.getUserId());
//        request.setAttribute("bookingHistory", bookingHistory);
//
//        // Forward to user profile page
//        request.getRequestDispatcher("userProfile.jsp").forward(request, response);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        HttpSession session = request.getSession(false);
//        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;
//
//        // Check if user is logged in
//        if (currentUser == null) {
//            response.sendRedirect("login.jsp");
//            return;
//        }
//
//        String action = request.getParameter("action");
//
//        if ("updateProfile".equals(action)) {
//            updateProfile(request, response, currentUser);
//        } else if ("logout".equals(action)) {
//            session.invalidate();
//            response.sendRedirect("login.jsp?logout=success");
//        } else {
//            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
//        }
//    }
//
//    private void updateProfile(HttpServletRequest request, HttpServletResponse response, User currentUser)
//            throws ServletException, IOException {
//        String name = request.getParameter("name");
//        String email = request.getParameter("email");
//        String contactNumber = request.getParameter("contactNumber");
//        String password = request.getParameter("password");
//
//        // Validate inputs
//        if (name == null || name.isEmpty() || email == null || email.isEmpty() ||
//                contactNumber == null || contactNumber.isEmpty()) {
//            request.setAttribute("error", "All fields are required");
//            request.getRequestDispatcher("editProfile.jsp").forward(request, response);
//            return;
//        }
//
//        // Check if new email is already taken by another user
//        if (!currentUser.getEmail().equals(email) && userManager.emailExists(email)) {
//            request.setAttribute("error", "Email already registered");
//            request.getRequestDispatcher("editProfile.jsp").forward(request, response);
//            return;
//        }
//
//        // Update user details
//        currentUser.setName(name);
//        currentUser.setEmail(email);
//        currentUser.setContactNumber(contactNumber);
//        if (password != null && !password.isEmpty() && password.length() >= 8) {
//            currentUser.setPassword(password);
//        }
//
//        // Save updated user
//        userManager.updateUser(currentUser);
//
//        // Update session
//        request.getSession().setAttribute("user", currentUser);
//        request.setAttribute("success", "Profile updated successfully");
//        request.getRequestDispatcher("userProfile.jsp").forward(request, response);
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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/UserProfileServlet")
public class UserProfileServlet extends HttpServlet {
    private UserManager userManager = new UserManager();
    // Mock booking history (in a real system, this would come from a database)
    private List<Booking> getBookingHistory(String userId) {
        // This is a mock implementation. In a real system, you'd query a database
        List<Booking> bookings = new ArrayList<>();
        bookings.add(new Booking("B001", "A Minecraft Movie", "Quick Flix Downtown", "2025-05-10 14:30", 2, 1500.00));
        bookings.add(new Booking("B002", "Moana 2", "Quick Flix Westside", "2025-05-08 18:00", 1, 750.00));
        return bookings;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;

        // Check if user is logged in
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get booking history
        List<Booking> bookingHistory = getBookingHistory(currentUser.getUserId());
        request.setAttribute("bookingHistory", bookingHistory);

        // Forward to user profile page
        request.getRequestDispatcher("userProfile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;

        // Check if user is logged in
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("updateProfile".equals(action)) {
            updateProfile(request, response, currentUser);
        } else if ("logout".equals(action)) {
            session.invalidate();
            response.sendRedirect("login.jsp?logout=success");
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response, User currentUser)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String contactNumber = request.getParameter("contactNumber");
        String password = request.getParameter("password");

        // Validate inputs
        if (name == null || name.isEmpty() || email == null || email.isEmpty() ||
                contactNumber == null || contactNumber.isEmpty()) {
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("editProfile.jsp").forward(request, response);
            return;
        }

        // Check if new email is already taken by another user
        if (!currentUser.getEmail().equals(email) && userManager.emailExists(email)) {
            request.setAttribute("error", "Email already registered");
            request.getRequestDispatcher("editProfile.jsp").forward(request, response);
            return;
        }

        // Update user details
        currentUser.setName(name);
        currentUser.setEmail(email);
        currentUser.setContactNumber(contactNumber);
        if (password != null && !password.isEmpty() && password.length() >= 8) {
            currentUser.setPassword(password);
        }

        // Save updated user
        userManager.updateUser(currentUser);

        // Update session
        request.getSession().setAttribute("user", currentUser);
        request.getSession().setAttribute("success", "Profile updated successfully");

        // Redirect to userDashboard.jsp
        response.sendRedirect("userDashboard.jsp");
    }
}
