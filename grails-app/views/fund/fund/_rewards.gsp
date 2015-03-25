<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<g:set var="rewardService" bean="rewardService"/>
<g:set var="userService" bean="userService"/>
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">Choose a Perk</h3>
    </div>
    <div class="panel-body">
        <div class="choose-error"></div>
        <% isAnonymous = userService.isAnonymous(user) %>
        <div class="list-group">
            <g:each in="${project.rewards}" var="reward">
                <%
                    def backers = contributionService.getBackersForProjectByReward(project, reward);
            		def price = projectService.getDataType(reward.price);
                    def isOnlyTwitterHandled = rewardService.isOnlyTwitterHandled(reward)
                    def isTwitterHandled = rewardService.isTwitterHandled(reward)
                %>
                <br>
                 <g:if test="${(user == null) && isOnlyTwitterHandled}">
                    <div title="As you are anonymous, this perk which contains twitter handler is disabled for you" class="list-group-item" id="onlyTwitterReward">
                        <h3 class="panel-title">twitter${reward.title}</h3> 
                        <h5 class="list-group-item-heading lead">$${price}</h5>
                        <p class="rewarddescription">${reward.description}</p>
                        <span class="badge">${backers}</span>&nbsp;&nbsp;<b>SUPPORTERS</b>
                    </div>
                 </g:if>
                 <g:elseif test="${(user == null) && isTwitterHandled}">
                        <a href="#" id="twitterReward" title="As you are anonymous, twitter handler information will be disabled for this perk" class="list-group-item <% if(perk == reward){%> active <%}%>" data-rewardid="${reward.id}" data-rewardprice="${reward.price}">
                            <h3 class="panel-title">${reward.title}</h3> 
                            <h5 class="list-group-item-heading lead">$${price}</h5>
                            <p class="rewarddescription">${reward.description}</p>
                            <span class="badge">${backers}</span>&nbsp;&nbsp;<b>SUPPORTERS</b>
                        </a>
                </g:elseif>
                <g:else>
                <a href="#" class="list-group-item <% if(perk == reward){%> active <%}%>" data-rewardid="${reward.id}" data-rewardprice="${reward.price}">
                    <h3 class="panel-title">${reward.title}</h3> 
                    <h5 class="list-group-item-heading lead">$${price}</h5>
                    <p class="rewarddescription">${reward.description}</p>
                    <span class="badge">${backers}</span>&nbsp;&nbsp;<b>SUPPORTERS</b>
                </a>
                </g:else>
            </g:each>
        </div>
    </div>
</div>
