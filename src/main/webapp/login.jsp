<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Log in to QuickFlicks to access unlimited entertainment and personalized streaming services.">
  <meta name="keywords" content="QuickFlicks, login, streaming, entertainment">
  <meta name="author" content="QuickFlicks Team">
  <title>Login - QuickFlicks</title>
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
      --glow-cyan: 0 0 10px rgba(0, 255, 255, 0.7);
    }

    body {
      font-family: 'Montserrat', sans-serif;
      background-color: var(--primary-black);
      color: var(--light-gray);
      min-height: 100vh;
      display: flex;
      align-items: center;
      background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)),
      url('https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?ixlib=rb-4.0.3&auto=format&fit=crop&w=1470&q=80');
      background-size: cover;
      background-position: center;
    }

    .login-container {
      max-width: 500px;
      width: 100%;
      margin: 2rem auto;
      padding: 2.5rem;
      background-color: rgba(13, 19, 33, 0.95);
      border-radius: 10px;
      box-shadow: 0 5px 30px rgba(0, 0, 0, 0.5);
      border-top: 4px solid var(--accent-dark-pink);
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

    .form-control {
      background-color: var(--secondary-black);
      border: 1px solid var(--medium-gray);
      color: var(--light-gray);
      height: 50px;
      padding: 0.75rem 1.25rem;
      transition: all 0.3s;
    }

    .form-control:focus {
      background-color: var(--secondary-black);
      color: var(--light-gray);
      border-color: var(--accent-cyan);
      box-shadow: var(--glow-cyan);
    }

    .btn-login {
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

    .btn-login:hover {
      background-color: var(--accent-dark-pink);
      transform: translateY(-3px);
      box-shadow: 0 10px 20px rgba(216, 17, 89, 0.4);
    }

    .alert-danger {
      background-color: rgba(216, 17, 89, 0.2);
      color: var(--light-gray);
      border-left: 4px solid var(--accent-dark-pink);
      border-radius: 5px;
    }

    .alert-success {
      background-color: rgba(40, 167, 69, 0.15);
      color: var(--light-gray);
      border-left: 4px solid var(--accent-cyan);
      border-radius: 5px;
    }

    .signup-link {
      text-align: center;
      margin-top: 1.5rem;
      color: var(--light-gray);
    }

    .signup-link a {
      color: var(--accent-cyan);
      text-decoration: none;
      font-weight: 600;
      transition: all 0.3s;
    }

    .signup-link a:hover {
      color: var(--accent-pink);
      text-decoration: underline;
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

    label {
      font-weight: 600;
      margin-bottom: 0.5rem;
    }
  </style>
</head>
<body>
<div class="container">
  <div class="login-container">
    <div class="login-logo">QUICK<span>FLICKS</span></div>
    <h2 class="login-title">SIGN IN TO YOUR ACCOUNT</h2>

    <c:if test="${not empty error}">
      <div class="alert alert-danger alert-dismissible fade show">
        <i class="fas fa-exclamation-circle me-2"></i> ${error}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
    </c:if>

    <c:if test="${not empty sessionScope.registrationSuccess}">
      <div class="alert alert-success alert-dismissible fade show">
        <i class="fas fa-check-circle me-2"></i> ${sessionScope.registrationSuccess}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
      <c:remove var="registrationSuccess" scope="session"/>
    </c:if>

    <form action="${pageContext.request.contextPath}/UserLoginServlet" method="post" id="loginForm">
      <div class="mb-3">
        <label for="email" class="form-label">Email</label>
        <div class="input-group">
          <i class="fas fa-envelope input-icon"></i>
          <input type="email" class="form-control" id="email" name="email" required placeholder="your@email.com" aria-describedby="emailHelp">
        </div>
      </div>

      <div class="mb-3">
        <label for="password" class="form-label">Password</label>
        <div class="input-group">
          <i class="fas fa-lock input-icon"></i>
          <input type="password" class="form-control" id="password" name="password" required placeholder="Enter your password" aria-describedby="passwordHelp">
        </div>
      </div>

      <button type="submit" class="btn btn-login mb-3">
        <i class="fas fa-sign-in-alt me-2"></i> SIGN IN
      </button>

      <div class="signup-link">
        New to QuickFlicks? <a href="register.jsp">Create an account</a>
      </div>
    </form>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  document.getElementById('loginForm').addEventListener('submit', function(event) {
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;
    if (!email || !password) {
      event.preventDefault();
      alert('Please fill in all required fields.');
    }
  });
</script>
</body>
</html>