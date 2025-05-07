<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Login - QuickFlicks</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
  <style>
    :root {
      --primary-black: #0D1321;
      --secondary-black: #1A1A2E;
      --dark-gray: #16213E;
      --medium-gray: #4a4a4a;
      --light-gray: #e5e5e5;
      --accent-pink: #FF1493;
      --accent-dark-pink: #D81159;
      --accent-cyan: #00FFFF;
      --white: #ffffff;
    }

    body {
      font-family: 'Montserrat', sans-serif;
      background-color: var(--primary-black);
      color: var(--light-gray);
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      background-image: url('https://assets.nflxext.com/ffe/siteui/vlv3/9d3533b2-0e2b-40b2-95e0-ecd7979cc88b/2b3a03f5-905e-4a89-8d45-5cc5f9e9bf27/LK-en-20240311-popsignuptwoweeks-perspective_alpha_website_large.jpg');
      background-size: cover;
      background-position: center;
    }

    body::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(13, 19, 33, 0.85);
      z-index: 0;
    }

    h1, h2, h3, h4, h5, h6 {
      font-family: 'Bebas Neue', sans-serif;
      letter-spacing: 1px;
    }

    .login-container {
      max-width: 450px;
      margin: auto;
      padding: 3rem;
      background-color: rgba(26, 26, 46, 0.9);
      border-radius: 10px;
      box-shadow: 0 0 30px var(--accent-cyan);
      border-top: 4px solid var(--accent-pink);
      position: relative;
      overflow: hidden;
      z-index: 1;
    }

    .login-container::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 5px;
      background: linear-gradient(90deg, var(--accent-pink), var(--accent-cyan), var(--accent-pink));
    }

    .login-logo {
      text-align: center;
      margin-bottom: 2.5rem;
    }

    .login-logo img {
      height: 60px;
      margin-bottom: 1rem;
    }

    .login-logo h2 {
      color: var(--accent-cyan);
      font-size: 2.5rem;
      margin-bottom: 0.5rem;
      text-shadow: 0 0 10px rgba(0, 255, 255, 0.5);
    }

    .login-logo span {
      color: var(--accent-pink);
    }

    .login-logo p {
      color: var(--medium-gray);
      font-size: 0.9rem;
    }

    .form-floating {
      margin-bottom: 1.5rem;
    }

    .form-control {
      background-color: var(--dark-gray);
      border: 1px solid var(--medium-gray);
      color: var(--light-gray);
      height: 50px;
      padding: 0 20px;
    }

    .form-control:focus {
      background-color: var(--dark-gray);
      color: var(--white);
      border-color: var(--accent-cyan);
      box-shadow: 0 0 0 0.25rem rgba(0, 255, 255, 0.25);
    }

    label {
      color: var(--medium-gray);
      padding: 0.8rem 1.25rem;
    }

    .btn-login {
      background-color: var(--accent-pink);
      border: none;
      padding: 12px;
      font-weight: 700;
      letter-spacing: 1px;
      text-transform: uppercase;
      transition: all 0.3s;
      margin-top: 1rem;
    }

    .btn-login:hover {
      background-color: var(--accent-dark-pink);
      transform: translateY(-3px);
      box-shadow: 0 0 20px var(--accent-cyan);
    }

    .user-login-link {
      text-align: center;
      margin-top: 2rem;
      color: var(--medium-gray);
    }

    .user-login-link a {
      color: var(--accent-cyan);
      text-decoration: none;
      font-weight: 600;
      transition: all 0.3s;
    }

    .user-login-link a:hover {
      color: var(--white);
      text-decoration: underline;
      text-shadow: 0 0 10px rgba(0, 255, 255, 0.5);
    }

    .alert-danger {
      background-color: rgba(255, 20, 147, 0.2);
      border: 1px solid var(--accent-pink);
      color: var(--white);
      border-radius: 5px;
      padding: 12px;
      margin-bottom: 1.5rem;
    }
  </style>
</head>
<body>
<div class="container my-auto py-5">
  <div class="login-container">
    <div class="login-logo">
      <img src="${pageContext.request.contextPath}/assets/logo.png" alt="QuickFlicks Logo">
      <h2>QUICK<span>FLIX</span> ADMIN</h2>
      <p>Admin access to manage the platform</p>
    </div>

    <c:if test="${not empty error}">
      <div class="alert alert-danger">
        <i class="fas fa-exclamation-circle me-2"></i> ${error}
      </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
      <div class="form-floating">
        <input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
        <label for="email"><i class="fas fa-envelope me-2"></i>Email address</label>
      </div>

      <div class="form-floating">
        <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
        <label for="password"><i class="fas fa-lock me-2"></i>Password</label>
      </div>

      <button type="submit" class="btn btn-login btn-primary w-100">
        <i class="fas fa-sign-in-alt me-2"></i>ADMIN LOGIN
      </button>

      <div class="user-login-link">
        Not an admin? <a href="${pageContext.request.contextPath}/login.jsp">Login as User</a>
      </div>
    </form>
  </div>
</div>

<footer class="footer">
  <div class="container text-center">
    <p>&copy; 2025 QUICKFLIX. ALL RIGHTS RESERVED.</p>
  </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>