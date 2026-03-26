package com.lms.servlet;

import com.lms.dao.CourseDAO;
import com.lms.dao.EnrollmentDAO;
import com.lms.dao.ProgressDAO;
import com.lms.dao.LessonDAO;
import com.lms.dao.interfaces.ICourseDAO;
import com.lms.dao.interfaces.IEnrollmentDAO;
import com.lms.dao.interfaces.IProgressDAO;
import com.lms.dao.interfaces.ILessonDAO;
import com.lms.model.Student;
import com.lms.model.Instructor;
import com.lms.model.Enrollment;
import com.lms.model.Course;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private ICourseDAO courseDAO;
    private IEnrollmentDAO enrollmentDAO;
    private IProgressDAO progressDAO;
    private ILessonDAO lessonDAO;

    @Override
    public void init() {
        courseDAO     = new CourseDAO();
        enrollmentDAO = new EnrollmentDAO();
        progressDAO   = new ProgressDAO();
        lessonDAO     = new LessonDAO();
    }

    // GET — show dashboard based on role
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String role = (String) session.getAttribute("role");

        if ("student".equals(role)) {
            Student student = (Student) session.getAttribute("loggedInStudent");
            List<Enrollment> enrollments = enrollmentDAO.findByStudent(student.getStudentId());

            // For each enrollment, count completed lessons
            enrollments.forEach(e -> {
                int total     = lessonDAO.findByCourse(e.getCourseId()).size();
                int completed = progressDAO.countCompleted(student.getStudentId(), e.getCourseId());
                e.getCourseId(); // course ID available for JSP
                request.setAttribute("total_" + e.getCourseId(), total);
                request.setAttribute("completed_" + e.getCourseId(), completed);
            });

            request.setAttribute("enrollments", enrollments);
            request.getRequestDispatcher("/jsp/dashboard.jsp").forward(request, response);

        } else if ("instructor".equals(role)) {
            Instructor instructor = (Instructor) session.getAttribute("loggedInInstructor");
            List<Course> courses  = courseDAO.findByInstructor(instructor.getInstructorId());
            request.setAttribute("courses", courses);
            request.getRequestDispatcher("/jsp/dashboard.jsp").forward(request, response);

        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
}