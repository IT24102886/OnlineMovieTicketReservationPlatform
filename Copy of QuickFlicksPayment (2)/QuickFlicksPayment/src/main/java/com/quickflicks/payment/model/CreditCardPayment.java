package com.quickflicks.payment.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * Credit card payment implementation
 */
@Data
@EqualsAndHashCode(callSuper = true)
@NoArgsConstructor
public class CreditCardPayment extends Payment {
    private String cardNumber;
    private String cardHolderName;
    private String expiryDate;
    private String cvv;
    
    public CreditCardPayment(double amount, String bookingId, String customerName, 
                            String cardNumber, String cardHolderName, 
                            String expiryDate, String cvv) {
        super(amount, bookingId, customerName);
        this.cardNumber = maskCardNumber(cardNumber);
        this.cardHolderName = cardHolderName;
        this.expiryDate = expiryDate;
        this.cvv = "***"; // Never store actual CVV
    }
    
    @Override
    public boolean processPayment() {
        // In a real application, this would connect to a payment gateway
        // For this demo, we'll simulate a successful payment
        setStatus(PaymentStatus.COMPLETED);
        return true;
    }
    
    @Override
    public String getPaymentType() {
        return "CREDIT_CARD";
    }
    
    @Override
    public String toStorageString() {
        return super.toStorageString() + "," + 
                cardNumber + "," + 
                cardHolderName + "," + 
                expiryDate;
    }
    
    /**
     * Mask the card number for security
     * @param cardNumber full card number
     * @return masked card number
     */
    private String maskCardNumber(String cardNumber) {
        if (cardNumber == null || cardNumber.length() < 4) {
            return cardNumber;
        }
        
        String lastFourDigits = cardNumber.substring(cardNumber.length() - 4);
        return "XXXX-XXXX-XXXX-" + lastFourDigits;
    }
}
