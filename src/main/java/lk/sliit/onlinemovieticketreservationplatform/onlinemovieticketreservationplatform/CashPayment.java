package com.quickflicks.payment.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * Cash payment implementation
 */
@Data
@EqualsAndHashCode(callSuper = true)
@NoArgsConstructor
public class CashPayment extends Payment {
    private double amountTendered;
    private double change;
    
    public CashPayment(double amount, String bookingId, String customerName, double amountTendered) {
        super(amount, bookingId, customerName);
        this.amountTendered = amountTendered;
        this.change = calculateChange(amount, amountTendered);
    }
    
    @Override
    public boolean processPayment() {
        // For cash payments, we just need to verify that enough cash was provided
        if (amountTendered >= getAmount()) {
            setStatus(PaymentStatus.COMPLETED);
            return true;
        } else {
            setStatus(PaymentStatus.FAILED);
            return false;
        }
    }
    
    @Override
    public String getPaymentType() {
        return "CASH";
    }
    
    @Override
    public String toStorageString() {
        return super.toStorageString() + "," + 
                amountTendered + "," + 
                change;
    }
    
    /**
     * Calculate change to be given back
     * @param amount the payment amount
     * @param amountTendered the cash amount provided
     * @return the change amount
     */
    private double calculateChange(double amount, double amountTendered) {
        return Math.max(0, amountTendered - amount);
    }
}
