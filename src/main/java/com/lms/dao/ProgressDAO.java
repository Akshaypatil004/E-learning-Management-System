package com.lms.dao;

import com.lms.dao.interfaces.IProgressDAO;
import com.lms.model.Progress;
import com.lms.util.DBConnectionPool;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class ProgressDAO implements IProgressDAO {

    // ─── SQL Constants ────────────────────────────────────────
    private static final String INSERT_PROGRESS =
        "INSERT INTO progress (student_id, lesson_id, is_completed) VALUES (?, ?, 0)";

    private static final String MARK_COMPLETE =
        "UPDATE progress SET is_completed = 1, completed_at = CURRENT_TIMESTAMP " +
        "WHERE student_id = ? AND lesson_id = ?";

    private static final String FIND_BY_STUDENT_AND_LESSON =
        "SELECT * FROM progress WHERE student_id = ? AND lesson_id = ?";

    private static final String FIND_BY_STUDENT_AND_COURSE =
        "SELECT p.* FROM progress p " +
        "JOIN lessons l ON p.lesson_id = l.lesson_id " +
        "WHERE p.student_id = ? AND l.course_id = ? " +
        "ORDER BY l.lesson_order ASC";

    private static final String COUNT_COMPLETED =
        "SELECT COUNT(*) FROM progress p " +
        "JOIN lessons l ON p.lesson_id = l.lesson_id " +
        "WHERE p.student_id = ? AND l.course_id = ? AND p.is_completed = 1";

    // ─── Methods ──────────────────────────────────────────────

    @Override
    public int create(Progress progress) {
        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(
                 INSERT_PROGRESS, new String[]{"progress_id"})) {

            ps.setInt(1, progress.getStudentId());
            ps.setInt(2, progress.getLessonId());
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error creating progress record", e);
        }
        return -1;
    }

    @Override
    public boolean markComplete(int studentId, int lessonId) {
        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(MARK_COMPLETE)) {

            ps.setInt(1, studentId);
            ps.setInt(2, lessonId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Error marking lesson complete", e);
        }
    }

    @Override
    public Optional<Progress> findByStudentAndLesson(int studentId, int lessonId) {
        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(FIND_BY_STUDENT_AND_LESSON)) {

            ps.setInt(1, studentId);
            ps.setInt(2, lessonId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapRow(rs));
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error finding progress by student and lesson", e);
        }
        return Optional.empty();
    }

    @Override
    public List<Progress> findByStudentAndCourse(int studentId, int courseId) {
        List<Progress> progressList = new ArrayList<>();

        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(FIND_BY_STUDENT_AND_COURSE)) {

            ps.setInt(1, studentId);
            ps.setInt(2, courseId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    progressList.add(mapRow(rs));
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error fetching progress by student and course", e);
        }
        return progressList;
    }

    @Override
    public int countCompleted(int studentId, int courseId) {
        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(COUNT_COMPLETED)) {

            ps.setInt(1, studentId);
            ps.setInt(2, courseId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error counting completed lessons", e);
        }
        return 0;
    }

    // ─── Row Mapper ───────────────────────────────────────────
    private Progress mapRow(ResultSet rs) throws SQLException {
        Progress progress = new Progress();
        progress.setProgressId(rs.getInt("progress_id"));
        progress.setStudentId(rs.getInt("student_id"));
        progress.setLessonId(rs.getInt("lesson_id"));
        progress.setCompleted(rs.getInt("is_completed") == 1);

        Timestamp ts = rs.getTimestamp("completed_at");
        if (ts != null) {
            progress.setCompletedAt(ts.toLocalDateTime());
        }
        return progress;
    }
}