package com.example.finalexam.entity;

public class Subject {
    private int subjectId;
    private String subjectCode;
    private String subjectName;
    private int credit;

    public Subject() {}

    public Subject(String subjectCode, String subjectName, int credit) {
        this.subjectCode = subjectCode;
        this.subjectName = subjectName;
        this.credit = credit;
    }

    // Getters & Setters
    public int getSubjectId() { return subjectId; }
    public void setSubjectId(int subjectId) { this.subjectId = subjectId; }

    public String getSubjectCode() { return subjectCode; }
    public void setSubjectCode(String subjectCode) { this.subjectCode = subjectCode; }

    public String getSubjectName() { return subjectName; }
    public void setSubjectName(String subjectName) { this.subjectName = subjectName; }

    public int getCredit() { return credit; }
    public void setCredit(int credit) { this.credit = credit; }
}
