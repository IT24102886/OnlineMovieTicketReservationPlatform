package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {
    private UserManager userManager;

    @Override
    public void init() throws ServletException {
        this.userManager = UserManager.getInstance();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String contactNumber = request.getParameter("contactNumber");

        if (!validateRegistration(name, email, password, confirmPassword, contactNumber, request, response)) {
            return;
        }

        User newUser = new User(null, name, email, password, contactNumber, null);
        newUser.setAdmin(false);

        userManager.addUser(newUser);
        System.out.println("Registered user: " + newUser.getEmail());

        HttpSession session = request.getSession();
        session.setAttribute("user", newUser);

        response.sendRedirect("index.jsp");
    }

    private boolean validateRegistration(String name, String email, String password,
                                         String confirmPassword, String contactNumber,
                                         HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (name == null || name.isEmpty() || email == null || email.isEmpty() ||
                password == null || password.isEmpty() || contactNumber == null || contactNumber.isEmpty()) {
            request.setAttribute("error", "All fields are required");
            forwardWithError(request, response);
            return false;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            forwardWithError(request, response);
            return false;
        }

        if (password.length() < 8) {
            request.setAttribute("error", "Password must be at least 8 characters");
            forwardWithError(request, response);
            return false;
        }

        if (!contactNumber.matches("\\+94\\d{9}|\\d{10}")) {
            request.setAttribute("error", "Invalid contact number format");
            forwardWithError(request, response);
            return false;
        }

        if (userManager.emailExists(email)) {
            request.setAttribute("error", "Email already registered");
            forwardWithError(request, response);
            return false;
        }

        return true;
    }

    private void forwardWithError(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }
}