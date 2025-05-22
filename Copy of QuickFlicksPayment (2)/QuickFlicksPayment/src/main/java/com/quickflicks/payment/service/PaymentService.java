package com.quickflicks.payment.service;

import com.quickflicks.payment.model.Payment;

import java.util.List;

/**
 * Service interface for payment processing
 */
public interface PaymentService {

    /**
     * Process a payment
     * @param payment the payment to process
     * @return true if payment was successful, false otherwise
     */
    boolean processPayment(Payment payment);

    /**
     * Save payment transaction to storage
     * @param payment the payment to save
     */
    void saveTransaction(Payment payment);

    /**
     * Get all payment transactions
     * @return list of all payments
     */
    List<Payment> getAllTransactions();

    /**
     * Get payment by transaction ID
     * @param transactionId the transaction ID
     * @return the payment if found, null otherwise
     */
    Payment getTransactionById(String transactionId);

    /**
     * Update an existing payment
     * @param payment the payment with updated information
     * @return true if update was successful, false otherwise
     */
    boolean updatePayment(Payment payment);

    /**
     * Delete a payment by transaction ID
     * @param transactionId the transaction ID to delete
     * @return true if deletion was successful, false otherwise
     */
    boolean deletePayment(String transactionId);
}
