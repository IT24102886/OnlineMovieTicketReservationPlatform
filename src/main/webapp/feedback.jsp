<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuickFlicks | Give Feedback</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;900&family=Bebas+Neue&display=swap" rel="stylesheet">
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
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: var(--primary-black);
            color: var(--light-gray);
            min-height: 100vh;
        }

        .feedback-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 30px;
            background-color: var(--secondary-black);
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
            border-left: 4px solid var(--accent-dark-pink);
        }

        .feedback-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .feedback-header h2 {
            color: var(--accent-dark-pink);
            font-family: 'Bebas Neue', sans-serif;
            letter-spacing: 2px;
        }

        .form-label {
            color: var(--light-gray);
            font-weight: 600;
        }

        .form-control, .form-select {
            background-color: var(--dark-gray);
            border: 1px solid var(--medium-gray);
            color: var(--light-gray);
            padding: 12px;
        }

        .form-control:focus, .form-select:focus {
            background-color: var(--dark-gray);
            border-color: var(--accent-dark-pink);
            color: var(--light-gray);
            box-shadow: 0 0 0 0.25rem rgba(236, 72, 153, 0.25);
        }

        .btn-submit {
            background-color: var(--accent-dark-pink);
            color: var(--white);
            border: none;
            padding: 12px 30px;
            font-weight: 600;
            letter-spacing: 1px;
            transition: all 0.3s;
        }

        .btn-submit:hover {
            background-color: var(--accent-pink);
            transform: translateY(-2px);
            box-shadow: var(--glow-cyan);
        }

        .rating {
            display: flex;
            flex-direction: row-reverse;
            justify-content: flex-end;
        }

        .rating input {
            display: none;
        }

        .rating label {
            cursor: pointer;
            font-size: 30px;
            color: var(--medium-gray);
            padding: 5px;
        }

        .rating label:hover,
        .rating label:hover ~ label,
        .rating input:checked ~ label {
            color: var(--accent-dark-pink);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="feedback-container">
            <div class="feedback-header">
                <h2>Share Your Experience</h2>
                <p class="text-muted">Your feedback helps us improve our services</p>
            </div>
            
            <form action="submitFeedback" method="POST">
                <div class="mb-4">
                    <label for="rating" class="form-label">How would you rate your experience?</label>
                    <div class="rating">
                        <input type="radio" name="rating" value="5" id="5"><label for="5">★</label>
                        <input type="radio" name="rating" value="4" id="4"><label for="4">★</label>
                        <input type="radio" name="rating" value="3" id="3"><label for="3">★</label>
                        <input type="radio" name="rating" value="2" id="2"><label for="2">★</label>
                        <input type="radio" name="rating" value="1" id="1"><label for="1">★</label>
                    </div>
                </div>

                <div class="mb-4">
                    <label for="feedbackType" class="form-label">Feedback Type</label>
                    <select class="form-select" id="feedbackType" name="feedbackType" required>
                        <option value="">Select feedback type</option>
                        <option value="suggestion">Suggestion</option>
                        <option value="complaint">Complaint</option>
                        <option value="praise">Praise</option>
                        <option value="other">Other</option>
                    </select>
                </div>

                <div class="mb-4">
                    <label for="feedbackText" class="form-label">Your Feedback</label>
                    <textarea class="form-control" id="feedbackText" name="feedbackText" rows="5" 
                              placeholder="Please share your thoughts with us..." required></textarea>
                </div>

                <div class="text-center">
                    <button type="submit" class="btn btn-submit">
                        <i class="fas fa-paper-plane me-2"></i>Submit Feedback
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 