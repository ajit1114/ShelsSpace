<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.DAO.BookDAOImp" %>
<%@ page import="com.DB.DBCOnnect" %>
<%@ page import="com.entity.BookDtls" %>
<%@ page import="java.util.List" %>
<%@ page import="com.entity.User" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin: All Books</title>
    <%@ include file="allCss.jsp" %> <!-- Ensure this file exists and is correctly referenced -->
</head>
<body>
    <%@ include file="navbar.jsp" %> <!-- Ensure this file exists and is correctly referenced -->
    <%
User user = (User)session.getAttribute("userobj");
%>

<h3 class="text-center">Hallo Admin : <%=user.getName() %></h3>
<% 

%>

    <div class="container">
        <% 
            // Get session and retrieve messages
            HttpSession ses = request.getSession();
            String succMsg = (String) session.getAttribute("succMsg");
            String failMsg = (String) session.getAttribute("failMsg");

            // Display success message if available
            if (succMsg != null) { 
        %>
        <div class="alert alert-success text-center">
            <%= succMsg %>
        </div>
        <%
                session.removeAttribute("succMsg"); // Clear the message after displaying
            } 

            // Display failure message if available
            if (failMsg != null) { 
        %>
        <div class="alert alert-danger text-center">
            <%= failMsg %>
        </div>
        <%
                session.removeAttribute("failMsg"); // Clear the message after displaying
            } 
        %>

        <table class="table table-striped">
            <thead class="bg-primary text-white">
                <tr>
                    <th scope="col">Id</th>
                    <th scope="col">Book Name</th>
                    <th scope="col">Author</th>
                    <th scope="col">Price</th>
                    <th scope="col">Categories</th>
                    <th scope="col">Status</th>
                    <th scope="col">Image</th>
                    <th scope="col">Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    BookDAOImp dao = new BookDAOImp(DBCOnnect.getConn());
                    List<BookDtls> list = dao.getAllBooks();
                    
                    if (list != null && !list.isEmpty()) {
                        for (BookDtls b : list) {
                %>
                <tr>
                    <td><%= b.getBookId() %></td>
                    <td><%= b.getBookName() %></td>
                    <td><%= b.getAuthor() %></td>
                    <td><%= b.getPrice() %></td>
                    <td><%= b.getBookCategory() %></td>
                    <td><%= b.getStatus() %></td>
                    <td>
                        <img src="../book/<%= b.getPhotoName() %>" 
                             alt="Book Image" 
                             style="width: 100px; height: 100px;">
                    </td>
                    <td>
                        <a href="edit_book.jsp?id=<%=b.getBookId()%>" class="btn btn-sm btn-primary">Edit</a>
                        <!-- Correct delete link -->
                        <a href="../delete?id=<%=b.getBookId()%>" class="btn btn-sm btn-danger">Delete</a> 
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="8" class="text-center">No books found.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>

    </div> <!-- End of container -->
</body>
</html>

