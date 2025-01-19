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
import jakarta.servlet.annotation.WebServlet;


@WebServlet("/delete")
public class DeletBookServlet extends HttpServlet {


	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		
		try {
			
			int id =Integer.parseInt(req.getParameter("id"));
			 BookDAOImp dao = new BookDAOImp(DBCOnnect.getConn());
	           

			
			boolean f= dao.deleteBooks(id);
			HttpSession ses=req.getSession();
			
			if(f)
			{
				
				ses.setAttribute("succMsg", "Book delete successfully.");
                resp.sendRedirect("admin/all_books.jsp");
			}
			
			else
			{
				ses.setAttribute("failMsg", "Book not found.");
                resp.sendRedirect("admin/all_books.jsp");
			}
			
		}
		catch( Exception e)
		{
			
		}
	}
	





}
