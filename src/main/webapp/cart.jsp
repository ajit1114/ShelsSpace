<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.DAO.BookDAOImp" %>
<%@ page import="com.DAO.cartDAOImpl" %>
<%@ page import="com.DB.DBCOnnect" %>
<%@ page import="com.entity.BookDtls" %>
<%@ page import="com.entity.Cart" %>
<%@ page import="com.entity.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.user.servlet.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cart Page</title>
    <%@ include file="all_component/allCss.jsp" %>
</head>
<body style="background-color:#f0f1f2">
    <%@ include file="all_component/navbar.jsp" %>
    
 <%
    String msg = (String) session.getAttribute("msg");
    String Fmsg = (String) session.getAttribute("FailedMsg");
%>

<!-- Alert Section -->
<div id="alert-container">
    <% if (msg != null) { %>
        <div class="alert alert-success text-center">
            <%= msg %>
        </div>
        <%
            session.removeAttribute("msg"); // Remove the session attribute
        %>
    <% } else if (Fmsg != null) { %>
        <div class="alert alert-danger text-center">
            <%= Fmsg %>
        </div>
        <%
            session.removeAttribute("Fmsg"); // Remove the session attribute
        %>
    <% } %>
</div>

<!-- JavaScript for Auto Disappearance -->
<script>
    // Function to hide the alert after 5 seconds
    setTimeout(function () {
        const alertContainer = document.getElementById('alert-container');
        if (alertContainer) {
            alertContainer.style.transition = 'opacity 0.5s ease'; // Smooth fade-out effect
            alertContainer.style.opacity = '0'; // Make it transparent
            setTimeout(() => {
                alertContainer.style.display = 'none'; // Remove from view
            }, 500); // Wait for fade-out animation to complete
        }
    }, 2000); 
</script>

    
    
    <%
        // Retrieve user object from session
        HttpSession session1 = request.getSession(false);
        User user1 = (User) session1.getAttribute("userobj");

        if (user1 == null) {
            // Redirect to login.jsp if user is not logged in
            response.sendRedirect("login.jsp");
            return; // Stop further processing of the page
        }

        // Initialize DAO and fetch cart details for the logged-in user
        cartDAOImpl dao = new cartDAOImpl(DBCOnnect.getConn());
        List<Cart> cart = dao.getBookByUser(user1.getId());
    %>
    
    
    
    
    <%
    // Retrieve success or failure messages from session
    String succMsg = (String) session.getAttribute("succMsg");
    String failedMsg = (String) session.getAttribute("failedMsg");

    // Remove the messages from the session to prevent them from persisting
    session.removeAttribute("succMsg");
    session.removeAttribute("failedMsg");
%>

<%-- Display success message if exists --%>
<% if (succMsg != null) { %>
    <div class="alert alert-success alert-dismissible fade show text-center" role="alert">
        <%= succMsg %>
        
    </div>
<% } %>

<%-- Display failure message if exists --%>
<% if (failedMsg != null) { %>
    <div class="alert alert-danger alert-dismissible fade show  text-center" role="alert">
        <%= failedMsg %>
       
    </div>
<% } %>
    

    <div class="container mt-4">
        <div class="row">
            <!-- Left Section: Your Selected Items -->
            <div class="col-md-6">
                <div class="card bg-white p-3">
                    <h3 class="text-center text-success">Your Selected Items</h3>
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th scope="col">Book Name</th>
                                    <th scope="col">Author</th>
                                    <th scope="col">Price</th>
                                    <th scope="col">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (cart != null && !cart.isEmpty()) {
                                        Double totalPrice = 0.0; // Initialize total price
                                        for (Cart c : cart) {
                                            totalPrice += c.getTotalPrice(); // Accumulate the total price
                                %>
                                            <tr>
                                                <td><%= c.getBookName() %></td>
                                                <td><%= c.getAuthor() %></td>
                                                <td><%= c.getPrice() %></td>
                                               <td>
    <a href="RemoveItem?bid=<%= c.getBid() %>&uid=<%= c.getUserid() %>&cid=<%= c.getCid() %>" 
       class="btn btn-danger btn-sm">Remove</a>
</td>

                                            </tr>
                                <%
                                        }
                                %>
                                        <tr>
                                            <td><strong>Total Price</strong></td>
                                            <td></td>
                                            <td></td>
                                            <td><strong><%= totalPrice %></strong></td>
                                        </tr>
                                <%
                                    } else {
                                %>
                                        <tr>
                                            <td colspan="4" class="text-center text-danger">No items in your cart.</td>
                                        </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>




            <!-- Right Section: Form -->
            <div class="col-md-6">
                <div class="card bg-white p-3">
                    <h3 class="text-center text-success">Your Details</h3>
                    <form action="OrderServlet" method="POST">
    <input type="hidden" value="<%=user1.getId() %>" name="id">
    <div class="form-row">
        <div class="form-group col-md-6">
            <label for="inputName">Name</label>
            <input type="text" class="form-control" id="inputName" name="name" value="<%= user1.getName() %>" readonly>
        </div>
        <div class="form-group col-md-6">
            <label for="inputEmail">Email</label>
            <input type="email" class="form-control" id="inputEmail" name="email" value="<%= user1.getEmail() %>" readonly>
        </div>
    </div>

    <div class="form-row">
        <div class="form-group col-md-6">
            <label for="inputMobile">Mobile No</label>
            <input type="number" class="form-control" id="inputMobile" name="mobile" placeholder="Mobile Number" required>
        </div>
        <div class="form-group col-md-6">
            <label for="inputAddress">Address</label>
            <input type="text" class="form-control" id="inputAddress" name="addr" placeholder="Address" required>
        </div>
    </div>

    <div class="form-row">
        <div class="form-group col-md-6">
            <label for="inputLandmark">Landmark</label>
            <input type="text" class="form-control" id="inputLandmark" name="landmark" placeholder="Landmark">
        </div>
        <div class="form-group col-md-6">
            <label for="inputCity">City</label>
            <input type="text" class="form-control" id="inputCity" name="city" placeholder="City" required>
        </div>
    </div>

    <div class="form-row">
        <div class="form-group col-md-6">
            <label for="inputState">State</label>
            <input type="text" class="form-control" id="inputState" name="state" placeholder="State" required>
        </div>
        <div class="form-group col-md-6">
            <label for="inputZip">Zip</label>
            <input type="text" class="form-control" id="inputZip" name="zip" placeholder="Zip Code" required>
        </div>
    </div>

  <div class="form-group">
    <label for="paymentMode">Payment Mode</label>
    <select class="form-control" id="paymentMode" name="paymentMode" required>
        <option value="noselect" disabled selected>Select Payment Mode</option>
      
        <option value="cod">Cash on Delivery</option>
    </select>
    <%-- Error message for invalid selection, dynamically displayed --%>
    <% if (msg != null && msg.contains("Payment")) { %>
        <span class="text-danger"><%= msg %></span>
    <% } %>
</div>


    <div class="text-center">
        <button type="submit" class="btn btn-warning">Order Now</button>
        <a href="index.jsp" class="btn btn-success">Continue Shopping</a>
    </div>
</form>

                </div>
            </div>
        </div>
    </div>
</body>
</html>
