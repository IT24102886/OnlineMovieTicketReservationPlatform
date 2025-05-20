package com.quickflicks.controller;

import com.quickflicks.model.Payment;
import com.quickflicks.model.Showtime;
import com.quickflicks.service.PaymentService;
import com.quickflicks.service.ShowtimeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * Controller for payment processing.
 */
@Controller
@RequestMapping("/payments")
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private ShowtimeService showtimeService;

    // Display payment form
    @GetMapping("/create")
    public String showPaymentForm(
            @RequestParam String showtimeId,
            @RequestParam String seats,
            Model model) {

        Showtime showtime = showtimeService.getShowtimeById(showtimeId);
        if (showtime == null) {
            return "redirect:/showtimes";
        }

        // Calculate total amount based on number of seats
        String[] seatArray = seats.split(",");
        double totalAmount = showtime.getTicketPrice() * seatArray.length;

        model.addAttribute("showtime", showtime);
        model.addAttribute("seats", seats);
        model.addAttribute("seatCount", seatArray.length);
        model.addAttribute("totalAmount", totalAmount);

        return "payments/create";
    }

    // Process credit card payment
    @PostMapping("/process-credit-card")
    public String processCreditCardPayment(
            @RequestParam String showtimeId,
            @RequestParam String seats,
            @RequestParam double amount,
            @RequestParam String cardNumber,
            @RequestParam String cardHolderName,
            Model model) {

        try {
            // Validate showtime exists
            Showtime showtime = showtimeService.getShowtimeById(showtimeId);
            if (showtime == null) {
                model.addAttribute("error", "Invalid showtime. Please try again.");
                return "redirect:/showtimes";
            }

            // Validate card number format (basic check)
            if (cardNumber == null || cardNumber.replaceAll("\\D", "").length() < 13 ||
                cardNumber.replaceAll("\\D", "").length() > 19) {
                model.addAttribute("error", "Invalid card number format.");
                return "redirect:/payments/create?showtimeId=" + showtimeId + "&seats=" + seats;
            }

            // Validate card holder name
            if (cardHolderName == null || cardHolderName.trim().isEmpty() ||
                !cardHolderName.matches("[A-Za-z ]{3,50}")) {
                model.addAttribute("error", "Invalid card holder name.");
                return "redirect:/payments/create?showtimeId=" + showtimeId + "&seats=" + seats;
            }

            // Process payment
            Payment payment = paymentService.processCreditCardPayment(
                showtimeId, amount, cardNumber, cardHolderName
            );

            if (payment != null) {
                // Parse seats to book them
                List<int[]> seatPositions = parseSeatPositions(seats);
                if (!seatPositions.isEmpty()) {
                    showtimeService.bookSeats(showtimeId, seatPositions);
                }

                model.addAttribute("payment", payment);
                model.addAttribute("paymentMethod", "Credit Card");
                model.addAttribute("seats", seats);
                return "payments/confirmation";
            } else {
                model.addAttribute("error", "Payment processing failed. Please try again.");
                return "redirect:/payments/create?showtimeId=" + showtimeId + "&seats=" + seats;
            }
        } catch (Exception e) {
            model.addAttribute("error", "An error occurred during payment processing: " + e.getMessage());
            return "redirect:/payments/create?showtimeId=" + showtimeId + "&seats=" + seats;
        }
    }

    // Process UPI payment
    @PostMapping("/process-upi")
    public String processUPIPayment(
            @RequestParam String showtimeId,
            @RequestParam String seats,
            @RequestParam double amount,
            @RequestParam String upiId,
            Model model) {

        try {
            // Validate showtime exists
            Showtime showtime = showtimeService.getShowtimeById(showtimeId);
            if (showtime == null) {
                model.addAttribute("error", "Invalid showtime. Please try again.");
                return "redirect:/showtimes";
            }

            // Validate UPI ID format
            if (upiId == null || !upiId.matches("[a-zA-Z0-9\\.\\-_]{3,50}@[a-zA-Z][a-zA-Z]{2,}")) {
                model.addAttribute("error", "Invalid UPI ID format.");
                return "redirect:/payments/create?showtimeId=" + showtimeId + "&seats=" + seats;
            }

            // Process payment
            Payment payment = paymentService.processUPIPayment(
                showtimeId, amount, upiId
            );

            if (payment != null) {
                // Parse seats to book them
                List<int[]> seatPositions = parseSeatPositions(seats);
                if (!seatPositions.isEmpty()) {
                    showtimeService.bookSeats(showtimeId, seatPositions);
                }

                model.addAttribute("payment", payment);
                model.addAttribute("paymentMethod", "UPI");
                model.addAttribute("seats", seats);
                return "payments/confirmation";
            } else {
                model.addAttribute("error", "Payment processing failed. Please try again.");
                return "redirect:/payments/create?showtimeId=" + showtimeId + "&seats=" + seats;
            }
        } catch (Exception e) {
            model.addAttribute("error", "An error occurred during payment processing: " + e.getMessage());
            return "redirect:/payments/create?showtimeId=" + showtimeId + "&seats=" + seats;
        }
    }

    // Helper method to parse seat positions from string
    private List<int[]> parseSeatPositions(String seats) {
        List<int[]> seatPositions = new ArrayList<>();
        if (seats != null && !seats.isEmpty()) {
            String[] seatArray = seats.split(",");
            for (String seat : seatArray) {
                String[] parts = seat.split("-");
                if (parts.length == 2) {
                    try {
                        int row = Integer.parseInt(parts[0]);
                        int col = Integer.parseInt(parts[1]);
                        seatPositions.add(new int[]{row, col});
                    } catch (NumberFormatException e) {
                        // Skip invalid seat format
                    }
                }
            }
        }
        return seatPositions;
    }

    // Display payment confirmation
    @GetMapping("/confirmation/{transactionId}")
    public String showConfirmation(@PathVariable String transactionId, Model model) {
        Payment payment = paymentService.getPaymentByTransactionId(transactionId);
        if (payment == null) {
            return "redirect:/";
        }

        model.addAttribute("payment", payment);
        model.addAttribute("paymentMethod", payment.getPaymentType());

        return "payments/confirmation";
    }

    // Display all payments (admin view)
    @GetMapping
    public String getAllPayments(Model model) {
        model.addAttribute("payments", paymentService.getAllPayments());
        return "payments/list";
    }
}
