package com.lms.dao;

import com.lms.dao.interfaces.ILessonDAO;
import com.lms.model.Lesson;
import com.lms.util.DBConnectionPool;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class LessonDAO implements ILessonDAO {

    // ─── SQL Constants ────────────────────────────────────────
    private static final String INSERT_LESSON =
        "INSERT INTO lessons (course_id, title, content, lesson_order) VALUES (?, ?, ?, ?)";

    private static final String FIND_BY_ID =
        "SELECT * FROM lessons WHERE lesson_id = ?";

    private static final String FIND_BY_COURSE =
        "SELECT * FROM lessons WHERE course_id = ? ORDER BY lesson_order ASC";

    private static final String UPDATE_LESSON =
        "UPDATE lessons SET title = ?, content = ?, lesson_order = ? WHERE lesson_id = ?";

    private static final String DELETE_LESSON =
        "DELETE FROM lessons WHERE lesson_id = ?";

    // ─── Methods ──────────────────────────────────────────────

    @Override
    public int create(Lesson lesson) {
        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(
                 INSERT_LESSON, new String[]{"lesson_id"})) {

            ps.setInt(1, lesson.getCourseId());
            ps.setString(2, lesson.getTitle());
            ps.setString(3, lesson.getContent().orElse(null));
            ps.setInt(4, lesson.getLessonOrder());
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error creating lesson", e);
        }
        return -1;
    }

    @Override
    public Optional<Lesson> findById(int lessonId) {
        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(FIND_BY_ID)) {

            ps.setInt(1, lessonId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapRow(rs));
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error finding lesson by ID", e);
        }
        return Optional.empty();
    }

    @Override
    public List<Lesson> findByCourse(int courseId) {
        List<Lesson> lessons = new ArrayList<>();

        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(FIND_BY_COURSE)) {

            ps.setInt(1, courseId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lessons.add(mapRow(rs));
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error fetching lessons by course", e);
        }
        return lessons;
    }

    @Override
    public boolean update(Lesson lesson) {
        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_LESSON)) {

            ps.setString(1, lesson.getTitle());
            ps.setString(2, lesson.getContent().orElse(null));
            ps.setInt(3, lesson.getLessonOrder());
            ps.setInt(4, lesson.getLessonId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Error updating lesson", e);
        }
    }

    @Override
    public boolean delete(int lessonId) {
        try (Connection conn = DBConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(DELETE_LESSON)) {

            ps.setInt(1, lessonId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Error deleting lesson", e);
        }
    }

    // ─── Row Mapper ───────────────────────────────────────────
    private Lesson mapRow(ResultSet rs) throws SQLException {
        Lesson lesson = new Lesson();
        lesson.setLessonId(rs.getInt("lesson_id"));
        lesson.setCourseId(rs.getInt("course_id"));
        lesson.setTitle(rs.getString("title"));
        lesson.setContent(rs.getString("content"));
        lesson.setLessonOrder(rs.getInt("lesson_order"));
        return lesson;
    }
}