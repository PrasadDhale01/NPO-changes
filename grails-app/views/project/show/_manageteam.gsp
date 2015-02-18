<g:set var="contributionService" bean="contributionService" />
<g:set var="projectService" bean="projectService" />
<g:set var="userService" bean="userService"/>
<%
    def teams = project.teams
	def currentTeam = projectService.getCurrentTeam(project,currentFundraiser)
	def amount = contributionService.getTotalContributionForUser(currentTeam.contributions)
    def percentage = contributionService.getPercentageContributionForProject(project)
    def currentUser = userService.getCurrentUser()
	def username
	if (currentUser) {
	    username = currentUser.username
	} 
    def isTeamExist = userService.isTeamAlreadyExist(project, currentUser)
    def contributedSoFar = contributionService.getTotalContributionForProject(project)
    def contribution = projectService.getDataType(contributedSoFar)
    boolean ended = projectService.isProjectDeadlineCrossed(project)
%>
<g:if test="${flash.message}">
   <div class="alert alert-success">
       ${flash.message}&nbsp;&nbsp;<i class=" fa fa-exclamation-circle"></i>
   </div>
</g:if>
<div class="col-md-12 col-sm-12 col-xs-12"></div>
<div class="pill-buttons">
<g:if test="${!teams.isEmpty()}">
	<ul class="nav nav-pills">
		<li data-toggle="tab" class="active show-team col-md-4 col-sm-4 col-xs-4">
		   <a href="#team">
		      <h4 class="text-center">${teams.size()}</h4>
		      <h5 class="text-center"> Team </h5>
		   </a>
		</li>
        <li data-toggle="tab" class="col-md-4 col-sm-4 col-xs-4 show-team-button">
            <button class="col-md-12 col-sm-12 col-xs-12 inviteteammember text-center btn btn-default btn-md" data-target="#teamComment" data-toggle="tab">
               Team Comments
            </button>
        </li>
		<g:if test="${!isTeamExist}">
		    <g:if test="${!ended}">
			    <li class="col-md-4 col-sm-4 col-xs-4 show-team-button ">
			        <g:form controller="project" action="addFundRaiser" id="${project.id}" params="['fr':username]">
					    <input type="submit" value="Join Us" class="col-md-12 col-sm-12 col-xs-12 inviteteammember text-center btn btn-default btn-md"/>
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
		    <g:if test="${currentFundraiser == currentUser}">
                <li data-toggle="tab" class="col-md-4 col-sm-4 col-xs-4 show-team-button">
                   <button class="col-md-12 col-sm-12 col-xs-12 btn btn-default btn-md inviteteammember dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
			           Activity <span class="caret"></span>
			       </button>
			       <ul class="dropdown-menu" role="menu">
				       <li>
				           <g:if test="${!ended}">
				               <a class="list" href="#inviteTeamMember" data-toggle="modal" model="['project': project]"><span class="glyphicon glyphicon-user"></span> &nbsp;&nbsp;Invite Members </a>
				           </g:if>
				           <g:else>
				               <a class="list"><span class="glyphicon glyphicon-user"></span> &nbsp;&nbsp;Invite Members </a>
				           </g:else>
				       </li>
				       <g:if test="${project.user!=currentUser}">
				           <li><a class="list" href="#editFundraiser" data-toggle="modal" model="['currentTeam': currentTeam"><i class="glyphicon glyphicon-edit"></i> &nbsp;&nbsp;Edit Fundraiser</a></li>
				       </g:if>
			       </ul>         
                </li>
            </g:if>
            <g:else>
                <li data-toggle="tab" class="show-team col-md-4 col-sm-4 col-xs-4">
                    <a href="#team">
		                <h4 class="text-center">$${amount}</h4>
		                <h5 class="text-center">Amount Raised</h5>
		            </a>
                </li>
            </g:else>
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
    <g:form action="editFundraiser" id="${currentTeam.id}" role="form"> 
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Edit Fundraiser</h4>
                </div>
                <div class="modal-body">
                    <g:hiddenField name="project" value="${project.id}"/>
                    <g:hiddenField name="projectAmount" id="projectAmount" onchange="alertFunction()" value="${project.amount}"/>
                    <div class="form-group">
                        <label>$ GOAL</label>
                        <input type="text" class="form-control" name="amount" placeholder="Goal" value="${currentTeam.amount}"/>
                    </div>
                </div>
                <div class="modal-footer">
                   <button data-dismiss="modal" class="btn btn-primary">Close</button>
				   <button class="btn btn-primary" type="submit" id="saveButton">Save</button>
		        </div>
		    </div>
		</div>
    </g:form>
</div>
		
