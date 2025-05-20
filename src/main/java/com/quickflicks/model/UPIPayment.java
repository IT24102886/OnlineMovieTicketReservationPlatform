package com.quickflicks.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * Represents a UPI payment.
 * Demonstrates polymorphism by providing a different implementation of processPayment.
 */
@Getter
@Setter
@NoArgsConstructor
public class UPIPayment extends Payment {
    private String upiId;
    
    public UPIPayment(String transactionId, double amount, String showtimeId, String upiId) {
        super(transactionId, amount, showtimeId);
        this.upiId = upiId;
    }
    
    @Override
    public boolean processPayment() {
        // In a real application, this would connect to a UPI payment gateway
        // For this demo, we'll simulate a successful payment
        setStatus("COMPLETED");
        return true;
    }
    
    @Override
    public String getPaymentType() {
        return "UPI";
    }
    
    @Override
    public String toFileString() {
        return super.toFileString() + "|" + upiId;
    }
}
