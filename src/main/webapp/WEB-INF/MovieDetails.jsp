<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="lk.sliit.onlinemovieticketreservationplatform.onlinemovieticketreservationplatform.Movie" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Movie Details - Online Movie Ticket Reservation</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      line-height: 1.6;
      color: #333;
      margin: 0;
      padding: 20px;
      background-color: #f5f5f5;
    }

    .container {
      max-width: 800px;
      margin: 0 auto;
      background: white;
      padding: 20px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
      border-radius: 5px;
    }

    h1 {
      color: #2c3e50;
      border-bottom: 2px solid #eee;
      padding-bottom: 10px;
    }

    .movie-detail {
      margin-bottom: 20px;
    }

    .detail-label {
      font-weight: bold;
      display: inline-block;
      width: 100px;
    }

    .movie-format {
      display: inline-block;
      padding: 5px 10px;
      background: #3498db;
      color: white;
      border-radius: 4px;
      font-size: 0.9rem;
    }

    .format-imax {
      background: #e74c3c;
    }

    .status-badge {
      display: inline-block;
      padding: 5px 10px;
      border-radius: 4px;
      margin-left: 10px;
      font-size: 0.9rem;
    }

    .status-available {
      background: #2ecc71;
      color: white;
    }

    .status-unavailable {
      background: #e74c3c;
      color: white;
    }

    .actions {
      margin-top: 30px;
      display: flex;
      gap: 10px;
    }

    .btn {
      padding: 10px 15px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 1rem;
      text-decoration: none;
      display: inline-block;
    }

    .btn-primary {
      background: #3498db;
      color: white;
    }

    .btn-primary:hover {
      background: #2980b9;
    }

    .btn-danger {
      background: #e74c3c;
      color: white;
    }

    .btn-danger:hover {
      background: #c0392b;
    }

    .edit-form {
      margin-top: 20px;
      border-top: 1px solid #eee;
      padding-top: 20px;
      display: none;
    }

    .form-group {
      margin-bottom: 15px;
    }

    .form-group label {
      display: block;
      margin-bottom: 5px;
      font-weight: 500;
    }

    input, select {
      width: 100%;
      padding: 8px;
      border: 1px solid #ddd;
      border-radius: 4px;
      font-size: 1rem;
      box-sizing: border-box;
    }
  </style>
</head>
<body>
<div class="container">
  <h1>Movie Details</h1>
  <!-- Your movie details content here -->
  <div class="actions">
    <a href="#" class="btn btn-primary">Edit</a>
    <a href="#" class="btn btn-danger">Delete</a>
  </div>
</div>
</body>
</html>