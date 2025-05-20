package com.quickflicks.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Base class for payment processing.
 * Demonstrates inheritance as different payment methods will extend this class.
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public abstract class Payment {
    private String transactionId;
    private double amount;
    private String showtimeId;
    private LocalDateTime transactionDate;
    private String status; // "PENDING", "COMPLETED", "FAILED"
    
    private static final DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    
    public Payment(String transactionId, double amount, String showtimeId) {
        this.transactionId = transactionId;
        this.amount = amount;
        this.showtimeId = showtimeId;
        this.transactionDate = LocalDateTime.now();
        this.status = "PENDING";
    }
    
    // Abstract method to process payment - will be implemented by subclasses
    public abstract boolean processPayment();
    
    // Method to get payment type - will be overridden by subclasses
    public abstract String getPaymentType();
    
    // Convert payment to string format for file storage
    public String toFileString() {
        return String.join("|",
            transactionId,
            String.valueOf(amount),
            showtimeId,
            transactionDate.format(DATE_TIME_FORMATTER),
            status,
            getPaymentType()
        );
    }
    
    // Create payment from string format from file storage - factory method
    public static Payment fromFileString(String fileString) {
        String[] parts = fileString.split("\\|");
        if (parts.length >= 6) {
            String transactionId = parts[0];
            double amount = Double.parseDouble(parts[1]);
            String showtimeId = parts[2];
            LocalDateTime transactionDate = LocalDateTime.parse(parts[3], DATE_TIME_FORMATTER);
            String status = parts[4];
            String paymentType = parts[5];
            
            Payment payment;
            
            // Create the appropriate payment subclass based on payment type
            if ("CREDIT_CARD".equals(paymentType) && parts.length >= 8) {
                payment = new CreditCardPayment(
                    transactionId, 
                    amount, 
                    showtimeId,
                    parts[6], // cardNumber
                    parts[7]  // cardHolderName
                );
            } else if ("UPI".equals(paymentType) && parts.length >= 7) {
                payment = new UPIPayment(
                    transactionId, 
                    amount, 
                    showtimeId,
                    parts[6]  // upiId
                );
            } else {
                return null; // Unknown payment type or missing data
            }
            
            payment.setTransactionDate(transactionDate);
            payment.setStatus(status);
            
            return payment;
        }
        return null;
    }
}
