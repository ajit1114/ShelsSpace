<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.DAO.BookDAOImp" %>
<%@ page import="com.DB.DBCOnnect" %>
<%@ page import="com.entity.BookDtls" %>
<%@ page import="java.util.List" %>
<%@ page import="com.entity.User" %>

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

<%
User user1 = (User)session.getAttribute("userobj");
    if (user1 == null) {
        response.sendRedirect("login.jsp");
    }
%>

<%@ include file="all_component/navbar.jsp" %>
<div class="container">

<%
User user2 = (User)session.getAttribute("userobj");
    if (user2 != null) {
    	%>
    	<h3 class="text-center">Hello, <%=user2.getName() %></h3>
    	<% 
    }
%>


<div class="container">
    <div class="row p-5">
        <!-- Sell Old Book Card -->
        <div class="col-md-6 mb-4">
            <a href="sell_book.jsp">
                <div class="card crd-ho">
                    <div class="card-body text-center">
                        <div class="text-primary">
                            <i class="fas fa-book-open fa-3x"></i>
                        </div>
                        <h3>Sell Old Book</h3>
                    </div>
                </div>
            </a>
        </div>

        <!-- Old Book Card -->
        <div class="col-md-6 mb-4">
            <a href="old_book.jsp">
                <div class="card crd-ho">
                    <div class="card-body text-center">
                        <div class="text-primary">
                            <i class="fas fa-book-open fa-3x"></i>
                        </div>
                        <h3>Old Book</h3>
                    </div>
                </div>
            </a>
        </div>
    </div>

    <div class="row p-5">
        <!-- Edit Profile Card -->
        <div class="col-md-6 mb-4">
            <a href="edit_profile.jsp">
                <div class="card crd-ho">
                    <div class="card-body text-center">
                        <div class="text-primary">
                            <i class="fas fa-edit fa-3x"></i>
                        </div>
                        <h4>Login & Security (Edit Profile)</h4>
                    </div>
                </div>
            </a>
        </div>

        <!-- My Orders Card -->
        <div class="col-md-6 mb-4">
            <a href="order.jsp">
                <div class="card crd-ho">
                    <div class="card-body text-center">
                        <div class="text-danger">
                            <i class="fas fa-box-open fa-3x"></i>
                        </div>
                        <h4>My Orders</h4>
                        <p>Track Your Order</p>
                    </div>
                </div>
            </a>
        </div>
    </div>

    <div class="row p-5">
        <!-- Help Card -->
        <div class="col-md-6 mb-4">
            <a href="help.jsp">
                <div class="card crd-ho">
                    <div class="card-body text-center">
                        <div class="text-primary">
                            <i class="fas fa-user-circle fa-3x"></i>
                        </div>
                        <h4>Help</h4>
                        <p>24/7 Support</p>
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>


<%@ include file="all_component/footer.jsp" %>

</body>
</html>