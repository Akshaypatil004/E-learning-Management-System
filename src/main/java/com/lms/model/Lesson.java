package com.lms.model;

import java.util.Optional;

public class Lesson {

    private int lessonId;
    private int courseId;
    private String title;
    private String content;
    private int lessonOrder;

    // ─── Constructors ─────────────────────────────────────────

    public Lesson() {
    }

    public Lesson(int lessonId, int courseId, String title,
            String content, int lessonOrder) {
        this.lessonId = lessonId;
        this.courseId = courseId;
        this.title = title;
        this.content = content;
        this.lessonOrder = lessonOrder;
    }

    // Constructor without ID — used when creating a new lesson
    public Lesson(int courseId, String title, String content, int lessonOrder) {
        this.courseId = courseId;
        this.title = title;
        this.content = content;
        this.lessonOrder = lessonOrder;
    }

    // ─── Getters ──────────────────────────────────────────────

    public int getLessonId() {
        return lessonId;
    }

    public int getCourseId() {
        return courseId;
    }

    public String getTitle() {
        return title;
    }

    public Optional<String> getContent() {
        return Optional.ofNullable(content);
    }

    public int getLessonOrder() {
        return lessonOrder;
    }

    // ─── Setters ──────────────────────────────────────────────

    public void setLessonId(int lessonId) {
        this.lessonId = lessonId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setLessonOrder(int lessonOrder) {
        this.lessonOrder = lessonOrder;
    }

    // ─── toString ─────────────────────────────────────────────

    @Override
    public String toString() {
        return "Lesson{" +
                "lessonId=" + lessonId +
                ", courseId=" + courseId +
                ", title='" + title + '\'' +
                ", lessonOrder=" + lessonOrder +
                '}';
    }
}