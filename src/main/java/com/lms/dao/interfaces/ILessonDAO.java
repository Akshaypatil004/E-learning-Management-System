package com.lms.dao.interfaces;

import com.lms.model.Lesson;
import java.util.List;
import java.util.Optional;

public interface ILessonDAO {

    // Add a new lesson to a course — returns generated lesson ID
    int create(Lesson lesson);

    // Find lesson by ID
    Optional<Lesson> findById(int lessonId);

    // Get all lessons for a course — ordered by lesson_order
    List<Lesson> findByCourse(int courseId);

    // Update lesson details
    boolean update(Lesson lesson);

    // Delete lesson by ID
    boolean delete(int lessonId);
}