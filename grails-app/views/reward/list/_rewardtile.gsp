<div class="panel panel-primary">
    <div class="panel-heading">
        <h3 class="panel-title">${reward.title}</h3>
    </div>
    <div class="panel-body">
        <p>${reward.description}</p>
         <hr>
            <a href="#myModal" role="button" class="rewarddelete close" data-toggle="modal" ><i class="fa fa-trash-o"></i></a>
          
            <div class="modal fade" id="myModal">
                <div class="modal-dialog">
                     
                     <div class="modal-content">
                        <div class="modal-header">
                            <button class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Delete Reward</h4>
                        </div><!--end of modal header-->
            
                        <div class="modal-body">
                              ${rewardId}
                            <h4>Are you sure you want to delete this reward</h4>
                        
                        </div><!--end modal-body-->
                                
                        <div class="modal-footer">
                            
                           <g:form action="list" method="DELETE" role="form">

            
		            <g:hiddenField name="rewardId"/> <!-- Value set by Javascript -->
                        <button type="submit" class="btn btn-primary btn-lg" id="sure">Sure</button>
                        <button class="btn btn-primary btn-lg" data-dismiss="modal" type="button">Cancel</button>
                    </g:form>
                   <!--  <script>
                        function myFunction()
                          {
                              document.getElementById("myTable").deleteRow(0);
                          }
                    </script> -->
                        </div><!--end modal-footer-->
                    
                    </div><!--end modal-content-->
                </div><!--end modal-dialog-->
       	    </div><!--end of modal fade-->

        </hr>
    </div>
    <div class="panel-footer">
        $${reward.price}
    </div>
</div>
