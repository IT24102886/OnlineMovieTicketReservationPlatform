package com.quickflicks.controller;

import com.quickflicks.model.Screen;
import com.quickflicks.model.Showtime;
import com.quickflicks.service.ScreenService;
import com.quickflicks.service.ShowtimeService;
import com.quickflicks.service.TheaterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Controller for showtime management.
 */
@Controller
@RequestMapping("/showtimes")
public class ShowtimeController {

    @Autowired
    private ShowtimeService showtimeService;

    @Autowired
    private ScreenService screenService;

    @Autowired
    private TheaterService theaterService;

    // Display all showtimes
    @GetMapping
    public String getAllShowtimes(Model model) {
        model.addAttribute("showtimes", showtimeService.getAllShowtimes());
        model.addAttribute("screens", screenService.getAllScreens());
        return "showtimes/list";
    }

    // Display showtime creation form
    @GetMapping("/create")
    public String showCreateForm(@RequestParam(required = false) String screenId, Model model) {
        model.addAttribute("screenId", screenId);
        model.addAttribute("screens", screenService.getAllScreens());
        return "showtimes/create";
    }

    // Handle showtime creation
    @PostMapping("/create")
    public String createShowtime(
            @RequestParam String screenId,
            @RequestParam String movieTitle,
            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm") LocalDateTime startTime,
            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm") LocalDateTime endTime,
            @RequestParam double ticketPrice,
            @RequestParam int rows,
            @RequestParam int cols) {

        Showtime showtime = new Showtime(null, screenId, movieTitle, startTime, endTime, ticketPrice, rows, cols);
        showtimeService.createShowtime(showtime);

        return "redirect:/screens/" + screenId;
    }

    // Display showtime details
    @GetMapping("/{id}")
    public String getShowtimeDetails(@PathVariable String id, Model model) {
        Showtime showtime = showtimeService.getShowtimeById(id);
        if (showtime == null) {
            return "redirect:/showtimes";
        }

        Screen screen = screenService.getScreenById(showtime.getScreenId());

        model.addAttribute("showtime", showtime);
        model.addAttribute("screen", screen);
        model.addAttribute("theater", theaterService.getTheaterById(screen.getTheaterId()));

        return "showtimes/details";
    }

    // Display seat selection page
    @GetMapping("/{id}/seats")
    public String showSeatSelection(@PathVariable String id, Model model) {
        Showtime showtime = showtimeService.getShowtimeById(id);
        if (showtime == null) {
            return "redirect:/showtimes";
        }

        model.addAttribute("showtime", showtime);
        return "showtimes/seats";
    }

    // Handle seat booking
    @PostMapping("/{id}/book")
    public String bookSeats(
            @PathVariable String id,
            @RequestParam("seats") List<String> selectedSeats,
            Model model) {

        try {
            // Validate showtime exists
            Showtime showtime = showtimeService.getShowtimeById(id);
            if (showtime == null) {
                model.addAttribute("error", "Showtime not found.");
                return "redirect:/showtimes";
            }

            // Validate seats are selected
            if (selectedSeats == null || selectedSeats.isEmpty()) {
                model.addAttribute("error", "Please select at least one seat.");
                return "redirect:/showtimes/" + id + "/seats";
            }

            // Parse seat positions
            List<int[]> seats = new ArrayList<>();
            for (String seat : selectedSeats) {
                String[] parts = seat.split("-");
                if (parts.length == 2) {
                    try {
                        int row = Integer.parseInt(parts[0]);
                        int col = Integer.parseInt(parts[1]);
                        seats.add(new int[]{row, col});
                    } catch (NumberFormatException e) {
                        model.addAttribute("error", "Invalid seat format.");
                        return "redirect:/showtimes/" + id + "/seats";
                    }
                }
            }

            // Check if seats are available (we don't book them yet - that happens after payment)
            if (!showtimeService.areSeatsAvailable(id, seats)) {
                model.addAttribute("error", "One or more selected seats are no longer available. Please select different seats.");
                return "redirect:/showtimes/" + id + "/seats";
            }

            // Proceed to payment
            return "redirect:/payments/create?showtimeId=" + id + "&seats=" + String.join(",", selectedSeats);
        } catch (Exception e) {
            model.addAttribute("error", "An error occurred: " + e.getMessage());
            return "redirect:/showtimes/" + id + "/seats";
        }
    }

    // Display showtime edit form
    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable String id, Model model) {
        Showtime showtime = showtimeService.getShowtimeById(id);
        if (showtime == null) {
            return "redirect:/showtimes";
        }

        model.addAttribute("showtime", showtime);
        model.addAttribute("screens", screenService.getAllScreens());
        return "showtimes/edit";
    }

    // Handle showtime update
    @PostMapping("/{id}/edit")
    public String updateShowtime(
            @PathVariable String id,
            @RequestParam String screenId,
            @RequestParam String movieTitle,
            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm") LocalDateTime startTime,
            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm") LocalDateTime endTime,
            @RequestParam double ticketPrice) {

        Showtime showtime = showtimeService.getShowtimeById(id);
        if (showtime == null) {
            return "redirect:/showtimes";
        }

        showtime.setScreenId(screenId);
        showtime.setMovieTitle(movieTitle);
        showtime.setStartTime(startTime);
        showtime.setEndTime(endTime);
        showtime.setTicketPrice(ticketPrice);

        showtimeService.updateShowtime(showtime);

        return "redirect:/showtimes/" + id;
    }

    // Handle showtime deletion
    @GetMapping("/{id}/delete")
    public String deleteShowtime(@PathVariable String id) {
        Showtime showtime = showtimeService.getShowtimeById(id);
        if (showtime == null) {
            return "redirect:/showtimes";
        }

        String screenId = showtime.getScreenId();

        showtimeService.deleteShowtime(id);

        return "redirect:/screens/" + screenId;
    }
}
