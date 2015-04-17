<g:set var="projectService" bean="projectService" />
<div class="panel panel-default">
	<div class="panel-heading">
		<h3 class="panel-title">Your chosen Perk</h3>
	</div>
	<div class="panel-body">
		<% def price = projectService.getDataType(reward.price) %>
		<h4>
			${reward.title}
		</h4>
	</div>
</div>
