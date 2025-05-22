/**
 * QuickFlicks Payment System JavaScript
 */

document.addEventListener('DOMContentLoaded', function() {
    // Credit card form validation
    const creditCardForm = document.getElementById('creditCardForm');
    if (creditCardForm) {
        creditCardForm.addEventListener('submit', function(event) {
            const cardNumber = document.getElementById('cardNumber').value;
            const expiryDate = document.getElementById('expiryDate').value;
            const cvv = document.getElementById('cvv').value;
            
            // Basic card number validation (remove spaces and check length)
            const cleanCardNumber = cardNumber.replace(/\s+/g, '');
            if (cleanCardNumber.length < 13 || cleanCardNumber.length > 19 || !/^\d+$/.test(cleanCardNumber)) {
                alert('Please enter a valid card number');
                event.preventDefault();
                return;
            }
            
            // Basic expiry date validation (MM/YY format)
            if (!/^\d{2}\/\d{2}$/.test(expiryDate)) {
                alert('Please enter expiry date in MM/YY format');
                event.preventDefault();
                return;
            }
            
            // Basic CVV validation
            if (!/^\d{3,4}$/.test(cvv)) {
                alert('Please enter a valid CVV (3 or 4 digits)');
                event.preventDefault();
                return;
            }
        });
    }
    
    // Format credit card number with spaces
    const cardNumberInput = document.getElementById('cardNumber');
    if (cardNumberInput) {
        cardNumberInput.addEventListener('input', function(e) {
            let value = e.target.value.replace(/\s+/g, '');
            if (value.length > 0) {
                value = value.match(new RegExp('.{1,4}', 'g')).join(' ');
            }
            e.target.value = value;
        });
    }
    
    // Format expiry date with slash
    const expiryDateInput = document.getElementById('expiryDate');
    if (expiryDateInput) {
        expiryDateInput.addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length > 2) {
                value = value.substring(0, 2) + '/' + value.substring(2, 4);
            }
            e.target.value = value;
        });
    }
});
