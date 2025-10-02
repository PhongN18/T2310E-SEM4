package com.example.finalexam.servlet;

import com.example.finalexam.dao.StudentScoreDAO;
import com.example.finalexam.entity.StudentScore;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/")
public class HomeServlet extends HttpServlet {

    private final StudentScoreDAO scoreDAO = new StudentScoreDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<StudentScore> scores = scoreDAO.getAllScoresWithDetails();
            request.setAttribute("scores", scores);
            request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error loading dashboard", e);
        }
    }
}
