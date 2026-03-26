package com.lms.model;

import java.time.LocalDateTime;
import java.util.Optional;

public class Course {

    private int courseId;
    private String title;
    private String description;
    private int instructorId;
    private LocalDateTime createdAt;

    // ─── Constructors ─────────────────────────────────────────

    public Course() {
    }

    public Course(int courseId, String title, String description,
            int instructorId, LocalDateTime createdAt) {
        this.courseId = courseId;
        this.title = title;
        this.description = description;
        this.instructorId = instructorId;
        this.createdAt = createdAt;
    }

    // Constructor without ID — used when creating a new course
    public Course(String title, String description, int instructorId) {
        this.title = title;
        this.description = description;
        this.instructorId = instructorId;
    }

    // ─── Getters ──────────────────────────────────────────────

    public int getCourseId() {
        return courseId;
    }

    public String getTitle() {
        return title;
    }

    public Optional<String> getDescription() {
        return Optional.ofNullable(description);
    }

    public int getInstructorId() {
        return instructorId;
    }

    public Optional<LocalDateTime> getCreatedAt() {
        return Optional.ofNullable(createdAt);
    }

    // ─── Setters ──────────────────────────────────────────────

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setInstructorId(int instructorId) {
        this.instructorId = instructorId;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    // ─── toString ─────────────────────────────────────────────

    @Override
    public String toString() {
        return "Course{" +
                "courseId=" + courseId +
                ", title='" + title + '\'' +
                ", instructorId=" + instructorId +
                '}';
    }
}