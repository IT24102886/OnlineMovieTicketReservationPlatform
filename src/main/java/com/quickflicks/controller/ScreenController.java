package com.quickflicks.controller;

import com.quickflicks.model.Screen;
import com.quickflicks.service.ScreenService;
import com.quickflicks.service.ShowtimeService;
import com.quickflicks.service.TheaterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

/**
 * Controller for screen management.
 */
@Controller
@RequestMapping("/screens")
public class ScreenController {

    @Autowired
    private ScreenService screenService;
    
    @Autowired
    private TheaterService theaterService;
    
    @Autowired
    private ShowtimeService showtimeService;
    
    // Display all screens
    @GetMapping
    public String getAllScreens(Model model) {
        model.addAttribute("screens", screenService.getAllScreens());
        model.addAttribute("theaters", theaterService.getAllTheaters());
        return "screens/list";
    }
    
    // Display screen creation form
    @GetMapping("/create")
    public String showCreateForm(@RequestParam(required = false) String theaterId, Model model) {
        Screen screen = new Screen();
        if (theaterId != null && !theaterId.isEmpty()) {
            screen.setTheaterId(theaterId);
        }
        
        model.addAttribute("screen", screen);
        model.addAttribute("theaters", theaterService.getAllTheaters());
        return "screens/create";
    }
    
    // Handle screen creation
    @PostMapping("/create")
    public String createScreen(@ModelAttribute Screen screen) {
        screenService.createScreen(screen);
        return "redirect:/theaters/" + screen.getTheaterId();
    }
    
    // Display screen details
    @GetMapping("/{id}")
    public String getScreenDetails(@PathVariable String id, Model model) {
        Screen screen = screenService.getScreenById(id);
        if (screen == null) {
            return "redirect:/screens";
        }
        
        model.addAttribute("screen", screen);
        model.addAttribute("theater", theaterService.getTheaterById(screen.getTheaterId()));
        model.addAttribute("showtimes", showtimeService.getShowtimesByScreenId(id));
        return "screens/details";
    }
    
    // Display screen edit form
    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable String id, Model model) {
        Screen screen = screenService.getScreenById(id);
        if (screen == null) {
            return "redirect:/screens";
        }
        
        model.addAttribute("screen", screen);
        model.addAttribute("theaters", theaterService.getAllTheaters());
        return "screens/edit";
    }
    
    // Handle screen update
    @PostMapping("/{id}/edit")
    public String updateScreen(@PathVariable String id, @ModelAttribute Screen screen) {
        screen.setId(id);
        screenService.updateScreen(screen);
        return "redirect:/screens/" + id;
    }
    
    // Handle screen deletion
    @GetMapping("/{id}/delete")
    public String deleteScreen(@PathVariable String id) {
        Screen screen = screenService.getScreenById(id);
        if (screen == null) {
            return "redirect:/screens";
        }
        
        String theaterId = screen.getTheaterId();
        
        // Delete all showtimes associated with this screen
        showtimeService.deleteShowtimesByScreenId(id);
        
        // Delete the screen
        screenService.deleteScreen(id);
        
        return "redirect:/theaters/" + theaterId;
    }
}
