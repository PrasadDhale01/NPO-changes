<g:set var="contributionService" bean="contributionService"/>
<div class="panel panel-default" style="margin-top: 30px;">
    <div class="panel-heading">
        <h3 class="panel-title">Choose a reward</h3>
    </div>
    <div class="panel-body">
        <div class="list-group">
            <g:each in="${project.rewards}" var="reward">
                <%
                    def backers = contributionService.getBackersForProjectByReward(project, reward);
                %>
                <a href="#" class="list-group-item" data-rewardid="${reward.id}">
                    <h4 class="list-group-item-heading">${reward.title}</h4>
                    <h5 class="list-group-item-heading lead">$${reward.price}</h5>
                    <p class="list-group-item-text text-justify">${reward.description}</p>
                    <p class="list-group-item-text text-justify">${backers} backer(s)</p>
                </a>
            </g:each>
        </div>
    </div>
</div>
