<%@ page import="java.text.SimpleDateFormat"%>
<g:set var="contributionService" bean="contributionService" />
<g:set var="projectService" bean="projectService" />
<g:set var="userService" bean="userService"/>
<%
    def user = team.user
    def username = user.username
    def userImageUrl = user.userImageUrl
    def userName = user.firstName
    def goal = projectService.getDataType(project.amount)
	def contributedAmount = contributionService.getTotalContributionForUser(team.contributions)
    def amount = projectService.getDataType(contributedAmount)
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
%>

<div class="fedu thumbnail grow teamtile" style="padding: 0">
	<div style="height: 200px; overflow: hidden;" class="blacknwhite">
		<g:link controller="project" action="show" id="${project.id}" params="['fundRaiser': username]">
		    <g:if test="${userImageUrl != null}">
				<img alt="${userName}" class="project-img" src="${userImageUrl}">
			</g:if>
			<g:else>
			    <img src="${resource(dir: 'images', file: 'profile_image.jpg')}" class="project-img" alt="Upload Photo"/>
			</g:else>
		</g:link>
	</div>

	<div class="modal-footer tile-footer">
		<div class="text-left">
			<span>${userName}</span>
		</div>
	</div>

	<div class="modal-footer tile-footer">
		<div class="row">
			<div class="col-md-6 col-xs-6">
                <h6 class="text-center"><span class="lead">$${goal}</span><br/>GOAL</h6>
            </div>
			<div class="col-md-6 col-xs-6">
				<h6 class="text-center">
					<span class="lead">$${amount}</span><br />ACHIEVED
				</h6>
			</div>
		</div>
	</div>
</div>
