package com.lms.servlet;

import com.lms.dao.LessonDAO;
import com.lms.dao.ProgressDAO;
import com.lms.dao.interfaces.ILessonDAO;
import com.lms.dao.interfaces.IProgressDAO;
import com.lms.model.Lesson;
import com.lms.model.Progress;
import com.lms.model.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/lessons")
public class LessonServlet extends HttpServlet {

    private ILessonDAO lessonDAO;
    private IProgressDAO progressDAO;

    @Override
    public void init() {
        lessonDAO    = new LessonDAO();
        progressDAO  = new ProgressDAO();
    }

    // GET — list lessons for a course
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int courseId         = Integer.parseInt(request.getParameter("courseId"));
        Student student      = (Student) session.getAttribute("loggedInStudent");
        List<Lesson> lessons = lessonDAO.findByCourse(courseId);
        List<Progress> progressList = progressDAO.findByStudentAndCourse(
            student.getStudentId(), courseId
        );

        request.setAttribute("lessons", lessons);
        request.setAttribute("progressList", progressList);
        request.setAttribute("courseId", courseId);
        request.getRequestDispatcher("/jsp/lessons.jsp").forward(request, response);
    }
}