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
<title>Index</title>
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

<%
User u=(User)session.getAttribute("userobj");
%>




<div class="container-fluid back-img" style="text-align: center; padding: 80px 0; background: linear-gradient(to right, #ff7e5f, #feb47b);"> <h1 class="text-center text-white display-2 font-weight-bold" style="text-shadow: 3px 3px 6px rgba(0, 0, 0, 0.7);">
        Welcome to <span style="color: #ffb81c;">ShelfSpace</span>
    </h1> 
    <p class="text-center text-white lead" style="font-size: 1.2rem;">Explore, Buy, and Manage your favorite Books</p>
</div>



<div class="container">
    <h3 class="text-center">Recent Books</h3>
    <div class="row">
    
    
     <%
            BookDAOImp dao1 = new BookDAOImp(DBCOnnect.getConn());
            List<BookDtls> list1 = dao1.getRecentBook();
           
            if (list1 != null && !list1.isEmpty()) {
                for (BookDtls b : list1) {
        %>
        <div class="col-md-3">
            <div class="card crd-ho">
                <div class="card-body text-center">
                     <img alt="" src="book/<%=b.getPhotoName() %>" style="width: 150px; height:200px" class="img-thumblin">
                    <p><%= b.getBookName() %></p>
                    <p>Author: <%= b.getAuthor() %></p>
                    <p>Categories: <%= b.getBookCategory() %></p>
                    
                    
                    <%
                    if(b.getBookCategory().equals("old"))
                    {
                    	%>
                    	<div class="row">
                    	
                    	
                       
                        <a href="veiw_book.jsp?bid=<%=b.getBookId()  %>" class="btn btn-success btn-sm ml-1">View Details</a>
                        <a href="#" class="btn btn-danger btn-sm ml-1">$<%=b.getPrice() %></a>
                    </div>
                    	
                    	<% 
                    }
                    
                    else
                    {
                    	%>
                    	
                        <div class="row">
                          <%
                    
                    
                
                User user1 = (User)session.getAttribute("userobj");
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
        <p class="text-center text-danger">No Recent books available.</p>
        <%
            }
        %>
    
        

        <!-- Repeat similar cards for other recent books -->
    </div>
  
    <div class="text-center mt-1">
        <a href="all_recent_book.jsp" class="btn btn-danger btn-sm text-white">View All</a>
    
</div>
</div>

<hr>

<div class="container">
    <h3 class="text-center">New Books</h3>
    <div class="row">
        <%
            BookDAOImp dao = new BookDAOImp(DBCOnnect.getConn());
            List<BookDtls> list = dao.getNewBook();

            if (list != null && !list.isEmpty()) {
                for (BookDtls b : list) {
        %>
        <div class="col-md-3">
            <div class="card crd-ho">
                <div class="card-body text-center">
                   <img alt="" src="book/<%=b.getPhotoName() %>" style="width: 150px; height:200px" class="img-thumblin">
                        
                    <p><%= b.getBookName() %></p>
                    <p>Author: <%= b.getAuthor() %></p>
                    <p>Categories: <%= b.getBookCategory() %></p>
                     
                    <div class="row">
                    
                    <%
                    
                    
                
                User user1 = (User)session.getAttribute("userobj");
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
    <div class="text-center mt-1">
        <a href="all_new_book.jsp" class="btn btn-danger btn-sm text-white">View All</a>
    </div>
</div>

<hr>

<div class="container">
    <h3 class="text-center">Old Books</h3>
    <div class="row">
    
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
                    
                    <div class="row">
                    
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

        <!-- Repeat similar cards for other old books -->
    </div>
    <div class="text-center mt-1">
        <a href="all_old_book.jsp" class="btn btn-danger btn-sm text-white">View All</a>
    </div>


<%@ include file="all_component/footer.jsp" %>

</body>
</html>
