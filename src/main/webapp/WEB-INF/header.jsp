<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuickFlicks - Payment System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="<c:url value='/css/styles.css'/>">
    <script>
        // Check for saved theme preference or use default
        document.addEventListener('DOMContentLoaded', function() {
            const savedTheme = localStorage.getItem('theme') || 'light';
            if (savedTheme === 'dark') {
                document.body.classList.add('dark-theme');
                document.getElementById('themeIcon').classList.remove('bi-moon');
                document.getElementById('themeIcon').classList.add('bi-sun');
                document.getElementById('themeText').textContent = 'Light Mode';
            }
        });

        // Toggle theme function
        function toggleTheme() {
            const body = document.body;
            const themeIcon = document.getElementById('themeIcon');
            const themeText = document.getElementById('themeText');

            if (body.classList.contains('dark-theme')) {
                // Switch to light theme
                body.classList.remove('dark-theme');
                themeIcon.classList.remove('bi-sun');
                themeIcon.classList.add('bi-moon');
                themeText.textContent = 'Dark Mode';
                localStorage.setItem('theme', 'light');
            } else {
                // Switch to dark theme
                body.classList.add('dark-theme');
                themeIcon.classList.remove('bi-moon');
                themeIcon.classList.add('bi-sun');
                themeText.textContent = 'Light Mode';
                localStorage.setItem('theme', 'dark');
            }
        }
    </script>
</head>
<body>
    <div class="content-wrapper">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="/">
                    <span class="text-info">QuickFlicks</span>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="/">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/theaters">Theaters</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/screens">Screens</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/showtimes">Showtimes</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="/payments">Payments</a>
                        </li>
                    </ul>
                    <button class="btn btn-outline-light theme-toggle" onclick="toggleTheme()">
                        <i id="themeIcon" class="bi bi-moon"></i>
                        <span id="themeText">Dark Mode</span>
                    </button>
                </div>
            </div>
        </nav>

        <div class="container mt-4">
