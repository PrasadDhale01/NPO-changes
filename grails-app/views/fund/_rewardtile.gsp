<g:set var="projectService" bean="projectService" />
<div class="panel panel-default ack-panel-width">
	<div class="ack-panel-reward">
		<h3 class="ack-panel-title">Your chosen Perk</h3>
	</div>
	<div class="panel-body ack-panel-perks">
		<% def price = projectService.getDataType(reward.price) %>
		<h4>
			${reward.title}
		</h4>
		<g:if test="${reward.id>1}">
			<p>Worth <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else>${price}</p>
		</g:if>
	</div>
</div>
