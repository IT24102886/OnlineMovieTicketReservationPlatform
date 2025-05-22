<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="common/header.jsp" />

<div class="row">
    <div class="col-md-12 text-center mt-5 mb-5">
        <h1 class="display-4">Welcome to QuickFlicks</h1>
        <p class="lead">Your one-stop solution for theater management and ticket booking.</p>
    </div>
</div>

<div class="row mb-5">
    <div class="col-md-12 text-center">
        <p>Browse theaters, check showtimes, and book your tickets online.</p>
        <a href="<c:url value='/theaters'/>" class="btn btn-info">View Theaters</a>
    </div>
</div>

<div class="row mt-5">
    <div class="col-md-6">
        <div class="card">
            <div class="card-header bg-dark text-white">
                <h5 class="mb-0">Our Theaters</h5>
            </div>
            <div class="card-body">
                <ul class="list-group list-group-flush">
                    <li class="list-group-item">
                        <div class="d-flex justify-content-between align-items-center">
                            <span>Theater Ceylon PLC</span>
                            <span class="badge bg-info">Galle Colombo 3</span>
                        </div>
                    </li>
                    <li class="list-group-item">
                        <div class="d-flex justify-content-between align-items-center">
                            <span>QuickFlix malabe</span>
                            <span class="badge bg-danger">Malabe Rd Athurugiriya</span>
                        </div>
                    </li>
                    <li class="list-group-item">
                        <div class="d-flex justify-content-between align-items-center">
                            <span>Sky Lite</span>
                            <span class="badge bg-warning text-dark">Malabe City</span>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <div class="col-md-6">
        <div class="card">
            <div class="card-header bg-dark text-white">
                <h5 class="mb-0">Upcoming Shows</h5>
            </div>
            <div class="card-body">
                <div class="alert alert-info">
                    No upcoming shows available.
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />
