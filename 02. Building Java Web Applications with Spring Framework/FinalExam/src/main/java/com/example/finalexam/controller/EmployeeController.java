package com.example.finalexam.controller;
import com.example.finalexam.entity.Employee;
import com.example.finalexam.repository.EmployeeRepository;

import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/employees")
public class EmployeeController {
    private final EmployeeRepository repository;

    public EmployeeController(EmployeeRepository repository) {
        this.repository = repository;
    }

    // Redirect root
    @GetMapping("/")
    public String root() {
        return "redirect:/employees";
    }

    // List employees + search
    @GetMapping
    public String list(@RequestParam(value = "q", required = false) String q, Model model) {
        List<Employee> employees = (q == null || q.isBlank())
                ? repository.findAll()
                : repository.findByFirstNameContainingIgnoreCaseOrLastNameContainingIgnoreCaseOrEmailContainingIgnoreCaseOrPositionContainingIgnoreCase(q, q, q, q);
        model.addAttribute("employees", employees);
        model.addAttribute("q", q == null ? "" : q);
        return "employees/list";
    }

    // Show create form
    @GetMapping("/new")
    public String createForm(Model model) {
        model.addAttribute("employee", new Employee());
        model.addAttribute("mode", "create");
        return "employees/form";
    }

    // Handle create
    @PostMapping
    public String create(@Valid @ModelAttribute("employee") Employee employee,
                         BindingResult bindingResult,
                         RedirectAttributes ra) {
        if (bindingResult.hasErrors()) {
            return "employees/form";
        }
        repository.save(employee);
        ra.addFlashAttribute("success", "Employee created successfully");
        return "redirect:/employees";
    }

    // Show edit form
    @GetMapping("/{id}/edit")
    public String editForm(@PathVariable Long id, Model model) throws Throwable {
        Employee emp = (Employee) repository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid id: " + id));
        model.addAttribute("employee", emp);
        model.addAttribute("mode", "edit");
        return "employees/form";
    }

    // Handle update
    @PutMapping("/{id}")
    public String update(@PathVariable Long id,
                         @Valid @ModelAttribute("employee") Employee employee,
                         BindingResult bindingResult,
                         RedirectAttributes ra) {
        if (bindingResult.hasErrors()) {
            return "employees/form";
        }
        employee.setId(id);
        repository.save(employee);
        ra.addFlashAttribute("success", "Employee updated successfully");
        return "redirect:/employees";
    }

    // Delete employee
    @DeleteMapping("/{id}")
    public String delete(@PathVariable Long id, RedirectAttributes ra) {
        repository.deleteById(id);
        ra.addFlashAttribute("success", "Employee deleted");
        return "redirect:/employees";
    }

    // View employee details
    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) throws Throwable {
        Employee emp = (Employee) repository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid id: " + id));
        model.addAttribute("employee", emp);
        return "employees/detail";
    }
}
