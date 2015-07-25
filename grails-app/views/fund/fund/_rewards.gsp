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
                %>
                <br>
                <a href="#" class="list-group-item <% if(perk == reward){%> active <%}%>" id="${reward.id}" data-rewardprice="${reward.price}">
                    <g:if test="${reward.id!=1 }">
                        <div class="tile-goal-show">
                            <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else><span class="perk-amount-fund">${price}</span>
                        </div>
                    </g:if>
                    <g:if test="${reward.id==1 }">
                    	<h4 class="perk-title-fund">I just want to help.</h4><br>
                    	<p class="perk-desc-fund"></p>
                    </g:if>
                    <g:else>
                    	 <h4 class="perk-title-fund">${reward.title}</h4>
                    	 <p class="perk-desc-fund">${reward.description}</p>
                    </g:else>
                    <span class="badge">${backers}</span>&nbsp;&nbsp;<span class="perksupporter">SUPPORTERS</span>
                </a>
            </g:each>
        </div>
    </div>
</div>
