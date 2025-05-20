<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../layout/header.jsp" />

<div class="row mb-4">
    <div class="col-md-8">
        <h2 class="screen-name"><i class="fas fa-tv me-2"></i>${screen.name}</h2>
        <p class="theater-location"><i class="fas fa-building me-2"></i>Theater: ${theater.name} - ${theater.location}</p>
        <div class="theater-specs mb-3">
            <div class="theater-spec">
                <i class="fas fa-users me-2"></i> Capacity: ${screen.capacity} seats
            </div>
            <div class="theater-spec">
                <i class="fas fa-film me-2"></i> Type: ${screen.screenType}
            </div>
        </div>
    </div>
    <div class="col-md-4 text-end">
        <a href="<c:url value='/screens/${screen.id}/edit' />" class="btn btn-warning"><i class="fas fa-edit me-1"></i>Edit Screen</a>
        <a href="<c:url value='/screens/${screen.id}/delete' />" class="btn btn-danger ms-2" onclick="return confirm('Are you sure you want to delete this screen?')"><i class="fas fa-trash me-1"></i>Delete Screen</a>
    </div>
</div>

<div class="card mb-4">
    <div class="card-header">
        <h5><i class="fas fa-chair me-2"></i>Seat Layout</h5>
    </div>
    <div class="card-body">
        <div class="seat-container">
            <div class="screen-display">SCREEN</div>

            <!-- Sample Seat Layout - This would be dynamically generated based on the screen's configuration -->
            <c:set var="rows" value="8" />
            <c:set var="cols" value="12" />

            <c:forEach begin="0" end="${rows - 1}" var="row">
                <div class="seat-row">
                    <div class="row-label">${(char)(65 + row)}</div>
                    <c:forEach begin="0" end="${cols - 1}" var="col">
                        <div class="seat seat-available" data-row="${row}" data-col="${col}">
                            ${col + 1}
                        </div>
                    </c:forEach>
                </div>
            </c:forEach>

            <div class="seat-legend">
                <div class="legend-item">
                    <div class="legend-box legend-available"></div>
                    <span>Available</span>
                </div>
                <div class="legend-item">
                    <div class="legend-box legend-selected"></div>
                    <span>Selected</span>
                </div>
                <div class="legend-item">
                    <div class="legend-box legend-booked"></div>
                    <span>Booked</span>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="card">
    <div class="card-header d-flex justify-content-between align-items-center">
        <h5><i class="fas fa-clock me-2"></i>Showtimes</h5>
        <a href="<c:url value='/showtimes/create?screenId=${screen.id}' />" class="btn btn-primary"><i class="fas fa-plus me-1"></i>Add Showtime</a>
    </div>
    <div class="card-body">
        <c:if test="${empty showtimes}">
            <p>No showtimes available for this screen.</p>
        </c:if>

        <c:if test="${not empty showtimes}">
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Movie</th>
                            <th>Start Time</th>
                            <th>End Time</th>
                            <th>Ticket Price</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${showtimes}" var="showtime">
                            <tr>
                                <td>${showtime.movieTitle}</td>
                                <td>
                                    <fmt:parseDate value="${showtime.startTime}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both" />
                                    <fmt:formatDate pattern="dd MMM yyyy, HH:mm" value="${parsedDateTime}" />
                                </td>
                                <td>
                                    <fmt:parseDate value="${showtime.endTime}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both" />
                                    <fmt:formatDate pattern="dd MMM yyyy, HH:mm" value="${parsedDateTime}" />
                                </td>
                                <td>$${showtime.ticketPrice}</td>
                                <td>
                                    <a href="<c:url value='/showtimes/${showtime.id}' />" class="btn btn-info btn-sm"><i class="fas fa-eye"></i></a>
                                    <a href="<c:url value='/showtimes/${showtime.id}/seats' />" class="btn btn-success btn-sm"><i class="fas fa-ticket-alt"></i></a>
                                    <a href="<c:url value='/showtimes/${showtime.id}/edit' />" class="btn btn-warning btn-sm"><i class="fas fa-edit"></i></a>
                                    <a href="<c:url value='/showtimes/${showtime.id}/delete' />" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this showtime?')"><i class="fas fa-trash"></i></a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
    </div>
</div>

<div class="mt-3">
    <a href="<c:url value='/theaters/${theater.id}' />" class="btn btn-secondary"><i class="fas fa-arrow-left me-1"></i>Back to Theater</a>
</div>

<jsp:include page="../layout/footer.jsp" />
