<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="common/header.jsp" />

<div class="row">
    <div class="col-md-12">
        <h1>Process Payment</h1>
        <p class="lead">Select a payment method and enter payment details.</p>
    </div>
</div>

<div class="row mt-4">
    <div class="col-md-12">
        <div class="card mb-4">
            <div class="card-header bg-secondary text-white">
                <h5 class="mb-0">Booking Details</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-4">
                        <p><strong>Booking ID:</strong> ${bookingId}</p>
                    </div>
                    <div class="col-md-4">
                        <p><strong>Amount:</strong> $${amount}</p>
                    </div>
                    <div class="col-md-4">
                        <p><strong>Customer:</strong> ${customerName}</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <ul class="nav nav-tabs" id="paymentTabs" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="credit-card-tab" data-bs-toggle="tab" data-bs-target="#credit-card" type="button" role="tab">Credit Card</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="cash-tab" data-bs-toggle="tab" data-bs-target="#cash" type="button" role="tab">Cash</button>
            </li>
        </ul>

        <div class="tab-content p-4 border border-top-0 rounded-bottom" id="paymentTabContent">
            <!-- Credit Card Payment Form -->
            <div class="tab-pane fade show active" id="credit-card" role="tabpanel">
                <form action="<c:url value='/payments/process/credit-card'/>" method="post" id="creditCardForm">
                    <input type="hidden" name="bookingId" value="${bookingId}">
                    <input type="hidden" name="amount" value="${amount}">
                    <input type="hidden" name="customerName" value="${customerName}">

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="cardNumber" class="form-label">Card Number</label>
                            <input type="text" class="form-control" id="cardNumber" name="cardNumber" placeholder="1234 5678 9012 3456" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="cardHolderName" class="form-label">Card Holder Name</label>
                            <input type="text" class="form-control" id="cardHolderName" name="cardHolderName" required>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="expiryDate" class="form-label">Expiry Date</label>
                            <input type="text" class="form-control" id="expiryDate" name="expiryDate" placeholder="MM/YY" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="cvv" class="form-label">CVV</label>
                            <input type="password" class="form-control" id="cvv" name="cvv" maxlength="4" required>
                        </div>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary">Process Credit Card Payment</button>
                    </div>
                </form>
            </div>

            <!-- Cash Payment Form -->
            <div class="tab-pane fade" id="cash" role="tabpanel">
                <form action="<c:url value='/payments/process/cash'/>" method="post" id="cashForm">
                    <input type="hidden" name="bookingId" value="${bookingId}">
                    <input type="hidden" name="amount" value="${amount}">
                    <input type="hidden" name="customerName" value="${customerName}">

                    <div class="mb-3">
                        <label for="amountTendered" class="form-label">Amount Tendered</label>
                        <div class="input-group">
                            <span class="input-group-text">$</span>
                            <input type="number" class="form-control" id="amountTendered" name="amountTendered" step="0.01" min="${amount}" required>
                        </div>
                        <div class="form-text">Amount must be equal to or greater than the payment amount.</div>
                    </div>

                    <div class="mb-3">
                        <label for="changeAmount" class="form-label">Change</label>
                        <div class="input-group">
                            <span class="input-group-text">$</span>
                            <input type="text" class="form-control" id="changeAmount" readonly>
                        </div>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary">Process Cash Payment</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Calculate change for cash payment
        const amountTendered = document.getElementById('amountTendered');
        const changeAmount = document.getElementById('changeAmount');
        const totalAmount = ${amount};

        amountTendered.addEventListener('input', function() {
            const tendered = parseFloat(this.value) || 0;
            const change = Math.max(0, tendered - totalAmount).toFixed(2);
            changeAmount.value = change;
        });
    });
</script>

<jsp:include page="common/footer.jsp" />
