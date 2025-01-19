package com.user.servlet;

import com.DAO.BookDAOImp;
import com.DAO.cartDAOImpl;
import com.DB.DBCOnnect;
import com.entity.BookDtls;
import com.entity.Cart;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get parameters
            String bidParam = request.getParameter("bid");
            String uidParam = request.getParameter("uid");

            // Validate parameters
            if (bidParam == null || uidParam == null || bidParam.isEmpty() || uidParam.isEmpty()) {
                response.getWriter().println("Error: User ID (uid) or Book ID (bid) is missing or invalid.");
                return;
            }

            int bid = Integer.parseInt(bidParam);
            int uid = Integer.parseInt(uidParam);

            // Debugging logs
            System.out.println("Received Book ID: " + bid);
            System.out.println("Received User ID: " + uid);

            // Fetch book details
            BookDAOImp bookDao = new BookDAOImp(DBCOnnect.getConn());
            BookDtls book = bookDao.getBookById(bid);

            if (book == null) {
                response.getWriter().println("Error: Book not found.");
                return;
            }

            // Create cart object
            Cart cart = new Cart();
            cart.setBid(bid);
            cart.setUserid(uid);
            cart.setBookName(book.getBookName());
            cart.setAuthor(book.getAuthor());
            cart.setPrice(Double.parseDouble(book.getPrice()));

            // Add to cart
            cartDAOImpl cartDao = new cartDAOImpl(DBCOnnect.getConn());
            boolean success = cartDao.addCart(cart);
            
            HttpSession session = request.getSession();

            if (success) {
            	
            	session.setAttribute("addCart", "Book Added Successfully");
            	response.sendRedirect("all_new_book.jsp");
               // response.getWriter().println("Book added to cart successfully!");
            } else {
            	session.setAttribute("fail", "Failed to add book to cart.");
                //response.getWriter().println("Failed to add book to cart.");
            }
        } catch (NumberFormatException e) {
            response.getWriter().println("Error: Invalid User ID or Book ID format.");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: An unexpected error occurred.");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Do nothing for POST
    }
}
