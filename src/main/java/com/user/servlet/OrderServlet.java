package com.user.servlet;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.DAO.BookOrderImpl;
import com.DAO.cartDAOImpl;
import com.DB.DBCOnnect;
import com.entity.Book_Order;
import com.entity.Cart;
import com.entity.User;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get current timestamp as java.sql.Timestamp for database
            LocalDateTime currentDateTime = LocalDateTime.now();
            Timestamp sqlTimestamp = Timestamp.valueOf(currentDateTime); // Save the current timestamp

            // Retrieve session and user details
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("userobj");

            // Validate session user object
            if (user == null) {
                session.setAttribute("FailedMsg", "User session expired. Please log in again.");
                response.sendRedirect("login.jsp");
                return;
            }

            // Retrieve parameters from request
            int userId = user.getId(); // Assuming user ID is fetched from session
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String mobile = request.getParameter("mobile");
            String address = request.getParameter("addr");
            String landmark = request.getParameter("landmark");
            String city = request.getParameter("city");
            String state = request.getParameter("state");
            String zip = request.getParameter("zip");
            String paymentMode = request.getParameter("paymentMode");

            // Validate payment mode
            if (paymentMode == null || "noselect".equals(paymentMode)) {
                session.setAttribute("FailedMsg", "Please select a valid payment option.");
                response.sendRedirect("cart.jsp");
                return;
            }

            // Construct full address
            String fullAddress = String.join(", ", address, landmark, city, state, zip);

            // Initialize DAO objects
            cartDAOImpl cartDao = new cartDAOImpl(DBCOnnect.getConn());
            BookOrderImpl orderDao = new BookOrderImpl(DBCOnnect.getConn());

            // Retrieve cart items for the user
            List<Cart> cartItems = cartDao.getBookByUser(userId);
            if (cartItems.isEmpty()) {
                session.setAttribute("FailedMsg", "Your cart is empty. Add items before placing an order.");
                response.sendRedirect("cart.jsp");
                return;
            }

            // Generate orders for each cart item
            int orderNumber = orderDao.getOrderNo(); // Fetch the starting order number
            List<Book_Order> orderList = new ArrayList<>();

            for (Cart cart : cartItems) {
                Book_Order order = new Book_Order();
                order.setOrderId("BOOK-ORD-00" + orderNumber);
                order.setUserName(name);
                order.setEmail(email);
                order.setPhno(mobile);
                order.setFulladdr(fullAddress);
                order.setBookName(cart.getBookName());
                order.setAuthor(cart.getAuthor());
                order.setPrice(String.valueOf(cart.getPrice()));
                order.setPayment(paymentMode);
                order.setDate(sqlTimestamp); // Store the SQL Timestamp

                orderList.add(order);
                orderNumber++;
            }

            // Save orders to database
            boolean orderSaved = orderDao.saveOrder(orderList);
            if (orderSaved) {
                session.setAttribute("SuccessMsg", "Order placed successfully!");
                response.sendRedirect("order_success.jsp");
            } else {
                session.setAttribute("FailedMsg", "Failed to place the order. Please try again.");
                response.sendRedirect("cart.jsp");
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Invalid number format in request parameters.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=An unexpected error occurred. Please try again later.");
        }
    }
}
