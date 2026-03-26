package com.lms.servlet;

import com.lms.dao.StudentDAO;
import com.lms.dao.InstructorDAO;
import com.lms.dao.CourseDAO;
import com.lms.dao.interfaces.IStudentDAO;
import com.lms.dao.interfaces.IInstructorDAO;
import com.lms.dao.interfaces.ICourseDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private IStudentDAO studentDAO;
    private IInstructorDAO instructorDAO;
    private ICourseDAO courseDAO;

    @Override
    public void init() {
        studentDAO    = new StudentDAO();
        instructorDAO = new InstructorDAO();
        courseDAO     = new CourseDAO();
    }

    // GET — show admin panel
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setAttribute("students",    studentDAO.findAll());
        request.setAttribute("instructors", instructorDAO.findAll());
        request.setAttribute("courses",     courseDAO.findAll());
        request.getRequestDispatcher("/jsp/admin.jsp").forward(request, response);
    }
}   