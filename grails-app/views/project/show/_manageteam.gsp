<g:set var="contributionService" bean="contributionService" />
<g:set var="projectService" bean="projectService" />
<g:set var="userService" bean="userService"/>
<%
    def teams = projectService.getEnabledAndValidatedTeamsForCampaign(project)
	def currentTeam = projectService.getCurrentTeam(project,currentFundraiser)
	def amount = contributionService.getTotalContributionForUser(currentTeam.contributions)
    def percentage = contributionService.getPercentageContributionForProject(project)
    def currentUser = userService.getCurrentUser()
	def username
	if (currentUser) {
	    username = currentUser.username
	}
    def isTeamExist = userService.isValidatedTeamExist(project, currentUser)
    def contributedSoFar = contributionService.getTotalContributionForProject(project)
    boolean ended = projectService.isProjectDeadlineCrossed(project)
%>
<g:if test="${flash.message}">
   <div class="alert alert-success">
       ${flash.message}&nbsp;&nbsp;<i class="fa fa-check-square"></i>
   </div>
</g:if>
<div class="col-md-12 col-sm-12 col-xs-12"></div>
<div class="pill-buttons">
<g:if test="${!teams.isEmpty()}">
	<ul class="nav nav-pills">
		<li data-toggle="tab" class="active show-team col-md-4 col-sm-4 col-xs-4 button-team-show">
		    <g:if test="${currentUser}">   
		        <a href="#team" class="text-center teammembers">
		            ${teams.size()}&nbsp;&nbsp;Teams
		        </a>
		    </g:if>
		    <g:else>
		        <div class="col-md-12 col-sm-12 col-xs-12 teammembers noOfteamsLabel disableteambutton text-center">${teams.size()}&nbsp;&nbsp;Teams</div>
		    </g:else>
		</li>
		<g:if test="${!isTeamExist}">
		    <g:if test="${!ended}">
			    <li class="col-md-4 col-sm-4 col-xs-4 show-team-button button-team-show">
			        <g:form controller="project" action="addFundRaiser" id="${project.id}" params="['fr':username]">
					    <input type="submit" value="Join Us" class="col-md-12 col-sm-12 col-xs-12 inviteteammember text-center btn btn-default btn-md manage-team"/>
					</g:form> 
			    </li>
		    </g:if>
		    <g:else>
		        <li class="col-md-4 col-sm-4 col-xs-4 show-team-button">
                    <input value="Join Us" class="col-md-12 col-sm-12 col-xs-12 inviteteammember disableteambutton text-center btn btn-md" readonly/>
                </li>
		    </g:else>
		</g:if>
		<g:else>
		    <g:if test="${currentFundraiser == currentUser || currentUser == project.user}">
                <li data-toggle="tab" class="col-md-4 col-sm-4 col-xs-4 show-team-button button-team-show">
                   <a class="col-md-12 col-sm-12 col-xs-12 btn btn-default btn-md inviteteammember dropdown-toggle manage-team" data-toggle="dropdown" aria-expanded="false">
			           Activity <span class="caret"></span>
			       </a>
			       <ul class="dropdown-menu" role="menu">
				       <li>
				           <g:if test="${!ended}">
				               <g:if test="${currentFundraiser == currentUser || currentUser != project.user}">
				                   <a class="list" href="#inviteTeamMember" data-toggle="modal" model="['project': project]"><span class="glyphicon glyphicon-user"></span> &nbsp;&nbsp;Invite Members </a>
				               </g:if>
				           </g:if>
				           <g:else>
				               <a class="list"><span class="glyphicon glyphicon-user"></span></i> &nbsp;&nbsp;Invite Members </a>
				           </g:else>
				       </li>
				       <g:if test="${!userService.isCampaignBeneficiaryOrAdmin(project,currentFundraiser)}">
				           <li><a class="list" href="#editFundraiser" data-toggle="modal" model="['currentTeam': currentTeam"><i class="glyphicon glyphicon-edit"></i> &nbsp;&nbsp;Edit Fundraiser</a></li>
				       </g:if>
			       </ul>
                </li>
            </g:if>
            
		</g:else>
	</ul>
	<div class="teamtileseperator"></div>

	<div class="tab-content">
	    <div class="tab-pane active col-md-12 col-sm-12 col-xs-12" id="team">
		    <g:render template="show/teamgrid"/>
		</div>
		<div class="tab-pane col-md-12 col-sm-12 col-xs-12" id="teamComment">
		    <g:render template="show/teamcomment"/>
		</div>
	</div>
	
</g:if>
</div>

<!-- Modal -->
<div class="modal fade" id="inviteTeamMember" tabindex="-1" role="dialog" aria-hidden="true">
    <g:form action="inviteTeamMember" id="${project.id}" role="form">
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
                        <input type="text" class="form-control" name="username" value="${userName}" placeholder="Name"/>
                    </div>
                    <div class="form-group">
                        <label>Email ID's (separated by comma)</label>
                        <textarea class="form-control" name="emailIds" rows="4" placeholder="Email ID's"></textarea>
                    </div>
                    <div class="form-group">
                        <label>Message (Optional)</label>
                        <textarea class="form-control" name="teammessage" rows="4" placeholder="Message"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary btn-block">Send Invitation</button>
                </div>
            </div>
        </div>
    </g:form>
</div>

<!-- Edit Fundraiser Modal -->
<div class="modal fade" id="editFundraiser" tabindex="-1" role="dialog" aria-hidden="true">
    <g:uploadForm action="editFundraiser" id="${currentTeam.id}" role="form"> 
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
                        <input type="text" class="form-control" name="amount" id="teamamount" placeholder="Goal" value="${currentTeam.amount.round()}"/>
                        <span id="errormsg"></span>
                    </div>
                    <div class="clear"></div>
                    <hr>
                    <h5><b>About My Team</b></h5><hr/>
                    <div class="form-group">
                        <label class="control-label">Brief Description</label>
                        <textarea class="form-control" maxlength="140" rows="2" id="descarea" name="description" placeholder="Make it catchy, and no more than 140 characters"> ${currentTeam.description} </textarea>
                        <label class="pull-right " id="desclength"></label>
                    </div>
                    <div class="clear"></div>
                    <div class="form-group">
                        <label>Story</label>
                        <textarea row="4" col="6" class="mceEditor" name="story">
						     ${currentTeam.story}</textarea>
                    </div>
                    <div class="clear"></div>
                    <hr>
                    <h5><b>Upload Images/Video</b></h5><hr/>
                    <div class="form-group">
      					<label class="col-sm-2 control-label">Pictures</label>
      					<div class="col-sm-4">
        					<div class="fileUpload btn btn-primary btn-sm">
	        					<span>Add Images</span>
	        					<input type="file" class="upload" name="imagethumbnail" id="projectImageFile" accept="image/*" multiple>
         					</div>
         					<label class="docfile-orglogo-css" id="editimg">Please select image file.</label>
         					<label class="docfile-orglogo-css" id="editTeamImg"></label>
      					</div>
      					<div class="col-sm-6">
      					    <g:each var="imgurl" in="${currentTeam.imageUrl}">
                                <div id="imgdiv" class="pr-thumb-div">
                                    <img  class='pr-thumbnail' src='${imgurl.url }' id="imgThumb${imgurl.id}" alt="images"/>
                                    <div class="deleteicon pictures-edit-deleteicon">
                                        <img alt="images" onClick="deleteTeamImage(this,'${imgurl.id}','${currentTeam.id}');" value='${imgurl.id}'
                                            src="https://s3.amazonaws.com/crowdera/assets/delete.ico" id="imageDelete"/>
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
        					<input id="videoUrl" class="form-control"
         						name="videoUrl" value="${currentTeam.videoUrl}">
      					</div>
      					<iframe class="edits-video" id="ytVideo" src="${currentTeam.videoUrl}"></iframe>
    				</div>
                </div>
                <div class="clear"></div>
                <div class="modal-footer">
                   <button data-dismiss="modal" class="btn btn-primary">Close</button>
				   <button class="btn btn-primary" type="submit" id="saveButton">Save</button>
		        </div>
		    </div>
		</div>
    </g:uploadForm>
</div>

