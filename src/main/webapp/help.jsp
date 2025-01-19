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
<%@ include file="all_component/navbar.jsp" %>

<div class ="card-body text-center">
<i class="fas fa-phone-square-alt fa-3x"></i>
<h3>24*7</h3>
<h4>Help Line Number</h4>
<h5>+91 9766678974</h5>
<a href="mailto:admin@shelfspace.com" class="text-primary">
    <i class="fas fa-envelope"></i> shelfspacehelpcenter@gmail.com
</a>

</div>

</body>
</html>