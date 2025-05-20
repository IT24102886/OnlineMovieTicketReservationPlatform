<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="layout/header.jsp" />

<div class="jumbotron">
    <h1 class="display-4">Welcome to QuickFlicks</h1>
    <p class="lead">Your one-stop solution for theater management and ticket booking.</p>
    <hr class="my-4">
    <p>Browse theaters, check showtimes, and book your tickets online.</p>
    <a class="btn btn-primary btn-lg" href="<c:url value='/theaters' />" role="button">View Theaters</a>
</div>

<div class="row mt-4">
    <div class="col-md-6">
        <div class="card">
            <div class="card-header">
                <h5>Our Theaters</h5>
            </div>
            <div class="card-body">
                <c:if test="${empty theaters}">
                    <p>No theaters available.</p>
                </c:if>
                <c:if test="${not empty theaters}">
                    <ul class="list-group">
                        <c:forEach items="${theaters}" var="theater">
                            <li class="list-group-item">
                                <a href="<c:url value='/theaters/${theater.id}' />">${theater.name}</a>
                                <span class="badge bg-secondary">${theater.location}</span>
                            </li>
                        </c:forEach>
                    </ul>
                </c:if>
            </div>
        </div>
    </div>
    
    <div class="col-md-6">
        <div class="card">
            <div class="card-header">
                <h5>Upcoming Shows</h5>
            </div>
            <div class="card-body">
                <c:if test="${empty showtimes}">
                    <p>No upcoming shows available.</p>
                </c:if>
                <c:if test="${not empty showtimes}">
                    <ul class="list-group">
                        <c:forEach items="${showtimes}" var="showtime">
                            <li class="list-group-item">
                                <a href="<c:url value='/showtimes/${showtime.id}' />">${showtime.movieTitle}</a>
                                <br>
                                <small>
                                    <fmt:parseDate value="${showtime.startTime}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both" />
                                    <fmt:formatDate pattern="dd MMM yyyy, HH:mm" value="${parsedDateTime}" />
                                </small>
                            </li>
                        </c:forEach>
                    </ul>
                </c:if>
            </div>
        </div>
    </div>
</div>

<jsp:include page="layout/footer.jsp" />
