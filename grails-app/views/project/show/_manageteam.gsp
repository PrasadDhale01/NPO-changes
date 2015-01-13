<g:set var="contributionService" bean="contributionService" />
<g:set var="projectService" bean="projectService" />
<g:set var="userService" bean="userService"/>
<%
    def teams = project.teams
    def percentage = contributionService.getPercentageContributionForProject(project)
    def user = userService.getCurrentUser()
    def isTeamExist = userService.isTeamAlreadyExist(project, user)
    def contributedSoFar = contributionService.getTotalContributionForProject(project)
    def contribution = projectService.getDataType(contributedSoFar)
%>
<div class="col-md-12 col-sm-12 col-xs-12 btn btn-primary divider"></div>
<div class="pill-buttons">
<g:if test="${!teams.isEmpty()}">
	<ul class="nav nav-pills">
		<li data-toggle="tab" class="active show-team col-md-4 col-sm-4 col-xs-4">
		   <a href="#team">
		      <h4 class="text-center">${teams.size()}</h4>
		      <h5 class="text-center"> Team </h5>
		   </a>
		</li>
        <li data-toggle="tab" class="col-md-4 col-sm-4 col-xs-4 show-team">
           <a href="#teamContribution">
              <h4 class="text-center">$${contribution}</h4> 
		      <h5 class="text-center">Team Contribution</h5>
           </a>
        </li>
		<g:if test="${!isTeamExist}">
		    <li class="col-md-4 col-sm-4 col-xs-4 show-team-button ">
		        <form action="/project/addFundRaiser/${project.id}">
				    <g:submitButton name="submit" value="Join Us" class="col-md-12 col-sm-12 col-xs-12 inviteteammember text-center btn btn-default btn-md"/>
				</form>
		    </li>
		</g:if>
		<g:else>
            <li data-toggle="tab" class="col-md-4 col-sm-4 col-xs-4 show-team-button">
                <button class="col-md-12 col-sm-12 col-xs-12 inviteteammember text-center btn btn-default btn-md" data-toggle="modal" data-target="#inviteTeamMember" model="['project': project]">
                   Invite Members
                </button>		    
            </li>
		</g:else>
	</ul>
</g:if>
<g:else>
    <div class="col-md-12 col-sm-12 col-xs-12 alert alert-info">Team is yet to create</div>
</g:else>
</div>

<div class="teamtileseperator"></div>

<div class="tab-content">
    <div class="tab-pane active col-md-12 col-sm-12 col-xs-12" id="team">
	    <g:render template="show/teamgrid"/>
	</div>
<%--	<div class="tab-pane col-md-12 col-sm-12 col-xs-12" id="teamContribution">--%>
<%--	    <g:render template=""/>--%>
<%--	</div>--%>
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
