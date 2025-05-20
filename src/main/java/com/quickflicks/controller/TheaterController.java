package com.quickflicks.controller;

import com.quickflicks.model.Theater;
import com.quickflicks.service.ScreenService;
import com.quickflicks.service.TheaterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

/**
 * Controller for theater management.
 */
@Controller
@RequestMapping("/theaters")
public class TheaterController {

    @Autowired
    private TheaterService theaterService;
    
    @Autowired
    private ScreenService screenService;
    
    // Display all theaters
    @GetMapping
    public String getAllTheaters(Model model) {
        model.addAttribute("theaters", theaterService.getAllTheaters());
        return "theaters/list";
    }
    
    // Display theater creation form
    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("theater", new Theater());
        return "theaters/create";
    }
    
    // Handle theater creation
    @PostMapping("/create")
    public String createTheater(@ModelAttribute Theater theater) {
        theaterService.createTheater(theater);
        return "redirect:/theaters";
    }
    
    // Display theater details
    @GetMapping("/{id}")
    public String getTheaterDetails(@PathVariable String id, Model model) {
        Theater theater = theaterService.getTheaterById(id);
        if (theater == null) {
            return "redirect:/theaters";
        }
        
        model.addAttribute("theater", theater);
        model.addAttribute("screens", screenService.getScreensByTheaterId(id));
        return "theaters/details";
    }
    
    // Display theater edit form
    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable String id, Model model) {
        Theater theater = theaterService.getTheaterById(id);
        if (theater == null) {
            return "redirect:/theaters";
        }
        
        model.addAttribute("theater", theater);
        return "theaters/edit";
    }
    
    // Handle theater update
    @PostMapping("/{id}/edit")
    public String updateTheater(@PathVariable String id, @ModelAttribute Theater theater) {
        theater.setId(id);
        theaterService.updateTheater(theater);
        return "redirect:/theaters";
    }
    
    // Handle theater deletion
    @GetMapping("/{id}/delete")
    public String deleteTheater(@PathVariable String id) {
        // Delete all screens associated with this theater
        screenService.deleteScreensByTheaterId(id);
        
        // Delete the theater
        theaterService.deleteTheater(id);
        return "redirect:/theaters";
    }
}
