<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../layout/header.jsp" />

<h2 class="mb-4"><i class="fas fa-edit me-2 text-primary"></i>Edit Screen</h2>

<form action="<c:url value='/screens/${screen.id}/edit' />" method="post">
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
        <input type="text" class="form-control" id="name" name="name" value="${screen.name}" required>
    </div>

    <div class="mb-3">
        <label for="capacity" class="form-label">Capacity</label>
        <input type="number" class="form-control" id="capacity" name="capacity" value="${screen.capacity}" min="1" required>
    </div>

    <div class="mb-3">
        <label for="screenType" class="form-label">Screen Type</label>
        <select class="form-select" id="screenType" name="screenType" required>
            <option value="Regular" ${screen.screenType eq 'Regular' ? 'selected' : ''}>Regular</option>
            <option value="IMAX" ${screen.screenType eq 'IMAX' ? 'selected' : ''}>IMAX</option>
            <option value="3D" ${screen.screenType eq '3D' ? 'selected' : ''}>3D</option>
            <option value="4DX" ${screen.screenType eq '4DX' ? 'selected' : ''}>4DX</option>
            <option value="VIP" ${screen.screenType eq 'VIP' ? 'selected' : ''}>VIP</option>
        </select>
    </div>

    <div class="mt-4">
        <button type="submit" class="btn btn-primary"><i class="fas fa-save me-1"></i>Update</button>
        <a href="<c:url value='/screens/${screen.id}' />" class="btn btn-secondary"><i class="fas fa-times me-1"></i>Cancel</a>
    </div>
</form>

<jsp:include page="../layout/footer.jsp" />
