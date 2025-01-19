package com.user.servlet;

import java.io.IOException;

import com.DAO.UserDAOImpl;
import com.DB.DBCOnnect;
import com.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            UserDAOImpl dao = new UserDAOImpl(DBCOnnect.getConn());
            HttpSession session = req.getSession();

            String email = req.getParameter("email");
            String password = req.getParameter("pass");

            if ("admin@gmail.com".equals(email) && "admin".equals(password)) {
                // Initialize the User object with admin details
                User adminUser = new User();
                adminUser.setName("Ajit kasabe");
                adminUser.setEmail(email);
              
                session.setAttribute("userobj", adminUser);
                resp.sendRedirect("admin/home.jsp");
            } else {
                User us = dao.login(email, password);

                if (us != null) {
                	
                	 User cust = new User();
                     cust.setName(us.getName());
                    session.setAttribute("userobj", us);
                    resp.sendRedirect("index.jsp");
                   
                } else {
                    session.setAttribute("failedMsg", "Email or Password Invalid");
                    resp.sendRedirect("login.jsp");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

