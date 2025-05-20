<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../layout/header.jsp" />

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2><i class="fas fa-building me-2 text-primary"></i>Theaters</h2>
    <a href="<c:url value='/theaters/create' />" class="btn btn-primary"><i class="fas fa-plus me-2"></i>Add New Theater</a>
</div>

<c:if test="${empty theaters}">
    <div class="alert alert-info">No theaters available.</div>
</c:if>

<!-- Facilities Section -->
<div class="facilities-section mb-5">
    <h3 class="section-header"><i class="fas fa-concierge-bell section-icon"></i>Facilities</h3>
    <div class="row">
        <div class="col-md-2 col-sm-4 col-6 mb-3">
            <div class="facility-item">
                <i class="fas fa-parking facility-icon"></i> Free Parking
            </div>
        </div>
        <div class="col-md-2 col-sm-4 col-6 mb-3">
            <div class="facility-item">
                <i class="fas fa-wheelchair facility-icon"></i> Wheelchair Access
            </div>
        </div>
        <div class="col-md-2 col-sm-4 col-6 mb-3">
            <div class="facility-item">
                <i class="fas fa-volume-up facility-icon"></i> Dolby Atmos Sound
            </div>
        </div>
        <div class="col-md-2 col-sm-4 col-6 mb-3">
            <div class="facility-item">
                <i class="fas fa-film facility-icon"></i> 4K Projection
            </div>
        </div>
        <div class="col-md-2 col-sm-4 col-6 mb-3">
            <div class="facility-item">
                <i class="fas fa-couch facility-icon"></i> VIP Lounge
            </div>
        </div>
    </div>
</div>

<!-- Our Theaters Section -->
<div class="our-theaters-section">
    <h3 class="section-header"><i class="fas fa-theater-masks section-icon"></i>Our Theaters</h3>

    <c:if test="${not empty theaters}">
        <div class="row">
            <c:forEach items="${theaters}" var="theater">
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card theater-card">
                        <div class="card-body">
                            <h4 class="theater-name">${theater.name}</h4>
                            <p class="theater-location"><i class="fas fa-map-marker-alt me-2"></i>${theater.location}</p>
                            <p class="theater-hours"><i class="far fa-clock me-2"></i>9:00 AM - 11:00 PM Daily</p>
                            <p class="theater-contact"><i class="fas fa-phone-alt me-2"></i>${theater.contactNumber}</p>

                            <div class="d-flex justify-content-between mt-3">
                                <a href="<c:url value='/theaters/${theater.id}' />" class="btn btn-primary"><i class="fas fa-info-circle me-1"></i>Details</a>
                                <div>
                                    <a href="<c:url value='/theaters/${theater.id}/edit' />" class="btn btn-warning btn-sm"><i class="fas fa-edit"></i></a>
                                    <a href="<c:url value='/theaters/${theater.id}/delete' />" class="btn btn-danger btn-sm ms-1" onclick="return confirm('Are you sure you want to delete this theater?')"><i class="fas fa-trash"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>

<jsp:include page="../layout/footer.jsp" />
