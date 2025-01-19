package com.user.servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/OldBookOrderServlet") // Map this servlet to a unique URL
public class OldBookOrderServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Handle adding an old book to the cart
        String bookId = request.getParameter("bookId");

        if (bookId == null || bookId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Book ID is missing.");
            return;
        }

        // Simulate adding the book to the cart (replace with actual logic)
        // Example: cart.addBook(bookId, isOldBook = true);
        System.out.println("Old Book with ID " + bookId + " added to the cart.");

        // Redirect or respond with success
        response.sendRedirect("cart.jsp"); // Replace "cart.jsp" with the appropriate page
    }
}
