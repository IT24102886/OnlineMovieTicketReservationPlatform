<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../layout/header.jsp" />

<div class="row mb-4">
    <div class="col-md-8">
        <h2 class="theater-name"><i class="fas fa-film me-2"></i>${theater.name}</h2>
        <p class="theater-location"><i class="fas fa-map-marker-alt me-2"></i>${theater.location}</p>
        <p class="theater-hours"><i class="far fa-clock me-2"></i>9:00 AM - 11:00 PM Daily</p>
        <p class="theater-contact"><i class="fas fa-phone-alt me-2"></i>${theater.contactNumber}</p>
    </div>
    <div class="col-md-4 text-end">
        <a href="<c:url value='/theaters/${theater.id}/edit' />" class="btn btn-warning"><i class="fas fa-edit me-1"></i>Edit Theater</a>
        <a href="<c:url value='/theaters/${theater.id}/delete' />" class="btn btn-danger ms-2" onclick="return confirm('Are you sure you want to delete this theater?')"><i class="fas fa-trash me-1"></i>Delete Theater</a>
    </div>
</div>

<!-- Facilities Section -->
<div class="facilities-section mb-4">
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
<div class="our-theaters-section mb-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="section-header"><i class="fas fa-tv section-icon"></i>Our Screens</h3>
        <a href="<c:url value='/screens/create?theaterId=${theater.id}' />" class="btn btn-primary"><i class="fas fa-plus me-1"></i>Add Screen</a>
    </div>

    <c:if test="${empty screens}">
        <div class="alert alert-info">No screens available for this theater.</div>
    </c:if>

    <c:if test="${not empty screens}">
        <div class="row">
            <c:forEach items="${screens}" var="screen">
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card screen-card">
                        <div class="card-body">
                            <h4 class="screen-name">${screen.name}</h4>
                            <div class="theater-specs mb-3">
                                <div class="theater-spec">
                                    <i class="fas fa-users me-2"></i> Capacity: ${screen.capacity}
                                </div>
                                <div class="theater-spec">
                                    <i class="fas fa-film me-2"></i> Type: ${screen.screenType}
                                </div>
                            </div>

                            <div class="theater-features">
                                <c:if test="${screen.screenType == 'IMAX'}">
                                    <div class="theater-feature">
                                        <i class="fas fa-couch me-1"></i> Luxury Recliners
                                    </div>
                                    <div class="theater-feature">
                                        <i class="fas fa-volume-up me-1"></i> Dolby Atmos
                                    </div>
                                    <div class="theater-feature">
                                        <i class="fas fa-laser-pointer me-1"></i> Laser Projection
                                    </div>
                                </c:if>
                                <c:if test="${screen.screenType == '3D'}">
                                    <div class="theater-feature">
                                        <i class="fas fa-glasses me-1"></i> Active 3D
                                    </div>
                                    <div class="theater-feature">
                                        <i class="fas fa-volume-up me-1"></i> Dolby Digital
                                    </div>
                                    <div class="theater-feature">
                                        <i class="fas fa-couch me-1"></i> Comfort Seating
                                    </div>
                                </c:if>
                                <c:if test="${screen.screenType == 'Standard' || screen.screenType == 'Regular'}">
                                    <div class="theater-feature">
                                        <i class="fas fa-chair me-1"></i> Premium Seating
                                    </div>
                                    <div class="theater-feature">
                                        <i class="fas fa-volume-up me-1"></i> DTS Sound
                                    </div>
                                </c:if>
                            </div>

                            <div class="d-flex justify-content-between mt-3">
                                <a href="<c:url value='/screens/${screen.id}' />" class="btn btn-primary"><i class="fas fa-info-circle me-1"></i>Details</a>
                                <div>
                                    <a href="<c:url value='/screens/${screen.id}/edit' />" class="btn btn-warning btn-sm"><i class="fas fa-edit"></i></a>
                                    <a href="<c:url value='/screens/${screen.id}/delete' />" class="btn btn-danger btn-sm ms-1" onclick="return confirm('Are you sure you want to delete this screen?')"><i class="fas fa-trash"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>
</div>

<div class="mt-3">
    <a href="<c:url value='/theaters' />" class="btn btn-secondary"><i class="fas fa-arrow-left me-1"></i>Back to Theaters</a>
</div>

<jsp:include page="../layout/footer.jsp" />
