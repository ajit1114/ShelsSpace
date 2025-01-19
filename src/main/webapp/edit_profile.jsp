<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.entity.User" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Profile</title>
<%@ include file="all_component/allCss.jsp" %>
<style>
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

<%
    // Use existing session object instead of redeclaring
    HttpSession httpSession = request.getSession(false);
    User loggedInUser = (User) httpSession.getAttribute("userobj");

    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String succMsg = (String) httpSession.getAttribute("succMsg");
    String failedMsg = (String) httpSession.getAttribute("failedMsg");

    httpSession.removeAttribute("succMsg");
    httpSession.removeAttribute("failedMsg");
%>

<% if (succMsg != null) { %>
    <div class="alert alert-success alert-dismissible fade show text-center" role="alert">
        <%= succMsg %>
    </div>
<% } %>

<% if (failedMsg != null) { %>
    <div class="alert alert-danger alert-dismissible fade show text-center" role="alert">
        <%= failedMsg %>
    </div>
<% } %>

<div class="container">
    <div class="row p-5">
        <div class="col-md-6 offset-md-3">
            <div class="card">
                <div class="card-body text-center">
                    <h4>Edit Profile</h4>
                    <form action="update_profile" method="post">
                        <input type="hidden" name="id" value="<%= loggedInUser.getId() %>" />
                        
                        <div class="form-group">
                            <label for="name">Full Name</label>
                            <input type="text" class="form-control" id="name" name="fname" value="<%= loggedInUser.getName() %>" required />
                        </div>
                        
                        <div class="form-group">
                            <label for="email">Email Address</label>
                            <input type="email" class="form-control" id="email" name="email" value="<%= loggedInUser.getEmail() %>" required />
                        </div>
                        
                        <div class="form-group">
                            <label for="phno">Phone Number</label>
                            <input type="text" class="form-control" id="phno" name="phno" value="<%= loggedInUser.getPhno() %>" required />
                        </div>
                        
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" class="form-control" id="password" name="pass" required />
                        </div>
                        
                        <button type="submit" class="btn btn-primary">Update</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
