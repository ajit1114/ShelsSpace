<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.DAO.BookDAOImp" %>
<%@ page import="com.DB.DBCOnnect" %>
<%@ page import="com.entity.BookDtls" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin: Edit Book</title>
    <%@ include file="allCss.jsp" %>
</head>
<body style="background-color: #f0f2f2;">
<%@ include file="navbar.jsp" %>

<div class="container">
    <div class="row">
        <div class="col-md-6 offset-md-3">
            <div class="card">
                <div class="card-body">
                    <h4 class="text-center">Edit Book</h4>

                    <% 
                        String idParam = request.getParameter("id");
                        if (idParam == null || idParam.isEmpty()) {
                    %>
                    <div class="alert alert-danger text-center">
                        Invalid request. Please provide a book ID.
                    </div>
                    <% 
                            return;
                        }

                        int id = 0;
                        try {
                            id = Integer.parseInt(idParam);
                        } catch (NumberFormatException e) {
                    %>
                    <div class="alert alert-danger text-center">
                        Invalid book ID format. Please provide a numeric ID.
                    </div>
                    <%
                            return;
                        }

                        BookDAOImp dao = new BookDAOImp(DBCOnnect.getConn());
                        BookDtls b = dao.getBookById(id);

                        if (b == null) {
                    %>
                    <div class="alert alert-danger text-center">
                        Book not found. Please check the ID and try again.
                    </div>
                    <% 
                            return;
                        }
                    %>

                    <% 
                        // Display success or failure messages
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

                    <form action="../edit_book" method="post">
                        <input type="hidden" name="id" value="<%= b.getBookId() %>">

                        <div class="form-group">
                            <label for="bname">Book Name</label>
                            <input name="bname" type="text" class="form-control" id="bname" value="<%= b.getBookName() %>" required>
                        </div>

                        <div class="form-group">
                            <label for="aname">Author Name</label>
                            <input name="aname" type="text" class="form-control" id="aname" value="<%= b.getAuthor() %>" required>
                        </div>

                        <div class="form-group">
                            <label for="bprice">Price</label>
                            <input name="bprice" type="text" class="form-control" id="bprice" value="<%= b.getPrice() %>" required>
                        </div>

                        <div class="form-group">
                            <label for="bcategory">Category</label>
                            <input name="bcategory" type="text" class="form-control" id="bcategory" value="<%= b.getBookCategory() %>" readonly>
                        </div>

                        <div class="form-group">
                            <label for="bstatus">Book Status</label>
                            <select id="bstatus" name="bstatus" class="form-control" required>
                                <option value="Available" <%= "Available".equals(b.getStatus()) ? "selected" : "" %>>Available</option>
                                <option value="Unavailable" <%= "Unavailable".equals(b.getStatus()) ? "selected" : "" %>>Unavailable</option>
                            </select>
                        </div>

                        <button type="submit" class="btn btn-primary">Update</button>
                    </form>

                </div> <!-- End of card-body -->
            </div> <!-- End of card -->
        </div> <!-- End of column -->
    </div> <!-- End of row -->
</div> <!-- End of container -->

</body>
</html>

