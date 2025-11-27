package org.example.finalexam.controller;

import org.example.finalexam.model.Place;
import org.example.finalexam.repository.PlaceRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*") // tạm mở cho Flutter, sau có thể giới hạn domain
public class PlaceController {

    private final PlaceRepository placeRepository;

    public PlaceController(PlaceRepository placeRepository) {
        this.placeRepository = placeRepository;
    }

    // getAllPlace
    @GetMapping("/places")
    public List<Place> getAllPlace() {
        return placeRepository.findAll();
    }
}

