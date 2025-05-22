<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="common/header.jsp" />

<div class="row">
    <div class="col-md-12">
        <h1>Edit Payment</h1>
        <p class="lead">Update payment information.</p>
    </div>
</div>

<div class="row mt-4">
    <div class="col-md-8 offset-md-2">
        <div class="card">
            <div class="card-header bg-warning text-dark d-flex justify-content-between align-items-center">
                <h5 class="mb-0">Edit Payment Details</h5>
                <a href="<c:url value='/payments/details/${payment.transactionId}'/>" class="btn btn-dark btn-sm">Back to Details</a>
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
                </div>

                <hr>

                <c:choose>
                    <c:when test="${payment.paymentType eq 'CREDIT_CARD'}">
                        <!-- Credit Card Payment Form -->
                        <form action="<c:url value='/payments/update/credit-card'/>" method="post">
                            <input type="hidden" name="transactionId" value="${payment.transactionId}">
                            
                            <div class="mb-3">
                                <label for="bookingId" class="form-label">Booking ID</label>
                                <input type="text" class="form-control" id="bookingId" name="bookingId" value="${payment.bookingId}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="amount" class="form-label">Amount</label>
                                <div class="input-group">
                                    <span class="input-group-text">$</span>
                                    <input type="number" class="form-control" id="amount" name="amount" step="0.01" min="0" value="${payment.amount}" required>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="customerName" class="form-label">Customer Name</label>
                                <input type="text" class="form-control" id="customerName" name="customerName" value="${payment.customerName}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="cardNumber" class="form-label">Card Number</label>
                                <input type="text" class="form-control" id="cardNumber" name="cardNumber" value="${payment.cardNumber}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="cardHolderName" class="form-label">Card Holder Name</label>
                                <input type="text" class="form-control" id="cardHolderName" name="cardHolderName" value="${payment.cardHolderName}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="expiryDate" class="form-label">Expiry Date</label>
                                <input type="text" class="form-control" id="expiryDate" name="expiryDate" placeholder="MM/YY" value="${payment.expiryDate}" required>
                            </div>
                            
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-warning">Update Payment</button>
                                <a href="<c:url value='/payments/details/${payment.transactionId}'/>" class="btn btn-secondary">Cancel</a>
                            </div>
                        </form>
                    </c:when>
                    <c:when test="${payment.paymentType eq 'CASH'}">
                        <!-- Cash Payment Form -->
                        <form action="<c:url value='/payments/update/cash'/>" method="post">
                            <input type="hidden" name="transactionId" value="${payment.transactionId}">
                            
                            <div class="mb-3">
                                <label for="bookingId" class="form-label">Booking ID</label>
                                <input type="text" class="form-control" id="bookingId" name="bookingId" value="${payment.bookingId}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="amount" class="form-label">Amount</label>
                                <div class="input-group">
                                    <span class="input-group-text">$</span>
                                    <input type="number" class="form-control" id="amount" name="amount" step="0.01" min="0" value="${payment.amount}" required>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="customerName" class="form-label">Customer Name</label>
                                <input type="text" class="form-control" id="customerName" name="customerName" value="${payment.customerName}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="amountTendered" class="form-label">Amount Tendered</label>
                                <div class="input-group">
                                    <span class="input-group-text">$</span>
                                    <input type="number" class="form-control" id="amountTendered" name="amountTendered" step="0.01" min="${payment.amount}" value="${payment.amountTendered}" required>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="changeAmount" class="form-label">Change</label>
                                <div class="input-group">
                                    <span class="input-group-text">$</span>
                                    <input type="text" class="form-control" id="changeAmount" value="${payment.change}" readonly>
                                </div>
                            </div>
                            
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-warning">Update Payment</button>
                                <a href="<c:url value='/payments/details/${payment.transactionId}'/>" class="btn btn-secondary">Cancel</a>
                            </div>
                        </form>
                    </c:when>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Calculate change for cash payment
        const amountTendered = document.getElementById('amountTendered');
        const changeAmount = document.getElementById('changeAmount');
        const amountInput = document.getElementById('amount');
        
        if (amountTendered && changeAmount && amountInput) {
            const updateChange = function() {
                const tendered = parseFloat(amountTendered.value) || 0;
                const amount = parseFloat(amountInput.value) || 0;
                const change = Math.max(0, tendered - amount).toFixed(2);
                changeAmount.value = change;
            };
            
            amountTendered.addEventListener('input', updateChange);
            amountInput.addEventListener('input', updateChange);
        }
    });
</script>

<jsp:include page="common/footer.jsp" />
