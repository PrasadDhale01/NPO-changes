<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">Choose a Perk</h3>
    </div>
    <div class="panel-body">
        <div class="choose-error"></div>

        <div class="list-group">
            <g:each in="${project.rewards}" var="reward">
                <%
                    def backers = contributionService.getBackersForProjectByReward(project, reward);
            		def price = projectService.getDataType(reward.price);
                %>
                <br>
                <a href="#" class="list-group-item" data-rewardid="${reward.id}" data-rewardprice="${reward.price}">
                    <h3 class="panel-title">${reward.title}</h3> 
                    <h5 class="list-group-item-heading lead">$${price}</h5>
                    <p class="rewarddescription">${reward.description}</p>
                    <span class="badge">${backers}</span>&nbsp;&nbsp;<b>SUPPORTERS</b>
                </a>
            </g:each>
        </div>
    </div>
</div>
