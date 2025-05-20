package com.quickflicks.controller;

import com.quickflicks.service.ShowtimeService;
import com.quickflicks.service.TheaterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * Controller for the home page.
 */
@Controller
public class HomeController {

    @Autowired
    private TheaterService theaterService;
    
    @Autowired
    private ShowtimeService showtimeService;
    
    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("theaters", theaterService.getAllTheaters());
        model.addAttribute("showtimes", showtimeService.getAllShowtimes());
        return "home";
    }
}
