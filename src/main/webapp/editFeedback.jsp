<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuickFlicks | Edit Feedback</title>
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

        .card {
            background-color: var(--secondary-black);
            border: none;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            margin-bottom: 20px;
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

        .form-control, .form-select {
            background-color: var(--dark-gray);
            border: 1px solid var(--medium-gray);
            color: var(--light-gray);
        }

        .form-control:focus, .form-select:focus {
            background-color: var(--dark-gray);
            border-color: var(--accent-dark-pink);
            color: var(--light-gray);
            box-shadow: 0 0 0 0.25rem rgba(236, 72, 153, 0.25);
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

        .rating-stars {
            color: var(--rating-yellow);
            font-size: 1.5rem;
        }

        .rating-stars .far {
            color: var(--medium-gray);
        }
    </style>
</head>
<body>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h4 class="mb-0"><i class="fas fa-edit me-2"></i>Edit Feedback</h4>
                </div>
                <div class="card-body">
                    <%
                        User user = (User) session.getAttribute("user");
                        if (user == null) {
                            response.sendRedirect("login.jsp");
                            return;
                        }

                        String error = (String) session.getAttribute("feedbackError");
                        if (error != null) {
                            session.removeAttribute("feedbackError");
                    %>
                    <div class="alert alert-danger" role="alert">
                        <%= error %>
                    </div>
                    <% } %>

                    <form action="editFeedback" method="POST">
                        <input type="hidden" name="entryNumber" value="${editEntryNumber}">
                        
                        <div class="mb-4">
                            <label class="form-label">Rating</label>
                            <div class="rating-stars">
                                <% 
                                    int currentRating = Integer.parseInt(session.getAttribute("editRating").toString());
                                    for (int i = 1; i <= 5; i++) {
                                %>
                                <i class="<%= i <= currentRating ? "fas" : "far" %> fa-star" data-rating="<%= i %>"></i>
                                <% } %>
                            </div>
                            <input type="hidden" name="rating" id="rating" value="${editRating}">
                        </div>

                        <div class="mb-4">
                            <label for="feedbackType" class="form-label">Feedback Type</label>
                            <select class="form-select" id="feedbackType" name="feedbackType" required>
                                <option value="">Select feedback type</option>
                                <option value="General" ${editFeedbackType == 'General' ? 'selected' : ''}>General</option>
                                <option value="Technical" ${editFeedbackType == 'Technical' ? 'selected' : ''}>Technical</option>
                                <option value="Service" ${editFeedbackType == 'Service' ? 'selected' : ''}>Service</option>
                                <option value="Content" ${editFeedbackType == 'Content' ? 'selected' : ''}>Content</option>
                                <option value="Other" ${editFeedbackType == 'Other' ? 'selected' : ''}>Other</option>
                            </select>
                        </div>

                        <div class="mb-4">
                            <label for="feedbackText" class="form-label">Your Feedback</label>
                            <textarea class="form-control" id="feedbackText" name="feedbackText" rows="4" required>${editFeedbackText}</textarea>
                        </div>

                        <div class="d-flex justify-content-between">
                            <a href="userDashboard.jsp" class="btn btn-outline-red">
                                <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                            </a>
                            <button type="submit" class="btn btn-red">
                                <i class="fas fa-save me-2"></i>Save Changes
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Custom JS -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    const stars = document.querySelectorAll('.rating-stars .fa-star');
    const ratingInput = document.getElementById('rating');

    stars.forEach(star => {
        star.addEventListener('click', function() {
            const rating = this.getAttribute('data-rating');
            ratingInput.value = rating;
            
            stars.forEach(s => {
                if (s.getAttribute('data-rating') <= rating) {
                    s.classList.remove('far');
                    s.classList.add('fas');
                } else {
                    s.classList.remove('fas');
                    s.classList.add('far');
                }
            });
        });

        star.addEventListener('mouseover', function() {
            const rating = this.getAttribute('data-rating');
            stars.forEach(s => {
                if (s.getAttribute('data-rating') <= rating) {
                    s.classList.remove('far');
                    s.classList.add('fas');
                }
            });
        });

        star.addEventListener('mouseout', function() {
            const currentRating = ratingInput.value;
            stars.forEach(s => {
                if (s.getAttribute('data-rating') <= currentRating) {
                    s.classList.remove('far');
                    s.classList.add('fas');
                } else {
                    s.classList.remove('fas');
                    s.classList.add('far');
                }
            });
        });
    });
});
</script>
</body>
</html> 