package com.lms.model;

import java.time.LocalDateTime;
import java.util.Optional;

public class Student {

    private int studentId;
    private String name;
    private String email;
    private String password;
    private LocalDateTime createdAt;

    // ─── Constructors ─────────────────────────────────────────

    public Student() {
    }

    public Student(int studentId, String name, String email,
            String password, LocalDateTime createdAt) {
        this.studentId = studentId;
        this.name = name;
        this.email = email;
        this.password = password;
        this.createdAt = createdAt;
    }

    // Constructor without ID — used when registering a new student
    public Student(String name, String email, String password) {
        this.name = name;
        this.email = email;
        this.password = password;
    }

    // ─── Getters ──────────────────────────────────────────────

    public int getStudentId() {
        return studentId;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public Optional<LocalDateTime> getCreatedAt() {
        return Optional.ofNullable(createdAt);
    }

    // ─── Setters ──────────────────────────────────────────────

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    // ─── toString ─────────────────────────────────────────────

    @Override
    public String toString() {
        return "Student{" +
                "studentId=" + studentId +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
}