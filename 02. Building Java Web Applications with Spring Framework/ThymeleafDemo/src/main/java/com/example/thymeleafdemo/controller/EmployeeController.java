package com.example.thymeleafdemo.controller;

import com.example.thymeleafdemo.model.Employee;
import jakarta.annotation.PostConstruct;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Arrays;
import java.util.List;

@Controller
@SpringBootApplication
@RequestMapping("/employees")
public class EmployeeController {

    private List<Employee> employees;

    @PostConstruct
    private void loadData() {
        Employee emp1 = new Employee(1, "John", "Doe", "johndoe@123.com");
        Employee emp2 = new Employee(2, "Jake", "Moe", "jakemoe@123.com");
        Employee emp3 = new Employee(3, "Joe", "Tim", "joetim@123.com");

        employees = Arrays.asList(emp1, emp2, emp3);
    }

    @GetMapping("/list")
    public String listEmployees(Model model) {
        model.addAttribute("employees", employees);

        return "list_employees";
    }

}
