<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="common/header.jsp" />

<div class="row">
    <div class="col-md-12">
        <h1>Payment Management</h1>
        <p class="lead">Process payments and view transaction history for movie ticket bookings.</p>
    </div>
</div>

<div class="row mt-4">
    <div class="col-md-6">
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0">Process New Payment</h5>
            </div>
            <div class="card-body">
                <p>Enter booking details to process a new payment:</p>
                <form action="<c:url value='/payments/process'/>" method="get">
                    <div class="mb-3">
                        <label for="bookingId" class="form-label">Booking ID</label>
                        <input type="text" class="form-control" id="bookingId" name="bookingId" required>
                    </div>
                    <div class="mb-3">
                        <label for="amount" class="form-label">Amount</label>
                        <div class="input-group">
                            <span class="input-group-text">$</span>
                            <input type="number" class="form-control" id="amount" name="amount" step="0.01" min="0" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="customerName" class="form-label">Customer Name</label>
                        <input type="text" class="form-control" id="customerName" name="customerName" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Continue to Payment</button>
                </form>
            </div>
        </div>
    </div>

    <div class="col-md-6">
        <div class="card">
            <div class="card-header bg-info text-white">
                <h5 class="mb-0">Payment History</h5>
            </div>
            <div class="card-body">
                <p>View and manage payment transactions:</p>
                <a href="<c:url value='/payments/history'/>" class="btn btn-info">View Payment History</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />
