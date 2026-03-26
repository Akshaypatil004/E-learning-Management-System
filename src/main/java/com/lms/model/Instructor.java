package com.lms.model;

import java.time.LocalDateTime;
import java.util.Optional;

public class Instructor {

    private int instructorId;
    private String name;
    private String email;
    private String password;
    private LocalDateTime createdAt;

    // ─── Constructors ─────────────────────────────────────────

    public Instructor() {
    }

    public Instructor(int instructorId, String name, String email,
            String password, LocalDateTime createdAt) {
        this.instructorId = instructorId;
        this.name = name;
        this.email = email;
        this.password = password;
        this.createdAt = createdAt;
    }

    // Constructor without ID — used when creating a new instructor
    public Instructor(String name, String email, String password) {
        this.name = name;
        this.email = email;
        this.password = password;
    }

    // ─── Getters ──────────────────────────────────────────────

    public int getInstructorId() {
        return instructorId;
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

    public void setInstructorId(int instructorId) {
        this.instructorId = instructorId;
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
        return "Instructor{" +
                "instructorId=" + instructorId +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
}