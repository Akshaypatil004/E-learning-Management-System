package com.lms.dao.interfaces;

import com.lms.model.Enrollment;
import java.util.List;

public interface IEnrollmentDAO {

    // Enroll a student in a course — returns generated enrollment ID
    int enroll(Enrollment enrollment);

    // Check if a student is already enrolled in a course
    boolean isEnrolled(int studentId, int courseId);

    // Get all enrollments for a student — used in student dashboard
    List<Enrollment> findByStudent(int studentId);

    // Get all enrollments for a course — used by instructor
    List<Enrollment> findByCourse(int courseId);

    // Unenroll a student from a course
    boolean unenroll(int studentId, int courseId);
}