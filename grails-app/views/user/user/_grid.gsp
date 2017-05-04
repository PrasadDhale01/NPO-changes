<div class="row">
    <g:if test="${projects.size() > 0}">
        <ul class="thumbnails list-unstyled">
            <%
                def index = 1 
            %>
            <g:each in="${projects}" var="project">
                <li class="col-md-6 col-lg-4 col-sm-6 col-xs-12">
                    <g:render template="/user/user/tile" model="['project': project]"></g:render>
                </li>
            </g:each>
        </ul>
    </g:if>
    <g:else>
        <div class="col-sm-12">
            <div class="alert alert-info">
                No Campaigns.
            </div>
        </div>
    </g:else>
</div>
<!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title text-center">Transfer Ownership</h4>
        </div>
        <form name='ownerTransfer'>
        <div class="modal-body text-center">
          <p>Please, enter the registered username of the designee in the input field below.</p>
          <input type="email" id="designeemail" name="designeemail" value=""/>
          
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default btn-info pull-left" data-dismiss="modal">Close ${b_url}</button>
              <button type="submit" id="transferProject" value="transferProject" class="btn btn-default btn-info pull-right" data-dismiss="modal" id="designeemailid">Submit</button>
              <input type="hidden" id="modalprojectId" name='modalprojectId' value=""/>
         </div>
        </form>
        
      </div>
    </div>
  </div>
    
<!-- modal end -->
<script type="text/javascript">
	$(document).ready(function(){
			
		$("#transferProject").click(function(){
			var username= $("#designeemail").val();
			var projectid =$("#modalprojectId").val();
			alert(username + "2"+ projectid);
			$.ajax({
			     url: $("#b_url").val()+'project/ownershiptransfer',
			     type: 'POST',
			     data: 'projectid='+projectid+'&username='+username,
			     success: function (result) {
			        alert(result);
			     },
			     error: function(data){
			         alert("fail");
			     }
			});  
		}); 

		$(".ownershipTransfer").click(function(e){
				var projectidd = $(this).data('projectid');
				$("#modalprojectId").val(projectidd);
				
		}); 
			
	});

</script>
