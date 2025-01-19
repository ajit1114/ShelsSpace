package com.admin.servlet;

import java.io.File;
import java.io.IOException;

import com.DAO.BookDAOImp;
import com.DB.DBCOnnect;
import com.entity.BookDtls;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/add_book")
@MultipartConfig
public class BookAdd extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            // Retrieve form data
            String bookName = req.getParameter("bname");
            String author = req.getParameter("aname");
            String price = req.getParameter("bprice");
            String category = req.getParameter("btype");
            String status = req.getParameter("bstatus");
            Part part = req.getPart("bimg");
            String fileName = part.getSubmittedFileName();

            // Debug form data
            System.out.println("Book Name: " + bookName);
            System.out.println("Author: " + author);
            System.out.println("Price: " + price);
            System.out.println("Category: " + category);
            System.out.println("Status: " + status);
            System.out.println("File Name: " + fileName);
            
            
            

            // Create BookDtls object
           BookDtls b = new BookDtls(bookName, author, price, category, status, fileName, "admin");

            // Call DAO
            BookDAOImp dao = new BookDAOImp(DBCOnnect.getConn());
            
           
            
            
           boolean f = dao.addBook(b);

            // Set session messages
            HttpSession ses = req.getSession();
            if (f) {
            	
            	 String path=getServletContext().getRealPath("")+"book";
                 //  System.out.print(path);
                   File file= new File(path);
                   part.write(path+File.separator+fileName);
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
