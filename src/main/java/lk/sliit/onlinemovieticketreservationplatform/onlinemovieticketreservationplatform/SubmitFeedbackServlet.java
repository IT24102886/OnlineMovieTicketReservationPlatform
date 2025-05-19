package lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.StandardOpenOption;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/submitFeedback")
public class SubmitFeedbackServlet extends HttpServlet {
    private static final String FEEDBACK_FILE = "feedback.txt";
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    private void writeToFileDirectly(String filePath, String content, boolean append) throws IOException {
        File file = new File(filePath);
        File parentDir = file.getParentFile();
        
        if (!parentDir.exists()) {
            if (!parentDir.mkdirs()) {
                throw new IOException("Failed to create directory: " + parentDir.getAbsolutePath());
            }
        }

        if (!append || !file.exists()) {
            Files.writeString(file.toPath(), content);
        } else {
            Files.writeString(file.toPath(), content, StandardOpenOption.APPEND);
        }

        // Verify the write
        if (!file.exists() || file.length() == 0) {
            throw new IOException("Failed to write to file: " + filePath);
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

        String rating = request.getParameter("rating");
        String feedbackType = request.getParameter("feedbackType");
        String feedbackText = request.getParameter("feedbackText");

        System.out.println("=== Feedback Submission Debug ===");
        System.out.println("User: " + user.getName() + " (" + user.getEmail() + ")");
        System.out.println("Rating: " + rating);
        System.out.println("Type: " + feedbackType);
        System.out.println("Feedback: " + feedbackText);
        System.out.println();

        if (rating == null || feedbackType == null || feedbackText == null || 
            rating.trim().isEmpty() || feedbackType.trim().isEmpty() || feedbackText.trim().isEmpty()) {
            session.setAttribute("feedbackError", "Please fill in all fields.");
            response.sendRedirect("feedback.jsp");
            return;
        }

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

            // Prepare the feedback entry
            StringBuilder feedbackEntry = new StringBuilder();
            if (!new File(sourcePath).exists()) {
                feedbackEntry.append("# QuickFlicks User Feedback Log\n");
                feedbackEntry.append("# Format: Each feedback entry is separated by a line of dashes\n");
                feedbackEntry.append("# Fields: User, Rating, Type, Feedback, Date\n");
                feedbackEntry.append("# Created: ").append(LocalDateTime.now().getYear()).append("\n\n");
            }

            feedbackEntry.append("=== Feedback Entry ===\n");
            feedbackEntry.append("User: ").append(user.getName()).append(" (").append(user.getEmail()).append(")\n");
            feedbackEntry.append("Rating: ").append(rating).append(" stars\n");
            feedbackEntry.append("Type: ").append(feedbackType).append("\n");
            feedbackEntry.append("Feedback: ").append(feedbackText).append("\n");
            feedbackEntry.append("Date: ").append(LocalDateTime.now().format(DATE_FORMATTER)).append("\n");
            feedbackEntry.append("===================\n\n");

            String content = feedbackEntry.toString();

            // Write to both locations
            System.out.println("\nWriting feedback...");
            
            // Write to source location
            writeToFileDirectly(sourcePath, content, new File(sourcePath).exists());
            System.out.println("Successfully wrote to source: " + sourcePath);
            
            // Write to deployed location
            writeToFileDirectly(deployedPath, content, new File(deployedPath).exists());
            System.out.println("Successfully wrote to deployed: " + deployedPath);

            // Verify the writes
            System.out.println("\n=== File Verification ===");
            File sourceFile = new File(sourcePath);
            File deployedFile = new File(deployedPath);

            System.out.println("Source file exists: " + sourceFile.exists());
            System.out.println("Source file length: " + sourceFile.length() + " bytes");
            System.out.println("Deployed file exists: " + deployedFile.exists());
            System.out.println("Deployed file length: " + deployedFile.length() + " bytes");

            if (sourceFile.exists()) {
                System.out.println("\nSource file content:");
                System.out.println(Files.readString(sourceFile.toPath()));
            }

            System.out.println("\n=== Operation Complete ===");
            response.sendRedirect("userDashboard.jsp");

        } catch (IOException e) {
            System.out.println("\n=== Error Occurred ===");
            System.out.println("Error message: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("feedbackError", "An error occurred while saving your feedback. Error: " + e.getMessage());
            response.sendRedirect("feedback.jsp");
        }
    }
} 