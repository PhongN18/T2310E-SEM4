package com.example.finalexam.dao;

import com.example.finalexam.entity.Subject;
import com.example.finalexam.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SubjectDAO {

    public void insertSubject(Subject subject) throws SQLException {
        String sql = "INSERT INTO subject_t (subject_code, subject_name, credit) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, subject.getSubjectCode());
            ps.setString(2, subject.getSubjectName());
            ps.setInt(3, subject.getCredit());
            ps.executeUpdate();
        }
    }

    public List<Subject> getAllSubjects() throws SQLException {
        List<Subject> subjects = new ArrayList<>();
        String sql = "SELECT * FROM subject_t";
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Subject subject = new Subject();
                subject.setSubjectId(rs.getInt("subject_id"));
                subject.setSubjectCode(rs.getString("subject_code"));
                subject.setSubjectName(rs.getString("subject_name"));
                subject.setCredit(rs.getInt("credit"));
                subjects.add(subject);
            }
        }
        return subjects;
    }

    public Subject getSubjectById(int subjectId) throws SQLException {
        String sql = "SELECT * FROM subject_t WHERE subject_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, subjectId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Subject subject = new Subject();
                subject.setSubjectId(rs.getInt("subject_id"));
                subject.setSubjectCode(rs.getString("subject_code"));
                subject.setSubjectName(rs.getString("subject_name"));
                subject.setCredit(rs.getInt("credit"));
                return subject;
            }
        }
        return null;
    }

    public void updateSubject(Subject subject) throws SQLException {
        String sql = "UPDATE subject_t SET subject_code=?, subject_name=?, credit=? WHERE subject_id=?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, subject.getSubjectCode());
            ps.setString(2, subject.getSubjectName());
            ps.setInt(3, subject.getCredit());
            ps.setInt(4, subject.getSubjectId());
            ps.executeUpdate();
        }
    }

    public void deleteSubject(int subjectId) throws SQLException {
        String sql = "DELETE FROM subject_t WHERE subject_id=?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, subjectId);
            ps.executeUpdate();
        }
    }
}
