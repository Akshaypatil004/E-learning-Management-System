package com.lms.dao;

import com.lms.dao.interfaces.ICourseDAO;
import com.lms.model.Course;
import com.lms.util.DBConnectionPool;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class CourseDAO implements ICourseDAO {

    // ─── SQL Constants ────────────────────────────────────────
    private static final String INSERT_COURSE =
        "INSERT INTO courses (title, description, instructor_id) VALUES (?, ?, ?)";

    private static final String FIND_BY_ID =
        "SELECT * FROM courses WHERE course_id = ?";

    private static final String FIND_ALL =
        "SELECT * FROM courses";

    private static final String FIND_BY_INSTRUCTOR =
        "SELECT * FROM courses WHERE instructor_id = ?";

    private static final String UPDATE_COURSE =
        "UPDATE courses SET title = ?, description = ? WHERE course_id = ?";

    private static final String DELETE_COURSE =
        "DELETE FROM courses WHERE course_id = ?";

    // ─── Methods ──────────────────────────────────────────────

    @Override
    public int create(Course course) {
        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(
                 INSERT_COURSE, new String[]{"course_id"})) {

            ps.setString(1, course.getTitle());
            ps.setString(2, course.getDescription().orElse(null));
            ps.setInt(3, course.getInstructorId());
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error creating course", e);
        }
        return -1;
    }

    @Override
    public Optional<Course> findById(int courseId) {
        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(FIND_BY_ID)) {

            ps.setInt(1, courseId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapRow(rs));
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error finding course by ID", e);
        }
        return Optional.empty();
    }

    @Override
    public List<Course> findAll() {
        List<Course> courses = new ArrayList<>();

        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(FIND_ALL);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                courses.add(mapRow(rs));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error fetching all courses", e);
        }
        return courses;
    }

    @Override
    public List<Course> findByInstructor(int instructorId) {
        List<Course> courses = new ArrayList<>();

        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(FIND_BY_INSTRUCTOR)) {

            ps.setInt(1, instructorId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    courses.add(mapRow(rs));
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error fetching courses by instructor", e);
        }
        return courses;
    }

    @Override
    public boolean update(Course course) {
        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_COURSE)) {

            ps.setString(1, course.getTitle());
            ps.setString(2, course.getDescription().orElse(null));
            ps.setInt(3, course.getCourseId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Error updating course", e);
        }
    }

    @Override
    public boolean delete(int courseId) {
        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(DELETE_COURSE)) {

            ps.setInt(1, courseId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Error deleting course", e);
        }
    }

    // ─── Row Mapper ───────────────────────────────────────────
    private Course mapRow(ResultSet rs) throws SQLException {
        Course course = new Course();
        course.setCourseId(rs.getInt("course_id"));
        course.setTitle(rs.getString("title"));
        course.setDescription(rs.getString("description"));
        course.setInstructorId(rs.getInt("instructor_id"));

        Timestamp ts = rs.getTimestamp("created_at");
        if (ts != null) {
            course.setCreatedAt(ts.toLocalDateTime());
        }
        return course;
    }
}