<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<g:set var="rewardService" bean="rewardService"/>
<g:set var="userService" bean="userService"/>

<%
    def rewards = rewardService.getSortedRewards(project);
%>
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">Choose a Perk</h3>
    </div>
    <div class="panel-body rewardTileOnFundPage">
        <div class="choose-error"></div>
        <% isAnonymous = userService.isAnonymous(user) %>
        <div class="list-group twitterHandler ">
            <g:each in="${rewards}" var="reward">
                <%
                    def backers = contributionService.getBackersForProjectByReward(project, reward);
            		def price = projectService.getDataType(reward.price);
                    def isOnlyTwitterHandled = rewardService.isOnlyTwitterHandled(reward)
                    def isTwitterHandled = rewardService.isTwitterHandled(reward)
                %>
                <br>
                <a href="#" class="list-group-item <% if(perk == reward){%> active <%}%>" id="${reward.id}" data-rewardprice="${reward.price}">
                    <h4 class="perk-title-fund">${reward.title}</h4>
                    <g:if test="${reward.id!=1 }">
                        <h3 class="perk-amount-fund">$${price}</h3>
                    </g:if>
                    <p class="perk-desc-fund">${reward.description}</p>
                    <span class="badge">${backers}</span>&nbsp;&nbsp;<span class="perksupporter">SUPPORTERS</span>
                </a>
            </g:each>
        </div>
    </div>
</div>
