<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="common/header.jsp" />

<div class="row">
    <div class="col-md-12 text-center mb-4">
        <c:choose>
            <c:when test="${success}">
                <div class="alert alert-success" role="alert">
                    <h4 class="alert-heading">Payment Successful!</h4>
                    <p>Your payment has been processed successfully.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-danger" role="alert">
                    <h4 class="alert-heading">Payment Failed!</h4>
                    <p>There was an issue processing your payment. Please try again.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<div class="row">
    <div class="col-md-8 offset-md-2">
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0">Payment Receipt</h5>
            </div>
            <div class="card-body">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <p><strong>Transaction ID:</strong> ${payment.transactionId}</p>
                        <p><strong>Date:</strong> ${payment.transactionDate}</p>
                        <p><strong>Status:</strong> ${payment.status}</p>
                    </div>
                    <div class="col-md-6">
                        <p><strong>Booking ID:</strong> ${payment.bookingId}</p>
                        <p><strong>Customer:</strong> ${payment.customerName}</p>
                        <p><strong>Amount:</strong> $${payment.amount}</p>
                    </div>
                </div>

                <hr>

                <div class="row">
                    <div class="col-md-12">
                        <h6>Payment Details</h6>

                        <c:choose>
                            <c:when test="${payment.paymentType eq 'CREDIT_CARD'}">
                                <p><strong>Payment Method:</strong> Credit Card</p>
                                <p><strong>Card Number:</strong> ${payment.cardNumber}</p>
                                <p><strong>Card Holder:</strong> ${payment.cardHolderName}</p>
                            </c:when>
                            <c:when test="${payment.paymentType eq 'CASH'}">
                                <p><strong>Payment Method:</strong> Cash</p>
                                <p><strong>Amount Tendered:</strong> $${payment.amountTendered}</p>
                                <p><strong>Change:</strong> $${payment.change}</p>
                            </c:when>
                        </c:choose>
                    </div>
                </div>
            </div>
            <div class="card-footer">
                <div class="d-flex justify-content-between">
                    <a href="<c:url value='/payments'/>" class="btn btn-secondary">Back to Payments</a>
                    <button class="btn btn-primary" onclick="window.print()">Print Receipt</button>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />
