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
<title>Insert title here: old</title>
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
            BookDAOImp dao3 = new BookDAOImp(DBCOnnect.getConn());
            List<BookDtls> list3 = dao3.getOldBook();

            if (list3 != null && !list3.isEmpty()) {
                for (BookDtls b : list3) {
        %>
       <div class="col-md-3">
            <div class="card crd-ho">
                <div class="card-body text-center">
                   <img alt="" src="book/<%=b.getPhotoName() %>" style="width: 150px; height:200px" class="img-thumblin">
                        
                    <p><%= b.getBookName() %></p>
                    <p>Author: <%= b.getAuthor() %></p>
                    <p>Categories: <%= b.getBookCategory() %></p>
                    <div class="text-center">
                    
                     <%
                    
                    
                
                User user1 = (User)session.getAttribute("userobj");
                    if(user1==null)
                    {
                    	%>
                    	
                    	<% 
                    }
                    else
                    {
                    	%>
    <a href="CartServlet?bid=<%=b.getBookId() %>&uid=<%=user1.getId() %>" class="btn btn-danger btn-sm ml-2">Add Cart</a>
<%
                    }
                    
                    %>
                       
                        <a href="veiw_book.jsp?bid=<%=b.getBookId()  %>" class="btn btn-success btn-sm ml-1">View Details</a>
                        <a href="#" class="btn btn-danger btn-sm ml-1">$<%= b.getPrice() %></a>
                    </div>
                </div>
            </div>
        </div>
        <%
                }
            } else {
        %>
        <p class="text-center text-danger">No old books available.</p>
        <%
            }
        %>

</div>
</div>
</body>
</html>