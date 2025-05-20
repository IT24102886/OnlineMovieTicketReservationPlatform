package com.quickflicks.service;

import com.quickflicks.model.CreditCardPayment;
import com.quickflicks.model.Payment;
import com.quickflicks.model.UPIPayment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * Service for managing payments.
 */
@Service
public class PaymentService {

    @Autowired
    private FileService fileService;

    // Process a credit card payment
    public CreditCardPayment processCreditCardPayment(String showtimeId, double amount,
                                                     String cardNumber, String cardHolderName) {
        try {
            // Validate inputs
            if (showtimeId == null || showtimeId.trim().isEmpty()) {
                throw new IllegalArgumentException("Showtime ID cannot be empty");
            }

            if (amount <= 0) {
                throw new IllegalArgumentException("Payment amount must be greater than zero");
            }

            if (cardNumber == null || cardNumber.trim().isEmpty()) {
                throw new IllegalArgumentException("Card number cannot be empty");
            }

            if (cardHolderName == null || cardHolderName.trim().isEmpty()) {
                throw new IllegalArgumentException("Card holder name cannot be empty");
            }

            // Generate unique transaction ID
            String transactionId = UUID.randomUUID().toString();

            // Create payment object
            CreditCardPayment payment = new CreditCardPayment(
                transactionId, amount, showtimeId, cardNumber, cardHolderName
            );

            // Process the payment
            if (payment.processPayment()) {
                // Save transaction to file
                fileService.appendLine(fileService.getTransactionsFilePath(), payment.toFileString());
                return payment;
            } else {
                // Payment processing failed
                return null;
            }
        } catch (Exception e) {
            // Log the error (in a real application)
            System.err.println("Error processing credit card payment: " + e.getMessage());
            return null;
        }
    }

    // Process a UPI payment
    public UPIPayment processUPIPayment(String showtimeId, double amount, String upiId) {
        try {
            // Validate inputs
            if (showtimeId == null || showtimeId.trim().isEmpty()) {
                throw new IllegalArgumentException("Showtime ID cannot be empty");
            }

            if (amount <= 0) {
                throw new IllegalArgumentException("Payment amount must be greater than zero");
            }

            if (upiId == null || upiId.trim().isEmpty()) {
                throw new IllegalArgumentException("UPI ID cannot be empty");
            }

            // Generate unique transaction ID
            String transactionId = UUID.randomUUID().toString();

            // Create payment object
            UPIPayment payment = new UPIPayment(transactionId, amount, showtimeId, upiId);

            // Process the payment
            if (payment.processPayment()) {
                // Save transaction to file
                fileService.appendLine(fileService.getTransactionsFilePath(), payment.toFileString());
                return payment;
            } else {
                // Payment processing failed
                return null;
            }
        } catch (Exception e) {
            // Log the error (in a real application)
            System.err.println("Error processing UPI payment: " + e.getMessage());
            return null;
        }
    }

    // Get all payments
    public List<Payment> getAllPayments() {
        return fileService.readLines(fileService.getTransactionsFilePath()).stream()
            .filter(line -> !line.trim().isEmpty())
            .map(Payment::fromFileString)
            .collect(Collectors.toList());
    }

    // Get payment by transaction ID
    public Payment getPaymentByTransactionId(String transactionId) {
        return getAllPayments().stream()
            .filter(payment -> payment.getTransactionId().equals(transactionId))
            .findFirst()
            .orElse(null);
    }

    // Get payments by showtime ID
    public List<Payment> getPaymentsByShowtimeId(String showtimeId) {
        return getAllPayments().stream()
            .filter(payment -> payment.getShowtimeId().equals(showtimeId))
            .collect(Collectors.toList());
    }
}
