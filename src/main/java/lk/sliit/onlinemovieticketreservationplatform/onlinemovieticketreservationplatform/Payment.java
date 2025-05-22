package com.quickflicks.payment.model;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Base class for all payment types
 */
@Data
@NoArgsConstructor
public abstract class Payment {
    private String transactionId;
    private double amount;
    private LocalDateTime transactionDate;
    private String bookingId;
    private String customerName;
    private PaymentStatus status;
    
    public Payment(double amount, String bookingId, String customerName) {
        this.transactionId = UUID.randomUUID().toString();
        this.amount = amount;
        this.bookingId = bookingId;
        this.customerName = customerName;
        this.transactionDate = LocalDateTime.now();
        this.status = PaymentStatus.PENDING;
    }
    
    /**
     * Process the payment - to be implemented by subclasses
     * @return true if payment was successful, false otherwise
     */
    public abstract boolean processPayment();
    
    /**
     * Get payment type name
     * @return String representation of payment type
     */
    public abstract String getPaymentType();
    
    /**
     * Convert payment to string format for storage
     * @return CSV formatted string
     */
    public String toStorageString() {
        return String.join(",", 
                transactionId,
                getPaymentType(),
                String.valueOf(amount),
                transactionDate.toString(),
                bookingId,
                customerName,
                status.toString());
    }
}
