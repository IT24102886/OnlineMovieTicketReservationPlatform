<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../layout/header.jsp" />

<h2>Payment</h2>

<c:if test="${not empty error}">
    <div class="alert alert-danger mb-4">
        <strong>Error:</strong> ${error}
    </div>
</c:if>

<div class="card mb-4">
    <div class="card-header">
        <h5>Booking Summary</h5>
    </div>
    <div class="card-body">
        <p><strong>Movie:</strong> ${showtime.movieTitle}</p>
        <p>
            <strong>Showtime:</strong>
            <fmt:parseDate value="${showtime.startTime}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both" />
            <fmt:formatDate pattern="dd MMM yyyy, HH:mm" value="${parsedDateTime}" />
        </p>
        <p><strong>Selected Seats:</strong> ${seats}</p>
        <p><strong>Number of Seats:</strong> ${seatCount}</p>
        <p><strong>Price per Ticket:</strong> $${showtime.ticketPrice}</p>
        <p><strong>Total Amount:</strong> $${totalAmount}</p>
    </div>
</div>

<div class="card mb-4">
    <div class="card-header">
        <h5>Payment Method</h5>
    </div>
    <div class="card-body">
        <ul class="nav nav-tabs" id="paymentTabs" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="credit-card-tab" data-bs-toggle="tab" data-bs-target="#credit-card" type="button" role="tab" aria-controls="credit-card" aria-selected="true">Credit Card</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="upi-tab" data-bs-toggle="tab" data-bs-target="#upi" type="button" role="tab" aria-controls="upi" aria-selected="false">UPI</button>
            </li>
        </ul>

        <div class="tab-content mt-3" id="paymentTabContent">
            <!-- Credit Card Payment Form -->
            <div class="tab-pane fade show active" id="credit-card" role="tabpanel" aria-labelledby="credit-card-tab">
                <form action="<c:url value='/payments/process-credit-card' />" method="post" id="creditCardForm" onsubmit="return validateCreditCardForm()">
                    <input type="hidden" name="showtimeId" value="${showtime.id}">
                    <input type="hidden" name="seats" value="${seats}">
                    <input type="hidden" name="amount" value="${totalAmount}">

                    <div class="mb-3">
                        <label for="cardNumber" class="form-label">Card Number</label>
                        <input type="text" class="form-control" id="cardNumber" name="cardNumber" placeholder="1234 5678 9012 3456" required pattern="[0-9]{13,19}" maxlength="19" onkeypress="return isNumberKey(event)">
                        <div class="invalid-feedback" id="cardNumberError">Please enter a valid card number (13-19 digits).</div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="expiryDate" class="form-label">Expiry Date</label>
                            <input type="text" class="form-control" id="expiryDate" placeholder="MM/YY" required pattern="(0[1-9]|1[0-2])\/([0-9]{2})" maxlength="5">
                            <div class="invalid-feedback" id="expiryDateError">Please enter a valid expiry date (MM/YY).</div>
                        </div>
                        <div class="col-md-6">
                            <label for="cvv" class="form-label">CVV</label>
                            <input type="text" class="form-control" id="cvv" placeholder="123" required pattern="[0-9]{3,4}" maxlength="4" onkeypress="return isNumberKey(event)">
                            <div class="invalid-feedback" id="cvvError">Please enter a valid CVV (3-4 digits).</div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="cardHolderName" class="form-label">Card Holder Name</label>
                        <input type="text" class="form-control" id="cardHolderName" name="cardHolderName" required pattern="[A-Za-z ]{3,50}">
                        <div class="invalid-feedback" id="cardHolderNameError">Please enter a valid name (3-50 characters).</div>
                    </div>

                    <div id="paymentError" class="alert alert-danger d-none">Please correct the errors in the form.</div>

                    <button type="submit" class="btn btn-primary">Pay $${totalAmount}</button>
                </form>
            </div>

            <!-- UPI Payment Form -->
            <div class="tab-pane fade" id="upi" role="tabpanel" aria-labelledby="upi-tab">
                <form action="<c:url value='/payments/process-upi' />" method="post" id="upiForm" onsubmit="return validateUpiForm()">
                    <input type="hidden" name="showtimeId" value="${showtime.id}">
                    <input type="hidden" name="seats" value="${seats}">
                    <input type="hidden" name="amount" value="${totalAmount}">

                    <div class="mb-3">
                        <label for="upiId" class="form-label">UPI ID</label>
                        <input type="text" class="form-control" id="upiId" name="upiId" placeholder="username@upi" required pattern="[a-zA-Z0-9\.\-_]{3,50}@[a-zA-Z][a-zA-Z]{2,}">
                        <div class="invalid-feedback" id="upiIdError">Please enter a valid UPI ID (e.g., username@upi).</div>
                    </div>

                    <div id="upiPaymentError" class="alert alert-danger d-none">Please correct the errors in the form.</div>

                    <button type="submit" class="btn btn-primary">Pay $${totalAmount}</button>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="mt-3">
    <a href="<c:url value='/showtimes/${showtime.id}/seats' />" class="btn btn-secondary">Back to Seat Selection</a>
</div>

<script>
    // Validation for Credit Card Form
    function validateCreditCardForm() {
        let isValid = true;
        const cardNumber = document.getElementById('cardNumber');
        const expiryDate = document.getElementById('expiryDate');
        const cvv = document.getElementById('cvv');
        const cardHolderName = document.getElementById('cardHolderName');
        const paymentError = document.getElementById('paymentError');

        // Reset previous validation
        paymentError.classList.add('d-none');
        cardNumber.classList.remove('is-invalid');
        expiryDate.classList.remove('is-invalid');
        cvv.classList.remove('is-invalid');
        cardHolderName.classList.remove('is-invalid');

        // Validate card number (Luhn algorithm)
        if (!validateCardNumber(cardNumber.value)) {
            cardNumber.classList.add('is-invalid');
            isValid = false;
        }

        // Validate expiry date
        if (!validateExpiryDate(expiryDate.value)) {
            expiryDate.classList.add('is-invalid');
            isValid = false;
        }

        // Validate CVV
        if (!/^[0-9]{3,4}$/.test(cvv.value)) {
            cvv.classList.add('is-invalid');
            isValid = false;
        }

        // Validate card holder name
        if (!/^[A-Za-z ]{3,50}$/.test(cardHolderName.value)) {
            cardHolderName.classList.add('is-invalid');
            isValid = false;
        }

        if (!isValid) {
            paymentError.classList.remove('d-none');
        }

        return isValid;
    }

    // Validation for UPI Form
    function validateUpiForm() {
        let isValid = true;
        const upiId = document.getElementById('upiId');
        const upiPaymentError = document.getElementById('upiPaymentError');

        // Reset previous validation
        upiPaymentError.classList.add('d-none');
        upiId.classList.remove('is-invalid');

        // Validate UPI ID
        if (!/^[a-zA-Z0-9\.\-_]{3,50}@[a-zA-Z][a-zA-Z]{2,}$/.test(upiId.value)) {
            upiId.classList.add('is-invalid');
            isValid = false;
        }

        if (!isValid) {
            upiPaymentError.classList.remove('d-none');
        }

        return isValid;
    }

    // Luhn algorithm for credit card validation
    function validateCardNumber(cardNumber) {
        // Remove spaces and non-digit characters
        cardNumber = cardNumber.replace(/\D/g, '');

        if (cardNumber.length < 13 || cardNumber.length > 19) {
            return false;
        }

        let sum = 0;
        let shouldDouble = false;

        // Loop through values starting from the rightmost digit
        for (let i = cardNumber.length - 1; i >= 0; i--) {
            let digit = parseInt(cardNumber.charAt(i));

            if (shouldDouble) {
                digit *= 2;
                if (digit > 9) {
                    digit -= 9;
                }
            }

            sum += digit;
            shouldDouble = !shouldDouble;
        }

        return (sum % 10) === 0;
    }

    // Validate expiry date
    function validateExpiryDate(expiryDate) {
        if (!/^(0[1-9]|1[0-2])\/([0-9]{2})$/.test(expiryDate)) {
            return false;
        }

        const parts = expiryDate.split('/');
        const month = parseInt(parts[0], 10);
        const year = parseInt('20' + parts[1], 10);

        const now = new Date();
        const currentYear = now.getFullYear();
        const currentMonth = now.getMonth() + 1; // JavaScript months are 0-based

        // Check if the card is expired
        if (year < currentYear || (year === currentYear && month < currentMonth)) {
            return false;
        }

        return true;
    }

    // Allow only numbers in input fields
    function isNumberKey(evt) {
        const charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
            return false;
        }
        return true;
    }

    // Format expiry date as MM/YY
    document.getElementById('expiryDate').addEventListener('input', function(e) {
        let value = e.target.value.replace(/\D/g, '');
        if (value.length > 2) {
            value = value.substring(0, 2) + '/' + value.substring(2, 4);
        }
        e.target.value = value;
    });
</script>

<jsp:include page="../layout/footer.jsp" />
