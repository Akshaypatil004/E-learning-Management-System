package com.lms.dao.interfaces;

import com.lms.model.Student;
import java.util.List;
import java.util.Optional;

public interface IStudentDAO {

    // Register a new student — returns generated student ID
    int register(Student student);

    // Find student by email — used during login
    Optional<Student> findByEmail(String email);

    // Find student by ID — used in dashboard, profile
    Optional<Student> findById(int studentId);

    // Get all students — used by admin
    List<Student> findAll();

    // Update student details
    boolean update(Student student);

    // Delete student by ID
    boolean delete(int studentId);
}