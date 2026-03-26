package com.lms.dao;

import com.lms.dao.interfaces.IStudentDAO;
import com.lms.model.Student;
import com.lms.util.DBConnectionPool;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class StudentDAO implements IStudentDAO {

    // ─── SQL Constants ────────────────────────────────────────
    private static final String INSERT_STUDENT =
        "INSERT INTO students (name, email, password) VALUES (?, ?, ?)";

    private static final String FIND_BY_EMAIL =
        "SELECT * FROM students WHERE email = ?";

    private static final String FIND_BY_ID =
        "SELECT * FROM students WHERE student_id = ?";

    private static final String FIND_ALL =
        "SELECT * FROM students";

    private static final String UPDATE_STUDENT =
        "UPDATE students SET name = ?, email = ? WHERE student_id = ?";

    private static final String DELETE_STUDENT =
        "DELETE FROM students WHERE student_id = ?";

    // ─── Methods ──────────────────────────────────────────────

    @Override
    public int register(Student student) {
        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(
                 INSERT_STUDENT, new String[]{"student_id"})) {

            ps.setString(1, student.getName());
            ps.setString(2, student.getEmail());
            ps.setString(3, student.getPassword());
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error registering student", e);
        }
        return -1;
    }

    @Override
    public Optional<Student> findByEmail(String email) {
        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(FIND_BY_EMAIL)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapRow(rs));
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error finding student by email", e);
        }
        return Optional.empty();
    }

    @Override
    public Optional<Student> findById(int studentId) {
        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(FIND_BY_ID)) {

            ps.setInt(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapRow(rs));
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error finding student by ID", e);
        }
        return Optional.empty();
    }

    @Override
    public List<Student> findAll() {
        List<Student> students = new ArrayList<>();

        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(FIND_ALL);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                students.add(mapRow(rs));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error fetching all students", e);
        }
        return students;
    }

    @Override
    public boolean update(Student student) {
        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_STUDENT)) {

            ps.setString(1, student.getName());
            ps.setString(2, student.getEmail());
            ps.setInt(3, student.getStudentId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Error updating student", e);
        }
    }

    @Override
    public boolean delete(int studentId) {
        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(DELETE_STUDENT)) {

            ps.setInt(1, studentId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Error deleting student", e);
        }
    }

    // ─── Row Mapper ───────────────────────────────────────────
    private Student mapRow(ResultSet rs) throws SQLException {
        Student student = new Student();
        student.setStudentId(rs.getInt("student_id"));
        student.setName(rs.getString("name"));
        student.setEmail(rs.getString("email"));
        student.setPassword(rs.getString("password"));

        Timestamp ts = rs.getTimestamp("created_at");
        if (ts != null) {
            student.setCreatedAt(ts.toLocalDateTime());
        }
        return student;
    }
}