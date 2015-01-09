<g:set var="contributionService" bean="contributionService" />
<g:set var="projectService" bean="projectService" />
<g:set var="userService" bean="userService"/>
<%
    def teams = project.teams
    def percentage = contributionService.getPercentageContributionForProject(project)
    def user = userService.getCurrentUser()
    def isTeamExist = userService.isTeamAlreadyExist(project, user)
    def contributedSoFar = contributionService.getTotalContributionForProject(project)
%>
<div class="col-md-12 col-sm-12 col-xs-12 btn btn-primary divider"></div>

<g:if test="${!teams.isEmpty()}">
	<div class="row manageTeam">
		<g:if test="${!isTeamExist}">
		    <div class="col-md-4 col-sm-4 col-xs-4 pull-right">
				<g:link controller="project" action="addFundRaiser" class="col-md-12 col-sm-12 col-xs-12 inviteteammember text-center btn btn-primary" id="${project.id}">Join Us</g:link>
		    </div>
		</g:if>
	</div>
</g:if>
<g:else>
    <div class="col-md-12 col-sm-12 col-xs-12 alert alert-info">Team is yet to create</div>
</g:else>

<div class="teamtileseperator"></div>

<div class="row">
	<div class="col-md-12 col-sm-12 col-xs-12">
	    <g:render template="show/teamgrid"/>
	</div>
</div>
