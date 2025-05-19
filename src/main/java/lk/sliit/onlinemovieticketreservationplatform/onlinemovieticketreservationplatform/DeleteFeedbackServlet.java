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
    private static final String FEEDBACK_FILE = "feedback.txt";

    private void deleteFromFile(String filePath, int targetEntry, User user) throws IOException {
        File feedbackFile = new File(filePath);
        if (!feedbackFile.exists()) {
            return;
        }

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
            }
        }
    }

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

        try {
            // Get the correct project path from the deployed path
            String deployedPath = getServletContext().getRealPath("/WEB-INF/feedback/" + FEEDBACK_FILE);
            String projectRoot = new File(deployedPath)
                .getParentFile() // feedback
                .getParentFile() // WEB-INF
                .getParentFile() // OnlineMovieTicketReservationPlatform-1.0-SNAPSHOT
                .getParentFile() // target
                .getParentFile() // OnlineMovieTicketReservationPlatform
                .getAbsolutePath();

            // Construct the source path
            String sourcePath = projectRoot + File.separator + "src" + File.separator + "main" + 
                              File.separator + "webapp" + File.separator + "WEB-INF" + 
                              File.separator + "feedback" + File.separator + FEEDBACK_FILE;

            System.out.println("=== Path Information ===");
            System.out.println("Project Root: " + projectRoot);
            System.out.println("Source Path: " + sourcePath);
            System.out.println("Deployed Path: " + deployedPath);

            // Delete from both locations
            deleteFromFile(sourcePath, targetEntry, user);
            deleteFromFile(deployedPath, targetEntry, user);

            response.sendRedirect("userDashboard.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("feedbackError", "An error occurred while deleting the feedback.");
            response.sendRedirect("userDashboard.jsp");
        }
    }
} 