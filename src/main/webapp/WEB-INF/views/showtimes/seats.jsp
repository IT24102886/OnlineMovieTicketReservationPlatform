<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../layout/header.jsp" />

<h2>Select Seats</h2>
<h4>${showtime.movieTitle}</h4>
<p>
    <fmt:parseDate value="${showtime.startTime}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both" />
    <fmt:formatDate pattern="dd MMM yyyy, HH:mm" value="${parsedDateTime}" />
    | Ticket Price: $${showtime.ticketPrice}
</p>

<div class="card mb-4">
    <div class="card-header">
        <h5>Screen Layout</h5>
    </div>
    <div class="card-body text-center">
        <div class="mb-4 p-2 bg-dark text-white">SCREEN</div>
        
        <form action="<c:url value='/showtimes/${showtime.id}/book' />" method="post" id="seatForm">
            <div class="seat-container">
                <c:forEach begin="0" end="${showtime.seatAvailability.length - 1}" var="row">
                    <div class="seat-row">
                        <span class="row-label">${(char)(65 + row)}</span>
                        <c:forEach begin="0" end="${showtime.seatAvailability[0].length - 1}" var="col">
                            <c:choose>
                                <c:when test="${showtime.seatAvailability[row][col]}">
                                    <div class="seat seat-available" data-row="${row}" data-col="${col}" onclick="toggleSeat(this)">
                                        ${(char)(65 + row)}${col + 1}
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="seat seat-booked">
                                        ${(char)(65 + row)}${col + 1}
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                </c:forEach>
            </div>
            
            <div class="mt-4">
                <div class="d-flex justify-content-center mb-3">
                    <div class="mx-2">
                        <div class="seat seat-available" style="display: inline-block;"></div> Available
                    </div>
                    <div class="mx-2">
                        <div class="seat seat-selected" style="display: inline-block;"></div> Selected
                    </div>
                    <div class="mx-2">
                        <div class="seat seat-booked" style="display: inline-block;"></div> Booked
                    </div>
                </div>
                
                <div id="selectedSeats" class="mb-3">
                    <p>Selected Seats: <span id="seatList">None</span></p>
                    <p>Total Amount: $<span id="totalAmount">0.00</span></p>
                </div>
                
                <button type="submit" class="btn btn-primary" id="bookButton" disabled>Proceed to Payment</button>
                <a href="<c:url value='/showtimes/${showtime.id}' />" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>

<script>
    const ticketPrice = ${showtime.ticketPrice};
    const selectedSeats = [];
    
    function toggleSeat(seatElement) {
        const row = seatElement.getAttribute('data-row');
        const col = seatElement.getAttribute('data-col');
        const seatId = row + '-' + col;
        const seatLabel = seatElement.innerText;
        
        if (seatElement.classList.contains('seat-selected')) {
            // Deselect seat
            seatElement.classList.remove('seat-selected');
            seatElement.classList.add('seat-available');
            
            const index = selectedSeats.findIndex(seat => seat.id === seatId);
            if (index !== -1) {
                selectedSeats.splice(index, 1);
            }
        } else {
            // Select seat
            seatElement.classList.remove('seat-available');
            seatElement.classList.add('seat-selected');
            
            selectedSeats.push({
                id: seatId,
                label: seatLabel
            });
        }
        
        updateSelectedSeats();
    }
    
    function updateSelectedSeats() {
        const seatListElement = document.getElementById('seatList');
        const totalAmountElement = document.getElementById('totalAmount');
        const bookButton = document.getElementById('bookButton');
        const seatForm = document.getElementById('seatForm');
        
        // Clear previous hidden inputs
        const previousInputs = document.querySelectorAll('input[name="seats"]');
        previousInputs.forEach(input => input.remove());
        
        if (selectedSeats.length === 0) {
            seatListElement.innerText = 'None';
            totalAmountElement.innerText = '0.00';
            bookButton.disabled = true;
        } else {
            seatListElement.innerText = selectedSeats.map(seat => seat.label).join(', ');
            totalAmountElement.innerText = (selectedSeats.length * ticketPrice).toFixed(2);
            bookButton.disabled = false;
            
            // Add hidden inputs for selected seats
            selectedSeats.forEach(seat => {
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'seats';
                input.value = seat.id;
                seatForm.appendChild(input);
            });
        }
    }
</script>

<jsp:include page="../layout/footer.jsp" />
