package com.lms.servlet;

import com.lms.dao.CourseDAO;
import com.lms.dao.interfaces.ICourseDAO;
import com.lms.model.Course;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/courses")
public class CourseServlet extends HttpServlet {

    private ICourseDAO courseDAO;

    @Override
    public void init() {
        courseDAO = new CourseDAO();
    }

    // GET — list all courses
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Course> courses = courseDAO.findAll();
        request.setAttribute("courses", courses);
        request.getRequestDispatcher("/jsp/courses.jsp").forward(request, response);
    }
}