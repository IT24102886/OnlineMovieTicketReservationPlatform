<%--<%@ page contentType="text/html;charset=UTF-8" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <title>Login - MovieFlix</title>--%>
<%--    <%@include file="../includes/header.jsp" %>--%>
<%--    <style>--%>
<%--        .login-container {--%>
<%--            max-width: 400px;--%>
<%--            margin: 5rem auto;--%>
<%--            padding: 2rem;--%>
<%--            border-radius: 8px;--%>
<%--            box-shadow: 0 0 20px rgba(0,0,0,0.1);--%>
<%--        }--%>
<%--        .login-logo {--%>
<%--            text-align: center;--%>
<%--            margin-bottom: 2rem;--%>
<%--        }--%>
<%--        .login-logo img {--%>
<%--            height: 50px;--%>
<%--        }--%>
<%--        .form-floating {--%>
<%--            margin-bottom: 1.5rem;--%>
<%--        }--%>
<%--        .btn-login {--%>
<%--            background: #f84464;--%>
<%--            border: none;--%>
<%--            padding: 10px;--%>
<%--            font-weight: 600;--%>
<%--        }--%>
<%--        .btn-login:hover {--%>
<%--            background: #e13353;--%>
<%--        }--%>
<%--        .signup-link {--%>
<%--            text-align: center;--%>
<%--            margin-top: 1.5rem;--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="container">--%>
<%--    <div class="login-container">--%>
<%--        <div class="login-logo">--%>
<%--            <img src="${pageContext.request.contextPath}/assets/logo.png" alt="MovieFlix">--%>
<%--        </div>--%>

<%--        <div class="alert alert-danger">${error}</div>--%>

<%--        <form action="${pageContext.request.contextPath}/LoginServlet" method="post">--%>
<%--            <div class="form-floating">--%>
<%--                <input type="email" class="form-control" id="email" name="email" placeholder="Email" required>--%>
<%--                <label for="email">Email address</label>--%>
<%--            </div>--%>

<%--            <div class="form-floating">--%>
<%--                <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>--%>
<%--                <label for="password">Password</label>--%>
<%--            </div>--%>

<%--            <button type="submit" class="btn btn-login btn-primary w-100">LOGIN</button>--%>

<%--            <div class="signup-link">--%>
<%--                New user? <a href="${pageContext.request.contextPath}/auth/register.jsp">Create account</a>--%>
<%--            </div>--%>
<%--        </form>--%>
<%--    </div>--%>
<%--</div>--%>

<%--<%@include file="../includes/footer.jsp" %>--%>
<%--</body>--%>
<%--</html>--%>







<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Login - Quick Flix</title>
  <!-- Bootstrap 5 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome for icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
  <style>
    :root {
      --primary-black: #141414;
      --secondary-black: #1f1f1f;
      --dark-gray: #2a2a2a;
      --medium-gray: #4a4a4a;
      --light-gray: #e5e5e5;
      --accent-red: #e50914;
      --accent-dark-red: #b20710;
      --white: #ffffff;
    }

    body {
      font-family: 'Montserrat', sans-serif;
      background-color: var(--primary-black);
      color: var(--light-gray);
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }

    h1, h2, h3, h4, h5, h6 {
      font-family: 'Bebas Neue', sans-serif;
      letter-spacing: 1px;
    }

    .login-container {
      max-width: 450px;
      margin: auto;
      padding: 3rem;
      background-color: var(--secondary-black);
      border-radius: 10px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
      border-top: 4px solid var(--accent-red);
      position: relative;
      overflow: hidden;
    }

    .login-container::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 5px;
      background: linear-gradient(90deg, var(--accent-red), #f84464, var(--accent-red));
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
      color: var(--white);
      font-size: 2rem;
      margin-bottom: 0.5rem;
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
      border-color: var(--accent-red);
      box-shadow: 0 0 0 0.25rem rgba(229, 9, 20, 0.25);
    }

    label {
      color: var(--medium-gray);
      padding: 0.8rem 1.25rem;
    }

    .btn-login {
      background-color: var(--accent-red);
      border: none;
      padding: 12px;
      font-weight: 700;
      letter-spacing: 1px;
      text-transform: uppercase;
      transition: all 0.3s;
      margin-top: 1rem;
    }

    .btn-login:hover {
      background-color: var(--accent-dark-red);
      transform: translateY(-3px);
      box-shadow: 0 10px 20px rgba(229, 9, 20, 0.3);
    }

    .signup-link {
      text-align: center;
      margin-top: 2rem;
      color: var(--medium-gray);
    }

    .signup-link a {
      color: var(--accent-red);
      text-decoration: none;
      font-weight: 600;
      transition: all 0.3s;
    }

    .signup-link a:hover {
      color: var(--white);
      text-decoration: underline;
    }

    .alert-danger {
      background-color: rgba(229, 9, 20, 0.2);
      border: 1px solid var(--accent-red);
      color: var(--white);
      border-radius: 5px;
      padding: 12px;
      margin-bottom: 1.5rem;
    }

    .footer {
      background-color: var(--primary-black);
      padding: 2rem 0;
      margin-top: auto;
      border-top: 1px solid var(--medium-gray);
    }

    /* Animation */
    @keyframes pulse {
      0% { transform: scale(1); }
      50% { transform: scale(1.05); }
      100% { transform: scale(1); }
    }

    .pulse-animation {
      animation: pulse 2s infinite;
    }

    /* Responsive adjustments */
    @media (max-width: 576px) {
      .login-container {
        padding: 2rem;
        margin: 2rem auto;
      }

      .login-logo img {
        height: 50px;
      }
    }
  </style>
</head>
<body>
<div class="container my-auto py-5">
  <div class="login-container">
    <div class="login-logo">
      <img src="${pageContext.request.contextPath}/assets/logo.png" alt="Quick Flix">
      <h2>QUICK<span>FLIX</span></h2>
      <p>Your ticket to unlimited entertainment</p>
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

      <button type="submit" class="btn btn-login btn-primary w-100 pulse-animation">
        <i class="fas fa-sign-in-alt me-2"></i>LOGIN
      </button>

      <div class="signup-link">
        New to Quick Flix? <a href="${pageContext.request.contextPath}/auth/register.jsp">Create your account</a>
      </div>
    </form>
  </div>
</div>

<footer class="footer">
  <div class="container text-center">
    <p>&copy; 2023 QUICK FLIX. ALL RIGHTS RESERVED.</p>
  </div>
</footer>

<!-- Bootstrap 5 JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>