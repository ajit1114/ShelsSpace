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

<div class="container">

<div class ="row p-3">
<div class="col-md-6 offset-md-3">


<div class="card">
<div class ="card-body text-center">

<form>

 <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="inputAddress">Address</label>
                                <input type="text" class="form-control" id="inputAddress" name="address" placeholder="Address" required>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="inputLandmark">Landmark</label>
                                <input type="text" class="form-control" id="inputLandmark" name="landmark" placeholder="Landmark">
                            </div>
                            
                             <div class="form-group col-md-6">
                                <label for="inputCity">City</label>
                                <input type="text" class="form-control" id="inputCity" name="city" placeholder="City" required>
                            </div>
                            
                            <div class="form-group col-md-6">
                                <label for="inputCity">State</label>
                                <input type="text" class="form-control" id="inputCity" name="city" placeholder="City" required>
                            </div>
                            
                             <div class="form-group col-md-6">
                                <label for="inputCity">Pin Code</label>
                                <input type="text" class="form-control" id="inputCity" name="city" placeholder="City" required>
                            </div>
                            
                           
                        </div>
                        
                        <div class="text-center">
                        <button  class="btn btn-warning">Add Address</button></div>

</form>


</div>
</div>
</div>
</div>
</div>


</body>
</html>