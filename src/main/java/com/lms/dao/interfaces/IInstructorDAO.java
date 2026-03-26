package com.lms.dao.interfaces;

import com.lms.model.Instructor;
import java.util.List;
import java.util.Optional;

public interface IInstructorDAO {

    // Register a new instructor
    int register(Instructor instructor);

    // Find instructor by email — used during login
    Optional<Instructor> findByEmail(String email);

    // Find instructor by ID
    Optional<Instructor> findById(int instructorId);

    // Get all instructors — used by admin
    List<Instructor> findAll();

    // Update instructor details
    boolean update(Instructor instructor);

    // Delete instructor by ID
    boolean delete(int instructorId);
}