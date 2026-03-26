package com.lms.servlet;

import com.lms.dao.EnrollmentDAO;
import com.lms.dao.interfaces.IEnrollmentDAO;
import com.lms.model.Enrollment;
import com.lms.model.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/enroll")
public class EnrollServlet extends HttpServlet {

    private IEnrollmentDAO enrollmentDAO;

    @Override
    public void init() {
        enrollmentDAO = new EnrollmentDAO();
    }

    // POST — enroll student in a course
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Student student  = (Student) session.getAttribute("loggedInStudent");
        int courseId     = Integer.parseInt(request.getParameter("courseId"));

        // Check if already enrolled — prevent duplicates
        if (!enrollmentDAO.isEnrolled(student.getStudentId(), courseId)) {
            Enrollment enrollment = new Enrollment(student.getStudentId(), courseId);
            enrollmentDAO.enroll(enrollment);
        }

        response.sendRedirect(request.getContextPath() + "/dashboard");
    }
}