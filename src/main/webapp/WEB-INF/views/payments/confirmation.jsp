<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../layout/header.jsp" />

<div class="card mb-4">
    <div class="card-header bg-success text-white">
        <h4>Payment Successful!</h4>
    </div>
    <div class="card-body">
        <div class="text-center mb-4">
            <i class="bi bi-check-circle-fill text-success" style="font-size: 4rem;"></i>
        </div>
        
        <h5>Transaction Details</h5>
        <p><strong>Transaction ID:</strong> ${payment.transactionId}</p>
        <p><strong>Amount:</strong> $${payment.amount}</p>
        <p><strong>Payment Method:</strong> ${paymentMethod}</p>
        <p>
            <strong>Transaction Date:</strong>
            <fmt:parseDate value="${payment.transactionDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
            <fmt:formatDate pattern="dd MMM yyyy, HH:mm:ss" value="${parsedDateTime}" />
        </p>
        <p><strong>Status:</strong> ${payment.status}</p>
        
        <c:if test="${not empty seats}">
            <p><strong>Selected Seats:</strong> ${seats}</p>
        </c:if>
        
        <div class="alert alert-info mt-4">
            <p>A confirmation email has been sent to your registered email address.</p>
            <p>Please show this confirmation page or the email at the theater entrance.</p>
        </div>
    </div>
</div>

<div class="text-center mt-4">
    <a href="<c:url value='/' />" class="btn btn-primary">Back to Home</a>
    <button class="btn btn-secondary" onclick="window.print()">Print Ticket</button>
</div>

<jsp:include page="../layout/footer.jsp" />
