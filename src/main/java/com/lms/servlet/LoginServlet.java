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
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.util.Optional;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private IStudentDAO studentDAO;
    private IInstructorDAO instructorDAO;

    @Override
    public void init() {
        studentDAO    = new StudentDAO();
        instructorDAO = new InstructorDAO();
    }

    // GET — show login page
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
    }

    // POST — process login
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email    = request.getParameter("email").trim();
        String password = request.getParameter("password");
        String role     = request.getParameter("role"); // student | instructor | admin

        HttpSession session = request.getSession();

        if ("student".equals(role)) {
            Optional<Student> student = studentDAO.findByEmail(email);
            if (student.isPresent() && BCrypt.checkpw(password, student.get().getPassword())) {
                session.setAttribute("loggedInStudent", student.get());
                session.setAttribute("role", "student");
                response.sendRedirect(request.getContextPath() + "/dashboard");
                return;
            }

        } else if ("instructor".equals(role)) {
            Optional<Instructor> instructor = instructorDAO.findByEmail(email);
            if (instructor.isPresent() && BCrypt.checkpw(password, instructor.get().getPassword())) {
                session.setAttribute("loggedInInstructor", instructor.get());
                session.setAttribute("role", "instructor");
                response.sendRedirect(request.getContextPath() + "/dashboard");
                return;
            }
        }

        // Login failed — forward back to login page with error
        request.setAttribute("errorMessage", "Invalid email, password, or role.");
        request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
    }
}