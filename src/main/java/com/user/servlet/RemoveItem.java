package com.user.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.DAO.cartDAOImpl;
import com.DB.DBCOnnect;

@WebServlet("/RemoveItem")
public class RemoveItem extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public RemoveItem() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Retrieve parameters
        String bidParam = request.getParameter("bid");
        String uidParam = request.getParameter("uid");
        String cidParam = request.getParameter("cid");

        // Validate parameters
        if (bidParam == null || uidParam == null || cidParam == null || 
            bidParam.isEmpty() || uidParam.isEmpty() || cidParam.isEmpty()) {
            session.setAttribute("failedMsg", "Invalid parameters. Please try again.");
            response.sendRedirect("cart.jsp");
            return;
        }

        try {
            // Parse parameters
            int bid = Integer.parseInt(bidParam);
            int uid = Integer.parseInt(uidParam);
            int cid = Integer.parseInt(cidParam);

            // Initialize DAO and remove the item
            cartDAOImpl dao = new cartDAOImpl(DBCOnnect.getConn());
            boolean isRemoved = dao.removeItem(bid, uid, cid);

            if (isRemoved) {
                session.setAttribute("succMsg", "Book removed from cart successfully.");
            } else {
                session.setAttribute("failedMsg", "Failed to remove book from cart. Please try again.");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("failedMsg", "Invalid parameter format. Please try again.");
        }

        // Redirect to the cart page
        response.sendRedirect("cart.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
