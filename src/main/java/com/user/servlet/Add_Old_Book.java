package com.user.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

import com.DAO.BookDAOImp;
import com.DB.DBCOnnect;
import com.entity.BookDtls;
import com.entity.User;

@WebServlet("/Add_Old_Book")
@MultipartConfig  // Ensure this annotation is present to handle file uploads
public class Add_Old_Book extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
        	
        	 HttpSession session1 = req.getSession(false);
        	 User user1 = (User) session1.getAttribute("userobj");
            // Retrieve form data
            String bookName = req.getParameter("bname");
            String author = req.getParameter("aname");
            String price = req.getParameter("bprice");
            String category = "old";
            String status = req.getParameter("bstatus");
            Part part = req.getPart("bimg");
            String fileName = part.getSubmittedFileName();
            String mail=req.getParameter(user1.getEmail());
            // Debugging
            System.out.println("Book Name: " + bookName);
            System.out.println("Author: " + author);
            System.out.println("Price: " + price);
            System.out.println("Category: " + category);
            System.out.println("Status: " + status);
            System.out.println("File Name: " + fileName);
            System.out.println("Mail: " + mail);
           
          //  User user1 = (User) session1.getAttribute("userobj");
            // Create BookDtls object
            BookDtls b = new BookDtls(bookName, author, price, category, status, fileName, user1.getEmail());

            // Call DAO
            BookDAOImp dao = new BookDAOImp(DBCOnnect.getConn());

            // Add book
            boolean f = dao.addBook(b);

            // Save file to server directory
            HttpSession ses = req.getSession();
            if (f) {
                String path = getServletContext().getRealPath("") + "book";
                File file = new File(path);
                if (!file.exists()) {
                    file.mkdir(); // Create the directory if it doesn't exist
                }
                part.write(path + File.separator + fileName);
                ses.setAttribute("succMsg", "Book added successfully.");
                resp.sendRedirect("admin/add_books.jsp");
            } else {
                ses.setAttribute("failMsg", "Failed to add book.");
                resp.sendRedirect("admin/add_books.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            HttpSession ses = req.getSession();
            ses.setAttribute("failMsg", "Exception: " + e.getMessage());
            resp.sendRedirect("admin/add_books.jsp");
        }
    }
}
