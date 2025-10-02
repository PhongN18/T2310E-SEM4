package com.example.finalexam.dao;

import com.example.finalexam.entity.Student;
import com.example.finalexam.entity.StudentScore;
import com.example.finalexam.entity.Subject;
import com.example.finalexam.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentScoreDAO {

    public void insertScore(StudentScore score) {
        String sql = "INSERT INTO student_score_t (student_id, subject_id, score1, score2) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, score.getStudentId());
            ps.setInt(2, score.getSubjectId());
            ps.setDouble(3, score.getScore1());
            ps.setDouble(4, score.getScore2());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<StudentScore> getScoresByStudent(int studentId) {
        List<StudentScore> list = new ArrayList<>();
        String sql = "SELECT * FROM student_score_t WHERE student_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                StudentScore sc = new StudentScore();
                sc.setStudentScoreId(rs.getInt("student_score_id"));
                sc.setStudentId(rs.getInt("student_id"));
                sc.setSubjectId(rs.getInt("subject_id"));
                sc.setScore1(rs.getDouble("score1"));
                sc.setScore2(rs.getDouble("score2"));
                list.add(sc);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<StudentScore> getAllScoresWithDetails() throws SQLException {
        List<StudentScore> scores = new ArrayList<>();
        String sql = """
        SELECT sc.student_score_id, sc.student_id, sc.subject_id, sc.score1, sc.score2,
               st.student_code, st.full_name, st.address,
               sub.subject_code, sub.subject_name, sub.credit
        FROM student_score_t sc
        JOIN student_t st ON sc.student_id = st.student_id
        JOIN subject_t sub ON sc.subject_id = sub.subject_id
        """;

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                StudentScore score = new StudentScore();
                score.setStudentScoreId(rs.getInt("student_score_id"));
                score.setStudentId(rs.getInt("student_id"));
                score.setSubjectId(rs.getInt("subject_id"));
                score.setScore1(rs.getDouble("score1"));
                score.setScore2(rs.getDouble("score2"));

                // Build Student object
                Student student = new Student();
                student.setStudentId(rs.getInt("student_id"));
                student.setStudentCode(rs.getString("student_code"));
                student.setFullName(rs.getString("full_name"));
                student.setAddress(rs.getString("address"));
                score.setStudent(student);

                // Build Subject object
                Subject subject = new Subject();
                subject.setSubjectId(rs.getInt("subject_id"));
                subject.setSubjectCode(rs.getString("subject_code"));
                subject.setSubjectName(rs.getString("subject_name"));
                subject.setCredit(rs.getInt("credit"));
                score.setSubject(subject);

                scores.add(score);
            }
        }
        return scores;
    }

    public void updateScore(StudentScore score) throws SQLException {
        String sql = "UPDATE student_score_t SET student_id=?, subject_id=?, score1=?, score2=? WHERE student_score_id=?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, score.getStudentId());
            ps.setInt(2, score.getSubjectId());
            ps.setDouble(3, score.getScore1());
            ps.setDouble(4, score.getScore2());
            ps.setInt(5, score.getStudentScoreId());
            ps.executeUpdate();
        }
    }

    public void deleteScore(int scoreId) throws SQLException {
        String sql = "DELETE FROM student_score_t WHERE student_score_id=?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, scoreId);
            ps.executeUpdate();
        }
    }

}
