package com.quickflicks.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * Represents a credit card payment.
 * Demonstrates inheritance by extending the Payment class.
 */
@Getter
@Setter
@NoArgsConstructor
public class CreditCardPayment extends Payment {
    private String cardNumber;
    private String cardHolderName;
    
    public CreditCardPayment(String transactionId, double amount, String showtimeId, 
                            String cardNumber, String cardHolderName) {
        super(transactionId, amount, showtimeId);
        this.cardNumber = maskCardNumber(cardNumber);
        this.cardHolderName = cardHolderName;
    }
    
    @Override
    public boolean processPayment() {
        // In a real application, this would connect to a payment gateway
        // For this demo, we'll simulate a successful payment
        setStatus("COMPLETED");
        return true;
    }
    
    @Override
    public String getPaymentType() {
        return "CREDIT_CARD";
    }
    
    @Override
    public String toFileString() {
        return super.toFileString() + "|" + cardNumber + "|" + cardHolderName;
    }
    
    // Method to mask the card number for security (show only last 4 digits)
    private String maskCardNumber(String cardNumber) {
        if (cardNumber == null || cardNumber.length() < 4) {
            return cardNumber;
        }
        
        String lastFourDigits = cardNumber.substring(cardNumber.length() - 4);
        StringBuilder masked = new StringBuilder();
        for (int i = 0; i < cardNumber.length() - 4; i++) {
            masked.append("X");
        }
        masked.append(lastFourDigits);
        
        return masked.toString();
    }
}
