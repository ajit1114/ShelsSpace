<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.DAO.BookDAOImp" %>
<%@ page import="com.DB.DBCOnnect" %>
<%@ page import="com.entity.BookDtls" %>
<%@ page import="java.util.List" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>New Books</title>
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
<body>

<%
    // Handle request attribute 'addCart'
    String addCart = (String) request.getAttribute("addCart"); 
    if (addCart != null && !addCart.isEmpty()) {
%>
    <!-- Show success message from request attribute -->
    <div class="alert alert-success text-center">
        <%= addCart %>
    </div>
<% 
    } 
%>

<%@ include file="all_component/navbar.jsp" %>

<%
    // Handle session attributes 'addCart1' and 'fail'
    String addCart1 = (String) session.getAttribute("addCart");
    String fail = (String) session.getAttribute("fail");

    if (addCart1 != null && !addCart1.isEmpty()) {
%>
    <!-- Show success message from session -->
    <div class="alert alert-success text-center">
        <%= addCart1 %>
    </div>
    <%
        session.removeAttribute("addCart"); // Remove after displaying
    } else if (fail != null && !fail.isEmpty()) {
    %>
    <!-- Show failure message from session -->
    <div class="alert alert-danger text-center">
        <%= fail %>
    </div>
    <%
        session.removeAttribute("fail"); // Remove after displaying
    }
%>

<div class="container-fluid">
    <div class="row">

        <%
            BookDAOImp dao = new BookDAOImp(DBCOnnect.getConn());
            List<BookDtls> list = dao.getAllNewBook();

            if (list != null && !list.isEmpty()) {
                for (BookDtls b : list) {
        %>
        <div class="col-md-3 p-3">
            <div class="card crd-ho">
                <div class="card-body text-center">
                    <img alt="" src="book/<%= b.getPhotoName() %>" style="width: 150px; height:200px" class="img-thumblin">
                    <p><%= b.getBookName() %></p>
                    <p>Author: <%= b.getAuthor() %></p>
                    <p>Categories: <%= b.getBookCategory() %></p>
                    <div class="text-center" style="text-center">
                        <%
                            User user1 = (User) session.getAttribute("userobj");
                            if (user1 != null) {
                        %>
                        <a href="CartServlet?bid=<%= b.getBookId() %>&uid=<%= user1.getId() %>" class="btn btn-danger btn-sm ml-2">Add Cart</a>
                        <% } %>
                        <a href="veiw_book.jsp?bid=<%= b.getBookId() %>" class="btn btn-success btn-sm ml-1">View Details</a>
                        <a href="#" class="btn btn-danger btn-sm ml-1">$<%= b.getPrice() %></a>
                    </div>
                </div>
            </div>
        </div>
        <%
                }
            } else {
        %>
        <p class="text-center text-danger">No new books available.</p>
        <%
            }
        %>
    </div>
</div>
</body>
</html>
