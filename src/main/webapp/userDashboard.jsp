<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform.User" %>
<%@ page import="lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform.Booking" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.IOException" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuickFlicks | User Dashboard</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;900&family=Bebas+Neue&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-black: #0A0F1D;
            --secondary-black: #1C2526;
            --dark-gray: #2A2F3A;
            --medium-gray: #6B7280;
            --light-gray: #D1D5DB;
            --accent-pink: #EC4899;
            --accent-dark-pink: #BE185D;
            --accent-cyan: #06B6D4;
            --white: #F9FAFB;
            --glow-cyan: 0 0 10px rgba(6, 182, 212, 0.5);
            --rating-yellow: #FBBF24;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: var(--primary-black);
            color: var(--light-gray);
            min-height: 100vh;
        }

        h1, h2, h3, h4, h5, h6 {
            font-family: 'Bebas Neue', sans-serif;
            letter-spacing: 1px;
        }

        .sidebar {
            background-color: var(--secondary-black);
            min-height: 100vh;
            border-right: 2px solid var(--medium-gray);
        }

        .sidebar-header {
            padding: 20px;
            border-bottom: 2px solid var(--accent-dark-pink);
            text-align: center;
        }

        .sidebar-header h4 {
            color: var(--white);
        }

        .sidebar-header h4 span {
            color: var(--accent-dark-pink);
        }

        .sidebar-menu {
            padding: 20px 0;
        }

        .sidebar-menu .nav-link {
            color: var(--light-gray);
            padding: 10px 20px;
            margin: 5px 0;
            border-radius: 0;
            position: relative;
            transition: all 0.3s;
        }

        .sidebar-menu .nav-link:before {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: 0;
            left: 0;
            background-color: var(--accent-dark-pink);
            visibility: hidden;
            transition: all 0.3s ease-in-out;
        }

        .sidebar-menu .nav-link:hover:before {
            visibility: visible;
            width: 100%;
        }

        .sidebar-menu .nav-link:hover {
            color: var(--accent-dark-pink);
            background-color: var(--dark-gray);
        }

        .sidebar-menu .nav-link.active {
            color: var(--accent-dark-pink);
            background-color: var(--dark-gray);
            border-left: 4px solid var(--accent-dark-pink);
        }

        .main-content {
            padding: 20px;
        }

        .card {
            background-color: var(--secondary-black);
            border: none;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            margin-bottom: 20px;
            border-left: 4px solid transparent;
            transition: all 0.3s;
            color: var(--light-gray);
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: var(--glow-cyan);
            border-left: 4px solid var(--accent-dark-pink);
        }

        .card-header {
            background-color: var(--dark-gray);
            border-bottom: 1px solid var(--medium-gray);
            font-weight: 700;
            font-family: 'Bebas Neue', sans-serif;
            letter-spacing: 1px;
            color: var(--accent-dark-pink);
        }

        .welcome-section {
            background: linear-gradient(135deg, var(--dark-gray) 0%, var(--secondary-black) 100%);
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 30px;
            border-left: 4px solid var(--accent-dark-pink);
            box-shadow: var(--glow-cyan);
        }

        .profile-img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid var(--accent-dark-pink);
        }

        .btn-red {
            background-color: var(--accent-dark-pink);
            color: var(--white);
            border: none;
            font-weight: 700;
            padding: 10px 20px;
            border-radius: 5px;
            letter-spacing: 1px;
            transition: all 0.3s;
        }

        .btn-red:hover {
            background-color: var(--accent-pink);
            transform: translateY(-3px);
            box-shadow: var(--glow-cyan);
            color: var(--white);
        }

        .btn-outline-red {
            border: 2px solid var(--accent-dark-pink);
            color: var(--accent-dark-pink);
            background-color: transparent;
            font-weight: 700;
            padding: 10px 20px;
            border-radius: 5px;
            letter-spacing: 1px;
            transition: all 0.3s;
        }

        .btn-outline-red:hover {
            background-color: var(--accent-dark-pink);
            color: var(--white);
            transform: translateY(-3px);
            box-shadow: var(--glow-cyan);
        }

        .table {
            color: var(--light-gray);
            background-color: var(--secondary-black);
        }

        .table th {
            background-color: var(--dark-gray);
            color: var(--accent-dark-pink);
            font-family: 'Bebas Neue', sans-serif;
            letter-spacing: 1px;
        }

        .table td {
            border-color: var(--medium-gray);
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3 col-lg-2 d-md-block sidebar">
            <div class="sidebar-header">
                <h4>QUICK<span>FLICKS</span></h4>
                <p class="text-muted">User Portal</p>
            </div>
            <div class="sidebar-menu">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="userDashboard.jsp">
                            <i class="fas fa-user me-2"></i> My Profile
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">
                            <i class="fas fa-home me-2"></i> Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="movies.jsp">
                            <i class="fas fa-film me-2"></i> Browse Movies
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="select-cinema.jsp">
                            <i class="fas fa-ticket-alt me-2"></i> Buy Tickets
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="feedback.jsp">
                            <i class="fas fa-comment-dots me-2"></i> Give Feedback
                        </a>
                    </li>
                    <li class="nav-item mt-4">
                        <a class="nav-link" href="UserLogoutServlet">
                            <i class="fas fa-sign-out-alt me-2"></i> Logout
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <!-- Main Content -->
        <div class="col-md-9 col-lg-10 ms-sm-auto main-content">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>User Dashboard</h2>
                <form action="UserLogoutServlet" method="post">
                    <button type="submit" class="btn btn-outline-red">
                        <i class="fas fa-sign-out-alt me-1"></i> Logout
                    </button>
                </form>
            </div>

            <%-- Get user from session --%>
            <% User user = (User) session.getAttribute("user"); %>
            <c:if test="${empty user}">
                <c:redirect url="login.jsp"/>
            </c:if>

            <!-- Welcome Section -->
            <div class="welcome-section">
                <div class="row align-items-center">
                    <div class="col-md-2 text-center">
                        <img src="https://ui-avatars.com/api/?name=<%= user.getName() %>&background=BE185D&color=fff&size=100"
                             alt="Profile Image" class="profile-img">
                    </div>
                    <div class="col-md-10">
                        <h3>Welcome back, <%= user.getName() %>!</h3>
                        <p class="mb-0">Explore movies and manage your bookings.</p>
                    </div>
                </div>
            </div>

            <!-- Dashboard Cards -->
            <div class="row">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <i class="fas fa-user me-2"></i> Profile Details
                        </div>
                        <div class="card-body">
                            <p><strong>Name:</strong> <%= user.getName() %></p>
                            <p><strong>Email:</strong> <%= user.getEmail() %></p>
                            <p><strong>Contact Number:</strong> <%= user.getContactNumber() %></p>
                            <a href="editProfile.jsp" class="btn btn-red btn-sm">Update Profile</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <i class="fas fa-ticket-alt me-2"></i> Quick Actions
                        </div>
                        <div class="card-body">
                            <div class="d-grid gap-2">
                                <a href="movies.jsp" class="btn btn-red">Browse Movies</a>
                                <a href="select-cinema.jsp" class="btn btn-red">Buy Tickets</a>
                                <a href="feedback.jsp" class="btn btn-red">Give Feedback</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Booking History -->
            <div class="card mt-4">
                <div class="card-header">
                    <i class="fas fa-history me-2"></i> Recent Bookings
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty bookingHistory}">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>Booking ID</th>
                                    <th>Movie</th>
                                    <th>Cinema</th>
                                    <th>Showtime</th>
                                    <th>Seats</th>
                                    <th>Total</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="booking" items="${bookingHistory}">
                                    <tr>
                                        <td>${booking.bookingId}</td>
                                        <td>${booking.movieTitle}</td>
                                        <td>${booking.cinema}</td>
                                        <td>${booking.showtime}</td>
                                        <td>${booking.seats}</td>
                                        <td>LKR ${booking.total}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <p>No recent bookings to display.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Feedback Section -->
            <div class="card mt-4">
                <div class="card-header">
                    <i class="fas fa-comment-dots me-2"></i> Your Feedback
                </div>
                <div class="card-body">
                    <!-- Display Feedback History -->
                    <div class="feedback-history mt-4">
                        <h5 class="mb-3">Your Feedback History</h5>
                        <%
                            String feedbackPath = application.getRealPath("/WEB-INF/feedback/feedback.txt");
                            File feedbackFile = new File(feedbackPath);
                            if (feedbackFile.exists()) {
                                try (BufferedReader reader = new BufferedReader(new FileReader(feedbackFile))) {
                                    String line;
                                    boolean isEntry = false;
                                    String currentEntry = "";
                                    int entryCount = 0;
                                    while ((line = reader.readLine()) != null) {
                                        if (line.startsWith("=== Feedback Entry ===")) {
                                            isEntry = true;
                                            currentEntry = "";
                                            entryCount++;
                                        } else if (line.startsWith("===================")) {
                                            isEntry = false;
                                            if (!currentEntry.isEmpty()) {
                                                // Only show entries for the current user
                                                if (currentEntry.contains(user.getEmail())) {
                                                    out.println("<div class='feedback-entry mb-3 p-3' style='background-color: var(--dark-gray); border-radius: 8px;'>");
                                                    out.println("<div class='d-flex justify-content-between align-items-start'>");
                                                    out.println("<div class='feedback-content'>");
                                                    out.println(currentEntry.replace("\n", "<br>"));
                                                    out.println("</div>");
                                                    out.println("<div class='ms-3'>");
                                                    out.println("<form action='editFeedback' method='GET' class='d-inline me-2'>");
                                                    out.println("<input type='hidden' name='entryNumber' value='" + entryCount + "'>");
                                                    out.println("<button type='submit' class='btn btn-warning btn-sm'>");
                                                    out.println("<i class='fas fa-edit'></i>");
                                                    out.println("</button>");
                                                    out.println("</form>");
                                                    out.println("<form action='deleteFeedback' method='POST' class='d-inline'>");
                                                    out.println("<input type='hidden' name='entryNumber' value='" + entryCount + "'>");
                                                    out.println("<button type='submit' class='btn btn-danger btn-sm' onclick=\"return confirm('Are you sure you want to delete this feedback?')\">");
                                                    out.println("<i class='fas fa-trash-alt'></i>");
                                                    out.println("</button>");
                                                    out.println("</form>");
                                                    out.println("</div>");
                                                    out.println("</div>");
                                                    out.println("</div>");
                                                }
                                            }
                                        } else if (isEntry) {
                                            currentEntry += line + "\n";
                                        }
                                    }
                                } catch (IOException e) {
                                    out.println("<p class='text-danger'>Error reading feedback history.</p>");
                                }
                            } else {
                                out.println("<p>No feedback history available.</p>");
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
