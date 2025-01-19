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
<title>sell_book</title>
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

<div class ="row p-5">
<div class="col-md-6 offset-md-4">


<div class="card">
<div class ="card-body text-center">
<H3>Sell Old Book</H3>

  <!-- Display success or failure message -->
                    <%
                        String succMsg = (String) session.getAttribute("succMsg");
                        String failMsg = (String) session.getAttribute("failMsg");
                        if (succMsg != null) {
                    %>
                        <div class="alert alert-success text-center">
                            <%= succMsg %>
                        </div>
                        <%
                            session.removeAttribute("succMsg");
                        }
                        if (failMsg != null) {
                        %>
                        <div class="alert alert-danger text-center">
                            <%= failMsg %>
                        </div>
                        <%
                            session.removeAttribute("failMsg");
                        }
                    %>
  <form action="${pageContext.request.contextPath}/Add_Old_Book" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="bname">Book Name</label>
                <input name="bname" type="text" class="form-control" id="bname" required>
            </div>
            <div class="form-group">
                <label for="aname">Author Name</label>
                <input name="aname" type="text" class="form-control" id="aname" required>
            </div>
            <div class="form-group">
                <label for="bprice">Price</label>
                <input name="bprice" type="text" class="form-control" id="bprice" required>
            </div>
            <div class="form-group">
                <label for="bstatus">Book Status</label>
                <select id="bstatus" name="bstatus" class="form-control" required>
                    <option value="">--Select--</option>
                    <option value="available">Available</option>
                    <option value="unavailable">Unavailable</option>
                </select>
            </div>
            <div class="form-group">
                <label for="bimg">Upload Photo</label>
                <input name="bimg" type="file" class="form-control-file" id="bimg" required>
            </div>
            <button type="submit" class="btn btn-primary">Sell</button>
        </form>
                    
</div>
</div>

</div>
</div>
</div>



</body>
</html>