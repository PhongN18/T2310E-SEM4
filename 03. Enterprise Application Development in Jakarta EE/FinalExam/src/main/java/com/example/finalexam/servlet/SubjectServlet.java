package com.example.finalexam.servlet;

import com.example.finalexam.dao.SubjectDAO;
import com.example.finalexam.entity.Subject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/subject")
public class SubjectServlet extends HttpServlet {

    private final SubjectDAO subjectDAO = new SubjectDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Subject> subjects = subjectDAO.getAllSubjects();
            request.setAttribute("subjects", subjects);
            request.getRequestDispatcher("/WEB-INF/views/subjectList.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error loading subjects", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            switch (action) {
                case "add" -> addSubject(request, response);
                case "edit" -> editSubject(request, response);
                case "delete" -> deleteSubject(request, response);
                default -> response.sendRedirect(request.getContextPath() + "/subject");
            }
        } catch (SQLException e) {
            throw new ServletException("Error processing subject action", e);
        }
    }

    private void addSubject(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String code = request.getParameter("subjectCode");
        String name = request.getParameter("subjectName");
        int credit = Integer.parseInt(request.getParameter("credit"));

        Subject subject = new Subject(code, name, credit);
        subjectDAO.insertSubject(subject);
        response.sendRedirect(request.getContextPath() + "/subject");
    }

    private void editSubject(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("subjectId"));
        String code = request.getParameter("subjectCode");
        String name = request.getParameter("subjectName");
        int credit = Integer.parseInt(request.getParameter("credit"));

        Subject subject = new Subject(code, name, credit);
        subject.setSubjectId(id);
        subjectDAO.updateSubject(subject);
        response.sendRedirect(request.getContextPath() + "/subject");
    }

    private void deleteSubject(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("subjectId"));
        subjectDAO.deleteSubject(id);
        response.sendRedirect(request.getContextPath() + "/subject");
    }
}
