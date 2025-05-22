package com.quickflicks.payment.service;

import com.quickflicks.payment.model.CashPayment;
import com.quickflicks.payment.model.CreditCardPayment;
import com.quickflicks.payment.model.Payment;
import com.quickflicks.payment.model.PaymentStatus;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import jakarta.annotation.PostConstruct;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Implementation of the PaymentService interface
 */
@Service
public class PaymentServiceImpl implements PaymentService {

    @Value("${payment.transaction.file}")
    private String transactionFilePath;

    @PostConstruct
    public void init() {
        // Create the transaction file if it doesn't exist
        try {
            File file = new File(transactionFilePath);
            if (!file.exists()) {
                file.createNewFile();
            }
        } catch (IOException e) {
            throw new RuntimeException("Failed to initialize transaction file", e);
        }
    }

    @Override
    public boolean processPayment(Payment payment) {
        boolean success = payment.processPayment();
        if (success) {
            saveTransaction(payment);
        }
        return success;
    }

    @Override
    public void saveTransaction(Payment payment) {
        try {
            String transactionRecord = payment.toStorageString() + System.lineSeparator();
            Files.write(
                Paths.get(transactionFilePath),
                transactionRecord.getBytes(),
                StandardOpenOption.APPEND
            );
        } catch (IOException e) {
            throw new RuntimeException("Failed to save transaction", e);
        }
    }

    @Override
    public List<Payment> getAllTransactions() {
        List<Payment> transactions = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(transactionFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    Payment payment = parseTransactionLine(line);
                    if (payment != null) {
                        transactions.add(payment);
                    }
                }
            }
        } catch (IOException e) {
            throw new RuntimeException("Failed to read transactions", e);
        }

        return transactions;
    }

    @Override
    public Payment getTransactionById(String transactionId) {
        return getAllTransactions().stream()
                .filter(payment -> payment.getTransactionId().equals(transactionId))
                .findFirst()
                .orElse(null);
    }

    @Override
    public boolean updatePayment(Payment payment) {
        List<Payment> transactions = getAllTransactions();

        // Remove the old payment
        List<Payment> updatedTransactions = transactions.stream()
                .filter(p -> !p.getTransactionId().equals(payment.getTransactionId()))
                .collect(Collectors.toList());

        // Add the updated payment
        updatedTransactions.add(payment);

        // Write all transactions back to the file
        try {
            // Clear the file
            new FileWriter(transactionFilePath, false).close();

            // Write all transactions
            for (Payment p : updatedTransactions) {
                String transactionRecord = p.toStorageString() + System.lineSeparator();
                Files.write(
                    Paths.get(transactionFilePath),
                    transactionRecord.getBytes(),
                    StandardOpenOption.APPEND
                );
            }

            return true;
        } catch (IOException e) {
            throw new RuntimeException("Failed to update transaction", e);
        }
    }

    @Override
    public boolean deletePayment(String transactionId) {
        List<Payment> transactions = getAllTransactions();

        // Filter out the payment to delete
        List<Payment> updatedTransactions = transactions.stream()
                .filter(p -> !p.getTransactionId().equals(transactionId))
                .collect(Collectors.toList());

        // If no payment was removed, return false
        if (updatedTransactions.size() == transactions.size()) {
            return false;
        }

        // Write all transactions back to the file
        try {
            // Clear the file
            new FileWriter(transactionFilePath, false).close();

            // Write all transactions
            for (Payment p : updatedTransactions) {
                String transactionRecord = p.toStorageString() + System.lineSeparator();
                Files.write(
                    Paths.get(transactionFilePath),
                    transactionRecord.getBytes(),
                    StandardOpenOption.APPEND
                );
            }

            return true;
        } catch (IOException e) {
            throw new RuntimeException("Failed to delete transaction", e);
        }
    }

    /**
     * Parse a transaction line from the storage file
     * @param line the CSV line to parse
     * @return the Payment object
     */
    private Payment parseTransactionLine(String line) {
        String[] parts = line.split(",");
        if (parts.length < 7) {
            return null;
        }

        String transactionId = parts[0];
        String paymentType = parts[1];
        double amount = Double.parseDouble(parts[2]);
        LocalDateTime transactionDate = LocalDateTime.parse(parts[3]);
        String bookingId = parts[4];
        String customerName = parts[5];
        PaymentStatus status = PaymentStatus.valueOf(parts[6]);

        Payment payment;

        if ("CREDIT_CARD".equals(paymentType)) {
            if (parts.length < 10) {
                return null;
            }

            String cardNumber = parts[7];
            String cardHolderName = parts[8];
            String expiryDate = parts[9];

            payment = new CreditCardPayment();
            ((CreditCardPayment) payment).setCardNumber(cardNumber);
            ((CreditCardPayment) payment).setCardHolderName(cardHolderName);
            ((CreditCardPayment) payment).setExpiryDate(expiryDate);
            ((CreditCardPayment) payment).setCvv("***");

        } else if ("CASH".equals(paymentType)) {
            if (parts.length < 9) {
                return null;
            }

            double amountTendered = Double.parseDouble(parts[7]);
            double change = Double.parseDouble(parts[8]);

            payment = new CashPayment();
            ((CashPayment) payment).setAmountTendered(amountTendered);
            ((CashPayment) payment).setChange(change);

        } else {
            return null;
        }

        payment.setTransactionId(transactionId);
        payment.setAmount(amount);
        payment.setTransactionDate(transactionDate);
        payment.setBookingId(bookingId);
        payment.setCustomerName(customerName);
        payment.setStatus(status);

        return payment;
    }
}
