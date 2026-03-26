package com.lms.model;

import java.time.LocalDateTime;
import java.util.Optional;

public class Progress {

    private int progressId;
    private int studentId;
    private int lessonId;
    private boolean completed;
    private LocalDateTime completedAt;

    // ─── Constructors ─────────────────────────────────────────

    public Progress() {
    }

    public Progress(int progressId, int studentId, int lessonId,
            boolean completed, LocalDateTime completedAt) {
        this.progressId = progressId;
        this.studentId = studentId;
        this.lessonId = lessonId;
        this.completed = completed;
        this.completedAt = completedAt;
    }

    // Constructor without ID — used when tracking a new lesson start
    public Progress(int studentId, int lessonId) {
        this.studentId = studentId;
        this.lessonId = lessonId;
        this.completed = false;
    }

    // ─── Getters ──────────────────────────────────────────────

    public int getProgressId() {
        return progressId;
    }

    public int getStudentId() {
        return studentId;
    }

    public int getLessonId() {
        return lessonId;
    }

    public boolean isCompleted() {
        return completed;
    }

    public Optional<LocalDateTime> getCompletedAt() {
        return Optional.ofNullable(completedAt);
    }

    // ─── Setters ──────────────────────────────────────────────

    public void setProgressId(int progressId) {
        this.progressId = progressId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public void setLessonId(int lessonId) {
        this.lessonId = lessonId;
    }

    public void setCompleted(boolean completed) {
        this.completed = completed;
    }

    public void setCompletedAt(LocalDateTime completedAt) {
        this.completedAt = completedAt;
    }

    // ─── toString ─────────────────────────────────────────────

    @Override
    public String toString() {
        return "Progress{" +
                "progressId=" + progressId +
                ", studentId=" + studentId +
                ", lessonId=" + lessonId +
                ", completed=" + completed +
                '}';
    }
}