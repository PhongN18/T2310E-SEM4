package com.example.finalexam.servlet;

import com.example.finalexam.dao.StudentDAO;
import com.example.finalexam.dao.StudentScoreDAO;
import com.example.finalexam.dao.SubjectDAO;
import com.example.finalexam.entity.StudentScore;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/score")
public class ScoreServlet extends HttpServlet {

    private final StudentScoreDAO scoreDAO = new StudentScoreDAO();
    private final StudentDAO studentDAO = new StudentDAO();
    private final SubjectDAO subjectDAO = new SubjectDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<StudentScore> scores = scoreDAO.getAllScoresWithDetails();
            request.setAttribute("scores", scores);
            request.setAttribute("students", studentDAO.getAllStudents());
            request.setAttribute("subjects", subjectDAO.getAllSubjects());
            request.getRequestDispatcher("/WEB-INF/views/scoreList.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error loading scores", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            switch (action) {
                case "add" -> addScore(request, response);
                case "edit" -> editScore(request, response);
                case "delete" -> deleteScore(request, response);
                default -> response.sendRedirect(request.getContextPath() + "/score");
            }
        } catch (SQLException e) {
            throw new ServletException("Error processing score action", e);
        }
    }

    private void addScore(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int studentId = Integer.parseInt(request.getParameter("studentId"));
        int subjectId = Integer.parseInt(request.getParameter("subjectId"));
        double score1 = Double.parseDouble(request.getParameter("score1"));
        double score2 = Double.parseDouble(request.getParameter("score2"));

        StudentScore score = new StudentScore(studentId, subjectId, score1, score2);
        scoreDAO.insertScore(score);
        response.sendRedirect(request.getContextPath() + "/score");
    }

    private void editScore(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("scoreId"));
        int studentId = Integer.parseInt(request.getParameter("studentId"));
        int subjectId = Integer.parseInt(request.getParameter("subjectId"));
        double score1 = Double.parseDouble(request.getParameter("score1"));
        double score2 = Double.parseDouble(request.getParameter("score2"));

        StudentScore score = new StudentScore(studentId, subjectId, score1, score2);
        score.setStudentScoreId(id);
        scoreDAO.updateScore(score);
        response.sendRedirect(request.getContextPath() + "/score");
    }

    private void deleteScore(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("scoreId"));
        scoreDAO.deleteScore(id);
        response.sendRedirect(request.getContextPath() + "/score");
    }
}
