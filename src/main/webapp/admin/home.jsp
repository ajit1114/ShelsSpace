<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    HttpSession session1 = request.getSession(false);
    if (session == null || session.getAttribute("userobj") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    String adminEmail = "admin@gmail.com";
    Object userObj = session.getAttribute("userobj");
    if (userObj == null || !adminEmail.equals(((com.entity.User) userObj).getEmail())) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<%@ include file="allCss.jsp"  %>

<style type="text/css">

a {
text.decoration: name;
color: black;

}

a:havar {
 text-decoration: name;
 color: black;
}
</style>
</head>
<body>
<%@ include file="navbar.jsp"  %>

<div class="container">
<div class="row p-5">
<div class="col-md-3">

<a href="add_books.jsp">

<div class="card">
<div class="card-body text-center">
<i class="fas fa-plus-square fa-3x text-primary"></i><br>
<h4>Add Books</h4>

</div>

</div>
</a>

</div>


<div class="col-md-3">
<a href="all_books.jsp">
<div class="card">
<div class="card-body text-center">
<i class="fas fa-book-open fa-3x text-danger"></i><br>
<h4>All Books</h4>

</div>

</div>

</a>
</div>



<div class="col-md-3">
<a href="order.jsp">
<div class="card">
<div class="card-body text-center">
<i class="fas fa-box-open fa-3x text-warning"></i><br>
<h4>Order</h4>

</div>

</div>

</a>
</div>





<div class="col-md-3">
<div class="card">
<div class="card-body text-center">
<a data-toggle="modal" data-target="#exampleModalCenter" class="btn btn-danger text-white">
<i class="fas fa-sign-out-alt fa-3x text-primary"></i><br>
<h4>Logout</h4>
</a>


</div>

</div>


</div>


</div>

</div>


</body>
</html>
