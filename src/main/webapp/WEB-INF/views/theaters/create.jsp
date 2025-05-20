<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../layout/header.jsp" />

<h2 class="mb-4"><i class="fas fa-plus-circle me-2 text-primary"></i>Add New Theater</h2>

<form action="<c:url value='/theaters/create' />" method="post">
    <div class="mb-3">
        <label for="name" class="form-label">Theater Name</label>
        <input type="text" class="form-control" id="name" name="name" required>
    </div>

    <div class="mb-3">
        <label for="location" class="form-label">Location</label>
        <input type="text" class="form-control" id="location" name="location" required>
    </div>

    <div class="mb-3">
        <label for="contactNumber" class="form-label">Contact Number</label>
        <input type="text" class="form-control" id="contactNumber" name="contactNumber" required>
    </div>

    <div class="mb-3">
        <label for="email" class="form-label">Email</label>
        <input type="email" class="form-control" id="email" name="email" required>
    </div>

    <div class="mt-4">
        <button type="submit" class="btn btn-primary"><i class="fas fa-save me-1"></i>Save</button>
        <a href="<c:url value='/theaters' />" class="btn btn-secondary"><i class="fas fa-times me-1"></i>Cancel</a>
    </div>
</form>

<jsp:include page="../layout/footer.jsp" />
