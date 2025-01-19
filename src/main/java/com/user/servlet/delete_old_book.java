package com.user.servlet;

import java.io.IOException;

import com.DAO.BookDAOImp;
import com.DB.DBCOnnect;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/delete_old_book")
public class delete_old_book extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve email and book ID parameters from request
            String mail = request.getParameter("mail");
            String bookIdParam = request.getParameter("Bid");

            // Validate parameters
            if (mail == null || mail.trim().isEmpty() || bookIdParam == null || bookIdParam.trim().isEmpty()) {
                throw new IllegalArgumentException("Required parameters are missing or invalid.");
            }

            int Bid = Integer.parseInt(bookIdParam);

            System.out.println("Email: " + mail);
            System.out.println("Book ID: " + Bid);

            // Initialize DAO and attempt to delete the old book
            BookDAOImp dao = new BookDAOImp(DBCOnnect.getConn());
            boolean f = dao.oldBookDelete(mail, "old", Bid);

            // Prepare session messages
            HttpSession session = request.getSession();
            if (f) {
                session.setAttribute("succMsg", "Old book deleted successfully.");
            } else {
                session.setAttribute("failedMsg", "Something went wrong. Please try again.");
            }

            // Redirect back to the JSP page
            response.sendRedirect("old_book.jsp");
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception for debugging
            HttpSession session = request.getSession();
            session.setAttribute("failedMsg", "An error occurred: " + e.getMessage());
            response.sendRedirect("old_book.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
