<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.DAO.BookDAOImp" %>
<%@ page import="com.DB.DBCOnnect" %>
<%@ page import="com.entity.BookDtls" %>
<%@ page import="java.util.List" %>
<%@ page import="com.entity.User" %>
<%@ page import="com.entity.Book_Order" %>
<%@ page import="com.DAO.BookOrderImpl" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EBook: Index</title>
<%@ include file="all_component/allCss.jsp" %>
<style type="text/css">
    .back-img {
        background: url("img/b.jpg");
        height: 50vh;
        width: 100%;
        background-repeat: no-repeat;
        background-size: cover;
    }

    .crd-ho:hover {
        background-color: #f7f7f7;
    }
</style>
</head>
<body style="background-color: #f7f7f7;">
<%@ include file="all_component/navbar.jsp" %>

<div class="container">
<h3 class="text-center text-primary">Your Order</h3>

<table class="table table-striped mt-5">
  <thead class="bg-primary text-white">
    <tr>
      <th scope="col">Order Id</th>
      <th scope="col">Name</th>
      <th scope="col">Book Name</th>
      <th scope="col">Author</th>
      <th scope="col">Price</th>
      <th scope="col">Payment Type</th>
    </tr>
  </thead>
  <tbody>
  
<%
    // Retrieve the user object from the session
    User u = (User) session.getAttribute("userobj");
    if (u == null) {
        // If the user object is not present, redirect to the login page or show an error message
        response.sendRedirect("login.jsp"); // Redirect to login page if user is not logged in
    } else {
        // Proceed only if user is logged in
        BookOrderImpl dao = new BookOrderImpl(DBCOnnect.getConn());
        List<Book_Order> blist = dao.getBook(u.getEmail());
        
        if (blist == null || blist.isEmpty()) {
            // Display a message if no orders are found
%>
            <h5 class="text-warning text-center">No orders found for your account.</h5>
<%
        } else {
            // Iterate through the list and display the orders
            for (Book_Order b : blist) {
%>
                <tr>
                    <th scope="row"><%= b.getOrderId() %></th>
                    <td><%= b.getUserName() %></td>
                    <td><%= b.getBookName() %></td>
                    <td><%= b.getAuthor() %></td>
                    <td><%= b.getPrice() %></td>
                    <td><%= b.getPayment() %></td>
                </tr>
<%
            }
        }
    }
%>

   
  </tbody>
</table>
</div>


</body>
</html>