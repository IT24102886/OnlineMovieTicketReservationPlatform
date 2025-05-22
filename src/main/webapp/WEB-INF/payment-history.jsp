<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="common/header.jsp" />

<div class="row">
    <div class="col-md-12">
        <h1>Payment History</h1>
        <p class="lead">View all payment transactions.</p>

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
    <div class="col-md-12">
        <div class="card">
            <div class="card-header bg-info text-white d-flex justify-content-between align-items-center">
                <h5 class="mb-0">Transaction List</h5>
                <a href="<c:url value='/payments'/>" class="btn btn-light btn-sm">Back to Payments</a>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty transactions}">
                        <div class="alert alert-info">
                            No payment transactions found.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>Transaction ID</th>
                                        <th>Date</th>
                                        <th>Booking ID</th>
                                        <th>Customer</th>
                                        <th>Amount</th>
                                        <th>Payment Type</th>
                                        <th>Status</th>
                                        <th style="min-width: 150px;">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${transactions}" var="transaction">
                                        <tr>
                                            <td>${transaction.transactionId}</td>
                                            <td>${transaction.transactionDate}</td>
                                            <td>${transaction.bookingId}</td>
                                            <td>${transaction.customerName}</td>
                                            <td>$${transaction.amount}</td>
                                            <td>${transaction.paymentType}</td>
                                            <td>
                                                <span class="badge ${transaction.status eq 'COMPLETED' ? 'bg-success' : transaction.status eq 'PENDING' ? 'bg-warning' : 'bg-danger'}">
                                                    ${transaction.status}
                                                </span>
                                            </td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <a href="<c:url value='/payments/details/${transaction.transactionId}'/>" class="btn btn-sm btn-primary">View</a>
                                                    <a href="<c:url value='/payments/edit/${transaction.transactionId}'/>" class="btn btn-sm btn-warning">Edit</a>
                                                    <button type="button" class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal${transaction.transactionId}">
                                                        Delete
                                                    </button>
                                                </div>

                                                <!-- Delete Modal for each transaction -->
                                                <div class="modal fade" id="deleteModal${transaction.transactionId}" tabindex="-1" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title">Confirm Delete</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                Are you sure you want to delete this payment? This action cannot be undone.
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                                <form action="<c:url value='/payments/delete/${transaction.transactionId}'/>" method="post">
                                                                    <button type="submit" class="btn btn-danger">Delete</button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />
