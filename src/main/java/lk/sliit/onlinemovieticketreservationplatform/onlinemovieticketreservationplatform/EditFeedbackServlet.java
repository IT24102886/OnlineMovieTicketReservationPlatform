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

@WebServlet(name = "EditFeedbackServlet", urlPatterns = {"/editFeedback"})
public class EditFeedbackServlet extends HttpServlet {
    private static final String FEEDBACK_FILE = "feedback.txt";

    private void updateFile(String filePath, int targetEntry, User user, String rating, 
                          String feedbackType, String feedbackText) throws IOException {
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

        // Find and update the target entry
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
            String date = "";
            for (int i = startIndex; i <= endIndex; i++) {
                String line = lines.get(i);
                if (line.contains(user.getEmail())) {
                    isUserEntry = true;
                }
                if (line.startsWith("Date: ")) {
                    date = line.replace("Date: ", "");
                }
            }

            if (isUserEntry) {
                // Update the feedback entry
                List<String> updatedLines = new ArrayList<>();
                for (int i = 0; i < lines.size(); i++) {
                    if (i == startIndex) {
                        updatedLines.add("=== Feedback Entry ===");
                        updatedLines.add("User: " + user.getName() + " (" + user.getEmail() + ")");
                        updatedLines.add("Rating: " + rating + " stars");
                        updatedLines.add("Type: " + feedbackType);
                        updatedLines.add("Feedback: " + feedbackText);
                        updatedLines.add("Date: " + date);
                        updatedLines.add("===================");
                        i = endIndex;
                    } else if (i < startIndex || i > endIndex) {
                        updatedLines.add(lines.get(i));
                    }
                }

                // Write the updated content back to the file
                try (FileWriter writer = new FileWriter(feedbackFile)) {
                    for (String line : updatedLines) {
                        writer.write(line + "\n");
                    }
                }
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

            File feedbackFile = new File(deployedPath);
            if (!feedbackFile.exists()) {
                session.setAttribute("feedbackError", "Feedback file not found.");
                response.sendRedirect("userDashboard.jsp");
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

            // Find the target entry
            int currentEntry = 0;
            int startIndex = -1;
            int endIndex = -1;
            String rating = "";
            String feedbackType = "";
            String feedbackText = "";

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
                // Extract feedback details
                for (int i = startIndex; i <= endIndex; i++) {
                    String line = lines.get(i);
                    if (line.startsWith("Rating: ")) {
                        rating = line.replace("Rating: ", "").replace(" stars", "");
                    } else if (line.startsWith("Type: ")) {
                        feedbackType = line.replace("Type: ", "");
                    } else if (line.startsWith("Feedback: ")) {
                        feedbackText = line.replace("Feedback: ", "");
                    }
                }

                // Verify that this entry belongs to the current user
                boolean isUserEntry = false;
                for (int i = startIndex; i <= endIndex; i++) {
                    if (lines.get(i).contains(user.getEmail())) {
                        isUserEntry = true;
                        break;
                    }
                }

                if (isUserEntry) {
                    // Store feedback details in session for editing
                    session.setAttribute("editEntryNumber", entryNumberStr);
                    session.setAttribute("editRating", rating);
                    session.setAttribute("editFeedbackType", feedbackType);
                    session.setAttribute("editFeedbackText", feedbackText);
                    response.sendRedirect("editFeedback.jsp");
                } else {
                    session.setAttribute("feedbackError", "You can only edit your own feedback.");
                    response.sendRedirect("userDashboard.jsp");
                }
            } else {
                session.setAttribute("feedbackError", "Feedback entry not found.");
                response.sendRedirect("userDashboard.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("feedbackError", "An error occurred while processing your request.");
            response.sendRedirect("userDashboard.jsp");
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
        String rating = request.getParameter("rating");
        String feedbackType = request.getParameter("feedbackType");
        String feedbackText = request.getParameter("feedbackText");

        if (entryNumberStr == null || rating == null || feedbackType == null || feedbackText == null ||
            entryNumberStr.trim().isEmpty() || rating.trim().isEmpty() || 
            feedbackType.trim().isEmpty() || feedbackText.trim().isEmpty()) {
            session.setAttribute("feedbackError", "Please fill in all fields.");
            response.sendRedirect("editFeedback.jsp");
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

            // Update both locations
            updateFile(sourcePath, targetEntry, user, rating, feedbackType, feedbackText);
            updateFile(deployedPath, targetEntry, user, rating, feedbackType, feedbackText);

            // Clear session attributes
            session.removeAttribute("editEntryNumber");
            session.removeAttribute("editRating");
            session.removeAttribute("editFeedbackType");
            session.removeAttribute("editFeedbackText");

            response.sendRedirect("userDashboard.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("feedbackError", "An error occurred while processing your request.");
            response.sendRedirect("editFeedback.jsp");
        }
    }
} 