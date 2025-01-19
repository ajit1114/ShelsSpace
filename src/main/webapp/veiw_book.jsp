<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.DAO.BookDAOImp" %>
<%@ page import="com.DB.DBCOnnect" %>
<%@ page import="com.entity.BookDtls" %>
<%@ page import="com.entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Book</title>
    <%@ include file="all_component/allCss.jsp" %>
    <!-- You can add additional custom CSS here -->
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Roboto', sans-serif;
        }
        .container {
            margin-top: 50px;
        }
        .book-card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
        }
        .book-card img {
            border-radius: 8px;
            margin-bottom: 20px;
            max-height: 200px;
            max-width: 100%;
            object-fit: cover;
        }
        .book-card h4 {
            color: #007bff;
            font-size: 1.2rem;
            font-weight: 500;
        }
        .book-card h5 {
            font-size: 1.1rem;
            color: #495057;
        }
        .book-card .btn {
            padding: 10px 20px;
            font-size: 1rem;
            border-radius: 25px;
            transition: background-color 0.3s ease;
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-danger {
            background-color: #e74c3c;
            border: none;
        }
        .btn-danger:hover {
            background-color: #c0392b;
        }
        .btn-warning {
            background-color: #f39c12;
            border: none;
        }
        .btn-warning:hover {
            background-color: #e67e22;
        }
        .features .col-md-4 {
            background-color: #f0f1f2;
            border-radius: 8px;
            padding: 20px;
            transition: transform 0.3s ease;
        }
        .features .col-md-4:hover {
            transform: scale(1.05);
        }
        .features i {
            color: #f39c12;
        }
        .features p {
            font-size: 1rem;
            color: #2c3e50;
        }
    </style>
</head>
<body>
    <%@ include file="all_component/navbar.jsp" %>

    <%
        // Fetch book details by ID
        int bid = Integer.parseInt(request.getParameter("bid"));
        BookDAOImp dao = new BookDAOImp(DBCOnnect.getConn());
        BookDtls b = dao.getBookById(bid);
    %>
    
    <div class="container p-3">
        <div class="row">
            <!-- Book Details -->
            <div class="col-md-6 book-card">
                <img alt="" src="book/<%=b.getPhotoName() %>">
                <h4>Book Name: <span class="text-primary"><%=b.getBookName() %></span></h4>
                <h5>Author: <%=b.getAuthor() %></h5>
                <h5>Category: <%=b.getBookCategory() %></h5>
            </div>

            <div class="col-md-6 book-card">
                <h2 class="text-success"><%=b.getBookName() %></h2>

                <% if ("old".equals(b.getBookCategory())) { %>
                    <!-- Seller Contact Information for Old Books -->
                    <h5 class="text-primary">Contact to Seller:</h5>
                    <h5><i class="far fa-envelope"></i> Email: <%=b.getEmail() %></h5>
                <% } %>

                <!-- Additional Features -->
                <div class="row features">
                    <div class="col-md-4 text-center p-4">
                        <i class="fas fa-money-bill-wave fa-3x"></i>
                        <p>Cash On Delivery</p>
                    </div>
                    <div class="col-md-4 text-center p-4">
                        <i class="fas fa-undo-alt fa-3x"></i>
                        <p>Return Available</p>
                    </div>
                    <div class="col-md-4 text-center p-4">
                        <i class="fas fa-truck-moving fa-3x"></i>
                        <p>Free Shipping</p>
                    </div>
                </div>

                <% 
                    if ("old".equals(b.getBookCategory())) { 
                        User user1 = (User) session.getAttribute("userobj");
                        if (user1 != null) {
                %>
                    <a href="CartServlet?bid=<%=b.getBookId() %>&uid=<%=user1.getId() %>" class="btn btn-warning btn-sm ml-2">Add to Cart</a>
                    <a href="#" class="btn btn-danger mt-3"><i class="fas fa-solid fa-indian-rupee-sign"></i> <%=b.getPrice() %></a>
                <% 
                    } else {
                %>
                    <p class="text-danger">Please log in to add this old book to your cart.</p>
                <% 
                    } 
                } else {
                    // For new books
                    User user1 = (User) session.getAttribute("userobj");
                    if (user1 == null) { 
                %>
                    <div class="text-center p-3">
                        <p class="text-danger">Please <a href="login.jsp">log in</a> to add this book to your cart.</p>
                    </div>
                <% 
                    } else { 
                %>
                    <a href="CartServlet?bid=<%=b.getBookId() %>&uid=<%=user1.getId() %>" class="btn btn-primary">
                        <i class="fas fa-cart-plus"></i> Add to Cart
                    </a>
                    <a href="#" class="btn btn-danger mt-3">
                        <i class="fas fa-solid fa-indian-rupee-sign"></i> <%=b.getPrice() %>
                    </a>
                <% 
                    } 
                } 
                %>
            </div>
        </div>
    </div>

</body>
</html>
