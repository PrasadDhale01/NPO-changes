<g:set var="contributionService" bean="contributionService" />
<g:set var="projectService" bean="projectService" />
<g:set var="userService" bean="userService"/>
<%
	def currentUserName
	if (currentUser) {
	    currentUserName = currentUser.username
	}
%>
<g:if test="${flash.message}">
   <div class="alert alert-success">
       ${flash.message}&nbsp;&nbsp;<i class="fa fa-check-square"></i>
   </div>
</g:if>
<div class="col-md-12 col-sm-12 col-xs-12"></div>
<div class="pill-buttons">
<g:if test="${!totalteams.isEmpty()}">
	<ul class="nav nav-pills">
		<li data-toggle="tab" class="active show-team col-md-4 col-sm-4 col-xs-4 button-team-show">
		    <g:if test="${currentUser}">
		        <a href="#team" class="text-center teammembers">
		            ${totalteams.size()}&nbsp;&nbsp;<g:if test="${totalteams.size() > 1}">Teams</g:if><g:else>Team</g:else>
		        </a>
		    </g:if>
		    <g:else>
		        <div class="col-md-12 col-sm-12 col-xs-12 teammembers noOfteamsLabel disableteambutton text-center">${totalteams.size()}&nbsp;&nbsp;<g:if test="${totalteams.size() > 1}">Teams</g:if><g:else>Team</g:else></div>
		    </g:else>
		</li>
		<g:if test="${!isTeamExist && project.validated}">
		    <g:if test="${!ended}">
			    <li class="col-md-4 col-sm-4 col-xs-4 show-team-button button-team-show">
			        <g:form controller="project" action="addTeam" id="${project.id}">
					    <input type="submit" value="Join Us" class="col-md-12 col-sm-12 col-xs-12 inviteteammember text-center btn btn-default btn-md manage-team all-place"/>
					</g:form> 
			    </li>
		    </g:if>
		    <g:else>
		        <li class="col-md-4 col-sm-4 col-xs-4 show-team-button">
                    <input value="Join Us" class="col-md-12 col-sm-12 col-xs-12 inviteteammember disableteambutton text-center btn btn-md all-place" readonly/>
                </li>
		    </g:else>
		</g:if>
		<g:else>
		    <g:if test="${(currentFundraiser == currentUser || isCrUserCampBenOrAdmin) && project.validated}">
                <li data-toggle="tab" class="col-md-4 col-sm-4 col-xs-4 show-team-button button-team-show">
                   <a class="col-md-12 col-sm-12 col-xs-12 btn btn-default btn-md inviteteammember dropdown-toggle manage-team" data-toggle="dropdown" aria-expanded="false">
			           Activity <span class="caret"></span>
			       </a>
			       <ul class="dropdown-menu TW-dropdown-height" role="menu">
				       <li>
				           <g:if test="${!ended}">
				               <g:if test="${currentFundraiser == currentUser || isCrUserCampBenOrAdmin}">
				                   <a class="list" href="#inviteTeamMember" data-toggle="modal"><span class="glyphicon glyphicon-user"></span> &nbsp;&nbsp;Invite Members </a>
    		               </g:if>
				           </g:if>
				           <g:else>
				               <a class="list"><span class="glyphicon glyphicon-user"></span></i> &nbsp;&nbsp;Invite Members</a>
				           </g:else>
				       </li>
				       <g:if test="${!isCrFrCampBenOrAdmin}">
				           <li><a class="list" href="#editFundraiser" data-toggle="modal"><i class="glyphicon glyphicon-edit"></i> &nbsp;&nbsp;Edit Fundraiser</a></li>
				       </g:if>
			       </ul>
                </li>
            </g:if>
            
		</g:else>
	</ul>
	<div class="teamtileseperator"></div>

    <div class="tab-content">
        <div class="tab-pane active col-md-12 col-sm-12 col-xs-12" id="team">
            <div class="teamList" id="teamList">
                <g:render template="show/teamgrid"/>
            </div>
        </div>
    </div>
	
</g:if>
</div>

<!-- Modal -->
<div class="modal fade" id="inviteTeamMember" tabindex="-1" role="dialog" aria-hidden="true">
    <g:form action="inviteTeamMember" id="${project.id}"  class="inviteTeamMember">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Invite Team Members</h4>
                </div>
                <div class="modal-body">
                    <g:hiddenField name="amount" value="${project.amount}"/>
                    <div class="form-group">
                        <label>Name</label>
                        <input type="text" class="form-control all-place" name="username" value="${userName}" placeholder="Name"/>
                    </div>
                    <div class="form-group">
                        <label>Email ID's (separated by comma)</label>
                        <textarea class="form-control all-place" name="emailIds" rows="4" placeholder="Email ID's"></textarea>
                    </div>
                    <div class="form-group">
                        <label>Message (Optional)</label>
                        <textarea class="form-control all-place" name="teammessage" rows="4" placeholder="Message"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary btn-block" id="btnSendInvitation">Send Invitation</button>
                </div>
            </div>
        </div>
    </g:form>
</div>

<!-- Edit Fundraiser Modal -->
<div class="modal fade" id="editFundraiser" tabindex="-1" role="dialog" aria-hidden="true">
    <g:uploadForm action="editFundraiser" id="${currentTeam.id}" params="['fr':currentFundraiser.username]"> 
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h2 class="modal-title text-center"><b>Edit Fundraiser Info</b></h2>
                </div>
                <div class="modal-body">
                    <g:hiddenField name="project" value="${project.id}"/>
                    <g:hiddenField name="projectAmount" value="${project.amount}"/>
                    <input type="hidden" id="b_url" value="<%=base_url%>" />
                    <h5><b>Team's Campaign Goal</b></h5><hr/>
                    <div class="form-group">
                        <label>$ GOAL</label>
                        <input type="text" class="form-control all-place" name="amount" id="teamamount" placeholder="Goal" value="${currentTeam.amount.round()}"/>
                        <span id="errormsg"></span>
                    </div>
                    <div class="clear"></div>
                    <hr>
                    <h5><b>About My Team</b></h5><hr/>
                    <div class="form-group TW-editfundraiser-modal">
                        <label class="control-label">Brief Description</label>
                        <textarea class="form-control all-place" maxlength="140" rows="2" id="descarea" name="description" placeholder="Make it catchy, and no more than 140 characters"> ${currentTeam.description} </textarea>
                        <label class="pull-right " id="desclength"></label>
                    </div>
                    <div class="clear"></div>
                    <div class="form-group TW-redactor">
                        <label>Story</label>
                        <textarea rows="4"  class="redactorEditor all-place" name="story">
						     ${currentTeam.story}</textarea>
                        <span id="storyRequired">This field is required</span>
                    </div>
                    <div class="clear"></div>
                    <hr>
                    <h5><b>Upload Images/Video</b></h5><hr/>
                    <div class="form-group">
      					<label class="col-sm-2 control-label">Pictures</label>
      					<div class="col-sm-4">
        					<div class="fileUpload btn btn-primary btn-sm">
	        					<span>Add Images</span>
	        					<input type="file" class="upload" name="imagethumbnail" id="projectImageFile" accept="image/jpeg, image/png" multiple>
         					</div>
         					<label class="docfile-orglogo-css" id="editimg">Please select image file.</label>
         					<label class="docfile-orglogo-css" id="editTeamImg"></label>
      					</div>
      					<div class="col-sm-6" id="teamImages">
      					    <g:each var="imgurl" in="${currentTeam.imageUrl}">
                                <div id="imgdiv" class="pr-thumb-div">
                                    <img  class='pr-thumbnail' src='${imgurl.url }' id="imgThumb${imgurl.id}" alt="images">
                                    <div class="deleteicon pictures-edit-deleteicon">
                                        <img alt="images" onClick="deleteTeamImage(this,'${imgurl.id}','${currentTeam.id}');" value='${imgurl.id}'
                                            src="//s3.amazonaws.com/crowdera/assets/delete.ico" id="imageDelete">
                                    </div>
                                </div> 
                            </g:each>
                            <script>
                               function deleteTeamImage(current,imgst, teamId) {
                                   $(current).parents('#imgdiv').remove();
                                   $.ajax({
                                       type:'post',
                                       url:$("#b_url").val()+'/project/deleteTeamImage',
                                       data:'imgst='+imgst+'&teamId='+teamId,
                                       success: function(data){
                                       $('#test').html(data);
                                   }
                                   }).error(function(){
                                       alert('An error occured');
                                   });
                               }
                            </script>
                            <div class="clear"></div>
        					<output id="result"></output>
        					<div id="test"></div>
      					</div>
    				</div>
    				<div class="clear"></div>
    				<div class="form-group">
      					<label class="col-sm-2 control-label">Video URL</label>
      					<div class="col-sm-4">
      					<g:hiddenField name="isVideoUrl" id="isVideoUrl" value="${currentTeam.videoUrl}"/>
        					<input id="videoUrl" class="form-control"
         						name="videoUrl" value="${currentTeam.videoUrl}">
      					</div>
      					<div class="col-sm-4 TW-editFUndraiser-video-thumb"><iframe class="edits-video" id="ytVideo" src="${currentTeam.videoUrl}"></iframe></div>
    				</div>
                </div>
                <div class="clear"></div>
                <div class="modal-footer">
                   <button data-dismiss="modal" class="btn btn-primary TW-btn-editfundraiser">Close</button>
				   <button class="btn btn-primary" type="submit" id="teamSaveButton">Save</button>
		        </div>
		    </div>
		</div>
    </g:uploadForm>
</div>
