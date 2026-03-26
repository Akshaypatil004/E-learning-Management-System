package com.lms.dao;

import com.lms.dao.interfaces.IEnrollmentDAO;
import com.lms.model.Enrollment;
import com.lms.util.DBConnectionPool;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EnrollmentDAO implements IEnrollmentDAO {

    // ─── SQL Constants ────────────────────────────────────────
    private static final String INSERT_ENROLLMENT =
        "INSERT INTO enrollments (student_id, course_id) VALUES (?, ?)";

    private static final String CHECK_ENROLLED =
        "SELECT COUNT(*) FROM enrollments WHERE student_id = ? AND course_id = ?";

    private static final String FIND_BY_STUDENT =
        "SELECT * FROM enrollments WHERE student_id = ?";

    private static final String FIND_BY_COURSE =
        "SELECT * FROM enrollments WHERE course_id = ?";

    private static final String DELETE_ENROLLMENT =
        "DELETE FROM enrollments WHERE student_id = ? AND course_id = ?";

    // ─── Methods ──────────────────────────────────────────────

    @Override
    public int enroll(Enrollment enrollment) {
        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(
                 INSERT_ENROLLMENT, new String[]{"enrollment_id"})) {

            ps.setInt(1, enrollment.getStudentId());
            ps.setInt(2, enrollment.getCourseId());
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error enrolling student", e);
        }
        return -1;
    }

    @Override
    public boolean isEnrolled(int studentId, int courseId) {
        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(CHECK_ENROLLED)) {

            ps.setInt(1, studentId);
            ps.setInt(2, courseId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error checking enrollment", e);
        }
        return false;
    }

    @Override
    public List<Enrollment> findByStudent(int studentId) {
        List<Enrollment> enrollments = new ArrayList<>();

        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(FIND_BY_STUDENT)) {

            ps.setInt(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    enrollments.add(mapRow(rs));
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error fetching enrollments by student", e);
        }
        return enrollments;
    }

    @Override
    public List<Enrollment> findByCourse(int courseId) {
        List<Enrollment> enrollments = new ArrayList<>();

        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(FIND_BY_COURSE)) {

            ps.setInt(1, courseId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    enrollments.add(mapRow(rs));
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error fetching enrollments by course", e);
        }
        return enrollments;
    }

    @Override
    public boolean unenroll(int studentId, int courseId) {
        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(DELETE_ENROLLMENT)) {

            ps.setInt(1, studentId);
            ps.setInt(2, courseId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Error unenrolling student", e);
        }
    }

    // ─── Row Mapper ───────────────────────────────────────────
    private Enrollment mapRow(ResultSet rs) throws SQLException {
        Enrollment enrollment = new Enrollment();
        enrollment.setEnrollmentId(rs.getInt("enrollment_id"));
        enrollment.setStudentId(rs.getInt("student_id"));
        enrollment.setCourseId(rs.getInt("course_id"));

        Timestamp ts = rs.getTimestamp("enrolled_at");
        if (ts != null) {
            enrollment.setEnrolledAt(ts.toLocalDateTime());
        }
        return enrollment;
    }
}