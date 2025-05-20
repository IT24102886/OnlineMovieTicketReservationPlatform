    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <p><i class="fas fa-film me-2 text-primary"></i><span class="text-primary fw-bold">QuickFlicks</span> &copy; 2023. All rights reserved.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p><i class="fas fa-headset me-1"></i> Support: +94 11 234 5678</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Custom JavaScript for Seat Selection -->
    <script>
        function toggleSeat(seat) {
            if (seat.classList.contains('seat-available')) {
                seat.classList.remove('seat-available');
                seat.classList.add('seat-selected');

                // Add hidden input for selected seat
                const row = seat.getAttribute('data-row');
                const col = seat.getAttribute('data-col');
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'seats';
                input.value = row + ',' + col;
                input.id = 'seat-' + row + '-' + col;
                document.getElementById('seatStatusInputs').appendChild(input);
            } else if (seat.classList.contains('seat-selected')) {
                seat.classList.remove('seat-selected');
                seat.classList.add('seat-available');

                // Remove hidden input for deselected seat
                const row = seat.getAttribute('data-row');
                const col = seat.getAttribute('data-col');
                const input = document.getElementById('seat-' + row + '-' + col);
                if (input) {
                    input.remove();
                }
            }
        }

        function toggleSeatStatus(seat) {
            if (seat.classList.contains('seat-available')) {
                seat.classList.remove('seat-available');
                seat.classList.add('seat-booked');

                // Update hidden input
                const row = seat.getAttribute('data-row');
                const col = seat.getAttribute('data-col');
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'seatStatus[' + row + '][' + col + ']';
                input.value = 'false';
                input.id = 'seatStatus-' + row + '-' + col;
                document.getElementById('seatStatusInputs').appendChild(input);
            } else if (seat.classList.contains('seat-booked')) {
                seat.classList.remove('seat-booked');
                seat.classList.add('seat-available');

                // Update hidden input
                const row = seat.getAttribute('data-row');
                const col = seat.getAttribute('data-col');
                const input = document.getElementById('seatStatus-' + row + '-' + col);
                if (input) {
                    input.value = 'true';
                }
            }
        }
    </script>
</body>
</html>
