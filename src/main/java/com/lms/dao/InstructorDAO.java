package com.lms.dao;

import com.lms.dao.interfaces.IInstructorDAO;
import com.lms.model.Instructor;
import com.lms.util.DBConnectionPool;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class InstructorDAO implements IInstructorDAO {

    // ─── SQL Constants ────────────────────────────────────────
    private static final String INSERT_INSTRUCTOR =
        "INSERT INTO instructors (name, email, password) VALUES (?, ?, ?)";

    private static final String FIND_BY_EMAIL =
        "SELECT * FROM instructors WHERE email = ?";

    private static final String FIND_BY_ID =
        "SELECT * FROM instructors WHERE instructor_id = ?";

    private static final String FIND_ALL =
        "SELECT * FROM instructors";

    private static final String UPDATE_INSTRUCTOR =
        "UPDATE instructors SET name = ?, email = ? WHERE instructor_id = ?";

    private static final String DELETE_INSTRUCTOR =
        "DELETE FROM instructors WHERE instructor_id = ?";

    // ─── Methods ──────────────────────────────────────────────

    @Override
    public int register(Instructor instructor) {
        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(
                 INSERT_INSTRUCTOR, new String[]{"instructor_id"})) {

            ps.setString(1, instructor.getName());
            ps.setString(2, instructor.getEmail());
            ps.setString(3, instructor.getPassword());
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error registering instructor", e);
        }
        return -1;
    }

    @Override
    public Optional<Instructor> findByEmail(String email) {
        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(FIND_BY_EMAIL)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapRow(rs));
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error finding instructor by email", e);
        }
        return Optional.empty();
    }

    @Override
    public Optional<Instructor> findById(int instructorId) {
        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(FIND_BY_ID)) {

            ps.setInt(1, instructorId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapRow(rs));
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error finding instructor by ID", e);
        }
        return Optional.empty();
    }

    @Override
    public List<Instructor> findAll() {
        List<Instructor> instructors = new ArrayList<>();

        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(FIND_ALL);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                instructors.add(mapRow(rs));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error fetching all instructors", e);
        }
        return instructors;
    }

    @Override
    public boolean update(Instructor instructor) {
        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_INSTRUCTOR)) {

            ps.setString(1, instructor.getName());
            ps.setString(2, instructor.getEmail());
            ps.setInt(3, instructor.getInstructorId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Error updating instructor", e);
        }
    }

    @Override
    public boolean delete(int instructorId) {
        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(DELETE_INSTRUCTOR)) {

            ps.setInt(1, instructorId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Error deleting instructor", e);
        }
    }

    // ─── Row Mapper ───────────────────────────────────────────
    private Instructor mapRow(ResultSet rs) throws SQLException {
        Instructor instructor = new Instructor();
        instructor.setInstructorId(rs.getInt("instructor_id"));
        instructor.setName(rs.getString("name"));
        instructor.setEmail(rs.getString("email"));
        instructor.setPassword(rs.getString("password"));

        Timestamp ts = rs.getTimestamp("created_at");
        if (ts != null) {
            instructor.setCreatedAt(ts.toLocalDateTime());
        }
        return instructor;
    }
}