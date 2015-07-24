<g:set var="projectService" bean="projectService" />
<div class="panel panel-default ack-panel-width">
	<div class="panel-heading">
		<h3 class="panel-title">Your chosen Perk</h3>
	</div>
	<div class="panel-body">
		<% def price = projectService.getDataType(reward.price) %>
		<h4>
			${reward.title}
		</h4>
		<g:if test="${reward.id>1}">
			<p>Worth <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span>&nbsp;</g:if><g:else>$</g:else>${price}</p>
		</g:if>
	</div>
</div>
