<g:set var="rewardService" bean="rewardService"/>
<g:set var="projectService" bean="projectService"/>
<%
	def projectId = project.id
	def backers = contributionService.getBackersForProjectByReward(project, reward);
%>
<div class="panel panel-primary">
	<div class="panel-heading">
		<h3 class="panel-title">${reward.title}</h3>
	</div>
	<div class="panel-body containrewards">
		<p>${reward.description}</p>
		<g:if test="${project.draft}">
			<g:if test="${reward.id != 1}">
				<g:form controller="project" action="deletecustomrewards" id="${reward.id}" params="['projectId': projectId]"  method="post">
					<button class="rewarddelete close" name="" value="Delete" onClick="return confirm(&#39;Are you sure you want to Delete this reward?&#39;);">
						<i class="fa fa-trash-o"></i>
					</button>
				</g:form>
			</g:if>
		</g:if>
	</div>
	<div class="panel-footer reward-footer">
		<% def price = projectService.getDataType(reward.price); %>
		<b>$${price}</b>
		<b class="pull-right">&nbsp;SUPPORTERS</b><span class="badge pull-right">${backers}</span>
	</div>
</div>
