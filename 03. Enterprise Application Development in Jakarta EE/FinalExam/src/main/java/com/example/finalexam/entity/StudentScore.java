package com.example.finalexam.entity;

public class StudentScore {
    private int studentScoreId;
    private int studentId;
    private int subjectId;
    private double score1;
    private double score2;
    private Student student;
    private Subject subject;

    public StudentScore() {}

    public StudentScore(int studentId, int subjectId, double score1, double score2) {
        this.studentId = studentId;
        this.subjectId = subjectId;
        this.score1 = score1;
        this.score2 = score2;
    }

    public Student getStudent() { return student; }
    public void setStudent(Student student) { this.student = student; }

    public Subject getSubject() { return subject; }
    public void setSubject(Subject subject) { this.subject = subject; }

    // Getters & Setters
    public int getStudentScoreId() { return studentScoreId; }
    public void setStudentScoreId(int studentScoreId) { this.studentScoreId = studentScoreId; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public int getSubjectId() { return subjectId; }
    public void setSubjectId(int subjectId) { this.subjectId = subjectId; }

    public double getScore1() { return score1; }
    public void setScore1(double score1) { this.score1 = score1; }

    public double getScore2() { return score2; }
    public void setScore2(double score2) { this.score2 = score2; }

    public String getGrade() {
        double finalScore = 0.3 * score1 + 0.7 * score2;
        if (finalScore >= 8.0) return "A";
        else if (finalScore >= 6.0) return "B";
        else if (finalScore >= 4.0) return "D";
        else return "F";
    }
}
