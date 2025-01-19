<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>EBook Login</title>
    <%@ include file="all_component/allCss.jsp"  %>
   
</head>
<body style="background-color:#f0f1f2">
 <%@ include file="all_component/navbar.jsp" %>
  
   
<div class="container text-center mt-3">
        <!-- Success Icon -->
        
            <i class="fas fa-check-circle fa-5x text-success"></i>
        

        <!-- Thank-You Message -->
        <h1 >Thank You</h1>

        <h2>Your order was placed successfully.</h2>
        <h5>  Within 7 days, your product will be delivered to your address.</h5>
        <!-- Order Success Message -->
      

       
            <a href="index.jsp" class="btn btn-primary btn-home mt-3">Home</a>
            <a href="order.jsp" class="btn btn-danger btn-view-order mt-3">View Order</a>
    </div>

    <!-- Bootstrap Icons -->

    <!-- Bootstrap JS (Optional) -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <%@ include file="all_component/footer.jsp" %>
</body>
</html>