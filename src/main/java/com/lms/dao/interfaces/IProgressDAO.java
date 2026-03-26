package com.lms.dao.interfaces;

import com.lms.model.Progress;
import java.util.List;
import java.util.Optional;

public interface IProgressDAO {

    // Create a progress record when student starts a lesson
    int create(Progress progress);

    // Mark a lesson as completed
    boolean markComplete(int studentId, int lessonId);

    // Get progress for a specific student and lesson
    Optional<Progress> findByStudentAndLesson(int studentId, int lessonId);

    // Get all progress records for a student across a course
    List<Progress> findByStudentAndCourse(int studentId, int courseId);

    // Count how many lessons a student completed in a course
    int countCompleted(int studentId, int courseId);
}