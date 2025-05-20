<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../layout/header.jsp" />

<h2 class="mb-4"><i class="fas fa-tv me-2 text-primary"></i>Add New Screen</h2>

<form action="<c:url value='/screens/create' />" method="post">
    <div class="mb-3">
        <label for="theaterId" class="form-label">Theater</label>
        <select class="form-select" id="theaterId" name="theaterId" required>
            <option value="">Select Theater</option>
            <c:forEach items="${theaters}" var="theater">
                <option value="${theater.id}" ${theater.id eq screen.theaterId ? 'selected' : ''}>${theater.name} - ${theater.location}</option>
            </c:forEach>
        </select>
    </div>

    <div class="mb-3">
        <label for="name" class="form-label">Screen Name</label>
        <input type="text" class="form-control" id="name" name="name" required>
    </div>

    <div class="mb-3">
        <label for="capacity" class="form-label">Capacity</label>
        <input type="number" class="form-control" id="capacity" name="capacity" min="1" required>
    </div>

    <div class="mb-3">
        <label for="screenType" class="form-label">Screen Type</label>
        <select class="form-select" id="screenType" name="screenType" required>
            <option value="Regular">Regular</option>
            <option value="IMAX">IMAX</option>
            <option value="3D">3D</option>
            <option value="4DX">4DX</option>
            <option value="VIP">VIP</option>
        </select>
    </div>

    <div class="mt-4">
        <button type="submit" class="btn btn-primary"><i class="fas fa-save me-1"></i>Save</button>
        <a href="<c:url value='/theaters' />" class="btn btn-secondary"><i class="fas fa-times me-1"></i>Cancel</a>
    </div>
</form>

<jsp:include page="../layout/footer.jsp" />
