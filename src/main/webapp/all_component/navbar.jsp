<div class="container-fluid" style="height: 10px; background-color: #303f9f;"></div>
<%@ page import="com.entity.User" %>

<div class="container-fluid p-3 bg-light">
    <div class="row">
        <div class="col-md-3 text-success">
            <h3><i class="fas fa-book"></i> ShelfSpace</h3>
        </div>
        <div class="col-md-6">
            <form class="form-inline my-2 my-lg-0" action ="search.jsp" method="post">
                <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" name="ch">
                <button class="btn btn-primary my-2 my-sm-0" type="submit">Search</button>
            </form>
        </div>
        <div class="col-md-3">
            <%
                // Check if user object is present in the session
                User user = (User)session.getAttribute("userobj");
                if (user != null) {
            %>
                <!-- User is logged in -->
                 <a href="cart.jsp" class="btn btn-danger">
                    <i class="fas fa-solid fa-cart-plus"></i>
                </a>
                <a href="setting.jsp" class="btn btn-success text-white">
                    <i class="fas fa-user"></i> <%=user.getName() %> <!-- Replace with your User class -->
                </a>
                <form action="logout" method="post" style="display: inline;">
                    <button class="btn btn-danger text-white" type="submit">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </button>
                </form>
            <%
                } else {
            %>
                <!-- User is not logged in -->
                
               
                <a href="login.jsp" class="btn btn-success text-white">
                    <i class="fas fa-sign-in-alt"></i> Login
                </a>
                <a href="register.jsp" class="btn btn-primary text-white">
                    <i class="fas fa-user-plus"></i> Register
                </a>
            <%
                }
            %>
        </div>
    </div>
</div>





<nav class="navbar navbar-expand-lg navbar-dark bg-custom">
 <a class="navbar-brand" href="index.jsp"><i class="fas fa-home"></i></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link" href="index.jsp"><i class="fas fa-home"></i>Home <span class="sr-only">(current)</span></a>
      </li>
      
            <li class="nav-item">
        <a class="nav-link" href="all_recent_book.jsp"><i class="fas fa-book-open"></i>Recent Book</a>
      </li>
      
      <li class="nav-item">
        <a class="nav-link" href="all_new_book.jsp"><i class="fas fa-book-open"></i>New Book</a>
      </li>
     
      <li class="nav-item">
        <a class="nav-link " href="all_old_book.jsp"><i class="fas fa-book-open"></i>Old Book</a>
      </li>
    </ul>
    <form class="form-inline my-2 my-lg-0">
     
      <a href="setting.jsp" class="btn btn-light my-2 my-sm-0 ml-1"><i class="fas fa-cog"></i>Seting</a>
     <a href="help.jsp" class="btn btn-light my-2 my-sm-0 ml-1">
    <i class="fas fa-phone-square-alt"></i> Contact Us
</a>

    </form>
  </div>
</nav>