package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

@WebServlet("/submitFeedback")
public class SubmitFeedbackServlet extends HttpServlet {
    private static final String FEEDBACK_DIR = "/WEB-INF/feedback";
    private static final String FEEDBACK_FILE = "feedback.txt";
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get form data
        String rating = request.getParameter("rating");
        String feedbackType = request.getParameter("feedbackType");
        String feedbackText = request.getParameter("feedbackText");

        // Validate input
        if (rating == null || feedbackType == null || feedbackText == null || 
            rating.trim().isEmpty() || feedbackType.trim().isEmpty() || feedbackText.trim().isEmpty()) {
            session.setAttribute("feedbackError", "Please fill in all fields.");
            response.sendRedirect("feedback.jsp");
            return;
        }

        try {
            // Get the absolute path to the feedback directory
            String feedbackDirPath = getServletContext().getRealPath(FEEDBACK_DIR);
            File feedbackDir = new File(feedbackDirPath);
            
            // Create directory if it doesn't exist
            if (!feedbackDir.exists()) {
                if (!feedbackDir.mkdirs()) {
                    throw new IOException("Failed to create feedback directory");
                }
            }

            // Create or append to feedback file
            File feedbackFile = new File(feedbackDir, FEEDBACK_FILE);
            if (!feedbackFile.exists()) {
                // Create new file with header
                try (PrintWriter writer = new PrintWriter(new FileWriter(feedbackFile))) {
                    writer.println("# QuickFlicks User Feedback Log");
                    writer.println("# Format: Each feedback entry is separated by a line of dashes");
                    writer.println("# Fields: User, Rating, Type, Feedback, Date");
                    writer.println("# Created: " + LocalDateTime.now().getYear());
                    writer.println();
                }
            }

            // Append new feedback
            try (FileWriter fw = new FileWriter(feedbackFile, true);
                 BufferedWriter bw = new BufferedWriter(fw);
                 PrintWriter out = new PrintWriter(bw)) {
                
                out.println("=== Feedback Entry ===");
                out.println("User: " + user.getName() + " (" + user.getEmail() + ")");
                out.println("Rating: " + rating + " stars");
                out.println("Type: " + feedbackType);
                out.println("Feedback: " + feedbackText);
                out.println("Date: " + LocalDateTime.now().format(DATE_FORMATTER));
                out.println("===================");
            }

            // Redirect back to dashboard without success message
            response.sendRedirect("userDashboard.jsp");

        } catch (IOException e) {
            e.printStackTrace();
            // Redirect to dashboard without error message
            response.sendRedirect("userDashboard.jsp");
        }
    }
} 