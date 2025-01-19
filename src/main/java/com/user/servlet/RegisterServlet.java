package com.user.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.DB.DBCOnnect;
import com.DAO.UserDAOImpl;
import com.entity.User;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        String name = request.getParameter("fname");
        String email = request.getParameter("email");
        String phno = request.getParameter("phno");
        String password = request.getParameter("pass");

        // Create a User object and set its fields
        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPhno(phno);
        user.setPassword(password);

        // Create UserDAO object for database interaction
        UserDAOImpl userDao = new UserDAOImpl(DBCOnnect.getConn());

        // Check if the email already exists in the database
        boolean emailExists = userDao.checkUser(email);

        if (emailExists) {
            // If email exists, set error message and forward to registration page
            request.setAttribute("errorMessage", "Email already exists. Please try a different email.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            // If email does not exist, attempt to register the user
            boolean isRegistered = userDao.userRegister(user);

            if (isRegistered) {
                // On successful registration, redirect to success page
            	request.setAttribute("success", "Registration Successful.");
            	request.getRequestDispatcher("register.jsp").forward(request, response);

            } else {
                // On registration failure, set error message and forward to registration page
                request.setAttribute("errorMessage", "Registration failed. Please try again.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        }
    }
}
