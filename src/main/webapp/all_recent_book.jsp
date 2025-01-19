<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.DAO.BookDAOImp" %>
<%@ page import="com.DB.DBCOnnect" %>
<%@ page import="com.entity.BookDtls" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here: Recent</title>
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
<body>
<%@ include file="all_component/navbar.jsp" %>


<div class="container-fluid">
<div class="row p-2">
 <%
            BookDAOImp dao1 = new BookDAOImp(DBCOnnect.getConn());
            List<BookDtls> list1 = dao1.getAllRecentBook();

            if (list1 != null && !list1.isEmpty()) {
                for (BookDtls b : list1) {
        %>
        <div class="col-md-3">
            <div class="card crd-ho mt-3">
                <div class="card-body text-center">
                     <img alt="" src="book/<%=b.getPhotoName() %>" style="width: 150px; height:200px" class="img-thumblin">
                    <p><%= b.getBookName() %></p>
                    <p>Author: <%= b.getAuthor() %></p>
                    <p>Categories: <%= b.getBookCategory() %></p>
                    
                    <%
                    if(b.getBookCategory().equals("old"))
                    {
                    	%>
                    	<div class="text-center">
                       
                        <a href="veiw_book.jsp?bid=<%=b.getBookId()  %>" class="btn btn-success btn-sm ml-1">View Details</a>
                        <a href="#" class="btn btn-danger btn-sm ml-1">$<%=b.getPrice() %></a>
                    </div>
                    	
                    	<% 
                    }
                    
                    else
                    {
                    	%>
                    	
                        <div class="text-center">
                          <%
                    
                    
                
                User u = (User)session.getAttribute("userobj");
                    if(u==null)
                    {
                    	%>
                    	 <a href="login.jsp" class="btn btn-danger btn-sm ml-2">Add Cart</a>
                    	<% 
                    }
                    else
                    {
                    	%>
    <a href="CartServlet?bid=<%=b.getBookId() %>&uid=<%=u.getId() %>" class="btn btn-danger btn-sm ml-2">Add Cart</a>
<%
                    }
                    
                    %>
                        <a href="veiw_book.jsp?bid=<%=b.getBookId()  %>" class="btn btn-success btn-sm ml-1">View Details</a>
                        <a href="#" class="btn btn-danger btn-sm ml-1">$<%= b.getPrice() %></a>
                    </div>

                    	
                    	<% 
                    }
                    
                    %>
                   
                </div>
            </div>
        </div>
        <%
                }
            } else {
        %>
        <p class="text-center text-danger">No new books available.</p>
        <%
            }
        %>



</div>

</div>
</div>
</body>
</html>