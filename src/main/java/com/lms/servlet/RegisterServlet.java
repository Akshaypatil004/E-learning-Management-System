package com.lms.servlet;

import com.lms.dao.StudentDAO;
import com.lms.dao.InstructorDAO;
import com.lms.dao.interfaces.IStudentDAO;
import com.lms.dao.interfaces.IInstructorDAO;
import com.lms.model.Student;
import com.lms.model.Instructor;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private IStudentDAO studentDAO;
    private IInstructorDAO instructorDAO;

    @Override
    public void init() {
        studentDAO    = new StudentDAO();
        instructorDAO = new InstructorDAO();
    }

    // GET — show register page
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
    }

    // POST — process registration
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name     = request.getParameter("name").trim();
        String email    = request.getParameter("email").trim();
        String password = request.getParameter("password");
        String role     = request.getParameter("role"); // student | instructor

        // Hash password — never store plain text
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        if ("student".equals(role)) {
            Student student = new Student(name, email, hashedPassword);
            studentDAO.register(student);

        } else if ("instructor".equals(role)) {
            Instructor instructor = new Instructor(name, email, hashedPassword);
            instructorDAO.register(instructor);
        }

        // Redirect to login after successful registration
        response.sendRedirect(request.getContextPath() + "/login");
    }
}