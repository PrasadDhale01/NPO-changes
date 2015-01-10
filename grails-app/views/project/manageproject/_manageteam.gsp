<g:set var="contributionService" bean="contributionService" />
<g:set var="projectService" bean="projectService" />
<%
    def user = userService.getCurrentUser()
    def userName = user.firstName +" "+ user.lastName
    def teams = project.teams
    def contributedSoFar = contributionService.getTotalContributionForProject(project)
    def contribution = projectService.getDataType(contributedSoFar)
%>
<div class="col-md-12 col-sm-12 col-xs-12 btn btn-primary divider"></div>
<g:if test="${project.validated}">
	<g:if test="${!teams.isEmpty()}">
		<g:if test="${project.user == user}">
			<div class="row manageTeam">
			    <div class="col-md-3 col-sm-3 col-xs-3">
			        <div class="team-footer">
			            <h4 class="text-center">${teams.size()}</h4>
				    	<h5 class="text-center"> Team </h5>
				    </div>
			    </div>
			    <div class="col-md-3 col-sm-3 col-xs-3">
			        <div class="team-footer">
			            <h4 class="text-center">$${contribution}</h4>
			            <h5 class="text-center">Team Contribution</h5>
			        </div>
			    </div>
			    
			    <div class="col-md-3 col-sm-3 col-xs-3">
					<a href="#" class="col-md-12 col-sm-12 col-xs-12 inviteteammember text-center btn btn-primary" data-toggle="modal" data-target="#inviteTeamMember" model="['project': project]">Invite Members</a>
			    </div>
				<div class="col-md-3 col-sm-3 col-xs-3 activitydropdown">
					<button type="button" class="col-md-12 col-sm-12 col-xs-12 btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
					      Activity <span class="caret"></span>
					</button>
					<ul class="dropdown-menu" role="menu">
						<li><a class="text-center" href="#"><span class="glyphicon glyphicon-envelope"></span> Team Message </a></li>
						<li><a class="text-center" href="#"><span class="glyphicon glyphicon-list-alt"></span> Campaign Statistics </a></li>
					</ul>
				</div>
			</div>
		</g:if>
		<g:else>
			<div class="row manageTeam">
			    <div class="col-md-4 col-sm-4 col-xs-4">
			        <div class="team-footer">
			            <h4 class="text-center">${teams.size()}</h4>
				    	<h5 class="text-center"> Team </h5>
				    </div>
			    </div>
			    <div class="col-md-4 col-sm-4 col-xs-4">
			        <div class="team-footer">
			            <h4 class="text-center">$${contribution}</h4>
		            <h5 class="text-center">Team Contribution</h5>
			        </div>
			    </div>
			    <div class="col-md-4 col-sm-4 col-xs-4">
					<a href="#" class="col-md-12 col-sm-12 col-xs-12 inviteteammember text-center btn btn-primary" data-toggle="modal" data-target="#inviteTeamMember" model="['project': project]">Invite Members</a>
				</div>
			</div>
		</g:else>
	</g:if>
	<g:else>
	    <div class="col-md-12 col-sm-12 col-xs-12 alert alert-info">Team is yet to create.</div>
	    <g:if test="${project.validated}">
	        <div class="col-md-12 col-sm-12 col-xs-12">
				<g:link controller="project" action="addFundRaiser" class="text-center btn btn-primary pull-right" id="${project.id}">create a team</g:link>
		    </div>
	    </g:if>
	</g:else>
</g:if>
<g:else>
    <div class="col-md-12 col-sm-12 col-xs-12 alert alert-info">You can create team after the project is published.</div>
</g:else>

<div class="teamtileseperator"></div>

<div class="row">
	<div class="col-md-12 col-sm-12 col-xs-12">
	    <g:render template="manageproject/teamgrid"/>
	</div>
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
