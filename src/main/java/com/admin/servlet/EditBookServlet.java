package com.admin.servlet;

import java.io.IOException;

import com.DAO.BookDAOImp;
import com.DB.DBCOnnect;
import com.entity.BookDtls;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/edit_book")
public class EditBookServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(); // Initialize session once for reuse

        try {
            // Parse book ID
            int id = Integer.parseInt(req.getParameter("id"));

            // Fetch updated details from the request
            String bookName = req.getParameter("bname");
            String author = req.getParameter("aname");
            String price = req.getParameter("bprice");
            String category = req.getParameter("bcategory");
            String status = req.getParameter("bstatus");
            String photoName = req.getParameter("bimage"); // Assume form might leave this null or empty if not updated

            // Initialize DAO and retrieve the existing book details
            BookDAOImp dao = new BookDAOImp(DBCOnnect.getConn());
            BookDtls existingBook = dao.getBookById(id);

            if (existingBook == null) {
                // Handle book not found
                session.setAttribute("failMsg", "Book not found.");
                resp.sendRedirect("admin/all_books.jsp");
                return;
            }

            // Retain old photo name if no new photo is provided
            if (photoName == null || photoName.trim().isEmpty()) {
                photoName = existingBook.getPhotoName();
            }

            // Create a new BookDtls object with updated details
            BookDtls updatedBook = new BookDtls(bookName, author, price, category, status, photoName, existingBook.getEmail());
            updatedBook.setBookId(id); // Ensure ID is retained

            // Perform update
            boolean isUpdated = dao.updateBook(updatedBook);

            // Handle success or failure
            if (isUpdated) {
                session.setAttribute("succMsg", "Book updated successfully.");
                resp.sendRedirect("admin/edit_book.jsp?id=" + id); // Redirect to the edit page with ID to show updated details
            } else {
                session.setAttribute("failMsg", "Failed to update book.");
                resp.sendRedirect("admin/edit_book.jsp?id=" + id); // Redirect back to the edit page with ID
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            session.setAttribute("failMsg", "Invalid book ID format.");
            resp.sendRedirect("admin/all_books.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("failMsg", "Error: " + e.getMessage());
            resp.sendRedirect("admin/all_books.jsp");
        }
    }
}
