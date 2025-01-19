<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
   <%@ include file="allCss.jsp" %>
</head>
<body style="background-color: #f0f2f2;">
<%@ include file="navbar.jsp" %>

<div class="container">
    <div class="row">
        <div class="col-md-4 offset-md-4">
            <div class="card">
                <div class="card-body">
                    <h4 class="text-center">Add Books</h4>

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

                    <form action="../add_book" method="post" enctype="multipart/form-data">
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
                            <label for="btype">Book Category</label>
                            <select id="btype" name="btype" class="form-control" required>
                                <option value="">--Select--</option>
                                <option value="new">New Book</option>
                                <option value="old">Old Book</option>
                            </select>
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
                        <button type="submit" class="btn btn-primary">Add</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
