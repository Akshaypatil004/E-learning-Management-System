package com.lms.dao.interfaces;

import com.lms.model.Course;
import java.util.List;
import java.util.Optional;

public interface ICourseDAO {

    // Create a new course — returns generated course ID
    int create(Course course);

    // Find course by ID
    Optional<Course> findById(int courseId);

    // Get all courses — used in course listing page
    List<Course> findAll();

    // Get all courses by a specific instructor
    List<Course> findByInstructor(int instructorId);

    // Update course details
    boolean update(Course course);

    // Delete course by ID
    boolean delete(int courseId);
}