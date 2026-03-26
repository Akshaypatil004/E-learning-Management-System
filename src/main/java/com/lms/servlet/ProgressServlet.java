package com.lms.servlet;

import com.lms.dao.ProgressDAO;
import com.lms.dao.interfaces.IProgressDAO;
import com.lms.model.Progress;
import com.lms.model.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Optional;

@WebServlet("/progress")
public class ProgressServlet extends HttpServlet {

    private IProgressDAO progressDAO;

    @Override
    public void init() {
        progressDAO = new ProgressDAO();
    }

    // POST — mark lesson as complete
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Student student = (Student) session.getAttribute("loggedInStudent");
        int lessonId    = Integer.parseInt(request.getParameter("lessonId"));
        int courseId    = Integer.parseInt(request.getParameter("courseId"));

        Optional<Progress> existing = progressDAO.findByStudentAndLesson(
            student.getStudentId(), lessonId
        );

        if (existing.isPresent()) {
            // Progress record exists — just mark complete
            progressDAO.markComplete(student.getStudentId(), lessonId);
        } else {
            // First time visiting — create record then mark complete
            Progress progress = new Progress(student.getStudentId(), lessonId);
            progressDAO.create(progress);
            progressDAO.markComplete(student.getStudentId(), lessonId);
        }

        response.sendRedirect(request.getContextPath() + "/lessons?courseId=" + courseId);
    }
}