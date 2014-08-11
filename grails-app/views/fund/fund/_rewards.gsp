<g:set var="contributionService" bean="contributionService"/>
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">Choose a reward</h3>
    </div>
    <div class="panel-body">
        <div class="choose-error"></div>

        <div class="list-group">
            <g:each in="${project.rewards}" var="reward">
                <%
                    def backers = contributionService.getBackersForProjectByReward(project, reward);
                %>
	        <g:if test="${reward.disabled == false}">
                    <a href="#" class="list-group-item" data-rewardid="${reward.id}" data-rewardprice="${reward.price}">
                        <h4 class="list-group-item-heading">${reward.title}</h4>
                        <h5 class="list-group-item-heading lead">$${reward.price}</h5>
                        <p class="list-group-item-text text-justify">${reward.description}</p>
                        <p class="list-group-item-text text-justify">${backers} backer(s)</p>
                    </a>
		</g:if>
            </g:each>
        </div>
    </div>
</div>
