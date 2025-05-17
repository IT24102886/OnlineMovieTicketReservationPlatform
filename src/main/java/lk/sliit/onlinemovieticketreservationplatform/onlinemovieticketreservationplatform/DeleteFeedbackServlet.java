package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "DeleteFeedbackServlet", urlPatterns = {"/deleteFeedback"})
public class DeleteFeedbackServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String entryNumberStr = request.getParameter("entryNumber");
        if (entryNumberStr == null || entryNumberStr.trim().isEmpty()) {
            session.setAttribute("feedbackError", "Invalid feedback entry.");
            response.sendRedirect("userDashboard.jsp");
            return;
        }

        int targetEntry = Integer.parseInt(entryNumberStr);
        String feedbackPath = getServletContext().getRealPath("/WEB-INF/feedback/feedback.txt");
        File feedbackFile = new File(feedbackPath);

        if (!feedbackFile.exists()) {
            session.setAttribute("feedbackError", "Feedback file not found.");
            response.sendRedirect("userDashboard.jsp");
            return;
        }

        try {
            // Read all lines from the file
            List<String> lines = new ArrayList<>();
            try (BufferedReader reader = new BufferedReader(new FileReader(feedbackFile))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    lines.add(line);
                }
            }

            // Find and remove the target entry
            int currentEntry = 0;
            int startIndex = -1;
            int endIndex = -1;

            for (int i = 0; i < lines.size(); i++) {
                if (lines.get(i).startsWith("=== Feedback Entry ===")) {
                    currentEntry++;
                    if (currentEntry == targetEntry) {
                        startIndex = i;
                    }
                } else if (lines.get(i).startsWith("===================") && startIndex != -1) {
                    endIndex = i;
                    break;
                }
            }

            if (startIndex != -1 && endIndex != -1) {
                // Verify that this entry belongs to the current user
                boolean isUserEntry = false;
                for (int i = startIndex; i <= endIndex; i++) {
                    if (lines.get(i).contains(user.getEmail())) {
                        isUserEntry = true;
                        break;
                    }
                }

                if (isUserEntry) {
                    // Remove the entry and the blank line after it
                    for (int i = endIndex; i >= startIndex; i--) {
                        lines.remove(i);
                    }
                    if (endIndex < lines.size() && lines.get(endIndex).trim().isEmpty()) {
                        lines.remove(endIndex);
                    }

                    // Write the updated content back to the file
                    try (FileWriter writer = new FileWriter(feedbackFile)) {
                        for (String line : lines) {
                            writer.write(line + "\n");
                        }
                    }

                    // Redirect back to dashboard without success message
                    response.sendRedirect("userDashboard.jsp");
                } else {
                    session.setAttribute("feedbackError", "You can only delete your own feedback.");
                    response.sendRedirect("userDashboard.jsp");
                }
            } else {
                session.setAttribute("feedbackError", "Feedback entry not found.");
                response.sendRedirect("userDashboard.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Redirect to dashboard without error message
            response.sendRedirect("userDashboard.jsp");
        }
    }
} 