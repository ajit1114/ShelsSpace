





<div class="container-fluid" style="height: 10px; background-color: #303f9f;"></div>

<div class="container-fluid p-3 bg-light">
    <div class="row">
        <div class="col-md-3 text-success">
            <h3><i class="fas fa-book"></i>ShelfSpace</h3>
        </div>
        <div class="col-md-6">
            
        </div>
        <div class="col-md-3">
            <!-- Check if userobj is not empty -->
          <c:choose>
    <!-- If userobj exists -->
    <c:when test="${not empty sessionScope.userobj}">
        <a href="../admin/home.jsp" class="btn btn-success text-white">
            <i class="fas fa-user"></i> ${sessionScope.userobj.name}
        </a>
        <a data-toggle="modal" data-target="#exampleModalCenter" class="btn btn-danger text-white">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </c:when>
    <!-- If userobj is empty -->
    
</c:choose>

            <!-- Check if userobj is empty -->
            
           
        </div>
    </div>
</div>
                <!-- LogOut -->
                <!-- Button trigger modal -->


<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
       <div class="center">
       <h4 text="white"> Do You Want Logout</h4>
       
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      <form action="../logout" method="post">
    <button type="submit" class="btn btn-primary text-white">Logout</button>
</form>


       
       </div>
      </div>
      <div class="modal-footer">
        
      </div>
    </div>
  </div>
</div>
               



<nav class="navbar navbar-expand-lg navbar-dark bg-custom">
    <a class="navbar-brand" href="#"><i class="fas fa-home"></i></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" 
        aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="../admin/home.jsp">
    <i class="fas fa-home"></i>Home <span class="sr-only"></span>
</a>

           
        </ul>
        
            
            <a href="help.jsp" class="btn btn-light my-2 my-sm-0 ml-1">
    <i class="fas fa-phone-square-alt"></i> Contact Us
</a>

        
    </div>
</nav>
