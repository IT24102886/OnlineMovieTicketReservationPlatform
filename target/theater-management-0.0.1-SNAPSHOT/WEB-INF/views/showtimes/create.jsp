<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../layout/header.jsp" />

<h2>Add New Showtime</h2>

<form action="<c:url value='/showtimes/create' />" method="post">
    <div class="mb-3">
        <label for="screenId" class="form-label">Screen</label>
        <select class="form-select" id="screenId" name="screenId" required>
            <option value="">Select Screen</option>
            <c:forEach items="${screens}" var="screen">
                <option value="${screen.id}" ${screen.id eq screenId ? 'selected' : ''}>${screen.name} (${screen.screenType})</option>
            </c:forEach>
        </select>
    </div>
    
    <div class="mb-3">
        <label for="movieTitle" class="form-label">Movie Title</label>
        <input type="text" class="form-control" id="movieTitle" name="movieTitle" required>
    </div>
    
    <div class="mb-3">
        <label for="startTime" class="form-label">Start Time</label>
        <input type="datetime-local" class="form-control" id="startTime" name="startTime" required>
    </div>
    
    <div class="mb-3">
        <label for="endTime" class="form-label">End Time</label>
        <input type="datetime-local" class="form-control" id="endTime" name="endTime" required>
    </div>
    
    <div class="mb-3">
        <label for="ticketPrice" class="form-label">Ticket Price</label>
        <input type="number" class="form-control" id="ticketPrice" name="ticketPrice" min="0" step="0.01" required>
    </div>
    
    <div class="mb-3">
        <label for="rows" class="form-label">Number of Rows</label>
        <input type="number" class="form-control" id="rows" name="rows" min="1" max="26" value="10" required>
    </div>
    
    <div class="mb-3">
        <label for="cols" class="form-label">Number of Columns</label>
        <input type="number" class="form-control" id="cols" name="cols" min="1" max="20" value="10" required>
    </div>
    
    <button type="submit" class="btn btn-primary">Save</button>
    <a href="<c:url value='/screens/${screenId}' />" class="btn btn-secondary">Cancel</a>
</form>

<jsp:include page="../layout/footer.jsp" />
