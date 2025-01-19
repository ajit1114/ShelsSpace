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

    <div class="container">
        <div class="row">
            <div class="col-md-4 offset-md-4">
                <div class="card">
                    <div class="card-body">
                        <h4 class="text-center">Login Page</h4>
                        <form action="login" method="post">
                            <div class="form-group">
                                <label for="exampleInputEmail1">Email address</label>
                                <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email" required="required" name="email">
                            </div>

                            <div class="form-group">
                                <label for="exampleInputPassword1">Password</label>
                                <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password" required="required" name="pass">
                            </div>

                            <button type="submit" class="btn btn-primary">Submit</button><br>
                            <a href="register.jsp">Create Account</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="all_component/footer.jsp" %>
</body>
</html>
