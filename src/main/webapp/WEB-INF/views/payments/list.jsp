<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../layout/header.jsp" />

<h2>Payment Transactions</h2>

<div class="card mb-4">
    <div class="card-header">
        <h5>All Transactions</h5>
    </div>
    <div class="card-body">
        <c:if test="${empty payments}">
            <div class="alert alert-info">No payment transactions found.</div>
        </c:if>
        
        <c:if test="${not empty payments}">
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>Transaction ID</th>
                            <th>Date & Time</th>
                            <th>Amount</th>
                            <th>Payment Method</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${payments}" var="payment">
                            <tr>
                                <td>${payment.transactionId}</td>
                                <td>
                                    <fmt:parseDate value="${payment.transactionDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
                                    <fmt:formatDate pattern="dd MMM yyyy, HH:mm:ss" value="${parsedDateTime}" />
                                </td>
                                <td>$${payment.amount}</td>
                                <td>${payment.paymentType}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${payment.status == 'COMPLETED'}">
                                            <span class="badge bg-success">Completed</span>
                                        </c:when>
                                        <c:when test="${payment.status == 'PENDING'}">
                                            <span class="badge bg-warning">Pending</span>
                                        </c:when>
                                        <c:when test="${payment.status == 'FAILED'}">
                                            <span class="badge bg-danger">Failed</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">${payment.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="<c:url value='/payments/confirmation/${payment.transactionId}' />" class="btn btn-info btn-sm">View Details</a>
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
    <a href="<c:url value='/' />" class="btn btn-primary">Back to Home</a>
</div>

<jsp:include page="../layout/footer.jsp" />
