package com.user.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.DAO.UserDAOImpl;
import com.DB.DBCOnnect;
import com.entity.User;

@WebServlet("/update_profile")
public class update_profile extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        try {
            // Extract and validate input parameters
            String idParam = request.getParameter("id");
            String name = request.getParameter("fname");
            String email = request.getParameter("email");
            String phno = request.getParameter("phno");
            String password = request.getParameter("pass");

            if (idParam == null || name == null || email == null || phno == null || password == null) {
                session.setAttribute("failedMsg", "All fields are required.");
                response.sendRedirect("edit_profile.jsp");
                return;
            }

            // Parse the ID and sanitize inputs
            int id = Integer.parseInt(idParam.trim());
            name = name.trim();
            email = email.trim();
            phno = phno.trim();
            password = password.trim();

            // Ensure all fields are non-empty
            if (name.isEmpty() || email.isEmpty() || phno.isEmpty() || password.isEmpty()) {
                session.setAttribute("failedMsg", "All fields must be filled.");
                response.sendRedirect("edit_profile.jsp");
                return;
            }

            // Create a User object and set values
            User user = new User();
            user.setId(id);
            user.setName(name);
            user.setEmail(email);
            user.setPhno(phno);

            // Initialize DAO
            UserDAOImpl userDao = new UserDAOImpl(DBCOnnect.getConn());

            // Verify password and update profile
            if (userDao.checkPassword(id, password)) {
                boolean isUpdated = userDao.updateProfile(user);

                if (isUpdated) {
                    session.setAttribute("succMsg", "Profile updated successfully.");
                } else {
                    session.setAttribute("failedMsg", "Failed to update profile. Please try again.");
                }
            } else {
                session.setAttribute("failedMsg", "Incorrect password. Profile not updated.");
            }

        } catch (NumberFormatException e) {
            // Handle invalid ID format
            session.setAttribute("failedMsg", "Invalid user ID format.");
        } catch (Exception e) {
            // Handle unexpected exceptions
            e.printStackTrace();
            session.setAttribute("failedMsg", "An unexpected error occurred. Please try again.");
        }

        // Redirect to the edit profile page
        response.sendRedirect("edit_profile.jsp");
    }
}
