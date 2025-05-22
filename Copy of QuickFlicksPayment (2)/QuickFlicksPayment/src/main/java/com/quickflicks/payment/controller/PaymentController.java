package com.quickflicks.payment.controller;

import com.quickflicks.payment.model.CashPayment;
import com.quickflicks.payment.model.CreditCardPayment;
import com.quickflicks.payment.model.Payment;
import com.quickflicks.payment.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * Controller for handling payment-related requests
 */
@Controller
@RequestMapping("/payments")
public class PaymentController {

    private final PaymentService paymentService;

    @Autowired
    public PaymentController(PaymentService paymentService) {
        this.paymentService = paymentService;
    }

    /**
     * Display the payment form
     */
    @GetMapping
    public String showPaymentPage() {
        return "payments";
    }

    /**
     * Display the payment form with booking details
     */
    @GetMapping("/process")
    public String showPaymentForm(@RequestParam("bookingId") String bookingId,
                                 @RequestParam("amount") double amount,
                                 @RequestParam("customerName") String customerName,
                                 Model model) {
        model.addAttribute("bookingId", bookingId);
        model.addAttribute("amount", amount);
        model.addAttribute("customerName", customerName);
        return "payment-form";
    }

    /**
     * Process a credit card payment
     */
    @PostMapping("/process/credit-card")
    public String processCreditCardPayment(@RequestParam("bookingId") String bookingId,
                                          @RequestParam("amount") double amount,
                                          @RequestParam("customerName") String customerName,
                                          @RequestParam("cardNumber") String cardNumber,
                                          @RequestParam("cardHolderName") String cardHolderName,
                                          @RequestParam("expiryDate") String expiryDate,
                                          @RequestParam("cvv") String cvv,
                                          Model model) {

        CreditCardPayment payment = new CreditCardPayment(
            amount, bookingId, customerName, cardNumber, cardHolderName, expiryDate, cvv
        );

        boolean success = paymentService.processPayment(payment);

        model.addAttribute("payment", payment);
        model.addAttribute("success", success);

        return "payment-confirmation";
    }

    /**
     * Process a cash payment
     */
    @PostMapping("/process/cash")
    public String processCashPayment(@RequestParam("bookingId") String bookingId,
                                    @RequestParam("amount") double amount,
                                    @RequestParam("customerName") String customerName,
                                    @RequestParam("amountTendered") double amountTendered,
                                    Model model) {

        CashPayment payment = new CashPayment(
            amount, bookingId, customerName, amountTendered
        );

        boolean success = paymentService.processPayment(payment);

        model.addAttribute("payment", payment);
        model.addAttribute("success", success);

        return "payment-confirmation";
    }

    /**
     * View all payment transactions
     */
    @GetMapping("/history")
    public String viewPaymentHistory(Model model) {
        model.addAttribute("transactions", paymentService.getAllTransactions());
        return "payment-history";
    }

    /**
     * View details of a specific payment
     */
    @GetMapping("/details/{transactionId}")
    public String viewPaymentDetails(@PathVariable("transactionId") String transactionId, Model model) {
        Payment payment = paymentService.getTransactionById(transactionId);
        if (payment == null) {
            return "redirect:/payments/history";
        }

        model.addAttribute("payment", payment);
        return "payment-details";
    }

    /**
     * Show form to edit a payment
     */
    @GetMapping("/edit/{transactionId}")
    public String showEditForm(@PathVariable("transactionId") String transactionId, Model model) {
        Payment payment = paymentService.getTransactionById(transactionId);
        if (payment == null) {
            return "redirect:/payments/history";
        }

        model.addAttribute("payment", payment);
        return "payment-edit";
    }

    /**
     * Update a credit card payment
     */
    @PostMapping("/update/credit-card")
    public String updateCreditCardPayment(@RequestParam("transactionId") String transactionId,
                                         @RequestParam("bookingId") String bookingId,
                                         @RequestParam("amount") double amount,
                                         @RequestParam("customerName") String customerName,
                                         @RequestParam("cardNumber") String cardNumber,
                                         @RequestParam("cardHolderName") String cardHolderName,
                                         @RequestParam("expiryDate") String expiryDate,
                                         RedirectAttributes redirectAttributes) {

        Payment existingPayment = paymentService.getTransactionById(transactionId);
        if (existingPayment == null || !(existingPayment instanceof CreditCardPayment)) {
            redirectAttributes.addFlashAttribute("error", "Payment not found or not a credit card payment");
            return "redirect:/payments/history";
        }

        CreditCardPayment payment = (CreditCardPayment) existingPayment;
        payment.setBookingId(bookingId);
        payment.setAmount(amount);
        payment.setCustomerName(customerName);
        payment.setCardNumber(cardNumber);
        payment.setCardHolderName(cardHolderName);
        payment.setExpiryDate(expiryDate);

        boolean success = paymentService.updatePayment(payment);

        if (success) {
            redirectAttributes.addFlashAttribute("message", "Payment updated successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to update payment");
        }

        return "redirect:/payments/details/" + transactionId;
    }

    /**
     * Update a cash payment
     */
    @PostMapping("/update/cash")
    public String updateCashPayment(@RequestParam("transactionId") String transactionId,
                                   @RequestParam("bookingId") String bookingId,
                                   @RequestParam("amount") double amount,
                                   @RequestParam("customerName") String customerName,
                                   @RequestParam("amountTendered") double amountTendered,
                                   RedirectAttributes redirectAttributes) {

        Payment existingPayment = paymentService.getTransactionById(transactionId);
        if (existingPayment == null || !(existingPayment instanceof CashPayment)) {
            redirectAttributes.addFlashAttribute("error", "Payment not found or not a cash payment");
            return "redirect:/payments/history";
        }

        CashPayment payment = (CashPayment) existingPayment;
        payment.setBookingId(bookingId);
        payment.setAmount(amount);
        payment.setCustomerName(customerName);
        payment.setAmountTendered(amountTendered);
        payment.setChange(Math.max(0, amountTendered - amount));

        boolean success = paymentService.updatePayment(payment);

        if (success) {
            redirectAttributes.addFlashAttribute("message", "Payment updated successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to update payment");
        }

        return "redirect:/payments/details/" + transactionId;
    }

    /**
     * Delete a payment
     */
    @PostMapping("/delete/{transactionId}")
    public String deletePayment(@PathVariable("transactionId") String transactionId,
                               RedirectAttributes redirectAttributes) {

        boolean success = paymentService.deletePayment(transactionId);

        if (success) {
            redirectAttributes.addFlashAttribute("message", "Payment deleted successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to delete payment");
        }

        return "redirect:/payments/history";
    }
}
