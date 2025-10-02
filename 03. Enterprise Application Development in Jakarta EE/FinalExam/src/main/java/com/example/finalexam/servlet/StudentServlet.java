package com.example.finalexam.servlet;

import com.example.finalexam.dao.StudentDAO;
import com.example.finalexam.entity.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/student")
public class StudentServlet extends HttpServlet {

    private final StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Student> students = studentDAO.getAllStudents();
        request.setAttribute("students", students);
        request.getRequestDispatcher("/WEB-INF/views/studentList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            switch (action) {
                case "add" -> addStudent(request, response);
                case "edit" -> editStudent(request, response);
                case "delete" -> deleteStudent(request, response);
                default -> response.sendRedirect(request.getContextPath() + "/student");
            }
        } catch (SQLException e) {
            throw new ServletException("Error processing student action", e);
        }
    }

    private void addStudent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String code = request.getParameter("studentCode");
        String name = request.getParameter("fullName");
        String address = request.getParameter("address");

        Student student = new Student(code, name, address);
        studentDAO.insertStudent(student);
        response.sendRedirect(request.getContextPath() + "/student");
    }

    private void editStudent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("studentId"));
        String code = request.getParameter("studentCode");
        String name = request.getParameter("fullName");
        String address = request.getParameter("address");

        Student student = new Student(code, name, address);
        student.setStudentId(id);
        studentDAO.updateStudent(student);
        response.sendRedirect(request.getContextPath() + "/student");
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("studentId"));
        studentDAO.deleteStudent(id);
        response.sendRedirect(request.getContextPath() + "/student");
    }
}
