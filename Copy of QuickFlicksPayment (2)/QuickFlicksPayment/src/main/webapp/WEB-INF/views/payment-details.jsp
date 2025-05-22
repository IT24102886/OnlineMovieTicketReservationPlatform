<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="common/header.jsp" />

<div class="row">
    <div class="col-md-12">
        <h1>Payment Details</h1>
        <p class="lead">View detailed information about this payment transaction.</p>

        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
    </div>
</div>

<div class="row mt-4">
    <div class="col-md-8 offset-md-2">
        <div class="card">
            <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                <h5 class="mb-0">Transaction Details</h5>
                <a href="<c:url value='/payments/history'/>" class="btn btn-light btn-sm">Back to History</a>
            </div>
            <div class="card-body">
                <div class="row mb-4">
                    <div class="col-md-6">
                        <h6>Transaction Information</h6>
                        <p><strong>Transaction ID:</strong> ${payment.transactionId}</p>
                        <p><strong>Date:</strong> ${payment.transactionDate}</p>
                        <p><strong>Status:</strong>
                            <span class="badge ${payment.status eq 'COMPLETED' ? 'bg-success' : payment.status eq 'PENDING' ? 'bg-warning' : 'bg-danger'}">
                                ${payment.status}
                            </span>
                        </p>
                    </div>
                    <div class="col-md-6">
                        <h6>Booking Information</h6>
                        <p><strong>Booking ID:</strong> ${payment.bookingId}</p>
                        <p><strong>Customer:</strong> ${payment.customerName}</p>
                        <p><strong>Amount:</strong> $${payment.amount}</p>
                    </div>
                </div>

                <hr>

                <div class="row">
                    <div class="col-md-12">
                        <h6>Payment Method</h6>

                        <c:choose>
                            <c:when test="${payment.paymentType eq 'CREDIT_CARD'}">
                                <div class="card bg-light">
                                    <div class="card-body">
                                        <h6 class="card-title">Credit Card Payment</h6>
                                        <p><strong>Card Number:</strong> ${payment.cardNumber}</p>
                                        <p><strong>Card Holder:</strong> ${payment.cardHolderName}</p>
                                        <p><strong>Expiry Date:</strong> ${payment.expiryDate}</p>
                                    </div>
                                </div>
                            </c:when>
                            <c:when test="${payment.paymentType eq 'CASH'}">
                                <div class="card bg-light">
                                    <div class="card-body">
                                        <h6 class="card-title">Cash Payment</h6>
                                        <p><strong>Amount Tendered:</strong> $${payment.amountTendered}</p>
                                        <p><strong>Change:</strong> $${payment.change}</p>
                                    </div>
                                </div>
                            </c:when>
                        </c:choose>
                    </div>
                </div>
            </div>
            <div class="card-footer">
                <div class="d-flex justify-content-between">
                    <div>
                        <a href="<c:url value='/payments/history'/>" class="btn btn-secondary">Back to History</a>
                        <a href="<c:url value='/payments/edit/${payment.transactionId}'/>" class="btn btn-warning">Edit Payment</a>
                        <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal">
                            Delete Payment
                        </button>
                    </div>
                    <button class="btn btn-primary" onclick="window.print()">Print Receipt</button>
                </div>
            </div>

            <!-- Delete Confirmation Modal -->
            <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            Are you sure you want to delete this payment? This action cannot be undone.
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <form action="<c:url value='/payments/delete/${payment.transactionId}'/>" method="post">
                                <button type="submit" class="btn btn-danger">Delete</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />
