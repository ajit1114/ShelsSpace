<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.DAO.BookDAOImp" %>
<%@ page import="com.DB.DBCOnnect" %>
<%@ page import="com.entity.BookDtls" %>
<%@ page import="com.entity.User" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Old Books</title>
    <%@ include file="all_component/allCss.jsp" %>
</head>
<body style="background-color:#f0f1f2">
    <%@ include file="all_component/navbar.jsp" %>
    <div class="container p-5">
        <div class="row">
            <div class="col-md-10">
                <%-- Display success and failure messages --%>
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

                <table class="table table-striped">
                    <thead class="bg-primary text-white">
                        <tr>
                            <th scope="col">Book Name</th>
                            <th scope="col">Author</th>
                            <th scope="col">Price</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            // Retrieve user and fetch books
                            User user3 = (User) session.getAttribute("userobj");
                            if (user3 != null) {
                                String mail = user3.getEmail(); // Use user3 instead of user
                                BookDAOImp dao = new BookDAOImp(DBCOnnect.getConn());
                                List<BookDtls> list = dao.getBookByOld(mail, "old");

                                // Iterate through books
                                for (BookDtls b : list) {
                        %>
                            <tr>
                                <td><%= b.getBookName() %></td>
                                <td><%= b.getAuthor() %></td>
                                <td><%= b.getPrice() %></td>
                                <td>
                                    <a href="delete_old_book?mail=<%= b.getEmail() %>&Bid=<%= b.getBookId() %>"
                                       class="btn btn-danger btn-sm">Delete</a>
                                </td>
                            </tr>
                        <%
                                }
                            } else {
                        %>
                            <tr>
                                <td colspan="4" class="text-center">No books found.</td>
                            </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
