package com.lms.model;

import java.time.LocalDateTime;
import java.util.Optional;

public class Enrollment {

    private int enrollmentId;
    private int studentId;
    private int courseId;
    private LocalDateTime enrolledAt;

    // ─── Constructors ─────────────────────────────────────────

    public Enrollment() {
    }

    public Enrollment(int enrollmentId, int studentId,
            int courseId, LocalDateTime enrolledAt) {
        this.enrollmentId = enrollmentId;
        this.studentId = studentId;
        this.courseId = courseId;
        this.enrolledAt = enrolledAt;
    }

    // Constructor without ID — used when enrolling a student
    public Enrollment(int studentId, int courseId) {
        this.studentId = studentId;
        this.courseId = courseId;
    }

    // ─── Getters ──────────────────────────────────────────────

    public int getEnrollmentId() {
        return enrollmentId;
    }

    public int getStudentId() {
        return studentId;
    }

    public int getCourseId() {
        return courseId;
    }

    public Optional<LocalDateTime> getEnrolledAt() {
        return Optional.ofNullable(enrolledAt);
    }

    // ─── Setters ──────────────────────────────────────────────

    public void setEnrollmentId(int enrollmentId) {
        this.enrollmentId = enrollmentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public void setEnrolledAt(LocalDateTime enrolledAt) {
        this.enrolledAt = enrolledAt;
    }

    // ─── toString ─────────────────────────────────────────────

    @Override
    public String toString() {
        return "Enrollment{" +
                "enrollmentId=" + enrollmentId +
                ", studentId=" + studentId +
                ", courseId=" + courseId +
                '}';
    }
}