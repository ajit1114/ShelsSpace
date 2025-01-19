<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.DAO.BookDAOImp" %>
<%@ page import="com.DB.DBCOnnect" %>
<%@ page import="com.entity.BookDtls" %>
<%@ page import="java.util.List" %>
<%@ page import="com.entity.User" %>
<%@ page import="com.entity.Book_Order" %>
<%@ page import="com.DAO.BookOrderImpl" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard - All Orders Overview</title>
<%@ include file="allCss.jsp"  %>
</head>
<body>
<%@ include file="navbar.jsp"  %>
<%
User user = (User)session.getAttribute("userobj");
%>

<h3 class="text-center">Hello Admin: <%= user.getName() %></h3>
<% 

%>

<table class="table table-striped ">
  <thead class="bg-primary text-white">
    <tr>
      <th scope="col">Order Id</th>
      <th scope="col">Name</th>
      <th scope="col">Email</th>
      <th scope="col">Address</th>
      <th scope="col">Phone No</th>
      <th scope="col">Book Name</th>
      <th scope="col">Author</th>
      <th scope="col">Price</th>
      <th scope="col">Payment Type</th>
      <th scope="col">Order Date</th>
    </tr>
  </thead>
  <tbody>
  
  <%
  
  BookOrderImpl dao = new BookOrderImpl(DBCOnnect.getConn());
  List<Book_Order> blist = dao.getBook();
  SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss"); 
  
  for (Book_Order b : blist) {
	  %>
	                  <tr>
	                      <th scope="row">
	                      <%= b.getOrderId() %></th>
	                      <td><%= b.getUserName() %></td>
	                      <td><%= b.getEmail() %></td>
	                      <td><%= b.getFulladdr() %></td>
	                      <td><%= b.getPhno() %></td>
	                      <td><%= b.getBookName() %></td>
	                      <td><%= b.getAuthor() %></td>
	                      <td><%= b.getPrice() %></td>
	                      <td><%= b.getPayment() %></td>
	                      <td>
	                          <%= b.getDate() != null ? sdf.format(b.getDate()) : "N/A" %>
	                      </td>
	                  </tr>
	  <%
	              }
  %>
   
  </tbody>
</table>
</body>
</html>
