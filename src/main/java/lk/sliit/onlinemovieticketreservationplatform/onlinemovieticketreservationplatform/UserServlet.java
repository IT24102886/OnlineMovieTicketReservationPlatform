//package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
//import java.io.IOException;
//import java.util.List;
//
//@WebServlet("/UserServlet")
//public class UserServlet extends HttpServlet {
//    private UserManager userManager = new UserManager();
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String action = request.getParameter("action");
//
//        try {
//            switch (action) {
//                case "register":
//                    registerUser(request, response);
//                    break;
//
//                case "update":
//                    updateUser(request, response);
//                    break;
//
//                case "login":
//                    authenticateUser(request, response);
//                    break;
//
//                default:
//                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
//            }
//        } catch (Exception e) {
//            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request: " + e.getMessage());
//        }
//    }
//
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String action = request.getParameter("action");
//
//        if (action != null) {
//            switch (action) {
//                case "delete":
//                    deleteUser(request, response);
//                    break;
//
//                case "viewAll":
//                    viewAllUsers(request, response);
//                    break;
//
//                case "viewProfile":
//                    viewUserProfile(request, response);
//                    break;
//
//                default:
//                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
//            }
//        } else {
//            // Default action: display all users (for admin)
//            viewAllUsers(request, response);
//        }
//    }
//
//    private void registerUser(HttpServletRequest request, HttpServletResponse response)
//            throws IOException, ServletException {
//        String name = request.getParameter("name");
//        String email = request.getParameter("email");
//        String password = request.getParameter("password");
//        String contactNumber = request.getParameter("contactNumber");
//
//        if (userManager.emailExists(email)) {
//            request.setAttribute("error", "Email already exists");
//            request.getRequestDispatcher("register.jsp").forward(request, response);
//            return;
//        }
//
//        User newUser = new User(null, name, email, password, contactNumber);
//        userManager.addUser(newUser);
//
//        // For regular users, redirect to login
//        // For admin-added users, redirect to user list
//        if (request.getParameter("adminAction") != null) {
//            response.sendRedirect("UserServlet?action=viewAll");
//        } else {
//            response.sendRedirect("login.jsp?registration=success");
//        }
//    }
//
//    private void updateUser(HttpServletRequest request, HttpServletResponse response)
//            throws IOException {
//        String userId = request.getParameter("userId");
//        String name = request.getParameter("name");
//        String email = request.getParameter("email");
//        String password = request.getParameter("password");
//        String contactNumber = request.getParameter("contactNumber");
//        boolean isAdmin = Boolean.parseBoolean(request.getParameter("isAdmin"));
//
//        User updatedUser = new User(userId, name, email, password, contactNumber);
//        updatedUser.setAdmin(isAdmin);
//        userManager.updateUser(updatedUser);
//
//        response.sendRedirect("UserServlet?action=viewAll");
//    }
//
//    private void authenticateUser(HttpServletRequest request, HttpServletResponse response)
//            throws IOException, ServletException {
//        String email = request.getParameter("email");
//        String password = request.getParameter("password");
//
//        User user = userManager.authenticate(email, password);
//
//        if (user != null) {
//            request.getSession().setAttribute("user", user);
//            if (user.isAdmin()) {
//                response.sendRedirect("adminDashboard.jsp");
//            } else {
//                response.sendRedirect("userDashboard.jsp");
//            }
//        } else {
//            request.setAttribute("error", "Invalid email or password");
//            request.getRequestDispatcher("login.jsp").forward(request, response);
//        }
//    }
//
//    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
//            throws IOException {
//        String userId = request.getParameter("userId");
//        userManager.deleteUser(userId);
//        response.sendRedirect("UserServlet?action=viewAll");
//    }
//
//    private void viewAllUsers(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        List<User> users = userManager.getAllUsers();
//        request.setAttribute("users", users);
//        request.getRequestDispatcher("viewUsers.jsp").forward(request, response);
//    }
//
//    private void viewUserProfile(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String userId = request.getParameter("userId");
//        List<User> users = userManager.getAllUsers();
//        User profileUser = users.stream()
//                .filter(u -> u.getUserId().equals(userId))
//                .findFirst()
//                .orElse(null);
//
//        if (profileUser != null) {
//            request.setAttribute("profileUser", profileUser);
//            request.getRequestDispatcher("userProfile.jsp").forward(request, response);
//        } else {
//            response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
//        }
//    }
//}







package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
    private UserManager userManager = new UserManager();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "register":
                    registerUser(request, response);
                    break;
                case "update":
                    updateUser(request, response);
                    break;
                case "login":
                    authenticateUser(request, response);
                    break;
                case "searchByName":
                    searchUsersByName(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request: " + e.getMessage());
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "delete":
                    deleteUser(request, response);
                    break;
                case "viewAll":
                    viewAllUsers(request, response);
                    break;
                case "viewProfile":
                    viewUserProfile(request, response);
                    break;
                case "sortByName":
                    sortUsersByName(request, response);
                    break;
                case "sortByDate":
                    sortUsersByDate(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } else {
            // Default action: display all users (for admin)
            viewAllUsers(request, response);
        }
    }

    private void registerUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String contactNumber = request.getParameter("contactNumber");

        if (userManager.emailExists(email)) {
            request.setAttribute("error", "Email already exists");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        User newUser = new User(null, name, email, password, contactNumber, null);
        userManager.addUser(newUser);

        // For regular users, redirect to login
        // For admin-added users, redirect to user list
        if (request.getParameter("adminAction") != null) {
            response.sendRedirect("UserServlet?action=viewAll");
        } else {
            response.sendRedirect("login.jsp?registration=success");
        }
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String userId = request.getParameter("userId");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String contactNumber = request.getParameter("contactNumber");
        boolean isAdmin = Boolean.parseBoolean(request.getParameter("isAdmin"));

        User updatedUser = new User(userId, name, email, password, contactNumber, null);
        updatedUser.setAdmin(isAdmin);
        userManager.updateUser(updatedUser);

        response.sendRedirect("UserServlet?action=viewAll");
    }

    private void authenticateUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userManager.authenticate(email, password);

        if (user != null) {
            request.getSession().setAttribute("user", user);
            if (user.isAdmin()) {
                response.sendRedirect("adminDashboard.jsp");
            } else {
                response.sendRedirect("userDashboard.jsp");
            }
        } else {
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String userId = request.getParameter("userId");
        userManager.deleteUser(userId);
        response.sendRedirect("UserServlet?action=viewAll");
    }

    private void viewAllUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<User> users = userManager.getAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("viewUsers.jsp").forward(request, response);
    }

    private void viewUserProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userId = request.getParameter("userId");
        User profileUser = userManager.getUserById(userId);

        if (profileUser != null) {
            request.setAttribute("profileUser", profileUser);
            request.getRequestDispatcher("userProfile.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
        }
    }

    private void sortUsersByName(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<User> users = userManager.insertionSortUsersByName();
        request.setAttribute("users", users);
        request.getRequestDispatcher("viewUsers.jsp").forward(request, response);
    }

    private void sortUsersByDate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<User> users = userManager.insertionSortUsersByRegistrationDate();
        request.setAttribute("users", users);
        request.getRequestDispatcher("viewUsers.jsp").forward(request, response);
    }

    private void searchUsersByName(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchName = request.getParameter("searchName");
        List<User> users = userManager.searchUsersByName(searchName);
        request.setAttribute("users", users);
        request.setAttribute("searchName", searchName);
        request.getRequestDispatcher("viewUsers.jsp").forward(request, response);
    }
}
