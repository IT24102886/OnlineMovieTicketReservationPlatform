
<%--<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>--%>
<%--<%@ page import="lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform.User" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html lang="en">--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--    <title>QuickFlicks | Edit Profile</title>--%>
<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">--%>
<%--    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">--%>
<%--    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">--%>
<%--    <style>--%>
<%--        :root {--%>
<%--            --primary-black: #0D1321;--%>
<%--            --secondary-black: #1A1A2E;--%>
<%--            --dark-gray: #16213E;--%>
<%--            --medium-gray: #4a4a4a;--%>
<%--            --light-gray: #e5e5e5;--%>
<%--            --accent-pink: #FF1493;--%>
<%--            --accent-dark-pink: #D81159;--%>
<%--            --accent-cyan: #00FFFF;--%>
<%--            --white: #ffffff;--%>
<%--            --glow-cyan: 0 0 10px rgba(0, 255, 255, 0.7);--%>
<%--        }--%>

<%--        body {--%>
<%--            font-family: 'Montserrat', sans-serif;--%>
<%--            background-color: var(--primary-black);--%>
<%--            color: var(--light-gray);--%>
<%--            min-height: 100vh;--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)),--%>
<%--            url('https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?ixlib=rb-4.0.3&auto=format&fit=crop&w=1470&q=80');--%>
<%--            background-size: cover;--%>
<%--            background-position: center;--%>
<%--        }--%>

<%--        .register-container {--%>
<%--            max-width: 500px;--%>
<%--            width: 100%;--%>
<%--            margin: 2rem auto;--%>
<%--            padding: 2.5rem;--%>
<%--            background-color: rgba(13, 19, 33, 0.95);--%>
<%--            border-radius: 10px;--%>
<%--            box-shadow: 0 5px 30px rgba(0, 0, 0, 0.5);--%>
<%--            border-top: 4px solid var(--accent-dark-pink);--%>
<%--        }--%>

<%--        .register-logo {--%>
<%--            font-family: 'Bebas Neue', sans-serif;--%>
<%--            font-size: 2.5rem;--%>
<%--            font-weight: 700;--%>
<%--            color: var(--white);--%>
<%--            text-align: center;--%>
<%--            margin-bottom: 1.5rem;--%>
<%--            letter-spacing: 2px;--%>
<%--        }--%>

<%--        .register-logo span {--%>
<%--            color: var(--accent-dark-pink);--%>
<%--        }--%>

<%--        .register-title {--%>
<%--            font-family: 'Bebas Neue', sans-serif;--%>
<%--            color: var(--accent-cyan);--%>
<%--            font-size: 1.8rem;--%>
<%--            margin-bottom: 1.5rem;--%>
<%--            text-align: center;--%>
<%--            letter-spacing: 1px;--%>
<%--        }--%>

<%--        .form-control {--%>
<%--            background-color: var(--secondary-black);--%>
<%--            border: 1px solid var(--medium-gray);--%>
<%--            color: var(--light-gray);--%>
<%--            height: 50px;--%>
<%--            padding: 0.75rem 1.25rem;--%>
<%--            transition: all 0.3s;--%>
<%--        }--%>

<%--        .form-control:focus {--%>
<%--            background-color: var(--secondary-black);--%>
<%--            color: var(--light-gray);--%>
<%--            border-color: var(--accent-cyan);--%>
<%--            box-shadow: var(--glow-cyan);--%>
<%--        }--%>

<%--        .btn-register {--%>
<%--            background-color: var(--accent-dark-pink);--%>
<%--            color: var(--white);--%>
<%--            border: none;--%>
<%--            font-weight: 700;--%>
<%--            padding: 12px;--%>
<%--            border-radius: 5px;--%>
<%--            letter-spacing: 1px;--%>
<%--            transition: all 0.3s;--%>
<%--            width: 100%;--%>
<%--        }--%>

<%--        .btn-register:hover {--%>
<%--            background-color: var(--accent-dark-pink);--%>
<%--            transform: translateY(-3px);--%>
<%--            box-shadow: 0 10px 20px rgba(216, 17, 89, 0.4);--%>
<%--        }--%>

<%--        .alert-danger {--%>
<%--            background-color: rgba(216, 17, 89, 0.2);--%>
<%--            color: var(--light-gray);--%>
<%--            border-left: 4px solid var(--accent-dark-pink);--%>
<%--            border-radius: 5px;--%>
<%--        }--%>

<%--        .input-icon {--%>
<%--            position: absolute;--%>
<%--            top: 50%;--%>
<%--            left: 15px;--%>
<%--            transform: translateY(-50%);--%>
<%--            color: var(--medium-gray);--%>
<%--        }--%>

<%--        .input-group {--%>
<%--            position: relative;--%>
<%--        }--%>

<%--        .input-group input {--%>
<%--            padding-left: 45px !important;--%>
<%--        }--%>

<%--        label {--%>
<%--            font-weight: 600;--%>
<%--            margin-bottom: 0.5rem;--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="container">--%>
<%--    <div class="register-container">--%>
<%--        <div class="register-logo">QUICK<span>FLICKS</span></div>--%>
<%--        <h2 class="register-title">EDIT YOUR PROFILE</h2>--%>

<%--        &lt;%&ndash; Get user from session &ndash;%&gt;--%>
<%--        <% User user = (User) session.getAttribute("user"); %>--%>
<%--        <c:if test="${empty user}">--%>
<%--            <c:redirect url="login.jsp"/>--%>
<%--        </c:if>--%>

<%--        <c:if test="${not empty error}">--%>
<%--            <div class="alert alert-danger alert-dismissible fade show">--%>
<%--                <i class="fas fa-exclamation-circle me-2"></i> ${error}--%>
<%--                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>--%>
<%--            </div>--%>
<%--        </c:if>--%>

<%--        <form action="UserProfileServlet" method="post">--%>
<%--            <input type="hidden" name="action" value="updateProfile">--%>

<%--            <div class="mb-3">--%>
<%--                <label for="name" class="form-label">Full Name</label>--%>
<%--                <div class="input-group">--%>
<%--                    <i class="fas fa-user input-icon"></i>--%>
<%--                    <input type="text" class="form-control" id="name" name="name" value="<%= user.getName() %>" required>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <div class="mb-3">--%>
<%--                <label for="email" class="form-label">Email</label>--%>
<%--                <div class="input-group">--%>
<%--                    <i class="fas fa-envelope input-icon"></i>--%>
<%--                    <input type="email" class="form-control" id="email" name="email" value="<%= user.getEmail() %>" required>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <div class="mb-3">--%>
<%--                <label for="contactNumber" class="form-label">Contact Number</label>--%>
<%--                <div class="input-group">--%>
<%--                    <i class="fas fa-phone input-icon"></i>--%>
<%--                    <input type="tel" class="form-control" id="contactNumber" name="contactNumber" value="<%= user.getContactNumber() %>" required>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <div class="mb-3">--%>
<%--                <label for="password" class="form-label">New Password (Optional)</label>--%>
<%--                <div class="input-group">--%>
<%--                    <i class="fas fa-lock input-icon"></i>--%>
<%--                    <input type="password" class="form-control" id="password" name="password" placeholder="Leave blank to keep current password" minlength="8">--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <button type="submit" class="btn btn-register mb-3">--%>
<%--                <i class="fas fa-save me-2"></i> SAVE CHANGES--%>
<%--            </button>--%>
<%--        </form>--%>
<%--    </div>--%>
<%--</div>--%>

<%--<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>--%>
<%--</body>--%>
<%--</html>--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=最新的代码
    <title>QuickFlicks | Edit Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
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
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)),
            url('https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?ixlib=rb-4.0.3&auto=format&fit=crop&w=1470&q=80');
            background-size: cover;
            background-position: center;
        }

        h1, h2, h3, h4, h5, h6 {
            font-family: 'Bebas Neue', sans-serif;
            letter-spacing: 1px;
        }

        .edit-container {
            max-width: 500px;
            width: 100%;
            margin: 2rem auto;
            padding: 2.5rem;
            background-color: var(--secondary-black);
            border-radius: 10px;
            box-shadow: 0 5px 30px rgba(0, 0, 0, 0.5);
            border-top: 4px solid var(--accent-dark-pink);
        }

        .form-control {
            background-color: var(--dark-gray);
            border: 1px solid var(--medium-gray);
            color: var(--light-gray);
            height: 50px;
            padding: 0.75rem 1.25rem;
            transition: all 0.3s;
        }

        .form-control:focus {
            background-color: var(--dark-gray);
            color: var(--light-gray);
            border-color: var(--accent-cyan);
            box-shadow: var(--glow-cyan);
        }

        .btn-red {
            background-color: var(--accent-dark-pink);
            color: var(--white);
            border: none;
            font-weight: 700;
            padding: 12px;
            border-radius: 5px;
            letter-spacing: 1px;
            transition: all 0.3s;
            width: 100%;
        }

        .btn-red:hover {
            background-color: var(--accent-pink);
            transform: translateY(-3px);
            box-shadow: var(--glow-cyan);
        }

        .alert-danger {
            background-color: rgba(190, 24, 93, 0.2);
            color: var(--light-gray);
            border-left: 4px solid var(--accent-dark-pink);
            border-radius: 5px;
        }

        .input-icon {
            position: absolute;
            top: 50%;
            left: 15px;
            transform: translateY(-50%);
            color: var(--medium-gray);
        }

        .input-group {
            position: relative;
        }

        .input-group input {
            padding-left: 45px !important;
        }

        .login-logo {
            font-family: 'Bebas Neue', sans-serif;
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--white);
            text-align: center;
            margin-bottom: 1.5rem;
            letter-spacing: 2px;
        }

        .login-logo span {
            color: var(--accent-dark-pink);
        }

        .login-title {
            font-family: 'Bebas Neue', sans-serif;
            color: var(--accent-cyan);
            font-size: 1.8rem;
            margin-bottom: 1.5rem;
            text-align: center;
            letter-spacing: 1px;
        }

        label {
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="edit-container">
        <div class="login-logo">QUICK<span>FLICKS</span></div>
        <h2 class="login-title">EDIT YOUR PROFILE</h2>

        <%-- Check if user is logged in --%>
        <% User user = (User) session.getAttribute("user"); %>
        <c:if test="${empty user}">
            <c:redirect url="login.jsp"/>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show">
                <i class="fas fa-exclamation-circle me-2"></i> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/UserServlet" method="post" id="editProfileForm">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="userId" value="<%= user.getUserId() %>">
            <input type="hidden" name="isAdmin" value="<%= user.isAdmin() %>">
            <input type="hidden" name="fromProfile" value="true">

            <div class="mb-3">
                <label for="name" class="form-label">Full Name</label>
                <div class="input-group">
                    <i class="fas fa-user input-icon"></i>
                    <input type="text" class="form-control" id="name" name="name" required
                           value="<%= user.getName() %>" placeholder="Your full name">
                </div>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <div class="input-group">
                    <i class="fas fa-envelope input-icon"></i>
                    <input type="email" class="form-control" id="email" name="email" required
                           value="<%= user.getEmail() %>" placeholder="your@email.com">
                </div>
            </div>

            <div class="mb-3">
                <label for="contactNumber" class="form-label">Contact Number</label>
                <div class="input-group">
                    <i class="fas fa-phone input-icon"></i>
                    <input type="text" class="form-control" id="contactNumber" name="contactNumber" required
                           value="<%= user.getContactNumber() %>" placeholder="Your contact number">
                </div>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">New Password (Optional)</label>
                <div class="input-group">
                    <i class="fas fa-lock input-icon"></i>
                    <input type="password" class="form-control" id="password" name="password"
                           placeholder="Enter new password (leave blank to keep current)">
                </div>
            </div>

            <button type="submit" class="btn btn-red">
                <i class="fas fa-save me-2"></i> SAVE CHANGES
            </button>
        </form>
    </div>
</div>

<!-- Bootstrap 5 JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById('editProfileForm').addEventListener('submit', function(event) {
        const name = document.getElementById('name').value;
        const email = document.getElementById('email').value;
        const contactNumber = document.getElementById('contactNumber').value;
        if (!name || !email || !contactNumber) {
            event.preventDefault();
            alert('Please fill in all required fields.');
        }
    });
</script>
</body>
</html>